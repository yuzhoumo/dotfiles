# Enable custom .python_history location on Python interactive console
# PYTHONSTARTUP environment variable should point to this file

import atexit
import os
import readline
import time


def write_history(path):
    import os
    import readline
    try:
        os.makedirs(os.path.dirname(path), mode=0o700, exist_ok=True)
        readline.write_history_file(path)
    except OSError:
        pass


cache_dir = os.environ.get('XDG_CACHE_HOME') or os.path.expanduser('~/.cache')
history_path = os.path.join(cache_dir, 'python_history')
try:
    readline.read_history_file(history_path)
except FileNotFoundError:
    pass

# Prevent creation of default history if custom is empty
if readline.get_current_history_length() == 0:
    readline.add_history(f'# History created at {time.asctime()}')

atexit.register(write_history, history_path)
del (atexit, os, readline, time, history_path, write_history)
