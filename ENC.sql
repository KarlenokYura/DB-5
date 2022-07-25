VARIABLE enc_val varchar2(2000);
DECLARE
  l_key      VARCHAR2 (2000) := '2812201928122019';
  l_in_val   VARCHAR2 (2000) := 'Happy New Year';       
  l_mod      NUMBER :=   DBMS_CRYPTO.encrypt_aes128
                    + DBMS_CRYPTO.chain_cbc
                    + DBMS_CRYPTO.pad_pkcs5;
  l_enc      RAW (2000);
BEGIN
  l_enc := DBMS_CRYPTO.encrypt (utl_i18n.string_to_raw (l_in_val, 'AL32UTF8'),
                                l_mod,
                                utl_i18n.string_to_raw (l_key, 'AL32UTF8')
                               );
  DBMS_OUTPUT.put_line ('Encrypted=' || l_enc);
  :enc_val := RAWTOHEX (l_enc);
END;

DECLARE
  l_key      VARCHAR2 (2000) := '2812201928122019';
  l_in_val   RAW (2000)      := HEXTORAW (:enc_val);
  l_mod      NUMBER :=   DBMS_CRYPTO.encrypt_aes128
                    + DBMS_CRYPTO.chain_cbc
                    + DBMS_CRYPTO.pad_pkcs5;
  l_dec      RAW (2000);
BEGIN
  l_dec := DBMS_CRYPTO.decrypt (l_in_val,
                                l_mod,
                                utl_i18n.string_to_raw (l_key, 'AL32UTF8')
                               );
  DBMS_OUTPUT.put_line ('Decrypted=' || utl_i18n.raw_to_char (l_dec));
END;

DECLARE
   l_key   RAW (16);
BEGIN
   l_key := DBMS_CRYPTO.randombytes (16);
   DBMS_OUTPUT.put_line ('Key=' || l_key);
END;



DECLARE
  l_in_val   VARCHAR2 (2000) := 'Happy New Year';
  l_hash     RAW (2000);
BEGIN
  l_hash := DBMS_CRYPTO.HASH (src => utl_i18n.string_to_raw (
                              l_in_val, 'AL32UTF8'),
                              typ => DBMS_CRYPTO.hash_sh1
                              );
  DBMS_OUTPUT.put_line ('Hash=' || l_hash);
END;


DECLARE
   l_in_val   VARCHAR2 (2000) := 'Happy New Year';
   l_key      VARCHAR2 (2000) := '2812201928122019';
   l_mac      RAW (2000);
BEGIN
   l_mac :=
      DBMS_CRYPTO.mac (src      => utl_i18n.string_to_raw (l_in_val,'AL32UTF8'),
                       typ      => DBMS_CRYPTO.hmac_sh1,
                       KEY      => utl_i18n.string_to_raw (l_key, 'AL32UTF8')
                      );
   DBMS_OUTPUT.put_line ('MAC=' || l_mac);

   l_key := '3112201931122019';
   l_mac :=
      DBMS_CRYPTO.mac (src      => utl_i18n.string_to_raw (l_in_val,'AL32UTF8'),
                       typ      => DBMS_CRYPTO.hmac_sh1,
                       KEY      => utl_i18n.string_to_raw (l_key, 'AL32UTF8')
                      );
   DBMS_OUTPUT.put_line ('MAC=' || l_mac);
END;