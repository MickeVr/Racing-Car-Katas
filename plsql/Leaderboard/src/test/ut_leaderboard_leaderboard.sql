CREATE OR REPLACE PACKAGE ut_leaderboard_leaderboard IS
   -- %suite(ut_leaderboard_leaderboard)
   -- %suitepath(Leaderboard)

   -- %beforeall
   PROCEDURE setup;

   -- %test(Should sum the points)
   PROCEDURE sum_the_points;


   -- %test(Should find the winner)
   PROCEDURE find_the_winner;

   -- %test(Should keep all drivers when same points)
   PROCEDURE keep_all_with_same_point;

   -- %test(Should find correct ranking with changing algorithm on self driving cars)
   PROCEDURE find_ranking_ch_algorithm;
END ut_leaderboard_leaderboard;
/

CREATE OR REPLACE PACKAGE BODY ut_leaderboard_leaderboard IS
   PROCEDURE setup IS
   BEGIN
      pack_leaderboard_testdata.setup_data;
   END setup;

   PROCEDURE sum_the_points IS
      results   string_integer_map;
   BEGIN
      --setup
      --done in package

      --act
      results := pack_leaderboard_testdata.sample_leaderboard1.driver_results();
      --verify
      ut.expect('Lewis Hamilton' MEMBER OF results.strings).to_be_true;
      ut.expect(results.get_int('Lewis Hamilton')).to_equal(18 + 18 + 25);
   END sum_the_points;

   PROCEDURE keep_all_with_same_point IS
      results   string_table;
   BEGIN
      --setup
      --done in package

      --act
      results := pack_leaderboard_testdata.sample_leaderboard1.driver_rankings();

      --verify
      ut.expect(results(1)).to_equal('Lewis Hamilton');
   END keep_all_with_same_point;

   PROCEDURE find_the_winner IS
      rankings            string_table;
      win_driver1         race;
      win_driver2         race;
      exEquoLeaderBoard   leaderboard;
   BEGIN
      --setup
      win_driver1 :=
         new race(
                'Australian Grand Prix',
                driver_table(pack_leaderboard_testdata.driver1, pack_leaderboard_testdata.driver2, pack_leaderboard_testdata.driver3));
      win_driver2 :=
         new race(
                'Malaysian Grand Prix',
                driver_table(pack_leaderboard_testdata.driver2, pack_leaderboard_testdata.driver1, pack_leaderboard_testdata.driver3));
      exEquoLeaderBoard := new leaderboard(race_table(win_driver1, win_driver2));

      --act
      rankings := exEquoLeaderBoard.driver_rankings();

      --verify
      ut.expect(rankings(1)).to_equal(pack_leaderboard_testdata.driver1.name);
      ut.expect(rankings(2)).to_equal(pack_leaderboard_testdata.driver2.name);
      ut.expect(rankings(3)).to_equal(pack_leaderboard_testdata.driver3.name);
   END find_the_winner;

   PROCEDURE find_ranking_ch_algorithm IS
      rankings   string_table;
   BEGIN
      --setup
      --in package

      --act
      rankings := pack_leaderboard_testdata.sample_leaderboard2.driver_rankings();

      --verify
      ut.expect(rankings.count, '3 participants').to_equal(3);
      ut.expect(rankings(1), 'Nr 1').to_equal(pack_leaderboard_testdata.driver2.name);
      ut.expect(rankings(2), 'Nr 2').to_equal(pack_leaderboard_testdata.driver1.name);
      ut.expect(rankings(3), 'Nr 3').to_equal(pack_leaderboard_testdata.driver4.name);
   END find_ranking_ch_algorithm;
END ut_leaderboard_leaderboard;
/