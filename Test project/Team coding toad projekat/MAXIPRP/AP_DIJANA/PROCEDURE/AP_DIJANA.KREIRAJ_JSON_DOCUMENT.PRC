CREATE OR REPLACE procedure AP_DIJANA.kreiraj_JSON_DOCUMENT(
  SF_POS_doc VARCHAR2,
  RJ_doc VARCHAR2,
  SF_TIP_doc2 VARCHAR2,
  docUMENT_doc VARCHAR2
) AS
begin
--obrisan komentar
select json_serialize(
            json_object (doc.SF_POS, doc.RJ ,doc.SF_TIP_doc, doc.docUMENT,doc.SF_PODTIP_doc,doc.IME_OP,doc.SF_RAD, doc.DAT_FORM,
  doc.DAT_doc,doc.DAT_DPO ,doc.SF_POS_2, doc.RJ_2, doc.SF_KOM, doc.SF_KPOS, doc.IZJAVA, doc.DAT_IZJ, doc.SF_TIP_doc_2, doc.docUMENT_2,
  doc.IZNOS_doc_2, doc.MAG_doc, doc.OTPREMNICA, doc.UGOVOR, doc.JCI, doc.MARZA_P, doc.RABAT_P, doc.RABAT, doc.POPUST, doc.SF_DEV,
  doc.DEV_KURS, doc.NAPOMENA, doc.ZAVRSENO, doc.STORNIRA, doc.SF_TIP_NAL, doc.NALOG, doc.OSN_PVRED, doc.PROD_VRED, doc.DEV_NVRED,
  doc.ORG_NVRED, doc.MALOPRODAJA, doc.IMA_POREZ, doc.POREZ, doc.PREN_POREZ, doc.POREZ_MARZA,  doc.TROSKOVI, doc.BR_STAVKI,  
  doc.UVODNI_TEKST, doc.ZAVRSNI_TEKST,  doc.OZNAKA, doc.OTPREMLJENO, doc.SF_VZC, doc.SF_VZL, doc.DAT_SLANJA, doc.REALIZOVANO, 
  doc.M_TIP_doc, doc.M_NAZIV, doc.M_docUMENT, doc.M_SF_KOM, doc.OBRADJENO,
                'document_stavke' value JSON_ARRAYAGG(
                    json_object (ds.*) returning clob
                ) 
            returning clob
            )
            returning clob pretty
        ) as dataJSON 
    FROM  maxi_2024.document doc, maxi_2024.document_stavke ds
    where  doc.SF_POS=ds.SF_POS and doc.RJ=ds.RJ and doc.SF_TIP_doc=ds.SF_TIP_doc and doc.docUMENT=ds.docUMENT
    and doc.SF_POS=SF_POS_doc and doc.RJ=RJ_doc and doc.SF_TIP_doc=SF_TIP_doc2 and doc.docUMENT=docUMENT_doc
group  by doc.SF_POS, doc.RJ ,doc.SF_TIP_doc, doc.docUMENT,doc.SF_PODTIP_doc,doc.IME_OP,doc.SF_RAD, doc.DAT_FORM,
  doc.DAT_doc,doc.DAT_DPO ,doc.SF_POS_2, doc.RJ_2, doc.SF_KOM, doc.SF_KPOS, doc.IZJAVA, doc.DAT_IZJ, doc.SF_TIP_doc_2, doc.docUMENT_2,
  doc.IZNOS_doc_2, doc.MAG_doc, doc.OTPREMNICA, doc.UGOVOR, doc.JCI, doc.MARZA_P, doc.RABAT_P, doc.RABAT, doc.POPUST, doc.SF_DEV,
  doc.DEV_KURS, doc.NAPOMENA, doc.ZAVRSENO, doc.STORNIRA, doc.SF_TIP_NAL, doc.NALOG, doc.OSN_PVRED, doc.PROD_VRED, doc.DEV_NVRED,
  doc.ORG_NVRED, doc.MALOPRODAJA, doc.IMA_POREZ, doc.POREZ, doc.PREN_POREZ, doc.POREZ_MARZA,  doc.TROSKOVI, doc.BR_STAVKI,  
  doc.UVODNI_TEKST, doc.ZAVRSNI_TEKST,  doc.OZNAKA, doc.OTPREMLJENO, doc.SF_VZC, doc.SF_VZL, doc.DAT_SLANJA, doc.REALIZOVANO, 
  doc.M_TIP_doc, doc.M_NAZIV, doc.M_docUMENT, doc.M_SF_KOM, doc.OBRADJENO;
end;
/
