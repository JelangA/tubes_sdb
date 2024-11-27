-- Trigger status
CREATE OR REPLACE TRIGGER before_verify_proposal
BEFORE UPDATE OF status ON proposals
FOR EACH ROW
BEGIN
    IF :NEW.status = 'DIVERIFIKASI' AND :OLD.status != 'DIUSULKAN' THEN
        RAISE_APPLICATION_ERROR(-20002, 'Proposal hanya dapat diverifikasi jika status sebelumnya DIUSULKAN.');
    END IF;
END;
/

-- Procedure admin verifikasi tim
CREATE OR REPLACE PROCEDURE verify_team (
    p_proposals_id IN CHAR
) AS
BEGIN
    -- Update status proposal menjadi DISETUJUI
    UPDATE proposals
    SET status = 'DIVERIFIKASI'
    WHERE id = p_proposals_id;

    -- Cek apakah ada baris yang diupdate
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Proposal tidak ditemukan atau sudah diverifikasi.');
    END IF;

    -- Commit perubahan
    COMMIT;
END verify_team;
/