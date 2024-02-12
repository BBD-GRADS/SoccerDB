from read import read_fixtures, read_teams

def main():
    fixtures = read_fixtures()
    teams = read_teams()
    
    team_index = {}

    for index, team in enumerate(teams):
        team_index[team] = index + 1

    final_fixtures = []

    for fixture in fixtures:
        team_name = fixture[2]
        fixture[2] = team_index[team_name]

        line = "({}, {}, {}, {}, {})".format(
            *fixture
        )

        final_fixtures.append(line)
    
    print(*final_fixtures, sep=",\n")

if __name__ == "__main__":
    main()