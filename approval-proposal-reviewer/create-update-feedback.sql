-- Prosedur untuk memberikan feedback langsung
CREATE OR REPLACE PROCEDURE AddFeedback (
    p_proposal_id IN CHAR,
    p_user_id IN INTEGER,
    p_revision_note IN CLOB,
    p_revision_section IN SMALLINT
) AS
    v_exists NUMBER;
BEGIN
    -- Validasi apakah proposal ID ada
SELECT COUNT(*) INTO v_exists
FROM proposals
WHERE id = p_proposal_id;

IF v_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Proposal tidak ditemukan.');
END IF;

    -- Tambahkan feedback ke tabel
INSERT INTO feedback (
    id_revision,
    revision_note,
    revision_date,
    proposals_id,
    user_id,
    revision_section
) VALUES (
             feedback_seq.NEXTVAL, -- Asumsi ada sequence untuk ID revisi
             p_revision_note,
             SYSDATE,
             p_proposal_id,
             p_user_id,
             p_revision_section
         );

COMMIT;

DBMS_OUTPUT.PUT_LINE('Feedback berhasil ditambahkan.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END AddFeedback;
/