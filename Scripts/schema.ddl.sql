DROP TABLE IF EXISTS battle_conditions;
DROP TABLE IF EXISTS battle_monsters;
DROP TABLE IF EXISTS battles;
DROP TABLE IF EXISTS campaigns;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS monster_actions;
DROP TABLE IF EXISTS monster_proficiencies_bonus;
DROP TABLE IF EXISTS monster_condition_immunities;
DROP TABLE IF EXISTS monster_imunities;
DROP TABLE IF EXISTS monster_resistances;
DROP TABLE IF EXISTS monster_vulnerabilities;
DROP TABLE IF EXISTS monsters;
DROP TABLE IF EXISTS alignments;
DROP TABLE IF EXISTS languages;
DROP TABLE IF EXISTS proficiency_bonus;
DROP TABLE IF EXISTS proficiencies;
DROP TABLE IF EXISTS sizes;
DROP TABLE IF EXISTS monster_types;
DROP TABLE IF EXISTS action_damage;
DROP TABLE IF EXISTS actions;
DROP TABLE IF EXISTS damages;
DROP TABLE IF EXISTS speeds;
DROP TABLE IF EXISTS armor_classes;
DROP TABLE IF EXISTS senses;
DROP TABLE IF EXISTS conditions;
DROP TABLE IF EXISTS usages;
DROP TABLE IF EXISTS dc;
DROP TABLE IF EXISTS damage_types;


CREATE TABLE armor_classes (
	id bigint GENERATED ALWAYS AS IDENTITY,
	armor_type varchar(50) NOT NULL,
	armor_value SMALLINT NOT NULL,
	
	CONSTRAINT armor_classes_pkey PRIMARY KEY (id),
	CONSTRAINT armor_ukey UNIQUE (armor_type,armor_value)
);

CREATE TABLE speeds (
	id bigint GENERATED ALWAYS AS IDENTITY,
	walk SMALLINT,
	swim SMALLINT,
	fly SMALLINT,
	CONSTRAINT speed_pkey PRIMARY KEY (id),
	CONSTRAINT speed_ukey UNIQUE (walk,swim,fly)
);

CREATE TABLE senses (
	id bigint GENERATED ALWAYS AS IDENTITY,
	darkvision SMALLINT,
	passive_perception SMALLINT NOT NULL,
	CONSTRAINT sense_pkey PRIMARY KEY (id),
	CONSTRAINT sense_ukey UNIQUE (darkvision, passive_perception) 
);

CREATE TABLE conditions (
	id bigint GENERATED ALWAYS AS IDENTITY,
	condition_name varchar(50) NOT NULL UNIQUE,
	CONSTRAINT conditions_pkey PRIMARY KEY (id)
);

CREATE TABLE usages (
	id bigint GENERATED ALWAYS AS IDENTITY,
	usage_type varchar(20) NOT NULL,
	times SMALLINT NOT NULL,
	CONSTRAINT usage_ukey UNIQUE (usage_type,times),
	CONSTRAINT usages_pkey PRIMARY KEY (id)
);

CREATE TABLE dc (
	id bigint GENERATED ALWAYS AS IDENTITY,
	dc_type varchar(20) NOT NULL,
	dc_value SMALLINT NOT NULL,
	success_type varchar(20),
	CONSTRAINT dc_pkey PRIMARY KEY (id),
	CONSTRAINT dc_ukey UNIQUE (dc_type,dc_value,success_type)
);

CREATE TABLE damage_types (
	id bigint GENERATED ALWAYS AS IDENTITY,
	damage_type_name varchar(50) UNIQUE,
	description varchar(150),
	CONSTRAINT damage_type_pkey PRIMARY KEY (id)
);

CREATE TABLE damages (
	id bigint GENERATED ALWAYS AS IDENTITY,
	damage_type_id bigint,
	damage_dices varchar(25),
	CONSTRAINT damage_pkey PRIMARY KEY (id),
	CONSTRAINT damage_type_fkey FOREIGN KEY (damage_type_id) REFERENCES damage_types(id)
);

CREATE TABLE actions (
	id bigint GENERATED ALWAYS AS IDENTITY,
	action_name varchar(50) NOT NULL UNIQUE,
	description varchar(150),
	usage_id bigint,
	attack_bonus SMALLINT NOT NULL DEFAULT 0,
	dc_id bigint NOT NULL,
	CONSTRAINT actions_pkey PRIMARY KEY (id),
	CONSTRAINT usage_fkey FOREIGN KEY (usage_id) REFERENCES usages(id),
	CONSTRAINT dc_fkey FOREIGN KEY (dc_id) REFERENCES dc(id)
);

CREATE TABLE action_damage (
	id bigint GENERATED ALWAYS AS IDENTITY,
	action_id bigint NOT NULL,
	damage_id bigint NOT NULL,
	CONSTRAINT action_damage_pkey PRIMARY KEY (id),
	CONSTRAINT action_fkey FOREIGN KEY (action_id) REFERENCES actions(id),
	CONSTRAINT damage_fkey FOREIGN KEY (damage_id) REFERENCES damages(id),
	CONSTRAINT action_damage_ukey UNIQUE (action_id,damage_id)
);

