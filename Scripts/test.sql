SELECT * FROM damage_types dt;
SELECT * FROM conditions c;
SELECT * FROM languages l;
SELECT * FROM alignments a;
SELECT * FROM proficiencies p;
SELECT * FROM sizes s;
SELECT * FROM monster_types mt;
SELECT * FROM senses s;
SELECT * FROM speeds s;
SELECT * FROM armor_classes ac;
SELECT * FROM monsters m;
SELECT * FROM usages u;
SELECT * FROM dcs d;
SELECT * FROM special_abilities sa;
SELECT * FROM damages d;

SELECT * FROM monsters m 
LEFT JOIN alignments a ON m.alignment_id = a.alignment_id 
INNER JOIN monster_types mt ON m.monster_type_id = mt.monster_type_id
INNER JOIN sizes s ON s.size_id = m.size_id
INNER JOIN senses s2 ON s2.sense_id = m.sense_id
INNER JOIN speeds s3 ON s3.speed_id = m.speed_id
INNER JOIN armor_classes ac ON ac.armor_classe_id = m.armor_id
;

SELECT * FROM monsters_stats;

SELECT d.damage_id, d.damage_dices, dt.damage_type_name, dt.description FROM damages d
INNER JOIN damage_types dt ON dt.damage_type_id = d.damage_type_id ;

SELECT * FROM users u ;
SELECT * FROM campaigns c;
SELECT * FROM battles b ;