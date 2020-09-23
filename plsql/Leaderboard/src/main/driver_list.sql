CREATE OR REPLACE TYPE driver_list FORCE IS OBJECT
(
   drivers driver_table,
   MEMBER FUNCTION index_of(info_driver driver)
      RETURN INTEGER,
   MEMBER FUNCTION COUNT
      RETURN INTEGER,
   MEMBER FUNCTION get(idx INTEGER)
      RETURN driver,
   MEMBER PROCEDURE put(new_driver driver),
   CONSTRUCTOR FUNCTION driver_list(SELF IN OUT NOCOPY driver_list)
      RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY driver_list IS
   MEMBER FUNCTION index_of(info_driver driver)
      RETURN INTEGER IS
      result   INTEGER := -1;
   BEGIN
      FOR i IN 1 .. drivers.COUNT
      LOOP
         IF info_driver = drivers(i) THEN
            result := i;
            EXIT;
         END IF;
      END LOOP;

      RETURN result;
   END index_of;

   MEMBER FUNCTION COUNT
      RETURN INTEGER IS
   BEGIN
      RETURN drivers.COUNT;
   END COUNT;

   MEMBER FUNCTION get(idx INTEGER)
      RETURN driver IS
   BEGIN
      RETURN drivers(idx);
   END get;

   MEMBER PROCEDURE put(new_driver driver) IS
   BEGIN
      SELF.drivers.EXTEND;
      SELF.drivers(SELF.drivers.COUNT) := new_driver;
   END put;

   CONSTRUCTOR FUNCTION driver_list(SELF IN OUT NOCOPY driver_list)
      RETURN SELF AS RESULT IS
   BEGIN
      SELF.drivers := driver_table();
      RETURN;
   END driver_list;
END;
/