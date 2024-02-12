import random

stats = []
"I know nested for loops are ugly and inefficient"

countStat = 1
for player in range(1, 21):
    for match in range(1, 11):
        # stats = (PlayerFixtureStatsID {PK} 1..5000,  PlayerID {FK} 1..100, FixtureID {FK} 1..50, Saves, Assists,
        # Goals, Tackles, YellowCards, RedCards, Fouls)
        stats.append(
            (countStat, player, match, random.choice([0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
             random.choice([0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3]),
             random.randint(0, 7), random.choice([0, 0, 0, 0, 1, 1]),
             random.choice([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2])))
        countStat = countStat + 1

for player in range(21, 41):
    for match in range(11, 21):
        stats.append(
            (countStat, player, match, random.choice([0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
             random.choice([0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3]),
             random.randint(0, 7), random.randint(0, 1), random.choice([0, 0, 0, 1, 1, 2]),
             random.choice([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1])))
        countStat = countStat + 1

for player in range(41, 61):
    for match in range(21, 31):
        stats.append(
            (countStat, player, match, random.choice([0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
             random.choice([0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3]),
             random.randint(0, 7), random.randint(0, 1), random.choice([0, 0, 0, 1, 1, 2]),
             random.choice([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1])))
        countStat = countStat + 1

for player in range(61, 81):
    for match in range(31, 41):
        stats.append(
            (countStat, player, match, random.choice([0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
             random.choice([0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3]),
             random.randint(0, 7), random.randint(0, 1), random.choice([0, 0, 0, 1, 1, 2]),
             random.choice([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1])))
        countStat = countStat + 1

for player in range(81, 101):
    for match in range(41, 51):
        stats.append(
            (countStat, player, match, random.choice([0, 0, 0, 0, 0, 1]), random.choice([0, 0, 0, 1, 1, 2]),
             random.choice([0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3]),
             random.randint(0, 7), random.randint(0, 1), random.choice([0, 0, 0, 1, 1, 2]),
             random.choice([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1])))
        countStat = countStat + 1

# Print the list
for item in stats:
    print(item, ',')
