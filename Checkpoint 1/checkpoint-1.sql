-- Total Population per police district in Chicago
SELECT area_id AS district, SUM(count) AS totalpopulation
FROM data_racepopulation
    JOIN data_area area on data_racepopulation.area_id = area.id
WHERE area.area_type = 'police-districts'
GROUP BY area_id ORDER BY district ASC;

-- Population per Allegation
SELECT data_allegation_areas.area_id  as district, drp.area_population AS district_population, COUNT(*) AS allegation_count,
       round(COUNT(*)*1000/drp.area_population, 2) as allegationspercapita
FROM data_allegation_areas LEFT JOIN data_area area ON data_allegation_areas.area_id = area.id
JOIN (SELECT area_id, SUM(count) AS area_population FROM data_racepopulation group by area_id) drp
ON drp.area_id = area.id
WHERE area.area_type = 'police-districts' and drp.area_population is not null
GROUP BY data_allegation_areas.area_id, drp.area_population ORDER BY district ASC;

-- Total police per district in Chicago
SELECT data_policeunit.id - 1 AS district, count(*) AS police_per_district
FROM data_policeunit JOIN data_officer officer ON data_policeunit.id = officer.last_unit_id
JOIN data_officerallegation d on officer.id = d.officer_id
WHERE data_policeunit.description in ('District 001', 'District 002', 'District 003', 'District 004',
'District 005', 'District 006', 'District 007', 'District 008', 'District 009', 'District 010', 'District 011',
'District 012', 'District 013', 'District 014', 'District 015', 'District 016', 'District 017', 'District 018',
'District 019', 'District 020', 'District 021', 'District 022', 'District 023', 'District 024', 'District 025')
GROUP BY data_policeunit.id ORDER BY district ASC;

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
JOIN data_officerallegation d on officer.id = d.officer_id
WHERE data_policeunit.description in ('District 001', 'District 002', 'District 003', 'District 004',
'District 005', 'District 006', 'District 007', 'District 008', 'District 009', 'District 010', 'District 011',
'District 012', 'District 013', 'District 014', 'District 015', 'District 016', 'District 017', 'District 018',
'District 019', 'District 020', 'District 021', 'District 022', 'District 023', 'District 024', 'District 025')
GROUP BY data_policeunit.id ORDER BY district ASC;

-- Gender distribution of Police Officers per district in Chicago
SELECT data_policeunit.id - 1 AS district,
       count(*) filter (WHERE gender = 'F')  AS Femalepolice,
       count(*) filter (WHERE gender = 'M')  AS Malepolice,
       round(count(*) filter (WHERE gender = 'F')*100.0/count(*), 2)  AS Fpolicepercent,
       round(count(*) filter (WHERE gender = 'M')*100.0/count(*), 2)  AS Mpolicepercent
--        100 - (round(count(*) filter (WHERE gender = 'F')*100.0/count(*), 2) +
--               round(count(*) filter (WHERE gender = 'M')*100.0/count(*), 2)) AS Other
FROM data_policeunit JOIN data_officer officer ON data_policeunit.id = officer.last_unit_id
JOIN data_officerallegation d on officer.id = d.officer_id
WHERE data_policeunit.description in ('District 001', 'District 002', 'District 003', 'District 004',
'District 005', 'District 006', 'District 007', 'District 008', 'District 009', 'District 010', 'District 011',
'District 012', 'District 013', 'District 014', 'District 015', 'District 016', 'District 017', 'District 018',
'District 019', 'District 020', 'District 021', 'District 022', 'District 023', 'District 024', 'District 025')
GROUP BY data_policeunit.id ORDER BY district ASC;


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
