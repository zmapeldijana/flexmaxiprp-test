CREATE OR REPLACE PROCEDURE AP_DIJANA.nova_test_procedura IS
    v_sf_status flex_status.sf_status%TYPE; 
    v_sf_desc flex_status.STATUS_DESCRIPTION%TYPE; -- Deklaracija promenljive
BEGIN
    -- Dodela vrednosti promenljivoj
    --test test
    SELECT s.sf_status, s.STATUS_DESCRIPTION 
    INTO v_sf_status, v_sf_desc 
    FROM flex_status s;
    
    -- Opciona obrada ili ispis vrednosti
    DBMS_OUTPUT.PUT_LINE('Status: ' || v_sf_status);
END;
/
