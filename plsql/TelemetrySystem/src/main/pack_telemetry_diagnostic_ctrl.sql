CREATE OR REPLACE PACKAGE pack_telemetry_diagnostic_ctrl IS
   FUNCTION get_diagnostic_info
      RETURN VARCHAR2;

   PROCEDURE set_diagnostic_info(diagnostic_info VARCHAR2);
   
   PROCEDURE check_transmission;
END pack_telemetry_diagnostic_ctrl;
/

CREATE OR REPLACE PACKAGE BODY pack_telemetry_diagnostic_ctrl IS
   --DiagnosticChannelConnectionString
   diagnostic_channel_connect_str   CONSTANT VARCHAR2(5) := '*111#';
   diagnostic_info                           VARCHAR2(32000);

   FUNCTION get_diagnostic_info
      RETURN VARCHAR2 IS
   BEGIN
      RETURN diagnostic_info;
   END get_diagnostic_info;

   PROCEDURE set_diagnostic_info(diagnostic_info VARCHAR2) IS
   BEGIN
      pack_telemetry_diagnostic_ctrl.diagnostic_info := diagnostic_info;
   END set_diagnostic_info;


   PROCEDURE check_transmission IS
      retries_left   INTEGER := 3;
   BEGIN
      diagnostic_info := '';

      pack_telemetry_client.disconnect_from_server;

      WHILE (pack_telemetry_client.get_online_status = FALSE AND retries_left > 0)
      LOOP
         pack_telemetry_client.connect_to_server(diagnostic_channel_connect_str);
         retries_left := retries_left - 1;
      END LOOP;

      IF (pack_telemetry_client.get_online_status = FALSE) THEN
         RAISE_APPLICATION_ERROR(-20001, 'Unable to connect.');
      END IF;

      pack_telemetry_client.send(pack_telemetry_client.diagnostic_message);
      diagnostic_info := pack_telemetry_client.receive();
   END check_transmission;
END pack_telemetry_diagnostic_ctrl;
/