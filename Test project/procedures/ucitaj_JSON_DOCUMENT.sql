CREATE OR REPLACE procedure AP_DIJANA.ucitaj_JSON_DOCUMENT
IS
    file_location VARCHAR2(255) := '/u02/DijanaTest';
    file_handle UTL_FILE.FILE_TYPE;
    file_data CLOB;
    buffer VARCHAR2(32767); -- Buffer size
BEGIN

 -- Open the JSON file
    file_handle := UTL_FILE.FOPEN('DOKUMENT_JSON_TEST', 'json_216_925_01_5.json', 'R');

    -- Read data from the file and append it to the CLOB variable file_data
    LOOP
        BEGIN
            UTL_FILE.GET_LINE(file_handle, buffer);
            file_data := file_data || buffer;      -- Assign the JSON data to the CLOB variable
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                EXIT;
        END;
    END LOOP;

    -- Close the file
    UTL_FILE.FCLOSE(file_handle);

    
    -- Now we have the JSON data in the file_data CLOB variable
    -- We can proceed to parse and process this JSON data dynamically
    
    -- Extracting data from the main document : DOKUMENT
    FOR main_rec IN (
        SELECT *
        FROM JSON_TABLE(file_data, '$[*]' COLUMNS (
            SF_POS VARCHAR2(50) PATH '$.SF_POS',
            RJ VARCHAR2(50) PATH '$.RJ',
            SF_TIP_DOK VARCHAR2(50) PATH '$.SF_TIP_DOK',
            DOKUMENT VARCHAR2(50) PATH '$.DOKUMENT',
            SF_PODTIP_DOK VARCHAR2(50) PATH '$.SF_PODTIP_DOK',
            IME_OP VARCHAR2(50) PATH '$.IME_OP',
            SF_RAD VARCHAR2(50) PATH '$.SF_RAD',
            DAT_FORM VARCHAR2(50) PATH '$.DAT_FORM',
            DAT_DOK VARCHAR2(50) PATH '$.DAT_DOK',
            DAT_DPO VARCHAR2(50) PATH '$.DAT_DPO',
            SF_POS_2 VARCHAR2(50) PATH '$.SF_POS_2',
            RJ_2 VARCHAR2(50) PATH '$.RJ_2',
            SF_KOM NUMBER PATH '$.SF_KOM',
            SF_KPOS VARCHAR2(50) PATH '$.SF_KPOS',
            IZJAVA VARCHAR2(50) PATH '$.IZJAVA',
            DAT_IZJ VARCHAR2(50) PATH '$.DAT_IZJ',
            SF_TIP_DOK_2 VARCHAR2(50) PATH '$.SF_TIP_DOK_2',
            DOKUMENT_2 VARCHAR2(50) PATH '$.DOKUMENT_2',
            IZNOS_DOK_2 NUMBER PATH '$.IZNOS_DOK_2',
            MAG_DOK VARCHAR2(50) PATH '$.MAG_DOK',
            OTPREMNICA VARCHAR2(50) PATH '$.OTPREMNICA',
            UGOVOR VARCHAR2(50) PATH '$.UGOVOR',
            JCI VARCHAR2(50) PATH '$.JCI',
            MARZA_P NUMBER PATH '$.MARZA_P',
            RABAT_P NUMBER PATH '$.RABAT_P',
            RABAT NUMBER PATH '$.RABAT',
            POPUST NUMBER PATH '$.POPUST',
            SF_DEV VARCHAR2(50) PATH '$.SF_DEV',
            DEV_KURS VARCHAR2(50) PATH '$.DEV_KURS',
            NAPOMENA VARCHAR2(50) PATH '$.NAPOMENA',
            ZAVRSENO NUMBER PATH '$.ZAVRSENO',
            STORNIRA NUMBER PATH '$.STORNIRA',
            SF_TIP_NAL VARCHAR2(50) PATH '$.SF_TIP_NAL',
            NALOG VARCHAR2(50) PATH '$.NALOG',
            OSN_PVRED NUMBER PATH '$.OSN_PVRED',
            PROD_VRED NUMBER PATH '$.PROD_VRED',
            DEV_NVRED NUMBER PATH '$.DEV_NVRED',
            ORG_NVRED NUMBER PATH '$.ORG_NVRED',
            MALOPRODAJA NUMBER PATH '$.MALOPRODAJA',
            IMA_POREZ NUMBER PATH '$.IMA_POREZ',
            POREZ NUMBER PATH '$.POREZ',
            PREN_POREZ NUMBER PATH '$.PREN_POREZ',
            POREZ_MARZA NUMBER PATH '$.POREZ_MARZA',
            TROSKOVI NUMBER PATH '$.TROSKOVI',
            BR_STAVKI NUMBER PATH '$.BR_STAVKI',
            UVODNI_TEKST VARCHAR2(4000) PATH '$.UVODNI_TEKST',
            ZAVRSNI_TEKST VARCHAR2(4000) PATH '$.ZAVRSNI_TEKST',
            OZNAKA VARCHAR2(50) PATH '$.OZNAKA',
            OTPREMLJENO VARCHAR2(50) PATH '$.OTPREMLJENO',
            SF_VZC VARCHAR2(50) PATH '$.SF_VZC',
            SF_VZL VARCHAR2(50) PATH '$.SF_VZL',
            DAT_SLANJA VARCHAR2(50) PATH '$.DAT_SLANJA',
            REALIZOVANO VARCHAR2(50) PATH '$.REALIZOVANO',
            M_TIP_DOK VARCHAR2(50) PATH '$.M_TIP_DOK',
            M_NAZIV VARCHAR2(50) PATH '$.M_NAZIV',
            M_DOKUMENT VARCHAR2(50) PATH '$.M_DOKUMENT',
            M_SF_KOM VARCHAR2(50) PATH '$.M_SF_KOM',
            OBRADJENO VARCHAR2(50) PATH '$.OBRADJENO'
        )) 
    ) 
    LOOP
        -- Insert data into the DOKUMENT table
        INSERT INTO AP_DIJANA.DOKUMENT (
            SF_POS,
            RJ,
            SF_TIP_DOK,
            DOKUMENT,
            SF_PODTIP_DOK,
            IME_OP,
            SF_RAD,
            DAT_FORM,
            DAT_DOK,
            DAT_DPO,
            SF_POS_2,
            RJ_2,
            SF_KOM,
            SF_KPOS,
            IZJAVA,
            DAT_IZJ,
            SF_TIP_DOK_2,
            DOKUMENT_2,
            IZNOS_DOK_2,
            MAG_DOK,
            OTPREMNICA,
            UGOVOR,
            JCI,
            MARZA_P,
            RABAT_P,
            RABAT,
            POPUST,
            SF_DEV,
            DEV_KURS,
            NAPOMENA,
            ZAVRSENO,
            STORNIRA,
            SF_TIP_NAL,
            NALOG,
            OSN_PVRED,
            PROD_VRED,
            DEV_NVRED,
            ORG_NVRED,
            MALOPRODAJA,
            IMA_POREZ,
            POREZ,
            PREN_POREZ,
            POREZ_MARZA,
            TROSKOVI,
            BR_STAVKI,
            UVODNI_TEKST,
            ZAVRSNI_TEKST,
            OZNAKA,
            OTPREMLJENO,
            SF_VZC,
            SF_VZL,
            DAT_SLANJA,
            REALIZOVANO,
            M_TIP_DOK,
            M_NAZIV,
            M_DOKUMENT,
            M_SF_KOM,
            OBRADJENO
        ) VALUES (
            main_rec.SF_POS,
            main_rec.RJ,
            main_rec.SF_TIP_DOK,
            main_rec.DOKUMENT,
            main_rec.SF_PODTIP_DOK,
            main_rec.IME_OP,
            main_rec.SF_RAD,
            TO_DATE(main_rec.DAT_FORM, 'YYYY-MM-DD"T"HH24:MI:SS'),
            TO_DATE(main_rec.DAT_DOK, 'YYYY-MM-DD"T"HH24:MI:SS'),
            TO_DATE(main_rec.DAT_DPO, 'YYYY-MM-DD"T"HH24:MI:SS'),
            main_rec.SF_POS_2,
            main_rec.RJ_2,
            main_rec.SF_KOM,
            main_rec.SF_KPOS,
            main_rec.IZJAVA,
            main_rec.DAT_IZJ,
            main_rec.SF_TIP_DOK_2,
            main_rec.DOKUMENT_2,
            main_rec.IZNOS_DOK_2,
            main_rec.MAG_DOK,
            main_rec.OTPREMNICA,
            main_rec.UGOVOR,
            main_rec.JCI,
            main_rec.MARZA_P,
            main_rec.RABAT_P,
            main_rec.RABAT,
            main_rec.POPUST,
            main_rec.SF_DEV,
            main_rec.DEV_KURS,
            main_rec.NAPOMENA,
            main_rec.ZAVRSENO,
            main_rec.STORNIRA,
            main_rec.SF_TIP_NAL,
            main_rec.NALOG,
            main_rec.OSN_PVRED,
            main_rec.PROD_VRED,
            main_rec.DEV_NVRED,
            main_rec.ORG_NVRED,
            main_rec.MALOPRODAJA,
            main_rec.IMA_POREZ,
            main_rec.POREZ,
            main_rec.PREN_POREZ,
            main_rec.POREZ_MARZA,
            main_rec.TROSKOVI,
            main_rec.BR_STAVKI,
            main_rec.UVODNI_TEKST,
            main_rec.ZAVRSNI_TEKST,
            main_rec.OZNAKA,
            main_rec.OTPREMLJENO,
            main_rec.SF_VZC,
            main_rec.SF_VZL,
            main_rec.DAT_SLANJA,
            main_rec.REALIZOVANO,
            main_rec.M_TIP_DOK,
            main_rec.M_NAZIV,
            main_rec.M_DOKUMENT,
            main_rec.M_SF_KOM,
            main_rec.OBRADJENO
        );
        DBMS_OUTPUT.PUT_LINE('Upisano u DOKUMENT.');
         -- Display the JSON data
        DBMS_OUTPUT.PUT_LINE(file_data);
        --Extracting data from items inside the main document : DOKUMENT_STAVKE
        -- Extracting data from items inside the main document : DOKUMENT_STAVKE
        FOR item_rec IN (
            SELECT *
            FROM JSON_TABLE(file_data, '$.dokument_stavke[*]' COLUMNS (
                SF_POS VARCHAR2(50) PATH '$.SF_POS',
                RJ VARCHAR2(50) PATH '$.RJ',
                SF_TIP_DOK VARCHAR2(50) PATH '$.SF_TIP_DOK',
                DOKUMENT VARCHAR2(50) PATH '$.DOKUMENT',
                STAVKA NUMBER PATH '$.STAVKA',
                RBR NUMBER PATH '$.RBR',
                SF_ART VARCHAR2(50) PATH '$.SF_ART',
                KOLICINA NUMBER PATH '$.KOLICINA',
                REALIZOVANO NUMBER PATH '$.REALIZOVANO',
                NAB_VRED NUMBER PATH '$.NAB_VRED',
                OSN_PCENA NUMBER PATH '$.OSN_PCENA',
                PROD_CENA NUMBER PATH '$.PROD_CENA',
                DEV_NVRED NUMBER PATH '$.DEV_NVRED',
                ORG_NVRED NUMBER PATH '$.ORG_NVRED',
                DEV_PCENA VARCHAR2(50) PATH '$.DEV_PCENA',
                DAT_ROK VARCHAR2(50) PATH '$.DAT_ROK',
                RABAT NUMBER PATH '$.RABAT',
                MARZA NUMBER PATH '$.MARZA',
                POREZ NUMBER PATH '$.POREZ',
                PREN_POREZ NUMBER PATH '$.PREN_POREZ',
                POREZ_MARZA NUMBER PATH '$.POREZ_MARZA',
                FAKT_VRED NUMBER PATH '$.FAKT_VRED',
                TROSAK NUMBER PATH '$.TROSAK',
                OSN_NCENA NUMBER PATH '$.OSN_NCENA',
                NAB_RABAT_P NUMBER PATH '$.NAB_RABAT_P',
                SF_ART_PRO VARCHAR2(50) PATH '$.SF_ART_PRO',
                PROD_VRED NUMBER PATH '$.PROD_VRED',
                M_DOKUMENT VARCHAR2(50) PATH '$.M_DOKUMENT',
                ODOBRENO VARCHAR2(50) PATH '$.ODOBRENO',
                INT_NVRED VARCHAR2(50) PATH '$.INT_NVRED',
                KOMADA VARCHAR2(50) PATH '$.KOMADA',
                SF_KOM_DOB VARCHAR2(50) PATH '$.SF_KOM_DOB',
                LOT VARCHAR2(50) PATH '$.LOT',
                ZA_PROMET VARCHAR2(50) PATH '$.ZA_PROMET',
                SF_POPUST VARCHAR2(50) PATH '$.SF_POPUST',
                SF_RNR VARCHAR2(50) PATH '$.SF_RNR'
            ))
        ) LOOP

            -- Insert data into the DOKUMENT_STAVKE table
            INSERT INTO AP_DIJANA.DOKUMENT_STAVKE (
                SF_POS,
                RJ,
                SF_TIP_DOK,
                DOKUMENT,
                STAVKA,
                RBR,
                SF_ART,
                KOLICINA,
                REALIZOVANO,
                NAB_VRED,
                OSN_PCENA,
                PROD_CENA,
                DEV_NVRED,
                ORG_NVRED,
                DEV_PCENA,
                DAT_ROK,
                RABAT,
                MARZA,
                POREZ,
                PREN_POREZ,
                POREZ_MARZA,
                FAKT_VRED,
                TROSAK,
                OSN_NCENA,
                NAB_RABAT_P,
                SF_ART_PRO,
                PROD_VRED,
                M_DOKUMENT,
                ODOBRENO,
                INT_NVRED,
                KOMADA,
                SF_KOM_DOB,
                LOT,
                ZA_PROMET,
                SF_POPUST,
                SF_RNR
            ) VALUES (
                item_rec.SF_POS,
                item_rec.RJ,
                item_rec.SF_TIP_DOK,
                item_rec.DOKUMENT,
                item_rec.STAVKA,
                item_rec.RBR,
                item_rec.SF_ART,
                item_rec.KOLICINA,
                item_rec.REALIZOVANO,
                item_rec.NAB_VRED,
                item_rec.OSN_PCENA,
                item_rec.PROD_CENA,
                item_rec.DEV_NVRED,
                item_rec.ORG_NVRED,
                item_rec.DEV_PCENA,
                TO_DATE(item_rec.DAT_ROK, 'YYYY-MM-DD"T"HH24:MI:SS'),
                item_rec.RABAT,
                item_rec.MARZA,
                item_rec.POREZ,
                item_rec.PREN_POREZ,
                item_rec.POREZ_MARZA,
                item_rec.FAKT_VRED,
                item_rec.TROSAK,
                item_rec.OSN_NCENA,
                item_rec.NAB_RABAT_P,
                item_rec.SF_ART_PRO,
                item_rec.PROD_VRED,
                item_rec.M_DOKUMENT,
                item_rec.ODOBRENO,
                item_rec.INT_NVRED,
                item_rec.KOMADA,
                item_rec.SF_KOM_DOB,
                item_rec.LOT,
                item_rec.ZA_PROMET,
                item_rec.SF_POPUST,
                item_rec.SF_RNR
            );
             DBMS_OUTPUT.PUT_LINE('Upisano u DOKUMENT_STAVKE.');
         -- Display the JSON data
        DBMS_OUTPUT.PUT_LINE(file_data);
        END LOOP;
    END LOOP;
END;
/

