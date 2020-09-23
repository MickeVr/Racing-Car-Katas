CREATE OR REPLACE TYPE self_driving_car FORCE UNDER driver
(
   algorithm_version VARCHAR2(500),
   CONSTRUCTOR FUNCTION self_driving_car(SELF IN OUT NOCOPY self_driving_car, algorithm_version VARCHAR2, company VARCHAR2)
      RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE BODY self_driving_car AS
   CONSTRUCTOR FUNCTION self_driving_car(SELF IN OUT NOCOPY self_driving_car, algorithm_version VARCHAR2, company VARCHAR2)
      RETURN SELF AS RESULT IS
   BEGIN
      SELF.name := algorithm_version;
      SELF.country := company;
      SELF.algorithm_version := algorithm_version;
      RETURN;
   END self_driving_car;
END;
/