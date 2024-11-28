CREATE OR REPLACE PROCEDURE register_team_member(
    p_id            CHAR,
    p_proposals_id  CHAR,
    p_students_nim  VARCHAR2,
    p_role          VARCHAR2
) AS
    v_proposal_count INTEGER;
    v_student_count  INTEGER;
BEGIN
    -- Validasi proposal ID
    SELECT COUNT(*)
    INTO v_proposal_count
    FROM proposals
    WHERE id = p_proposals_id;

    IF v_proposal_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Proposal ID tidak ditemukan.');
    END IF;

    -- Validasi NIM mahasiswa
    SELECT COUNT(*)
    INTO v_student_count
    FROM students
    WHERE nim = p_students_nim;

    IF v_student_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'NIM mahasiswa tidak valid.');
    END IF;

    -- Validasi role
    IF NOT (p_role IN ('LEADER', 'MEMBER-1', 'MEMBER-2', 'MEMBER-3', 'MEMBER-4')) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Role tidak valid.');
    END IF;

    -- Insert ke tabel proponent_members
    INSERT INTO proponent_members (id, proposals_id, students_nim, role)
    VALUES (p_id, p_proposals_id, p_students_nim, p_role);
END;
/
