--Test
CREATE OR REPLACE PROCEDURE AP_DIJANA.generisi_JSON_DOCUMENT(
    SF_POS_doc VARCHAR2,
    RJ_doc VARCHAR2,
    SF_TIP_doc2 VARCHAR2,
    docUMENT_doc VARCHAR2
) AS
    file_handle UTL_FILE.FILE_TYPE;
    file_name VARCHAR2(100);
    json_data CLOB;
BEGIN
    -- Generate JSON data 
    SELECT 
        json_serialize(
            json_object (doc.SF_POS, doc.RJ ,doc.SF_TIP_doc, doc.docUMENT,doc.SF_PODTIP_doc,doc.IME_OP,doc.SF_RAD, doc.DAT_FORM,
  doc.DAT_dok,doc.DAT_DPO ,doc.SF_POS_2, doc.RJ_2, doc.SF_KOM, doc.SF_KPOS, doc.IZJAVA, doc.DAT_IZJ, doc.SF_TIP_dok_2, doc.DOKUMENT_2,
  doc.IZNOS_doc_2, doc.MAG_doc, doc.OTPREMNICA, doc.UGOVOR, doc.JCI, doc.MARZA_P, doc.RABAT_P, doc.RABAT, doc.POPUST, doc.SF_DEV,
  doc.DEV_KURS, doc.NAPOMENA, doc.ZAVRSENO, doc.STORNIRA, doc.SF_TIP_NAL, doc.NALOG, doc.OSN_PVRED, doc.PROD_VRED, doc.DEV_NVRED,
  doc.ORG_NVRED, doc.MALOPRODAJA, doc.IMA_POREZ, doc.POREZ, doc.PREN_POREZ, doc.POREZ_MARZA,  doc.TROSKOVI, doc.BR_STAVKI,  
  doc.UVODNI_TEKST, doc.ZAVRSNI_TEKST,  doc.OZNAKA, doc.OTPREMLJENO, doc.SF_VZC, doc.SF_VZL, doc.DAT_SLANJA, doc.REALIZOVANO, 
  doc.M_TIP_doc, doc.M_NAZIV, doc.M_docUMENT, doc.M_SF_KOM, doc.OBRADJENO,
                'document_stavke' VALUE (
                    SELECT 
                        JSON_ARRAYAGG(
                            json_object (ds.SF_POS, ds.RJ, ds.SF_TIP_doc, ds.docUMENT, ds.STAVKA, ds.RBR, ds.SF_ART, ds.KOLICINA, 
                                         ds.REALIZOVANO, ds.NAB_VRED, ds.OSN_PCENA, ds.PROD_CENA, ds.DEV_NVRED, ds.ORG_NVRED, 
                                         ds.DEV_PCENA, ds.DAT_ROK, ds.RABAT, ds.MARZA, ds.POREZ, ds.PREN_POREZ, ds.POREZ_MARZA, 
                                         ds.FAKT_VRED, ds.TROSAK, ds.OSN_NCENA, ds.NAB_RABAT_P, ds.SF_ART_PRO, ds.PROD_VRED, 
                                         ds.M_docUMENT, ds.ODOBRENO, ds.INT_NVRED, ds.KOMADA, ds.SF_KOM_DOB, ds.LOT, ds.ZA_PROMET, 
                                         ds.SF_POPUST, ds.SF_RNR
                            returning clob)
                        returning clob) 
                    FROM ap_dijana.document_stavke ds
                    WHERE ds.SF_POS = doc.SF_POS AND ds.RJ = doc.RJ AND ds.SF_TIP_doc = doc.SF_TIP_doc AND ds.docUMENT = doc.docUMENT
                ) returning clob
            ) RETURNING CLOB PRETTY
        ) INTO json_data 
    FROM ap_dijana.document doc
    WHERE doc.SF_POS = SF_POS_doc AND doc.RJ = RJ_doc AND doc.SF_TIP_doc = SF_TIP_doc2 AND doc.docUMENT = docUMENT_doc;

    -- Generate file name with current date
    file_name := 'json_' || SF_POS_doc || '_' || RJ_doc || '_' || SF_TIP_doc2 || '_' || docUMENT_doc || '.json';


    -- Open the file for writing
    file_handle := UTL_FILE.FOPEN('docUMENT_JSON_TEST', file_name, 'W');

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

