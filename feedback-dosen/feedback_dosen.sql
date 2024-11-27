CREATE OR REPLACE TRIGGER check_user_role_before_feedback
BEFORE INSERT ON feedback
FOR EACH ROW
DECLARE
    v_user_role VARCHAR2(50);
BEGIN
    -- Ambil role user dari tabel user
    SELECT role
    INTO v_user_role
    FROM "user"
    WHERE id_user = :NEW.user_id;

    -- Periksa apakah role user adalah 'lecture'
    IF v_user_role != 'lecture' THEN
        RAISE_APPLICATION_ERROR(-20003, 'Hanya user dengan role "lecture" yang dapat memberikan feedback.');
    END IF;
END;
/

-- Penilaian dan Feedback Dosen
CREATE OR REPLACE PROCEDURE submit_feedback (
    p_user_id          IN INTEGER,
    p_proposals_id     IN CHAR,
    p_revision_note    IN CLOB,
    p_revision_date    IN DATE,
    p_revision_section IN SMALLINT
) AS
BEGIN
    -- Masukkan feedback dosen ke tabel feedback
    INSERT INTO feedback (
        id_revision,
        revision_note,
        revision_date,
        proposals_id,
        user_id,
        revision_section
    )
    VALUES (
        feedback_seq.NEXTVAL, -- Diasumsikan ada sequence untuk id_revision
        p_revision_note,
        p_revision_date,
        p_proposals_id,
        p_user_id,
        p_revision_section
    );
    
    -- Commit perubahan
    COMMIT;
END submit_feedback;
/