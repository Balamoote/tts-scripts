import sys
import gzip
from multiprocessing import Pool
from pathlib import Path
import re
from natasha import (
    Doc,
    MorphVocab,
    Segmenter,
    NewsEmbedding,
    NewsMorphTagger,
)

# Load the Natasha model for morphological analysis
segmenter = Segmenter()
emb = NewsEmbedding()
morph_tagger = NewsMorphTagger(emb)

# Read text from stdin and split it into lines
file_contents = sys.stdin.read()
lines = file_contents.split('\n')

# Load the list of homographs
if len(sys.argv) > 1:
    omo_list_path = Path(sys.argv[1])
else:
    omo_list_path = Path("omo_list.phy.gz")

with gzip.open(omo_list_path, 'rt') as f:
    omo_list = {word.strip() for word in f}

def format_morphology(morph):
    formatted_morph = '_'.join([f"{key}={value}" for key, value in morph.items()])
    return formatted_morph

def analyze_line(line):
    words = set(word.lower() for word in re.split('[^а-яёА-ЯЁ]+', line) if word.lower() in omo_list)
    analyzed_tokens = []
    for token in re.split('([а-яёА-ЯЁ]+)', line):
        if token and (token.lower() in words or token[0].isupper()):
            doc = Doc(token)
            doc.segment(segmenter)
            doc.tag_morph(morph_tagger)
            for t in doc.tokens:
                tag_ = t.pos
                morph = format_morphology(t.feats)
                if token[0].isupper() and tag_ != 'PROPN':
                    analyzed_tokens.append((token, ''))
                else:
                    analyzed_tokens.append((t.text, f"<#@_{tag_}_{morph}_@#>"))
        else:
            analyzed_tokens.append((token, ''))

    analyzed_line = ''
    for i, (token_text, morph) in enumerate(analyzed_tokens):
        analyzed_line += token_text + morph
        if i < len(analyzed_tokens) - 1:
            next_token_text = analyzed_tokens[i + 1][0]
            if next_token_text and next_token_text[0].isalpha():
                analyzed_line += ''

    return analyzed_line

# analyze = morphology only for words from the omo_list.phy and proper names
if __name__ == '__main__':
    with Pool() as p:
        analyzed_lines = p.map(analyze_line, lines)
        for line, analyzed_line in zip(lines, analyzed_lines):
            print(analyzed_line, end='\n')
