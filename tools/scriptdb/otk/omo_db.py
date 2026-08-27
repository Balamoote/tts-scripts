"""Загрузка базы омографов из gz файлов"""

import gzip
import json
from pathlib import Path

def parse_variants(parts, word):
    variants = []
    for v in parts[1:]:
        accented = v.replace("'", "\u0301")
        variants.append({"accented": accented, "plain": word})
    return variants

def load_omo_db(app_dir, progress_var=None, root=None):
    """Загружает базу омографов из mano-lc, mano-uc, uniomo, automo"""
    db_file = app_dir / "scriptaux" / "omo_db.json"
    scriptdb_dir = app_dir / "scriptdb"
    sources = ("mano-lc.gz", "mano-uc.gz", "uniomo.gz", "automo.gz")
    need_rebuild = not db_file.exists()
    
    if not need_rebuild:
        try:
            db_mtime = db_file.stat().st_mtime
            for fname in sources:
                fpath = scriptdb_dir / fname
                if fpath.exists() and fpath.stat().st_mtime > db_mtime:
                    need_rebuild = True
                    break
        except Exception:
            need_rebuild = True

    if need_rebuild:
        if progress_var:
            progress_var.set("Построение базы омографов ... ждите")
        if root:
            root.update_idletasks()
        
        omo_db = {}

        # 1. mano-lc — все регистры
        fpath = scriptdb_dir / "mano-lc.gz"
        if fpath.exists():
            try:
                with gzip.open(fpath, "rt", encoding="utf-8") as f:
                    for line in f:
                        line = line.strip()
                        if not line or line.startswith("#"):
                            continue
                        parts = line.split()
                        if len(parts) < 2:
                            continue
                        word = parts[0].lstrip("_").split("=")[0].strip()
                        variants = parse_variants(parts, word)
                        if word and variants:
                            for key in (word, word.capitalize(), word.upper()):
                                if key not in omo_db:
                                    omo_db[key] = {"variants": variants, "auto_pattern": ""}
            except Exception as e:
                print(f"Ошибка чтения mano-lc.gz: {e}")

        # 2. mano-uc — только с заглавной и верхним
        fpath = scriptdb_dir / "mano-uc.gz"
        if fpath.exists():
            try:
                with gzip.open(fpath, "rt", encoding="utf-8") as f:
                    for line in f:
                        line = line.strip()
                        if not line or line.startswith("#"):
                            continue
                        parts = line.split()
                        if len(parts) < 2:
                            continue
                        word = parts[0].lstrip("_").split("=")[0].strip()
                        variants = parse_variants(parts, word)
                        if word and variants:
                            for key in (word.capitalize(), word.upper()):
                                if key not in omo_db:
                                    omo_db[key] = {"variants": variants, "auto_pattern": ""}
            except Exception as e:
                print(f"Ошибка чтения mano-uc.gz: {e}")

        # 3. uniomo — дополняем варианты
        fpath = scriptdb_dir / "uniomo.gz"
        if fpath.exists():
            try:
                with gzip.open(fpath, "rt", encoding="utf-8") as f:
                    for line in f:
                        line = line.strip()
                        if not line or line.startswith("#"):
                            continue
                        parts = line.split()
                        if len(parts) < 2:
                            continue
                        word = parts[0].lstrip("_").split("=")[0].strip()
                        variants = parse_variants(parts, word)
                        if not variants:
                            continue
                        for key in (word, word.capitalize(), word.upper()):
                            if key in omo_db:
                                existing = {v["accented"] for v in omo_db[key]["variants"]}
                                for v in variants:
                                    if v["accented"] not in existing:
                                        omo_db[key]["variants"].append(v)
                                        existing.add(v["accented"])
            except Exception as e:
                print(f"Ошибка чтения uniomo.gz: {e}")

        # 4. automo — шаблоны
        fpath = scriptdb_dir / "automo.gz"
        if fpath.exists():
            try:
                with gzip.open(fpath, "rt", encoding="utf-8") as f:
                    for line in f:
                        line = line.strip()
                        if not line:
                            continue
                        parts = line.split()
                        if len(parts) >= 4:
                            pattern = parts[0]
                            word = parts[1]
                            for key in (word, word.capitalize(), word.upper()):
                                if key in omo_db:
                                    omo_db[key]["auto_pattern"] = pattern
            except Exception as e:
                print(f"Ошибка чтения automo.gz: {e}")

        try:
            db_file.parent.mkdir(parents=True, exist_ok=True)
            with open(db_file, "w", encoding="utf-8") as f:
                json.dump(omo_db, f, ensure_ascii=False, indent=1)
        except Exception as e:
            print(f"Ошибка сохранения omo_db.json: {e}")
        return omo_db
    else:
        try:
            with open(db_file, "r", encoding="utf-8") as f:
                return json.load(f)
        except Exception:
            return {}

