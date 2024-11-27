CREATE OR REPLACE PROCEDURE ApproveRejectProposal (
    p_proposal_id IN CHAR,
    p_status IN VARCHAR2,
    p_reviewer_id IN CHAR,
    p_revision_note IN CLOB DEFAULT NULL
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

    -- Validasi status yang diizinkan
    IF p_status NOT IN ('LOLOS', 'TIDAK_LOLOS') THEN
        RAISE_APPLICATION_ERROR(-20002, 'Status tidak valid. Hanya LOLOS atau TIDAK_LOLOS yang diizinkan.');
    END IF;

    -- Perbarui status proposal
    UPDATE proposals
    SET status = p_status
    WHERE id = p_proposal_id;

    -- Tambahkan feedback jika ada catatan revisi
    IF p_revision_note IS NOT NULL THEN
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
                     (SELECT user_id FROM reviewer WHERE id_reviewer = p_reviewer_id),
                     NULL -- Jika tidak ada bagian tertentu untuk revisi
                 );
    END IF;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Proposal berhasil diperbarui.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END ApproveRejectProposal;
/