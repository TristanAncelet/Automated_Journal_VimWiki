#!/usr/bin/python3

from pathlib import Path
from utils.py.journals import *
import os

PROJ_DIR=Path(os.getenv("PROJ_DIR"))
TASK_FILE=PROJ_DIR/"tasks.wiki"
NAV=os.getenv("SITE_NAV")

if not TASK_FILE.exists():
    TASK_FILE.touch()
else:
    # Clearing out the file
    with TASK_FILE.open('w') as file:
        file.write("")


with TASK_FILE.open('a') as file:
    file.write("%title Tasks\n\n\n")
    file.write(f"{NAV}\n")

    for fileobj in get_journal():
        filename = fileobj.name
        todo, done = get_task_lists(fileobj)

        if len(todo) != 0 or len(done) != 0:
            file_date=filename.split('.')[0].replace('-',' ')
            file.write(f"[[{filename}|{file_date}]]\n")

        if len(todo) != 0:
            file.write("TODO\n")
            file.write("----\n")

            for task in todo:
                task_string=task.replace('=','').strip()
                file.write(f"- [[{filename}#{task_string}|{task_string}]]\n")
            file.write("\n")

        if len(done) != 0:
            file.write("DONE\n")
            file.write("----\n")
            for task in done:
                task_string=task.replace('=','').strip()
                file.write(f"- [[{filename}#{task_string}|{task_string}]]\n")
            file.write("\n")
