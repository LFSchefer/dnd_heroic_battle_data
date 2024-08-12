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
INNER JOIN speeds s3 ON s3.speed_id = m.speed_id
INNER JOIN armor_classes ac ON ac.armor_classe_id = m.armor_id
;

CREATE OR REPLACE VIEW monsters_stats AS
	SELECT  m.monster_id, m.monster_name, m.hit_points, m.hit_dices, m.hit_points_roll, m.strength,
	m.dexterity, m.constitution, m.intelligence, m.wisdom, m.charisma, m.challenge_rating, m.xp,
	m.image_url, m.dnd5_url, m.dnd5_native, a.alignment_id , a.alignments_name ,a.description ,
	s.size_id , s.size_name , s2.sense_id , s2.darkvision , s2.passive_perception ,
	s3.speed_id , s3.walk , s3.swim , s3.fly , ac.armor_classe_id , ac.armor_type , ac.armor_value 
	FROM monsters m 
	LEFT JOIN alignments a ON m.alignment_id = a.alignment_id 
	INNER JOIN monster_types mt ON m.monster_type_id = mt.monster_type_id
	INNER JOIN sizes s ON s.size_id = m.size_id
	INNER JOIN senses s2 ON s2.sense_id = m.sense_id
	INNER JOIN speeds s3 ON s3.speed_id = m.speed_id
	INNER JOIN armor_classes ac ON ac.armor_classe_id = m.armor_id
;

SELECT * FROM monsters_stats;