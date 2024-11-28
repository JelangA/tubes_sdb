CREATE OR REPLACE PROCEDURE upload_proposal(
    p_id                CHAR,
    p_lecture_nip       VARCHAR2,
    p_scheme_types_id   CHAR,
    p_team_name         VARCHAR2,
    p_business_name     VARCHAR2,
    p_business_overview CLOB,
    p_business_situation VARCHAR2,
    p_submission_funds  NUMBER,
    p_turnover_targets  NUMBER,
    p_year              SMALLINT
) AS
    v_lecture_count INTEGER;
    v_scheme_count  INTEGER;
BEGIN
    -- Validasi NIP dosen
    SELECT COUNT(*)
    INTO v_lecture_count
    FROM lecture
    WHERE nip = p_lecture_nip;

    IF v_lecture_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'NIP dosen pembimbing tidak valid.');
    END IF;

    -- Validasi scheme_types_id
    SELECT COUNT(*)
    INTO v_scheme_count
    FROM scheme_types
    WHERE id = p_scheme_types_id;

    IF v_scheme_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Scheme Types ID tidak valid.');
    END IF;

    -- Insert ke tabel proposals
    INSERT INTO proposals (
        id, lecture_nip, scheme_types_id, team_name, business_name,
        business_overview, business_situation, submission_funds,
        turnover_targets, year, status, is_completed
    )
    VALUES (
        p_id, p_lecture_nip, p_scheme_types_id, p_team_name, p_business_name,
        p_business_overview, p_business_situation, p_submission_funds,
        p_turnover_targets, p_year, 'DIUSULKAN', 0
    );
END;
/
