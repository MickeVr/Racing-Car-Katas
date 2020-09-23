CREATE OR REPLACE PACKAGE ut_leaderboard_race IS
   -- %suite(ut_leaderboard_race)
   -- %suitepath(Leaderboard)

   -- %test(Should calculate driver points)
   PROCEDURE should_calculate_driver_points;
END ut_leaderboard_race;
/

CREATE OR REPLACE PACKAGE BODY ut_leaderboard_race IS
   PROCEDURE should_calculate_driver_points IS
   BEGIN
      ut.expect(pack_leaderboard_testdata.race1.get_points(pack_leaderboard_testdata.driver1)).to_equal(25);
      ut.expect(pack_leaderboard_testdata.race1.get_points(pack_leaderboard_testdata.driver2)).to_equal(18);
      ut.expect(pack_leaderboard_testdata.race1.get_points(pack_leaderboard_testdata.driver3)).to_equal(15);
   END should_calculate_driver_points;
END ut_leaderboard_race;
/