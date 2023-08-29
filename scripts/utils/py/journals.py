#!/usr/bin/python3

from pathlib import Path
import re

TIME_REGEX=re.compile(r"= .* =")
TOPIC_REGEX=re.compile(r"===[=]* .* ===[=]*")
TASK_REGEX=re.compile(r"==== .* ====")
TASK_DONE_REGEX=re.compile(r".*(DUE:\s*DONE).*")

JOURNAL_PATH = Path.home() / "Journal"

def get_journals() -> list[Path]:
    journals = { journal.name:journal for journal in JOURNAL_PATH.glob("20??-??-??.wiki") }
    journal_names = sorted(journals)
    return journals
    
def get_journal() -> Path:
    journals = get_journals()
    for name in sorted(journals):
        yield journals[name]

def get_tasks(file:Path) -> list[str]:
    with file.open('r') as openFile:
        tasks = TASK_REGEX.findall(openFile.read())
    return tasks

def get_task_lists(file:Path) -> tuple[list,list]:
    todo = list()
    done = list()

    for task in get_tasks(file):
        if TASK_DONE_REGEX.match(task):
            done.append(task)
        else:
            todo.append(task)
    return todo, done

def get_all_tasks() -> dict[Path:list[str]]:
    file_tasks = { file:get_tasks(file) for file in get_journal() }
    return file_tasks


