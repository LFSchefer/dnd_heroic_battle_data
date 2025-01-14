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
SELECT * FROM monster_languages ml;
SELECT * FROM monster_imunities mi;
SELECT * FROM monster_resistances mr;
SELECT * FROM monster_vulnerabilities mv;
SELECT * FROM monster_condition_immunities mci;
SELECT * FROM monsters_stats;
SELECT * FROM damage_types dt ;

SELECT d.damage_id, d.damage_dices, dt.damage_type_name, dt.description FROM damages d
INNER JOIN damage_types dt ON dt.damage_type_id = d.damage_type_id;

SELECT * FROM users u ;
SELECT * FROM campaigns c;
SELECT * FROM battles b ;
