"""Парсинг .sh скриптов омографов"""

import re
from pathlib import Path

def parse_script(script_file):
    """Парсит один .sh скрипт и возвращает (info dict, target_file)"""
    try:
        with open(script_file, "r", encoding="utf-8") as f:
            content = f.read()
        
        info = {
            "file": script_file,
            "word": "",
            "variants": [],
            "unaccented_count": 0,
            "auto_pattern": "",
        }
        target_file = None
        
        for line in content.split("\n"):
            if "Автошаблон:" in line:
                m = re.search(r"Автошаблон:\s*(\S+)", line)
                if m:
                    info["auto_pattern"] = m.group(1)
            if "По умолчанию:" in line:
                m = re.search(r"По умолчанию:\s*(\S+)", line)
                if m:
                    info["default"] = m.group(1)
            if "Всего найдено:" in line:
                m = re.search(r"Всего найдено:\s*(\d+)", line)
                if m:
                    info["total_found"] = int(m.group(1))
            if "#" in line and "<=" in line and not line.strip().startswith("0)"):
                m = re.search(r"#\s+(\S+)\s*<=\s*(\S+)", line)
                if m:
                    info["variants"].append({"accented": m.group(1), "plain": m.group(2)})
            # Извлекаем путь к целевому файлу из sed-строки
            if "sed -ri" in line and target_file is None:
                m = re.search(r"sed -ri.*?\.\./(\S+)", line)
                if m:
                    target_file = script_file.parent.parent / m.group(1)
        
        if info["variants"]:
            info["word"] = info["variants"][0]["plain"]
            if "default" not in info:
                info["default"] = info["variants"][0]["accented"]
        
        return info, target_file
    except Exception as e:
        print(f"Ошибка парсинга {script_file}: {e}")
        return None, None

def load_scripts(script_dir):
    """Загружает все .sh скрипты из директории"""
    scripts_info = {}
    target_file = None
    
    for script_file in script_dir.glob("*.sh"):
        if script_file.name == "stripper.sh":
            continue
        
        info, script_target = parse_script(script_file)
        if info and info["variants"]:
            scripts_info[info["word"]] = info
            if script_target and target_file is None:
                target_file = script_target
    
    return scripts_info, target_file