CREATE TABLE monster_types (
	id bigint GENERATED ALWAYS AS IDENTITY,
	type_name varchar(50) NOT NULL,
	CONSTRAINT monter_type_pkey PRIMARY KEY (id),
	CONSTRAINT monster_types_ukey UNIQUE (type_name)
);

CREATE TABLE sizes (
	id bigint GENERATED ALWAYS AS IDENTITY,
	size_name varchar(50) NOT NULL,
	CONSTRAINT sizes_pkey PRIMARY KEY (id),
	CONSTRAINT size_ukey UNIQUE (size_name)
);

CREATE TABLE proficiencies (
	id bigint GENERATED ALWAYS AS IDENTITY,
	proficiency_name varchar(50) NOT NULL,
	proficiency_type varchar(50) NOT NULL,
	proficiency_attribute varchar(50) NOT NULL,
	CONSTRAINT proficiencies_pkey PRIMARY KEY (id),
	CONSTRAINT proficiency_ukey UNIQUE (proficiency_name)
);

CREATE TABLE proficiency_bonus (
	id bigint GENERATED ALWAYS AS IDENTITY,
	bonus_value SMALLINT NOT NULL,
	proficiency_id bigint NOT NULL,
	CONSTRAINT proficiency_bonus_pkey PRIMARY KEY (id),
	CONSTRAINT proficiency_fkey FOREIGN KEY (proficiency_id) REFERENCES proficiencies(id),
	CONSTRAINT proficiency_bonus_ukey UNIQUE (bonus_value,proficiency_id)
);

CREATE TABLE alignments (
	id bigint GENERATED ALWAYS AS IDENTITY,
	alignments_name varchar(50) NOT NULL,
	CONSTRAINT alignments_pkey PRIMARY KEY (id),
	CONSTRAINT alignment_ukey UNIQUE (alignments_name)
);

CREATE TABLE languages (
	id bigint GENERATED ALWAYS AS IDENTITY,
	languages_name varchar(50) NOT NULL,
	CONSTRAINT langages_pkey PRIMARY KEY (id),
	CONSTRAINT languages_ukey UNIQUE (languages_name)
);

CREATE TABLE monsters (
	id bigint GENERATED ALWAYS AS IDENTITY,
	monster_name varchar(100) NOT NULL,
	alignment_id bigint NOT NULL,
	hit_points SMALLINT NOT NULL,
	hit_dices varchar(30) NOT NULL,
	hit_points_roll varchar(30) NOT NULL,
	strenght SMALLINT NOT NULL,
	dexterity SMALLINT NOT NULL,
	constitution SMALLINT NOT NULL,
	inteligence SMALLINT NOT NULL,
	wisdom SMALLINT NOT NULL,
	charisma SMALLINT NOT NULL,
	languages_id bigint NOT NULL,
	challenge_rating SMALLINT NOT NULL,
	xp integer NOT NULL,
	image_url varchar(200),
	dnd5_url varchar(200),
	dnd5_native boolean NOT NULL DEFAULT FALSE,
	monter_type_id bigint NOT NULL,
	size_id bigint NOT NULL,
	sense_id bigint NOT NULL,
	speed_id bigint NOT NULL,
	armor_id bigint NOT NULL,
	CONSTRAINT monter_pkey PRIMARY KEY (id),
	CONSTRAINT monster_ukey UNIQUE (monster_name),
	CONSTRAINT monster_type_fkey FOREIGN KEY (monter_type_id) REFERENCES monster_types(id),
	CONSTRAINT size_fkey FOREIGN KEY (size_id) REFERENCES sizes (id),
	CONSTRAINT sense_fkey FOREIGN KEY (sense_id) REFERENCES senses(id),
	CONSTRAINT speed_fkey FOREIGN KEY (speed_id) REFERENCES speeds(id),
	CONSTRAINT armor_fkey FOREIGN KEY (armor_id) REFERENCES armor_classes(id),
	CONSTRAINT alignment_fkey FOREIGN KEY (alignment_id) REFERENCES alignments(id),
	CONSTRAINT langage_fkey FOREIGN KEY (languages_id) REFERENCES languages(id)
);

