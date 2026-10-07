"""Управление кэшем списков вхождений"""


class OccurrenceCache:
    def __init__(self, max_size=20):
        self.max_size = max_size
        self.cache_dict = {}
        self.cache_order = []

    def get(self, key):
        if key in self.cache_dict:
            return self.cache_dict[key]
        return None

    def put(self, key, value):
        if key in self.cache_dict:
            self.cache_order.remove(key)
        self.cache_dict[key] = value
        self.cache_order.append(key)
        if len(self.cache_order) > self.max_size:
            old_key = self.cache_order.pop(0)
            del self.cache_dict[old_key]

    def remove(self, key):
        if key in self.cache_dict:
            del self.cache_dict[key]
            if key in self.cache_order:
                self.cache_order.remove(key)

    def clear(self):
        self.cache_dict.clear()
        self.cache_order.clear()

    def __len__(self):
        return len(self.cache_dict)


def update_cache_entry(cache_manager, word, li, ti, lines, detokenize_fn, is_unaccented_fn,
                       context_length, fit_prefix=None, fit_suffix=None,
                       max_prefix_px=None, max_suffix_px=None):
    """Обновляет одно вхождение в кэше"""
    cache_key = (word, True)
    cached = cache_manager.get(cache_key)
    if not cached:
        return
    batch = cached[0]
    om_width = cached[1]
    rest = tuple(cached[2:])
    for idx, b in enumerate(batch):
        if b[1] == li and b[2] == ti:
            tokens = lines[li]
            t = tokens[ti]
            line_str = detokenize_fn(tokens).rstrip("\n\r")
            pos = 0
            for tj in range(ti):
                pos += len(tokens[tj]["text"])
            om_start = pos
            om_end = pos + len(t["text"])
            if fit_prefix is not None and max_prefix_px:
                prefix = fit_prefix(line_str[:om_start], max_prefix_px, context_length or None)
            else:
                ctx_start = max(0, om_start - context_length)
                prefix = line_str[ctx_start:om_start]
                if ctx_start > 0:
                    prefix = "◊" + prefix
            if fit_suffix is not None and max_suffix_px:
                suffix = fit_suffix(line_str[om_end:], max_suffix_px)
            else:
                ctx_end = min(len(line_str), om_end + context_length)
                suffix = line_str[om_end:ctx_end]
                if ctx_end < len(line_str):
                    suffix = suffix + "◊"
            batch[idx] = (li + 1, li, ti, prefix, t["text"], suffix, not is_unaccented_fn(t["text"]))
            cache_manager.put(cache_key, (batch, om_width) + rest)
            break


def build_fill_queue(scripts_info, cache_size, auto_cache_size):
    """Строит очередь слов для заполнения кэша"""
    words = sorted(
        [
            w
            for w in scripts_info
            if scripts_info[w].get("file") is not None and scripts_info[w].get("unaccented_count", 0) > 0
        ],
        key=lambda w: scripts_info[w].get("unaccented_count", 0),
        reverse=True,
    )
    limit = max(1, cache_size - 10)
    limit = min(limit, auto_cache_size) if auto_cache_size > 0 else limit
    return list(words[:limit])
