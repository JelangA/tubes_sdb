CREATE OR REPLACE TRIGGER before_verify_proposal
BEFORE UPDATE OF status ON proposals
FOR EACH ROW
BEGIN
    IF (:NEW.status = 'DIVERIFIKASI' OR :NEW.status = 'VERIFIKASI_GAGAL') AND :OLD.status != 'DIUSULKAN' THEN
        RAISE_APPLICATION_ERROR(-20002, 'Proposal hanya dapat diverifikasi jika status sebelumnya DIUSULKAN.');
    END IF;
END;
/

-- Procedure admin verifikasi tim
CREATE OR REPLACE PROCEDURE verify_team (
    p_proposals_id IN CHAR,
    p_new_status   IN VARCHAR2
) AS
BEGIN
    -- Status
    IF p_new_status NOT IN ('DIVERIFIKASI', 'VERIFIKASI_GAGAL') THEN
    RAISE_APPLICATION_ERROR(-20001, 'Status tidak valid.');
    END IF;

    -- Update status proposal menjadi DISETUJUI
    UPDATE proposals
    SET status = p_new_status
    WHERE id = p_proposals_id;

    -- Cek apakah ada baris yang diupdate
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Proposal tidak ditemukan atau sudah diverifikasi.');
    END IF;

    -- Commit perubahan
    COMMIT;
END verify_team;
/

BEGIN
    verify_team(
        p_proposals_id => 'prop-001',
        p_new_status => 'VERIFIKASI_GAGAL'
    );
END;