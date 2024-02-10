import numpy as np
from read import read_staff, read_teams, read_staff_codes


def main():
    staff_codes = read_staff_codes()
    num_staff_codes = len(staff_codes)

    staff_names, staff_surnames = read_staff()

    teams = read_teams()[:10]
    num_teams = len(teams)
    num_staff = len(staff_names)

    staff_per_team = max(1, num_staff // num_teams)
    team_id = 0
    staff_members = []

    for staff_id, staff_info in enumerate(zip(staff_names, staff_surnames)):
        if staff_id % staff_per_team == 0:
            team_id += 1

        staff_code_id = staff_id % staff_per_team

        line = "({}, {}, {}, '{}', '{}')".format(
            staff_id,
            staff_code_id,
            team_id,
            staff_info[0],
            staff_info[1],
        )

        staff_members.append(line)

    print(*staff_members, sep=",\n")


if __name__ == "__main__":
    main()
