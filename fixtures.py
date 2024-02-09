from playerData import random_date

data = []
teamID = [1, 2, 3, 4, 5]
opponents = [['Manchester United', 'Liverpool', 'Tottenham Hotspur', 'Sundowns', 'Pirates'],
             ['Everton', 'Man City', 'Chiefs', 'Lions', 'Bulls'],
             ['West Ham', 'Arsenal', 'Stormers', 'Sharks', 'Cheetahs'],
             ['Leeds', 'Brentford', 'Aston Villa', 'Pumas', 'Griquas'],
             ['Leinster', 'Munster', 'Ulster', 'Saracens', 'Toulon']]

runner = 0
slower = 0
for i in range(1, 51):
    temp = (
        i, teamID[slower], opponents[slower][runner], 1 if i <= 25 else 0, random_date(2024, 2024).strftime('%Y-%m-%d') + ' 17:00')

    runner = runner + 1
    if runner == 5:
        runner = 0
        slower = slower + 1
    if slower == 5:
        slower = 0

    data.append(temp)

# Print the list
for item in data:
    print(item, ',')
