from random import choice
from playerData import random_date

fixtures = []
teamID = [1, 2, 3, 4, 5]
opponents = [['Manchester United', 'Liverpool', 'Tottenham Hotspur', 'Sundowns', 'Pirates'],
             ['Everton', 'Man City', 'Chiefs', 'Lions', 'Bulls'],
             ['West Ham', 'Arsenal', 'Stormers', 'Sharks', 'Cheetahs'],
             ['Leeds', 'Brentford', 'Aston Villa', 'Pumas', 'Griquas'],
             ['Leinster', 'Munster', 'Ulster', 'Saracens', 'Toulon']]

runner = 0
slower = 0
tID = -1
temp = ()
for i in range(1, 51):
    if i in range(1, 11):
        tID = 1
    elif i in range(11, 21):
        tID = 2
    elif i in range(21, 31):
        tID = 3
    elif i in range(31, 41):
        tID = 4
    elif i in range(41, 51):
        tID = 5

    temp = (
        i, tID, opponents[tID - 1][runner], 0 if i % 2 == 0 else 1,
        random_date(2024, 2024).strftime('%Y-%m-%d') + ' ' + choice(['17:00', '15:00', '13:00']))
    runner = runner + 1
    if runner == 5:
        runner = 0
    fixtures.append(temp)

# Print the list
for item in fixtures:
    print(item, ',')
