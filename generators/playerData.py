import random
from datetime import datetime, timedelta
import io


# Function to generate a random date between 2006 and 2010
def random_date(yearStart=2006, yearEnd=2010):
    start_date = datetime(yearStart, 1, 1)
    end_date = datetime(yearEnd, 12, 31)

    return start_date + timedelta(
        seconds=random.randint(0, int((end_date - start_date).total_seconds())))


if __name__ == '__main__':
    f = open('babynames-clean.csv')
    names = []
    count = 0
    for line in f:
        names.append(line[:line.index(',')])
        count += 1
        if count > 99:
            break
    f.close()
    surnamesAll = []
    count = 0
    with io.open('intersurnames.csv', encoding='utf-8') as infile:
        for line in infile:
            if count > 99:
                break
            count += 1
            if not line.isascii():
                continue
            line = line[:line.index(',')].lower()
            if len(line) <= 1:
                continue
            first = line[0].upper()
            line = first + line[1:]
            surnamesAll.append(line)

    surnames = []
    for k in range(0, 100):
        k += 1
        ra = random.randint(0, len(surnamesAll) - 1)
        surnames.append(surnamesAll[ra])

    players = []
    tID = -1
    for i in range(1, 101):
        if i in range(1, 21):
            tID = 1  # H
        elif i in range(21, 41):
            tID = 2
        elif i in range(41, 61):
            tID = 3
        elif i in range(61, 81):
            tID = 4
        elif i in range(81, 101):
            tID = 5
        temp = (
            i, random.choice(names), random.choice(surnames), random_date().strftime('%Y-%m-%d'), random.randint(1, 17),
            tID)
        players.append(temp)
    # Print the list
    for item in players:
        print(item, ',')
