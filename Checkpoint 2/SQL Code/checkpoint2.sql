-- Racial distribution of Population of each district
SELECT area_id AS district,
SUM(count) filter (WHERE race = 'Black') AS Blackpop,
SUM(count) filter (WHERE race = 'White')  AS Whitepop,
SUM(count) filter (WHERE race = 'Hispanic')  AS Hispanicpop,
SUM(count) filter (WHERE race = 'Asian/Pacific Islander')  AS AsianPacificIslanderpop,
SUM(count) filter (WHERE race = 'Native American/Alaskan Native')  AS Nativepop,
SUM(count) filter (WHERE race = 'Other/Unknown')  AS Otherpop,
SUM(count) filter (WHERE race = 'Black')*100.0 / (SUM(count))  AS Blackpoppercent,
SUM(count) filter (WHERE race = 'White')*100.0  / (SUM(count))  AS Whitepoppercent,
SUM(count) filter (WHERE race = 'Hispanic') *100.0 / (SUM(count)) AS Hispanicpoppercent,
SUM(count) filter (WHERE race = 'Asian/Pacific Islander')*100.0  / SUM(count) AS AsianPacificIslanderpoppercent,
SUM(count) filter (WHERE race = 'Native American/Alaskan Native')*100.0  / SUM(count)  AS NativeAmericanpoppercent,
SUM(count) filter (WHERE race = 'Other/Unknown')*100.0  / SUM(count)  AS Otherpoppercent
FROM data_racepopulation JOIN data_area area on data_racepopulation.area_id = area.id
WHERE area.area_type = 'police-districts'
GROUP BY area_id ORDER BY district ASC;

-- Guide to map area_id to Police District
SELECT id, name, area_type from data_area where area_type = 'police-districts' ORDER BY id ASC;


SELECT last_unit_id - 1 as district, gender, race, major_award_count, allegation_count, sustained_count, unsustained_count, birth_year
         FROM data_policeunit
                  LEFT JOIN data_officer d ON data_policeunit.id = d.last_unit_id
         WHERE data_policeunit.id > 0 AND data_policeunit.id < 27


-- Racial Distribution of Police officers per district in Chicago
SELECT data_policeunit.id - 1 AS district,
       count(*) AS police_per_district,
       count(*) filter (WHERE race = 'Black')  AS Black,
       count(*) filter (WHERE race = 'White')  AS White,
       count(*) filter (WHERE race = 'Hispanic')  AS Hispanic,
       count(*) filter (WHERE race = 'Asian/Pacific')  AS AsianPacificIslander,
       count(*) filter (WHERE race = 'Native American/Alaskan Native')  AS Native,
--        count(*) filter (WHERE race = 'Other/Unknown')  AS Other,
       round(count(*) filter (WHERE race = 'Black')*100.0/count(*), 2)  AS Blackpercent,
       round(count(*) filter (WHERE race = 'White')*100.0/count(*), 2)  AS Whitepercent,
       round(count(*) filter (WHERE race = 'Hispanic')*100.0/count(*), 2)  AS Hispanicpercent,
       round(count(*) filter (WHERE race = 'Asian/Pacific')*100.0/count(*), 2)  AS AsianPacificpercent,
       round(count(*) filter (WHERE race = 'Native American/Alaskan Native')*100.0/count(*), 2)  AS Nativepercent,
       100 - (round(count(*) filter (WHERE race = 'Black')*100.0/count(*), 2) +
              round(count(*) filter (WHERE race = 'White')*100.0/count(*), 2) +
              round(count(*) filter (WHERE race = 'Hispanic')*100.0/count(*), 2) +
              round(count(*) filter (WHERE race = 'Asian/Pacific')*100.0/count(*), 2) +
              round(count(*) filter (WHERE race = 'Native American/Alaskan Native')*100.0/count(*), 2)) AS Other
FROM data_policeunit JOIN data_officer officer ON data_policeunit.id = officer.last_unit_id
-- JOIN data_officerallegation d on officer.id = d.officer_id
WHERE data_policeunit.description in ('District 001', 'District 002', 'District 003', 'District 004',
'District 005', 'District 006', 'District 007', 'District 008', 'District 009', 'District 010', 'District 011',
'District 012', 'District 013', 'District 014', 'District 015', 'District 016', 'District 017', 'District 018',
'District 019', 'District 020', 'District 021', 'District 022', 'District 023', 'District 024', 'District 025')
GROUP BY data_policeunit.id ORDER BY district ASC;

-- Gender distribution of Police Officers per district in Chicago
SELECT data_policeunit.id - 1 AS district,
       count(*) filter (WHERE gender = 'F')  AS Femalepolice,
       count(*) filter (WHERE gender = 'M')  AS Malepolice,
       round(count(*) filter (WHERE gender = 'F')*100.0/count(*), 2)  AS Fpolicepercent, count(*) as test,
       round(count(*) filter (WHERE gender = 'M')*100.0/count(*), 2)  AS Mpolicepercent
--        100 - (round(count(*) filter (WHERE gender = 'F')*100.0/count(*), 2) +
--               round(count(*) filter (WHERE gender = 'M')*100.0/count(*), 2)) AS Other
FROM data_policeunit JOIN data_officer officer ON data_policeunit.id = officer.last_unit_id
-- JOIN data_officerallegation d on officer.id = d.officer_id
WHERE data_policeunit.description in ('District 001', 'District 002', 'District 003', 'District 004',
'District 005', 'District 006', 'District 007', 'District 008', 'District 009', 'District 010', 'District 011',
'District 012', 'District 013', 'District 014', 'District 015', 'District 016', 'District 017', 'District 018',
'District 019', 'District 020', 'District 021', 'District 022', 'District 023', 'District 024', 'District 025')
GROUP BY data_policeunit.id ORDER BY district ASC;