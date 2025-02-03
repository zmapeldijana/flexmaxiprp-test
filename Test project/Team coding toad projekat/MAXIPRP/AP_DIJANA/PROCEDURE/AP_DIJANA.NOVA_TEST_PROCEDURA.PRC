CREATE OR REPLACE PROCEDURE AP_DIJANA.nova_test_procedura IS
    v_sf_status flex_status.sf_status%TYPE; -- Deklaracija promenljive
BEGIN
    -- Dodela vrednosti promenljivoj
    SELECT s.sf_status 
    INTO v_sf_status 
    FROM flex_status s;
    
    -- Opciona obrada ili ispis vrednosti
    DBMS_OUTPUT.PUT_LINE('Status: ' || v_sf_status);
END;
/
