import random
from datetime import datetime

# Read all fixtures into a list
with open('fixtures.txt') as file:
    lines = file.readlines()
    fixtures = [line.strip().split(',') for line in lines]

def checkDate(fID):
    if datetime.strptime(fixtures[fID - 1][-1][1:-7], "%Y-%m-%d").date() > datetime.now().date():
        return False
    else:
        return True

stats = []
# "I know nested for loops are ugly and inefficient"

countStat = 1
for player in range(1, 21):
    for match in range(1, 11):
        if checkDate(match):
            # stats = (PlayerFixtureStatsID {PK} 1..5000,  PlayerID {FK} 1..100, FixtureID {FK} 1..50, Saves, Assists,
            # Goals, Tackles, YellowCards, RedCards, Fouls)
            stats.append(
                (player, match, random.choice([0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
                 random.choice([0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3]),
                 random.randint(0, 7), random.choice([0, 0, 0, 0, 1, 1]),
                 random.choice([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
                 random.randrange(20, 90)))


for player in range(21, 41):
    for match in range(11, 21):
        if checkDate(match):
            stats.append(
                (player, match, random.choice([0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
                 random.choice([0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3]),
                 random.randint(0, 7), random.choice([0, 0, 0, 0, 1, 1]),
                 random.choice([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
                 random.randrange(20, 90)))


for player in range(41, 61):
    for match in range(21, 31):
        if checkDate(match):
            stats.append(
                (player, match, random.choice([0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
                 random.choice([0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3]),
                 random.randint(0, 7), random.choice([0, 0, 0, 0, 1, 1]),
                 random.choice([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
                 random.randrange(20, 90)))


for player in range(61, 81):
    for match in range(31, 41):
        if checkDate(match):
            stats.append(
                (player, match, random.choice([0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
                 random.choice([0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3]),
                 random.randint(0, 7), random.choice([0, 0, 0, 0, 1, 1]),
                 random.choice([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
                 random.randrange(20, 90)))


for player in range(81, 101):
    for match in range(41, 51):
        if checkDate(match):
            stats.append(
                (player, match, random.choice([0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
                 random.choice([0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3]),
                 random.randint(0, 7), random.choice([0, 0, 0, 0, 1, 1]),
                 random.choice([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
                 random.randrange(20, 90)))


# Print the list
for item in stats:
    print(item, ',')

fileStats = open('fixtureStats.txt', 'w')
for item in stats:
    fileStats.write(str(item) + ',\n')
fileStats.close()

