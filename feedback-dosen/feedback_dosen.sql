CREATE SEQUENCE feedback_seq
START WITH 1  -- Nilai awal
INCREMENT BY 1  -- Langkah kenaikan
NOCACHE;        -- Tidak menggunakan cache untuk nilai

CREATE OR REPLACE TRIGGER check_user_role_before_feedback
BEFORE INSERT ON feedback
FOR EACH ROW
DECLARE
    v_user_role     VARCHAR2(50);
    v_lecture_nip   VARCHAR2(18);  -- Mendeklarasikan variabel nip dosen
    v_feedback_nip  VARCHAR2(18);  -- Variabel untuk menyimpan nip dosen pemberi feedback
BEGIN
    -- Ambil role user dari tabel "user"
    SELECT role
    INTO v_user_role
    FROM "user"
    WHERE id_user = :NEW.user_id;

    -- Periksa apakah role user adalah 'lecture'
    IF v_user_role != 'lecture' THEN
        RAISE_APPLICATION_ERROR(-20003, 'Hanya user dengan role "lecture" yang dapat memberikan feedback.');
    END IF;

    -- Ambil nip dari dosen yang terkait dengan proposal
    SELECT lecture_nip
    INTO v_lecture_nip
    FROM proposals
    WHERE id = :NEW.proposals_id;

    -- Ambil nip dosen yang memberikan feedback
    SELECT nip
    INTO v_feedback_nip
    FROM lecture
    WHERE user_id = :NEW.user_id;

    -- Periksa apakah nip dosen pemberi feedback tidak sama dengan nip dosen di proposal
    IF v_feedback_nip = v_lecture_nip THEN
        RAISE_APPLICATION_ERROR(-20004, 'Dosen yang memberikan feedback tidak boleh sama dengan dosen pendamping.');
    END IF;
END;
/

-- Penilaian dan Feedback Dosen
CREATE OR REPLACE PROCEDURE submit_feedback (
    p_user_id          IN INTEGER,
    p_proposals_id     IN CHAR,
    p_revision_note    IN CLOB,
    p_revision_date    IN DATE,
    p_revision_section IN SMALLINT,
    p_new_status       IN VARCHAR2
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
    
    IF p_new_status NOT IN ('DISETUJUI', 'DITOLAK') THEN
    RAISE_APPLICATION_ERROR(-20001, 'Status tidak valid.');
    END IF;
    
    UPDATE proposals
    SET status = p_new_status
    WHERE id = p_proposals_id;

    -- Commit perubahan
    COMMIT;
END submit_feedback;
/

BEGIN
    submit_feedback(
        p_user_id          => 5,
        p_proposals_id     => 'prop-001',
        p_revision_note    => 'Tim memerlukan perbaikan pada bagian C.',
        p_revision_date    => SYSDATE,
        p_revision_section => 1,
        p_new_status       => 'DISETUJUI'
    );
END;