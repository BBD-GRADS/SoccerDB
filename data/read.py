import numpy as np

def read_fixtures() -> list:
    FIXTURES_FILE = "fixtures.txt"
    fixtures = []

    with open(FIXTURES_FILE, "r") as file:
        for line in file.readlines():
            clean_line = line.strip().split(",")
            fixtures.append(clean_line)

    return fixtures

def read_teams() -> list:
    TEAM_FILE = "teams.txt"

    teams = []

    with open(TEAM_FILE, "r") as file:
        for line in file.readlines():
            teams.append(line.strip())

    return teams


def read_staff() -> list:
    STAFF_FILE = "staff.txt"
    DELIMITER = ";"

    staff_names = []
    staff_surnames = []

    with open(STAFF_FILE, "r") as file:
        for line in file.readlines():
            name, surname = line.split(DELIMITER)
            staff_names.append(name)
            staff_surnames.append(surname.strip())

    np.random.shuffle(staff_names)
    np.random.shuffle(staff_surnames)
    return staff_names, staff_surnames


def read_staff_codes():
    staff_codes = ["Coach", "AssistantCoach", "Physio", "Accountant"]
    return staff_codes


def read_position_codes():
    position_codes = [
        "GK",
        "LB",
        "CB",
        "RB",
        "LWB",
        "RWB",
        "CDM",
        "LM",
        "CM",
        "RM",
        "CAM",
        "LW",
        "LF",
        "CF",
        "RF",
        "RW",
        "ST",
    ]

    return position_codes
