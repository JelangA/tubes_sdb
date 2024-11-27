DECLARE
    v_exists BOOLEAN;
BEGIN
    v_exists := check_scheme_type_exists('SCHEMA001', 'Kategori 1');
    DBMS_OUTPUT.PUT_LINE('Scheme Type Exists: ' || CASE WHEN v_exists THEN 'YES' ELSE 'NO' END);
END;
/

DECLARE
    v_info VARCHAR2(200);
BEGIN
    v_info := get_timeline_type_info('TIMELINETYPE001');
    DBMS_OUTPUT.PUT_LINE('Timeline Type Info: ' || v_info);
END;
/


