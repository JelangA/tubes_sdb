CREATE OR REPLACE PROCEDURE add_timeline (
    p_id IN CHAR,
    p_scheme_id IN CHAR,
    p_year IN VARCHAR2,
    p_status IN VARCHAR2
) AS
BEGIN
    INSERT INTO timelines (id, scheme_id, year, status)
    VALUES (p_id, p_scheme_id, p_year, p_status);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE add_scheme (
    p_id IN CHAR,
    p_name IN VARCHAR2
) AS
BEGIN
    INSERT INTO schemes (id, name)
    VALUES (p_id, p_name);
    COMMIT;
END;
/

CREATE OR REPLACE FUNCTION check_scheme_exists (
    p_name IN VARCHAR2
) RETURN BOOLEAN AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM schemes
    WHERE LOWER(name) = LOWER(p_name);

    RETURN v_count > 0;
END;
/

CREATE OR REPLACE FUNCTION get_timeline_status (
    p_id IN CHAR
) RETURN VARCHAR2 AS
    v_status VARCHAR2(10);
BEGIN
    SELECT status
    INTO v_status
    FROM timelines
    WHERE id = p_id;

    RETURN v_status;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'NOT FOUND';
END;
/
