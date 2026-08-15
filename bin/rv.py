import json
import pathlib 
import random
import argparse
import subprocess

# Insert your path
database = pathlib.Path("/home/user/bin/db.json")
watched = pathlib.Path("/home/user/bin/watched.json")

def load_db(path):
    with open(path, "r") as file:
        return json.load(file)

def save_db(path, db):
    with open(path, "w") as file:
        json.dump(db, file, indent=4)

def check_in(url):
    db = load_db(watched)
    db.append(url)
    save_db(watched, db)

def add(url):
    db = load_db(database)
    db.append(url)
    save_db(database, db)

def pick_random_video():
    url = random.choice(load_db(database))
    subprocess.run(["bspc", "desktop", "-f", "7"])
    subprocess.run(["firefox", url])
    subprocess.run(["bspc", "desktop", "-f", "last"])
    res = subprocess.run([
        "zenity", "--question",
        "--text=Move video to watched?",
        '--ok-label=Yes', 
        '--cancel-label=No'
    ])
    if res.returncode == 0:
        check_in(url)
        remove_video(url)
        subprocess.run(["notify-send", f"Watched: {len(load_db(watched))}\nRemains: {len(load_db(database))}"])

def list_videos():
    print(f"Watched: {len(load_db(watched))}, Remains: {len(load_db(database))}")
    return load_db(database), load_db(watched)
 
def remove_video(url):
    db = load_db(database)
    db.remove(url)
    save_db(database, db)

def main():
    parser = argparse.ArgumentParser(
        description="enjoy"
    )

    subparsers = parser.add_subparsers(dest="command")

    # add
    add_parser = subparsers.add_parser("add")
    add_parser.add_argument("url")

    # rm 
    add_parser = subparsers.add_parser("rm")
    add_parser.add_argument("url")

    # rm 
    add_parser = subparsers.add_parser("watched")
    add_parser.add_argument("url")

    # random
    subparsers.add_parser("random")

    # list
    subparsers.add_parser("list")

    args = parser.parse_args()

    if args.command == "add":
        add(args.url)

    elif args.command == "rm":
        remove_video(args.url)

    elif args.command == "random":
        pick_random_video()

    elif args.command == "list":
        list_videos()

    elif args.command == "watched": 
        check_in(args.url)

    else:
        parser.print_help()


if __name__ == "__main__":
    main()

