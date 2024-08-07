SELECT * FROM damage_types dt ;
SELECT * FROM conditions c ;
SELECT * FROM languages l ;
SELECT * FROM alignments a ;
SELECT * FROM proficiencies p ;
SELECT * FROM sizes s ;
SELECT * FROM monster_types mt ;
SELECT * FROM senses s ;
SELECT * FROM speeds s ;
SELECT * FROM armor_classes ac ;
SELECT * FROM monsters m ;

SELECT * FROM monsters m 
LEFT JOIN alignments a ON m.alignment_id = a.alignment_id 
INNER JOIN monster_types mt ON m.monster_type_id = mt.monster_type_id
INNER JOIN sizes s ON s.size_id = m.size_id
INNER JOIN senses s2 ON s2.sense_id = m.sense_id
;
