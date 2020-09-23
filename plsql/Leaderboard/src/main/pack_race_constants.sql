CREATE OR REPLACE PACKAGE pack_race_constants IS
   TYPE integer_list IS TABLE OF INTEGER;

   POINTS   CONSTANT integer_list := integer_list(25, 18, 15);
END pack_race_constants;
/
