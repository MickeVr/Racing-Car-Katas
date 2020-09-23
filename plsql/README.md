# Racing Car Katas

This is the PLSQL version of the Racing Car Katas.

## Installation

The project uses:

- Oracle PSQL, tested on version 12 and above
- [utPLSQL](https://github.com/utPLSQL)

Recommended:
- [Git](https://git-scm.com/downloads)

Clone the repository.

Install all the sql files with your favorite database client by executing:

```sh
./Racing-Car-Katas/plsql/install.sql
```

## Folders

- `src` - Contains the exercises :
  - Leaderboard
  - TelemetrySystem
  
- Each exercise directory contains a main and test folder
  - main - Contains the main code
  - test - Contains the corresponding tests

## Testing

utPLSQL is used to run tests. To execute all tests, run the following command on the database:

```shell script
exec ut.run();
```

To run only the tests of a single exercise, use the suite for the exercise, e.g.

```shell script
exec ut.run(':TelemetrySystem');
```

