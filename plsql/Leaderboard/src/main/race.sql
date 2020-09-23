CREATE OR REPLACE TYPE race FORCE IS OBJECT
(
   name VARCHAR2(500),
   results driver_list,
   driver_names driver_name_map,
   CONSTRUCTOR FUNCTION race(SELF IN OUT NOCOPY race, new_name VARCHAR2, new_driver_table driver_table)
      RETURN SELF AS RESULT,
   MEMBER FUNCTION position(info_driver driver)
      RETURN INTEGER,
   MEMBER FUNCTION get_points(info_driver driver)
      RETURN INTEGER,
   MEMBER FUNCTION get_driver_name(info_driver driver)
      RETURN VARCHAR2
);

CREATE OR REPLACE TYPE BODY race IS
   CONSTRUCTOR FUNCTION race(SELF IN OUT NOCOPY race, new_name VARCHAR2, new_driver_table driver_table)
      RETURN SELF AS RESULT IS
      driver_name     VARCHAR(500);
      single_driver   driver;
   BEGIN
      SELF.name := new_name;
      SELF.results := driver_list(new_driver_table);
      SELF.driver_names := driver_name_map;

      FOR i IN 1 .. new_driver_table.COUNT
      LOOP
         single_driver := new_driver_table(i);
         driver_name := single_driver.name;

         IF (single_driver IS OF (self_driving_car)) THEN
            driver_name :=
               'Self Driving Car - ' || single_driver.country || ' (' || TREAT(single_driver AS self_driving_car).algorithm_version || ')';
         END IF;

         SELF.driver_names.put(single_driver, driver_name);
      END LOOP;
      RETURN;
   END race;

   MEMBER FUNCTION position(info_driver driver)
      RETURN INTEGER IS
   BEGIN
      RETURN SELF.results.index_of(info_driver);
   END position;

   MEMBER FUNCTION get_points(info_driver driver)
      RETURN INTEGER IS
   BEGIN
      RETURN pack_race_constants.points(position(info_driver));
   END get_points;

   MEMBER FUNCTION get_driver_name(info_driver driver)
      RETURN VARCHAR2 IS
   BEGIN
      RETURN SELF.driver_names.get_name(info_driver);
   END get_driver_name;
END;
/