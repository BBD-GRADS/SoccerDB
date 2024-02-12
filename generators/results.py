import random

results = []
for i in range(1, 51):
    results.append((i, i, random.randint(0, 4), random.randint(0, 3)))

# Print the list
for item in results:
    print(item, ',')

