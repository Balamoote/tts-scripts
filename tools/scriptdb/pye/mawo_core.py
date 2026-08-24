# Модуль обработки текста для получения дополнительных признаков для снятия омографии.
# Служит только для создания временной версии книги для вычленения оттуда этих признаков.
# Уже существующая инфраструктура на gawk, sed и т.п. используется в том числе для устранения
# замеченных ошибок в работе модели spaCy или там, где этам модель не дает достаточных данных.

# Установка mawo-core
# pip install mawo-core

import sys
import gzip
from multiprocessing import Pool
from pathlib import Path
import re
from mawo import Russian

# Инициализация mawo-core для морфологического анализа
nlp = Russian()

# Прочитать из stdin текст и разбить его на строки в массив lines
file_contents = sys.stdin.read()
lines = file_contents.split('\n')

# Загрузить список омографов
if len(sys.argv) > 1:
    omo_list_path = Path(sys.argv[1])
else:
    omo_list_path = Path("omo_list.phy.gz")

with gzip.open(omo_list_path, 'rt') as f:
    omo_list = {word.strip() for word in f}

def clean_morph_value(value):
    """Очищает значение морфологии от пробелов, запятых и None"""
    if value is None:
        return ''
    value = str(value)
    value = value.replace(' ', '_').replace(',', '_')
    return value

def analyze_line(line):
    words = set(word.lower() for word in re.split('[^а-яёА-ЯЁ]+', line) if word.lower() in omo_list)
    if words:
        analyzed_sentences = []
        for sent in re.split(r"(?<=[.!?…;])\s+", line):
            sent_text = sent + ' '
            if not sent_text:
                continue
            sentence_contains_word = False
            analyzed_sent = ''
            doc = nlp(sent_text)
            for token in doc.tokens:
                text = token.text.lower()
                if text in words:
                    sentence_contains_word = True
                    tag_ = clean_morph_value(token.tag)
                    # Собираем морфологию из доступных атрибутов
                    morph_parts = []
                    if hasattr(token, 'animacy'):
                        morph_parts.append(f"animacy={clean_morph_value(token.animacy)}")
                    if hasattr(token, 'aspect'):
                        morph_parts.append(f"aspect={clean_morph_value(token.aspect)}")
                    if hasattr(token, 'case'):
                        morph_parts.append(f"case={clean_morph_value(token.case)}")
                    if hasattr(token, 'gender'):
                        morph_parts.append(f"gender={clean_morph_value(token.gender)}")
                    if hasattr(token, 'mood'):
                        morph_parts.append(f"mood={clean_morph_value(token.mood)}")
                    if hasattr(token, 'number'):
                        morph_parts.append(f"number={clean_morph_value(token.number)}")
                    if hasattr(token, 'person'):
                        morph_parts.append(f"person={clean_morph_value(token.person)}")
                    if hasattr(token, 'tense'):
                        morph_parts.append(f"tense={clean_morph_value(token.tense)}")
                    if hasattr(token, 'verbform'):
                        morph_parts.append(f"verbform={clean_morph_value(token.verbform)}")
                    if hasattr(token, 'voice'):
                        morph_parts.append(f"voice={clean_morph_value(token.voice)}")
                    morph = '_'.join(morph_parts)
                    analyzed_sent += f"{token.text}<#@_{tag_}_{morph}_@#>"
                elif token.pos == "PROPN":
                    sentence_contains_word = True
                    tag_ = clean_morph_value(token.tag)
                    morph_parts = []
                    if hasattr(token, 'animacy'):
                        morph_parts.append(f"animacy={clean_morph_value(token.animacy)}")
                    if hasattr(token, 'case'):
                        morph_parts.append(f"case={clean_morph_value(token.case)}")
                    if hasattr(token, 'gender'):
                        morph_parts.append(f"gender={clean_morph_value(token.gender)}")
                    if hasattr(token, 'number'):
                        morph_parts.append(f"number={clean_morph_value(token.number)}")
                    morph = '_'.join(morph_parts)
                    analyzed_sent += f"{token.text}<#@_{tag_}_{morph}_@#>"
                else:
                    analyzed_sent += token.text + ' '
            if sentence_contains_word:
                analyzed_sentences.append(analyzed_sent)
            else:
                analyzed_sentences.append(sent_text)
        return ''.join(analyzed_sentences)
    else:
        return line

# analyze = морфология только для слов из списка omo_list.scy
if __name__ == '__main__':
    with Pool() as p:
        analyzed_lines = p.map(analyze_line, lines)
        for line in analyzed_lines:
            print(line, end='\n')