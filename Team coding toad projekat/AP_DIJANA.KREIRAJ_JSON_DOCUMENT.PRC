CREATE OR REPLACE procedure AP_DIJANA.kreiraj_JSON_DOCUMENT(
  SF_POS_dok VARCHAR2,
  RJ_dok VARCHAR2,
  SF_TIP_dok2 VARCHAR2,
  DOKUMENT_dok VARCHAR2
) AS
begin
--test da isprobam push
select json_serialize(
            json_object (dok.SF_POS, dok.RJ ,dok.SF_TIP_DOK, dok.DOKUMENT,dok.SF_PODTIP_DOK,dok.IME_OP,dok.SF_RAD, dok.DAT_FORM,
  dok.DAT_DOK,dok.DAT_DPO ,dok.SF_POS_2, dok.RJ_2, dok.SF_KOM, dok.SF_KPOS, dok.IZJAVA, dok.DAT_IZJ, dok.SF_TIP_DOK_2, dok.DOKUMENT_2,
  dok.IZNOS_DOK_2, dok.MAG_DOK, dok.OTPREMNICA, dok.UGOVOR, dok.JCI, dok.MARZA_P, dok.RABAT_P, dok.RABAT, dok.POPUST, dok.SF_DEV,
  dok.DEV_KURS, dok.NAPOMENA, dok.ZAVRSENO, dok.STORNIRA, dok.SF_TIP_NAL, dok.NALOG, dok.OSN_PVRED, dok.PROD_VRED, dok.DEV_NVRED,
  dok.ORG_NVRED, dok.MALOPRODAJA, dok.IMA_POREZ, dok.POREZ, dok.PREN_POREZ, dok.POREZ_MARZA,  dok.TROSKOVI, dok.BR_STAVKI,  
  dok.UVODNI_TEKST, dok.ZAVRSNI_TEKST,  dok.OZNAKA, dok.OTPREMLJENO, dok.SF_VZC, dok.SF_VZL, dok.DAT_SLANJA, dok.REALIZOVANO, 
  dok.M_TIP_DOK, dok.M_NAZIV, dok.M_DOKUMENT, dok.M_SF_KOM, dok.OBRADJENO,
                'dokument_stavke' value JSON_ARRAYAGG(
                    json_object (ds.*) returning clob
                ) 
            returning clob
            )
            returning clob pretty
        ) as dataJSON 
    FROM  maxi_2024.dokument dok, maxi_2024.dokument_stavke ds
    where  dok.SF_POS=ds.SF_POS and dok.RJ=ds.RJ and dok.SF_TIP_DOK=ds.SF_TIP_DOK and dok.DOKUMENT=ds.DOKUMENT
    and dok.SF_POS=SF_POS_dok and dok.RJ=RJ_dok and dok.SF_TIP_DOK=SF_TIP_DOK2 and dok.DOKUMENT=DOKUMENT_dok
group  by dok.SF_POS, dok.RJ ,dok.SF_TIP_DOK, dok.DOKUMENT,dok.SF_PODTIP_DOK,dok.IME_OP,dok.SF_RAD, dok.DAT_FORM,
  dok.DAT_DOK,dok.DAT_DPO ,dok.SF_POS_2, dok.RJ_2, dok.SF_KOM, dok.SF_KPOS, dok.IZJAVA, dok.DAT_IZJ, dok.SF_TIP_DOK_2, dok.DOKUMENT_2,
  dok.IZNOS_DOK_2, dok.MAG_DOK, dok.OTPREMNICA, dok.UGOVOR, dok.JCI, dok.MARZA_P, dok.RABAT_P, dok.RABAT, dok.POPUST, dok.SF_DEV,
  dok.DEV_KURS, dok.NAPOMENA, dok.ZAVRSENO, dok.STORNIRA, dok.SF_TIP_NAL, dok.NALOG, dok.OSN_PVRED, dok.PROD_VRED, dok.DEV_NVRED,
  dok.ORG_NVRED, dok.MALOPRODAJA, dok.IMA_POREZ, dok.POREZ, dok.PREN_POREZ, dok.POREZ_MARZA,  dok.TROSKOVI, dok.BR_STAVKI,  
  dok.UVODNI_TEKST, dok.ZAVRSNI_TEKST,  dok.OZNAKA, dok.OTPREMLJENO, dok.SF_VZC, dok.SF_VZL, dok.DAT_SLANJA, dok.REALIZOVANO, 
  dok.M_TIP_DOK, dok.M_NAZIV, dok.M_DOKUMENT, dok.M_SF_KOM, dok.OBRADJENO;
end;
/
