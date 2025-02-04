CREATE OR REPLACE PROCEDURE AP_DIJANA.kreiraj_JSON_DOCUMENT_test2(
    SF_POS_dok VARCHAR2,
    RJ_dok VARCHAR2,
    SF_TIP_dok2 VARCHAR2,
    DOKUMENT_dok VARCHAR2
) AS
    file_handle UTL_FILE.FILE_TYPE;
    file_name VARCHAR2(100);
    json_data CLOB;
BEGIN
    -- Generate JSON data
    SELECT 
        json_serialize(
            json_object (
                'dok' VALUE (
                    SELECT 
                        JSON_ARRAYAGG(
                            json_object (ds.SF_POS, ds.RJ, ds.SF_TIP_DOK, ds.DOKUMENT, ds.STAVKA, ds.RBR, ds.SF_ART, ds.KOLICINA, 
                                         ds.REALIZOVANO, ds.NAB_VRED, ds.OSN_PCENA, ds.PROD_CENA, ds.DEV_NVRED, ds.ORG_NVRED, 
                                         ds.DEV_PCENA, ds.DAT_ROK, ds.RABAT, ds.MARZA, ds.POREZ, ds.PREN_POREZ, ds.POREZ_MARZA, 
                                         ds.FAKT_VRED, ds.TROSAK, ds.OSN_NCENA, ds.NAB_RABAT_P, ds.SF_ART_PRO, ds.PROD_VRED, 
                                         ds.M_DOKUMENT, ds.ODOBRENO, ds.INT_NVRED, ds.KOMADA, ds.SF_KOM_DOB, ds.LOT, ds.ZA_PROMET, 
                                         ds.SF_POPUST, ds.SF_RNR
                            returning clob)
                        returning clob) 
                    FROM ap_dijana.dokument_stavke ds
                    WHERE ds.SF_POS = dok.SF_POS AND ds.RJ = dok.RJ AND ds.SF_TIP_DOK = dok.SF_TIP_DOK AND ds.DOKUMENT = dok.DOKUMENT
                ) returning clob
            ) RETURNING CLOB PRETTY
        ) INTO json_data 
    FROM ap_dijana.dokument dok
    WHERE dok.SF_POS = SF_POS_dok AND dok.RJ = RJ_dok AND dok.SF_TIP_DOK = SF_TIP_DOK2 AND dok.DOKUMENT = DOKUMENT_dok;

    -- Generate file name with current date (change the directory path as needed)
    file_name := 'json1_' || TO_CHAR(SYSDATE, 'YYYYMMDD') || '.json';

    -- Open the file for writing
    file_handle := UTL_FILE.FOPEN('DOKUMENT_JSON_TEST', file_name, 'W');

    -- Write the JSON data to the file
    UTL_FILE.PUT_LINE(file_handle, json_data);

    -- Close the file
    UTL_FILE.FCLOSE(file_handle);
    
    -- Display a message indicating successful execution
    DBMS_OUTPUT.PUT_LINE('Procedure executed successfully.');

EXCEPTION
    WHEN OTHERS THEN
        IF UTL_FILE.IS_OPEN(file_handle) THEN
            UTL_FILE.FCLOSE(file_handle);
        END IF;
        RAISE;
END;
/
