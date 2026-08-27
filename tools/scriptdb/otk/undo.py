"""Управление стеком отмены операций"""

class UndoManager:
    def __init__(self):
        self.undo_stack = []
        self.group_undo_active = False
        self.group_undo_buffer = []
    
    def start_group(self):
        """Начинает групповую операцию"""
        self.group_undo_active = True
        self.group_undo_buffer = []
    
    def end_group(self):
        """Завершает групповую операцию"""
        if self.group_undo_buffer:
            self.undo_stack.append(("group", self.group_undo_buffer))
        self.group_undo_active = False
        self.group_undo_buffer = []
    
    def add_action(self, action_type, li, ti, old_text, old_clean):
        """Добавляет действие в стек или буфер группы"""
        action = (action_type, li, ti, old_text, old_clean)
        if self.group_undo_active:
            self.group_undo_buffer.append(action)
        else:
            self.undo_stack.append(action)
    
    def pop(self):
        """Извлекает последнее действие или группу"""
        if self.undo_stack:
            return self.undo_stack.pop()
        return None
    
    def clear(self):
        """Очищает стек"""
        self.undo_stack.clear()
        self.group_undo_buffer.clear()
        self.group_undo_active = False
    
    def __len__(self):
        return len(self.undo_stack)
    
    def __bool__(self):
        return bool(self.undo_stack)

def apply_undo_action(action_data, lines, original_lines, dirty_lines):
    """Применяет отмену действия к данным"""
    if action_data[0] == "group":
        group_actions = action_data[1]
        affected_lines = set()
        for action, li, ti, old_text, old_clean in group_actions:
            t = lines[li][ti]
            t["text"] = old_text
            t["clean"] = old_clean
            affected_lines.add(li)
        return ("group", affected_lines, None)
    else:
        action, li, ti, old_text, old_clean = action_data
        t = lines[li][ti]
        t["text"] = old_text
        t["clean"] = old_clean
        return (action, {li}, old_clean)

def update_dirty_lines(dirty_lines, original_lines, lines, affected_lines):
    """Обновляет dirty_lines после отмены"""
    for li in affected_lines:
        if li in original_lines:
            current = "".join(t["text"] for t in lines[li])
            if current == original_lines[li]:
                dirty_lines.discard(li)
            else:
                dirty_lines.add(li)
        else:
            dirty_lines.add(li)
