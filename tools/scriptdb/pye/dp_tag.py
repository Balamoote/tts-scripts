# Модуль обработки текста для получения дополнительных признаков для снятия омографии.
# Использует DeepPavlov morpho_ru_syntagrus_bert для морфологического анализа
# Оптимизирован для CUDA с батчевой обработкой

import sys
import gzip
from pathlib import Path
import re
import os

os.environ["KERAS_BACKEND"] = "tensorflow"

from deeppavlov import build_model


def parse_conllu(sentence):
    """Парсит результат DeepPavlov в формате CoNLL-U"""
    tokens = []
    for line in sentence.split("\n"):
        if line.strip() and not line.startswith("#"):
            parts = line.split("\t")
            if len(parts) >= 6:
                tokens.append(
                    {
                        "text": parts[1],
                        "lemma": parts[2],
                        "pos": parts[3],
                        "tag": parts[4] if parts[4] != "_" else "",
                        "morph": parts[5] if parts[5] != "_" else "",
                    }
                )
    return tokens


def process_sentence(sent, words, tokens):
    """Обрабатывает одно предложение и возвращает размеченный текст"""
    analyzed_sent = ""
    original_words = sent.split()
    token_index = 0

    for word in original_words:
        text_lower = word.lower().strip(".,!?;:\"'()[]{}")

        if text_lower in words and token_index < len(tokens):
            token = tokens[token_index]
            morph = token["morph"].replace("|", "_")
            pos = token["pos"]
            analyzed_sent += f"{word}<#@_{pos}_{morph}_@#> "
        elif token_index < len(tokens) and tokens[token_index]["pos"] == "PROPN":
            token = tokens[token_index]
            morph = token["morph"].replace("|", "_").replace("=", "_")
            pos = token["pos"]
            analyzed_sent += f"{word}<#@_{pos}_{morph}_@#> "
        else:
            analyzed_sent += word + " "

        token_index += 1

    return analyzed_sent


def analyze_batch(lines, omo_list, model):
    """Батчевая обработка строк для эффективного использования CUDA"""

    # Подготовка всех предложений для обработки
    sentences_to_process = []
    sentence_info = []

    for line_idx, line in enumerate(lines):
        words = set(word.lower() for word in re.split("[^а-яёА-ЯЁ]+", line) if word.lower() in omo_list)
        if words:
            for sent in re.split(r"(?<=[.!?…;])\s+", line):
                sent_text = sent.strip()
                if sent_text:
                    sentences_to_process.append(sent_text)
                    sentence_info.append((line_idx, words, sent_text))

    # Батчевая обработка всех предложений
    results = []
    batch_size = 32  # Оптимальный размер батча для CUDA

    for i in range(0, len(sentences_to_process), batch_size):
        batch = sentences_to_process[i : i + batch_size]
        try:
            batch_results = model(batch)
            results.extend(batch_results)
        except Exception as e:
            print(f"Error processing batch: {e}", file=sys.stderr)
            # В случае ошибки обрабатываем по одному
            for sent in batch:
                try:
                    single_result = model([sent])
                    results.append(single_result[0])
                except:
                    results.append("")

    # Сборка результатов
    analyzed_sentences = {}
    for info, result in zip(sentence_info, results):
        line_idx, words, sent_text = info
        tokens = parse_conllu(result) if result else []
        analyzed = process_sentence(sent_text, words, tokens)

        if line_idx not in analyzed_sentences:
            analyzed_sentences[line_idx] = []
        analyzed_sentences[line_idx].append((sent_text, analyzed))

    # Формирование итоговых строк
    final_lines = []
    for line_idx, line in enumerate(lines):
        if line_idx in analyzed_sentences:
            # Заменяем только те предложения, которые были обработаны
            new_line = line
            for sent_text, analyzed in analyzed_sentences[line_idx]:
                new_line = new_line.replace(sent_text, analyzed)
            final_lines.append(new_line)
        else:
            final_lines.append(line)

    return final_lines


if __name__ == "__main__":
    # Загрузка модели
    print("Loading model...", file=sys.stderr)
    model = build_model("morpho_ru_syntagrus_bert", download=True)
    print("Model loaded.", file=sys.stderr)

    # Чтение входных данных
    file_contents = sys.stdin.read()
    lines = file_contents.split("\n")

    # Загрузка списка омографов
    if len(sys.argv) > 1:
        omo_list_path = Path(sys.argv[1])
    else:
        omo_list_path = Path("omo_list.phy.gz")

    with gzip.open(omo_list_path, "rt") as f:
        omo_list = {word.strip() for word in f}

    print(f"Processing {len(lines)} lines...", file=sys.stderr)

    # Обработка
    analyzed_lines = analyze_batch(lines, omo_list, model)

    # Вывод результатов
    for line in analyzed_lines:
        print(line, end="\n")

    print("Done.", file=sys.stderr)
