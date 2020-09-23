CREATE OR REPLACE TYPE driver_name_map FORCE IS OBJECT
(
   drivers driver_list,
   name_list string_table,
   MEMBER PROCEDURE put(new_driver driver, new_name VARCHAR2),
   MEMBER FUNCTION get_name(info_driver driver)
      RETURN VARCHAR2,
   CONSTRUCTOR FUNCTION driver_name_map(SELF IN OUT NOCOPY driver_name_map)
      RETURN SELF AS RESULT
);


CREATE OR REPLACE TYPE BODY driver_name_map IS
   MEMBER PROCEDURE put(new_driver driver, new_name VARCHAR2) IS
      found_index   INTEGER := -1;
   BEGIN
      FOR i IN 1 .. SELF.drivers.COUNT
      LOOP
         IF SELF.drivers.get(i) = new_driver THEN
            found_index := i;
         END IF;
      END LOOP;

      IF found_index < 0 THEN
         SELF.drivers.put(new_driver);
         SELF.name_list.EXTEND;
         found_index := SELF.drivers.COUNT;
      END IF;

      SELF.name_list(found_index) := new_name;
   END put;

   MEMBER FUNCTION get_name(info_driver driver)
      RETURN VARCHAR2 IS
   BEGIN
      RETURN SELF.name_list(drivers.index_of(info_driver));
   END get_name;

   CONSTRUCTOR FUNCTION driver_name_map(SELF IN OUT NOCOPY driver_name_map)
      RETURN SELF AS RESULT IS
   BEGIN
      SELF.drivers := driver_list();
      SELF.name_list := string_table();
      RETURN;
   END driver_name_map;
END;
/