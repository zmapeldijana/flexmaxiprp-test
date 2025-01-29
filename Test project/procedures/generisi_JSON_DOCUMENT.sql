CREATE OR REPLACE PROCEDURE AP_DIJANA.generisi_JSON_dokUMENT(
    SF_POS_dok VARCHAR2,
    RJ_dok VARCHAR2,
    SF_TIP_dok2 VARCHAR2,
    dokUMENT_dok VARCHAR2
) AS
    file_handle UTL_FILE.FILE_TYPE;
    file_name VARCHAR2(100);
    json_data CLOB;
BEGIN
    -- Generate JSON data
    SELECT 
        json_serialize(
            json_object (dok.SF_POS, dok.RJ ,dok.SF_TIP_dok, dok.dokUMENT,dok.SF_PODTIP_dok,dok.IME_OP,dok.SF_RAD, dok.DAT_FORM,
  dok.DAT_dok,dok.DAT_DPO ,dok.SF_POS_2, dok.RJ_2, dok.SF_KOM, dok.SF_KPOS, dok.IZJAVA, dok.DAT_IZJ, dok.SF_TIP_dok_2, dok.dokUMENT_2,
  dok.IZNOS_dok_2, dok.MAG_dok, dok.OTPREMNICA, dok.UGOVOR, dok.JCI, dok.MARZA_P, dok.RABAT_P, dok.RABAT, dok.POPUST, dok.SF_DEV,
  dok.DEV_KURS, dok.NAPOMENA, dok.ZAVRSENO, dok.STORNIRA, dok.SF_TIP_NAL, dok.NALOG, dok.OSN_PVRED, dok.PROD_VRED, dok.DEV_NVRED,
  dok.ORG_NVRED, dok.MALOPRODAJA, dok.IMA_POREZ, dok.POREZ, dok.PREN_POREZ, dok.POREZ_MARZA,  dok.TROSKOVI, dok.BR_STAVKI,  
  dok.UVODNI_TEKST, dok.ZAVRSNI_TEKST,  dok.OZNAKA, dok.OTPREMLJENO, dok.SF_VZC, dok.SF_VZL, dok.DAT_SLANJA, dok.REALIZOVANO, 
  dok.M_TIP_dok, dok.M_NAZIV, dok.M_dokUMENT, dok.M_SF_KOM, dok.OBRADJENO,
                'dokument_stavke' VALUE (
                    SELECT 
                        JSON_ARRAYAGG(
                            json_object (ds.SF_POS, ds.RJ, ds.SF_TIP_dok, ds.dokUMENT, ds.STAVKA, ds.RBR, ds.SF_ART, ds.KOLICINA, 
                                         ds.REALIZOVANO, ds.NAB_VRED, ds.OSN_PCENA, ds.PROD_CENA, ds.DEV_NVRED, ds.ORG_NVRED, 
                                         ds.DEV_PCENA, ds.DAT_ROK, ds.RABAT, ds.MARZA, ds.POREZ, ds.PREN_POREZ, ds.POREZ_MARZA, 
                                         ds.FAKT_VRED, ds.TROSAK, ds.OSN_NCENA, ds.NAB_RABAT_P, ds.SF_ART_PRO, ds.PROD_VRED, 
                                         ds.M_dokUMENT, ds.ODOBRENO, ds.INT_NVRED, ds.KOMADA, ds.SF_KOM_DOB, ds.LOT, ds.ZA_PROMET, 
                                         ds.SF_POPUST, ds.SF_RNR
                            returning clob)
                        returning clob) 
                    FROM ap_dijana.dokument_stavke ds
                    WHERE ds.SF_POS = dok.SF_POS AND ds.RJ = dok.RJ AND ds.SF_TIP_dok = dok.SF_TIP_dok AND ds.dokUMENT = dok.dokUMENT
                ) returning clob
            ) RETURNING CLOB PRETTY
        ) INTO json_data 
    FROM ap_dijana.dokument dok
    WHERE dok.SF_POS = SF_POS_dok AND dok.RJ = RJ_dok AND dok.SF_TIP_dok = SF_TIP_dok2 AND dok.dokUMENT = dokUMENT_dok;

    -- Generate file name with current date
    file_name := 'json_' || SF_POS_dok || '_' || RJ_dok || '_' || SF_TIP_dok2 || '_' || dokUMENT_dok || '.json';


    -- Open the file for writing
    file_handle := UTL_FILE.FOPEN('dokUMENT_JSON_TEST', file_name, 'W');

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

