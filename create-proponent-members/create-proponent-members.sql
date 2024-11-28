CREATE OR REPLACE PROCEDURE register_team_with_proposal (
    p_team_name          VARCHAR2,
    p_business_name      VARCHAR2,
    p_business_overview  CLOB,
    p_business_instagram VARCHAR2,
    p_business_situation VARCHAR2,
    p_submission_funds   NUMBER,
    p_turnover_targets   NUMBER,
    p_year               SMALLINT,
    p_leader_nim         VARCHAR2,
    p_leader_user_id     INTEGER,
    p_scheme_types_id    CHAR,
    p_lecture_nip        VARCHAR2,
    p_members            SYS.ODCIVARCHAR2LIST -- List of NIM for team members
) AS
    v_proposals_id CHAR(36);
    v_member_id    CHAR(36);
BEGIN
    -- Generate unique ID for the proposal
    v_proposals_id := SYS_GUID();

    -- Insert Proposal
    INSERT INTO proposals (
        id, lecture_nip, scheme_types_id, team_name, business_name,
        business_overview, business_instagram, business_situation,
        submission_funds, turnover_targets, year, status, is_completed
    ) VALUES (
        v_proposals_id, p_lecture_nip, p_scheme_types_id, p_team_name, p_business_name,
        p_business_overview, p_business_instagram, p_business_situation,
        p_submission_funds, p_turnover_targets, p_year, 'DIUSULKAN', 0
    );

    -- Insert Leader as Proponent Member
    v_member_id := SYS_GUID();
    INSERT INTO proponent_members (
        id, proposals_id, students_nim, role
    ) VALUES (
        v_member_id, v_proposals_id, p_leader_nim, 'LEADER'
    );

    -- Insert Team Members
    IF p_members IS NOT NULL THEN
        FOR i IN 1 .. p_members.COUNT LOOP
            v_member_id := SYS_GUID();
            INSERT INTO proponent_members (
                id, proposals_id, students_nim, role
            ) VALUES (
                v_member_id, v_proposals_id, p_members(i), 'MEMBER-' || i
            );
        END LOOP;
    END IF;

    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Proposal and team successfully registered with Proposal ID: ' || v_proposals_id);

EXCEPTION
    WHEN OTHERS THEN
        -- Rollback transaction in case of any error
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Error occurred: ' || SQLERRM);
END;
/