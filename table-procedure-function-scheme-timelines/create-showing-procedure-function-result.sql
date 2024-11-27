DECLARE
    v_exists BOOLEAN;
BEGIN
    v_exists := check_scheme_exists('PMW-V');
    DBMS_OUTPUT.PUT_LINE('Skema Ada: ' || CASE WHEN v_exists THEN 'YES' ELSE 'NO' END);
END;


DECLARE
    v_status VARCHAR2(10);
BEGIN
    v_status := get_timeline_status('TIMELINE001');
    DBMS_OUTPUT.PUT_LINE('Status Timeline: ' || v_status);
END;
