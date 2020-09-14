CREATE OR REPLACE PACKAGE pack_random_integer IS
   PROCEDURE seed_generator(seed_value BINARY_INTEGER);

   FUNCTION get_value(lower_bound INTEGER, upper_bound INTEGER)
      RETURN INTEGER;
END pack_random_integer;
/

CREATE OR REPLACE PACKAGE BODY pack_random_integer IS
   PROCEDURE seed_generator(seed_value BINARY_INTEGER) IS
   BEGIN
      DBMS_RANDOM.seed(val => seed_value);
   END seed_generator;

   FUNCTION get_value(lower_bound INTEGER, upper_bound INTEGER)
      RETURN INTEGER IS
   BEGIN
      RETURN TRUNC(DBMS_RANDOM.VALUE(lower_bound, upper_bound + 1));
   END get_value;
END pack_random_integer;
/