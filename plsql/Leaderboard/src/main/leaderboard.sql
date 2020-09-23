CREATE OR REPLACE TYPE leaderboard FORCE IS OBJECT
(
   race_list race_table,
   CONSTRUCTOR FUNCTION leaderboard(SELF IN OUT NOCOPY leaderboard)
      RETURN SELF AS RESULT,
   MEMBER FUNCTION driver_results
      RETURN string_integer_map,
   MEMBER FUNCTION driver_rankings
      RETURN string_table
);


CREATE OR REPLACE TYPE BODY leaderboard IS
   CONSTRUCTOR FUNCTION leaderboard(SELF IN OUT NOCOPY leaderboard)
      RETURN SELF AS RESULT IS
   BEGIN
      SELF.race_list := race_table();
      RETURN;
   END leaderboard;

   MEMBER FUNCTION driver_results
      RETURN string_integer_map IS
      results          string_integer_map := string_integer_map();
      driver_name      VARCHAR2(500);
      current_race     race;
      current_driver   driver;
      points           INTEGER;
   BEGIN
      FOR indx_race IN 1 .. race_list.COUNT
      LOOP
         current_race := race_list(indx_race);
      
         FOR indx_driver IN 1 .. current_race.results.COUNT
         LOOP
            current_driver := current_race.results.get(indx_driver);
            driver_name := current_race.get_driver_name(current_driver);
            points := current_race.get_points(current_driver);
            IF (driver_name MEMBER OF results.strings) THEN
               results.put(driver_name, results.get_int(driver_name) + points);
            ELSE
               results.put(driver_name, points);
            END IF;
         END LOOP;
      END LOOP;

      RETURN results;
   END driver_results;

   MEMBER FUNCTION driver_rankings
      RETURN string_table IS
      results        string_integer_map;
      result_table   string_table;
   BEGIN
      results := driver_results();

      WITH
         t_names AS(SELECT ROWNUM idx, COLUMN_VALUE name FROM TABLE(results.strings)),
         t_ranks AS(SELECT ROWNUM idx, COLUMN_VALUE ranking FROM TABLE(results.ints))
        SELECT name
          BULK COLLECT INTO result_table
          FROM t_names JOIN t_ranks ON (t_names.idx = t_ranks.idx)
      ORDER BY ranking DESC;

      RETURN result_table;
   END driver_rankings;
END;
/