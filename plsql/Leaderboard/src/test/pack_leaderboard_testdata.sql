CREATE OR REPLACE PACKAGE pack_leaderboard_testdata IS
   driver1               driver;
   driver2               driver;
   driver3               driver;
   driver4               self_driving_car;

   race1                 race;
   race2                 race;
   race3                 race;
   race4                 race;
   race5                 race;
   race6                 race;

   sample_leaderboard1   leaderboard;
   sample_leaderboard2   leaderboard;

   PROCEDURE setup_data;
END pack_leaderboard_testdata;
/

CREATE OR REPLACE PACKAGE BODY pack_leaderboard_testdata IS
   PROCEDURE setup_data IS
   BEGIN
      driver1 := new driver('Nico Rosberg', 'DE');
      driver2 := new driver('Lewis Hamilton', 'UK');
      driver3 := new driver('Sebastian Vettel', 'DE');
      driver4 := new self_driving_car('1.2', 'Acme');

      race1 := new race('Australian Grand Prix', driver_table(driver1, driver2, driver3));
      race2 := new race('Malaysian Grand Prix', driver_table(driver3, driver2, driver1));
      race3 := new race('Chinese Grand Prix', driver_table(driver2, driver1, driver3));
      race4 := new race('Fictional Grand Prix 1', driver_table(driver1, driver2, driver4));
      race5 := new race('Fictional Grand Prix 2', driver_table(driver4, driver2, driver1));

      driver4.algorithm_version := '1.3';
      race6 := new race('Fictional Grand Prix 3', driver_table(driver2, driver1, driver4));

      sample_leaderboard1 := new leaderboard(race_table(race1, race2, race3));
      sample_leaderboard1 := new leaderboard(race_table(race4, race5, race6));
   END setup_data;
BEGIN
   setup_data;
END pack_leaderboard_testdata;
/