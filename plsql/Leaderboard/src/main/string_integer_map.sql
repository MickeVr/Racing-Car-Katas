CREATE OR REPLACE TYPE string_integer_map FORCE IS OBJECT
(
   strings string_table,
   ints integer_table,
   MEMBER PROCEDURE put(new_string VARCHAR2, new_int INTEGER),
   MEMBER FUNCTION get_int(key_string VARCHAR2)
      RETURN INTEGER,
   CONSTRUCTOR FUNCTION string_integer_map(SELF IN OUT NOCOPY string_integer_map)
      RETURN SELF AS RESULT
);


CREATE OR REPLACE TYPE BODY string_integer_map IS
   MEMBER PROCEDURE put(new_string VARCHAR2, new_int INTEGER) IS
      found_index   INTEGER := -1;
   BEGIN
      FOR i IN 1 .. SELF.strings.COUNT
      LOOP
         IF SELF.strings(i) = new_string THEN
            found_index := i;
         END IF;
      END LOOP;

      IF found_index < 0 THEN
         SELF.strings.EXTEND;
         SELF.ints.EXTEND;
         found_index := SELF.strings.COUNT;
         SELF.strings(found_index) := new_string;
      END IF;


      SELF.ints(found_index) := new_int;
   END put;

   MEMBER FUNCTION get_int(key_string VARCHAR2)
      RETURN INTEGER IS
   BEGIN
      FOR i IN 1 .. SELF.strings.COUNT
      LOOP
         IF SELF.strings(i) = key_string THEN
            RETURN SELF.ints(i);
         END IF;
      END LOOP;

      RETURN NULL;
   END get_int;

   CONSTRUCTOR FUNCTION string_integer_map(SELF IN OUT NOCOPY string_integer_map)
      RETURN SELF AS RESULT IS
   BEGIN
      SELF.strings := string_table();
      SELF.ints := integer_table();
      RETURN;
   END string_integer_map;
END;
/