DECLARE
    v_members SYS.ODCIVARCHAR2LIST;
BEGIN
    -- Tambahkan NIM anggota tim
    v_members := SYS.ODCIVARCHAR2LIST('123456789', '987654321', '112233445');

    -- Panggil prosedur
    register_team_with_proposal(
        p_team_name          => 'Tech Innovators',
        p_business_name      => 'TechCorp',
        p_business_overview  => 'Innovating technology solutions',
        p_business_instagram => 'techcorp_official',
        p_business_situation => 'Pre-market validation completed',
        p_submission_funds   => 5000000,
        p_turnover_targets   => 20000000,
        p_year               => 2024,
        p_leader_nim         => '123456789',
        p_leader_user_id     => 1001,
        p_scheme_types_id    => 'A123B456C789',
        p_lecture_nip        => '9876543210123456',
        p_members            => v_members
    );
END;
/