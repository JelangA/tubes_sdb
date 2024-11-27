CREATE OR REPLACE PROCEDURE add_scheme_type (
    p_id IN CHAR,
    p_scheme_id IN CHAR,
    p_name IN VARCHAR2
) AS
BEGIN
    INSERT INTO scheme_types (id, scheme_id, name)
    VALUES (p_id, p_scheme_id, p_name);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE add_timeline_type (
    p_id IN CHAR,
    p_timeline_id IN CHAR,
    p_name IN VARCHAR2,
    p_order_num IN NUMBER,
    p_start_date IN DATE,
    p_end_date IN DATE
) AS
BEGIN
    INSERT INTO timeline_types (id, timeline_id, name, order_num, start_date, end_date)
    VALUES (p_id, p_timeline_id, p_name, p_order_num, p_start_date, p_end_date);
    COMMIT;
END;
/
