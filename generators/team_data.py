import numpy as np
from read import read_teams

CLUB_TEAMS_COUNT = 5
FIELDS = ["TeamID", "Name", "IsOurClub"]


def main():
    print(*FIELDS, sep="\t")
    teams = read_teams()
    lines = []

    for index, name in enumerate(teams):
        is_part_of_club = 1 if index < CLUB_TEAMS_COUNT else 0
        line = "({}, '{}', {})".format(index, name, is_part_of_club)
        lines.append(line)

    print(*lines, sep=",\n")


if __name__ == "__main__":
    main()
