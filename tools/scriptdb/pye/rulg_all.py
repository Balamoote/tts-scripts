# Модуль обработки текста для получения дополнительных признаков для снятия омографии.
# Служит только для создания временной версии книги для вычленения оттуда этих признаков.
# Уже существующая инфраструктура на gawk, sed и т.п. используется в том числе для устранения
# замеченных ошибок в работе модели spaCy или там, где этам модель не дает достаточных данных.

# Установка spaCy

# pip install -U pip setuptools wheel
# pip install -U spacy
# python -m spacy download ru_core_news_lg

import sys
from multiprocessing import Pool
from pathlib import Path
import spacy
import re

# Загрузить модель spaCy, при этом нужно выдать морфологическую информацию по омографам
nlp = spacy.load('ru_core_news_lg', disable=['lemmatizer'])

# Прочитать из stdin текст и разбить его на стрроки в массив lines
file_contents = sys.stdin.read()
lines = file_contents.split('\n')

# Загрузить список омографов
if len(sys.argv) > 1:
    omo_list_path = Path(sys.argv[1])
else:
    omo_list_path = Path("omo_list.scy.gz")

with open(omo_list_path, 'r') as f:
    omo_list = {word.strip() for word in f}

def analyze_line(line):
    words = set(word.lower() for word in re.split('[^а-яёА-ЯЁ]+', line) if word.lower() in omo_list)
    if words:
        analyzed_sentences = []
        for sent in re.split("(?<=[.!?…;])\s+", line):
            sent_text = sent.lstrip() + ' ' 
            if not sent_text:
                continue
            sentence_contains_word = False
            analyzed_sent = ''
            doc = nlp(sent_text)
            for token in doc:
                    sentence_contains_word = True
                    tag_ = token.tag_
                    morph = '_'.join([str(m) for m in token.morph])
                    analyzed_sent += f"{token.text_with_ws}<#@_{tag_}_{morph}_@#>"
            if sentence_contains_word:
                analyzed_sentences.append(analyzed_sent)
            else:
                analyzed_sentences.append(sent_text)
        return ' '.join(analyzed_sentences)
    else:
        return line

# analyze = морфология только для предложений со словами из списка omo_list.scy
if __name__ == '__main__':
    with Pool() as p:
        analyzed_lines = p.map(analyze_line, lines)
        for line in analyzed_lines:
            print(line, end='\n')
