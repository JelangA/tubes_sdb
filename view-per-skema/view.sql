-- proposal per skema
CREATE VIEW view_proposals_per_skema AS
SELECT 
    st.name AS scheme_type_name,
    s.name AS scheme_name,
    p.team_name,
    p.business_name,
    p.status,
    p.submission_funds,
    p.turnover_targets,
    p.year
FROM 
    proposals p
JOIN 
    scheme_types st ON p.scheme_types_id = st.id
JOIN 
    schemes s ON st.schemes_id = s.id;

SELECT * FROM view_proposals_per_skema WHERE scheme_name = 'Scheme 1';