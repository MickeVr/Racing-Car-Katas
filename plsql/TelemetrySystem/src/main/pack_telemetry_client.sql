CREATE OR REPLACE PACKAGE pack_telemetry_client IS
   DIAGNOSTIC_MESSAGE   CONSTANT VARCHAR2(5) := 'AT#UD';

   FUNCTION get_online_status
      RETURN BOOLEAN;

   PROCEDURE connect_to_server(server_connect_string VARCHAR2);

   PROCEDURE disconnect_from_server;

   PROCEDURE send(message_content VARCHAR2);

   FUNCTION receive
      RETURN VARCHAR2;
END pack_telemetry_client;
/

CREATE OR REPLACE PACKAGE BODY pack_telemetry_client IS
   online_status               BOOLEAN;
   diagnostic_message_result   VARCHAR2(32000);

   FUNCTION get_online_status
      RETURN BOOLEAN IS
   BEGIN
      RETURN online_status;
   END get_online_status;

   PROCEDURE connect_to_server(server_connect_string VARCHAR2) IS
      successfull_operation   BOOLEAN;
   BEGIN
      IF server_connect_string IS NULL THEN
         RAISE_APPLICATION_ERROR(-20000, 'IllegalStateException');
      END IF;

      -- simulate the operation on a real modem with a 80% success rate
      successfull_operation := (pack_random_integer.get_value(1, 10) <= 8);

      online_status := successfull_operation;
   END connect_to_server;

   PROCEDURE disconnect_from_server IS
   BEGIN
      online_status := FALSE;
   END disconnect_from_server;

   PROCEDURE send(message_content VARCHAR2) IS
   BEGIN
      IF (message_content IS NULL) THEN
         RAISE_APPLICATION_ERROR(-20000, 'IllegalStateException');
      END IF;

      IF message_content = DIAGNOSTIC_MESSAGE THEN
         -- simulate a status report
         diagnostic_message_result := 'LAST TX rate................ 100 MBPS' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'HIGHEST TX rate............. 100 MBPS' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'LAST RX rate................ 100 MBPS' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'HIGHEST RX rate............. 100 MBPS' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'BIT RATE.................... 100000000' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'WORD LEN.................... 16' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'WORD/FRAME.................. 511' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'BITS/FRAME.................. 8192' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'MODULATION TYPE............. PCM/FM' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'TX Digital Los.............. 0.75' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'RX Digital Los.............. 0.10' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'BEP Test.................... -5' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'Local Rtrn Count............ 00' || CHR(13) || CHR(10);
         diagnostic_message_result := diagnostic_message_result || 'Remote Rtrn Count........... 00';
      END IF;
   -- here should go the real Send operation (not needed for this exercise)

   END send;

   FUNCTION receive
      RETURN VARCHAR2 IS
      message_content   VARCHAR2(32000);
      message_length    INTEGER;
   BEGIN
      IF (diagnostic_message_result IS NULL) THEN
         -- simulate a received message_content (just for illustration - not needed for this exercise)
         message_length := pack_random_integer.get_value(60, 110);

         FOR i IN 1 .. message_length
         LOOP
            message_content := message_content || CHR(pack_random_integer.get_value(86, 126));
         END LOOP;
      ELSE
         message_content := diagnostic_message_result;
         diagnostic_message_result := '';
      END IF;

      RETURN message_content;
   END receive;
BEGIN
   pack_random_integer.seed_generator(42);
END pack_telemetry_client;
/