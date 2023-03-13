SELECT last_unit_id - 1 as district, gender, race, major_award_count, allegation_count, sustained_count, unsustained_count, birth_year
         FROM data_policeunit
                  LEFT JOIN data_officer d ON data_policeunit.id = d.last_unit_id
         WHERE data_policeunit.id > 0 AND data_policeunit.id < 27