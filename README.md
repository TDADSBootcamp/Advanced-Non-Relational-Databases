Supporting materials for Data Science Bootcamp - Big Data Ecosystem

# Contents

Each of the following have their own README.md instructions.

- [python/race_condition](python/race_condition) demonstrates incorrect final values of a shared counter when incremented by multiple threads concurrently.
- [python/awesome_game](python/awesome_game) supports an exercise to manually walk through a map/reduce process to produce a leaderboard from player scores.
- [python/word_count](python/word_count) is a mapper and reducer in Python to implement a word count over text input.
- [python/knn](python/knn) implements a k-nearest neighbours classifier using two map/reduce operations.

# Running without Hadoop

We can test our mappers and reducers by piping outputs to input and using the `sort` command line tool to simulate the shuffle step.

Example: `cat myfile.txt | python mapper.py | sort | python reducer.py`

# Running Hadoop

You can optionally run a real Hadoop cluster on your VM to process these jobs.