CREATE TABLE monster_vulnerabilities (
	id bigint GENERATED ALWAYS AS IDENTITY,
	vulnerability_id bigint NOT NULL,
	monster_id bigint NOT NULL,
	CONSTRAINT monster_vulnerability_pkey PRIMARY KEY (id),
	CONSTRAINT monster_vulnerability_ukey UNIQUE (vulnerability_id, monster_id),
	CONSTRAINT vulnerability_fkey FOREIGN KEY (vulnerability_id) REFERENCES damage_types(id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monsters(id) ON DELETE CASCADE
);

CREATE TABLE monster_resistances (
	id bigint GENERATED ALWAYS AS IDENTITY,
	resistance_id bigint NOT NULL,
	monster_id bigint NOT NULL,
	CONSTRAINT monster_resistances_pkey PRIMARY KEY (id),
	CONSTRAINT monster_resistances_ukey UNIQUE (resistance_id, monster_id),
	CONSTRAINT resistance_fkey FOREIGN KEY (resistance_id) REFERENCES damage_types(id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monsters(id) ON DELETE CASCADE
);

CREATE TABLE monster_imunities (
	id bigint GENERATED ALWAYS AS IDENTITY,
	imunity_id bigint NOT NULL,
	monster_id bigint NOT NULL,
	CONSTRAINT monster_imunity_pkey PRIMARY KEY (id),
	CONSTRAINT monster_imunity_ukey UNIQUE (imunity_id, monster_id),
	CONSTRAINT imunity_fkey FOREIGN KEY (imunity_id) REFERENCES damage_types(id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monsters(id) ON DELETE CASCADE 
);

CREATE TABLE monster_condition_immunities (
	id bigint GENERATED ALWAYS AS IDENTITY,
	condition_id bigint NOT NULL,
	monster_id bigint NOT NULL,
	CONSTRAINT monster_condition_immunities_pkey PRIMARY KEY (id),
	CONSTRAINT monster_condition_imunity_ukey UNIQUE (condition_id, monster_id),
	CONSTRAINT condition_imunity_fkey FOREIGN KEY (condition_id) REFERENCES conditions(id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monsters(id) ON DELETE CASCADE
);

CREATE TABLE monster_proficiencies_bonus (
	id bigint GENERATED ALWAYS AS IDENTITY,
	proficiency_bonus_id bigint NOT NULL,
	monster_id bigint NOT NULL,
	CONSTRAINT monster_proficiencies_bonus_pkey PRIMARY KEY (id),
	CONSTRAINT monster_proficiencies_bonus_ukey UNIQUE (proficiency_bonus_id, monster_id),
	CONSTRAINT proficiency_bonus_fkey FOREIGN KEY (proficiency_bonus_id) REFERENCES proficiency_bonus(id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monsters(id) ON DELETE CASCADE
);

CREATE TABLE monster_actions (
	id bigint GENERATED ALWAYS AS IDENTITY,
	action_id bigint NOT NULL,
	monster_id bigint NOT NULL,
	CONSTRAINT monster_actions_pkey PRIMARY KEY (id),
	CONSTRAINT monster_action_ukey UNIQUE (action_id, monster_id),
	CONSTRAINT action_fkey FOREIGN KEY (action_id) REFERENCES actions(id),
	CONSTRAINT monst_fkey FOREIGN KEY (monster_id) REFERENCES monsters(id) ON DELETE CASCADE
);

CREATE TABLE users (
	id bigint GENERATED ALWAYS AS IDENTITY,
	user_name varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	user_password varchar(100) NOT NULL,
	CONSTRAINT user_pkey PRIMARY KEY (id),
	CONSTRAINT user_ukey UNIQUE (user_name),
	CONSTRAINT unique_email UNIQUE (email)
);

CREATE TABLE campaigns (
	id bigint GENERATED ALWAYS AS IDENTITY,
	campaign_name varchar(200) NOT NULL,
--	user_id bigint NOT NULL,
	creation_date timestamp DEFAULT current_timestamp,
	CONSTRAINT campaigns_pkey PRIMARY KEY (id),
	CONSTRAINT campaign_ukey UNIQUE (campaign_name)
--	CONSTRAINT unique_campaign UNIQUE (campaign_name, user_id)
--	CONSTRAINT user_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE battles (
	id bigint GENERATED ALWAYS AS IDENTITY,
	battle_name varchar(200) NOT NULL,
	campaign_id bigint NOT NULL,
	CONSTRAINT battle_pkey PRIMARY KEY (id),
	CONSTRAINT battle_ukey UNIQUE (battle_name, campaign_id),
	CONSTRAINT campaing_fkey FOREIGN KEY (campaign_id) REFERENCES campaigns(id) ON DELETE CASCADE
);

CREATE TABLE battle_monsters (
	id bigint GENERATED ALWAYS AS IDENTITY,
	current_hit_points SMALLINT NOT NULL,
	battle_monster_name varchar(100) NOT NULL,
	monster_id bigint NOT NULL,
	battle_id bigint NOT NULL,
	CONSTRAINT battle_monster_pkey PRIMARY KEY (id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monsters(id),
	CONSTRAINT battle_fkey FOREIGN KEY (battle_id) REFERENCES battles(id) ON DELETE CASCADE
);

CREATE TABLE battle_conditions (
	id bigint GENERATED ALWAYS AS IDENTITY,
	battle_monster_id bigint NOT NULL,
	condition_id bigint NOT NULL,
	CONSTRAINT battle_conditions_pkey PRIMARY KEY (id),
	CONSTRAINT battle_monster_fkey FOREIGN KEY (battle_monster_id) REFERENCES battle_monsters(id) ON DELETE CASCADE,
	CONSTRAINT condition_id_fkey FOREIGN KEY (condition_id) REFERENCES conditions(id)
);
