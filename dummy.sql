INSERT ALL
    INTO "user" (id_user, name, phone, email, password, role) VALUES (1, 'Admin User', '081234567890', 'admin@example.com', 'admin123', 'admin')
INTO "user" (id_user, name, phone, email, password, role) VALUES (2, 'Dosen A', '081234567891', 'dosenA@example.com', 'passwordA', 'lecture')
INTO "user" (id_user, name, phone, email, password, role) VALUES (3, 'Reviewer A', '081234567892', 'reviewerA@example.com', 'passwordB', 'reviewer')
INTO "user" (id_user, name, phone, email, password, role) VALUES (4, 'Mahasiswa A', '081234567893', 'mahasiswaA@example.com', 'passwordC', 'student')
INTO "user" (id_user, name, phone, email, password, role) VALUES (5, 'Mahasiswa B', '081234567894', 'mahasiswaB@example.com', 'passwordD', 'student')
INTO "user" (id_user, name, phone, email, password, role) VALUES (6, 'Reviewer B', '081234567895', 'reviewerB@example.com', 'passwordE', 'reviewer')
INTO "user" (id_user, name, phone, email, password, role) VALUES (7, 'Dosen B', '081234567896', 'dosenB@example.com', 'passwordF', 'lecture')
SELECT * FROM dual;




INSERT INTO lecture (nip, user_id, major, study_program, status) VALUES ('123456789012345678', 2, 'Teknik Informatika', 'Sistem Informasi', 'AKTIF');
INSERT INTO lecture (nip, user_id, major, study_program, status) VALUES ('123456789012345679', 7, 'Teknik Elektro', 'Komputer dan Elektronika', 'AKTIF');

INSERT INTO students (nim, user_id, major, study_program, year, status) VALUES ('210001', 4, 'Teknik Informatika', 'Sistem Informasi', 2022, 'AKTIF');
INSERT INTO students (nim, user_id, major, study_program, year, status) VALUES ('210002', 5, 'Teknik Informatika', 'Sistem Komputer', 2023, 'AKTIF');

INSERT INTO reviewer (id_reviewer, user_id, company, status) VALUES ('rev-001', 3, 'PT. Reviewer Sejahtera', 'AKTIF');
INSERT INTO reviewer (id_reviewer, user_id, company, status) VALUES ('rev-002', 6, 'PT. Reviewer Teknologi', 'AKTIF');

INSERT INTO schemes (id, name) VALUES ('sch-001', 'Scheme 1');
INSERT INTO schemes (id, name) VALUES ('sch-002', 'Scheme 2');
INSERT INTO schemes (id, name) VALUES ('sch-003', 'Scheme 3');

INSERT INTO scheme_types (id, schemes_id, name) VALUES ('sct-001', 'sch-001', 'Type A');
INSERT INTO scheme_types (id, schemes_id, name) VALUES ('sct-002', 'sch-001', 'Type B');
INSERT INTO scheme_types (id, schemes_id, name) VALUES ('sct-003', 'sch-002', 'Type C');

INSERT INTO timelines (id, schemes_id, year, status) VALUES ('tim-001', 'sch-001', 2024, 'AKTIF');
INSERT INTO timelines (id, schemes_id, year, status) VALUES ('tim-002', 'sch-002', 2023, 'NON-AKTIF');

INSERT INTO timeline_types (ORDER_NUM, id, timelines_id, name, START_DATE, end_date)
VALUES (1, 'tlt-001', 'tim-001', 'Submission Period', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-02-01', 'YYYY-MM-DD'));
INSERT INTO timeline_types (ORDER_NUM, id, timelines_id, name, START_DATE, END_DATE)
VALUES (2, 'tlt-002', 'tim-001', 'Review Period', TO_DATE('2024-02-02', 'YYYY-MM-DD'), TO_DATE('2024-03-01', 'YYYY-MM-DD'));

INSERT INTO proposals (id, lecture_nip, scheme_types_id, letter, team_name, business_name, business_overview, business_instagram, business_situation, submission_funds, turnover_targets, year, status, is_completed)
VALUES ('prop-001', '123456789012345678', 'sct-001', 'Surat Proposal', 'Tim A', 'Bisnis A', 'Overview bisnis A', '@bisnisA', 'Situasi bisnis stabil', 10000000, 20000000, 2024, 'DIUSULKAN', 0);
INSERT INTO proposals (id, lecture_nip, scheme_types_id, letter, team_name, business_name, business_overview, business_instagram, business_situation, submission_funds, turnover_targets, year, status, is_completed)
VALUES ('prop-002', '123456789012345679', 'sct-002', 'Surat Proposal B', 'Tim B', 'Bisnis B', 'Overview bisnis B', '@bisnisB', 'Situasi bisnis berkembang', 15000000, 25000000, 2024, 'DIUSULKAN', 1);

INSERT INTO proponent_members (id, proposals_id, students_nim, role) VALUES ('pm-001', 'prop-001', '210001', 'LEADER');
INSERT INTO proponent_members (id, proposals_id, students_nim, role) VALUES ('pm-002', 'prop-002', '210002', 'LEADER');

INSERT INTO feedback (id_revision, revision_note, revision_date, proposals_id, user_id, revision_section)
VALUES (1, 'Revisi bagian pendanaan', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'prop-001', 3, 1);
INSERT INTO feedback (id_revision, revision_note, revision_date, proposals_id, user_id, revision_section)
VALUES (2, 'Revisi struktur tim', TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'prop-002', 6, 2);

INSERT INTO support_files (id, proposals_id, name, url) VALUES ('sf-001', 'prop-001', 'Dokumen Pendukung A', 'https://example.com/dokumenA');
INSERT INTO support_files (id, proposals_id, name, url) VALUES ('sf-002', 'prop-002', 'Dokumen Pendukung B', 'https://example.com/dokumenB');