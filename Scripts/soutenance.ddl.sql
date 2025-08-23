DROP TABLE IF EXISTS monsters;
DROP TABLE IF EXISTS battles;
DROP TABLE IF EXISTS campaigns;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS monster_condition_immunities;
DROP TABLE IF EXISTS monster_imunities;
DROP TABLE IF EXISTS monster_resistances;
DROP TABLE IF EXISTS monster_vulnerabilities;
DROP TABLE IF EXISTS monster_languages;
DROP TABLE IF EXISTS monster_special_abilities;
DROP TABLE IF EXISTS monster_models;
DROP TABLE IF EXISTS alignments;
DROP TABLE IF EXISTS languages;
DROP TABLE IF EXISTS sizes;
DROP TABLE IF EXISTS monster_types;
DROP TABLE IF EXISTS armor_types;
DROP TABLE IF EXISTS conditions;
DROP TABLE IF EXISTS damage_types;
DROP TABLE IF EXISTS special_abilities;


CREATE TABLE armor_types (
	armor_types_id bigint GENERATED ALWAYS AS IDENTITY,
	armor_type varchar(50) NOT NULL,
	CONSTRAINT armor_classes_pkey PRIMARY KEY (armor_types_id),
	CONSTRAINT armor_ukey UNIQUE (armor_type)
);

CREATE TABLE conditions (
	condition_id bigint GENERATED ALWAYS AS IDENTITY,
	condition_name varchar(50) NOT NULL,
	description varchar(1500),
	CONSTRAINT conditions_pkey PRIMARY KEY (condition_id),
	CONSTRAINT condition_name_ukey UNIQUE (condition_name)
);

CREATE TABLE damage_types (
	damage_type_id bigint GENERATED ALWAYS AS IDENTITY,
	damage_type_name varchar(50),
	description varchar(255),
	CONSTRAINT damage_type_pkey PRIMARY KEY (damage_type_id),
	CONSTRAINT damage_type_ukey UNIQUE (damage_type_name)
);

CREATE TABLE monster_types (
	monster_type_id bigint GENERATED ALWAYS AS IDENTITY,
	type_name varchar(50) NOT NULL,
	CONSTRAINT monter_type_pkey PRIMARY KEY (monster_type_id),
	CONSTRAINT monster_types_ukey UNIQUE (type_name)
);

CREATE TABLE sizes (
	size_id bigint GENERATED ALWAYS AS IDENTITY,
	size_name varchar(50) NOT NULL,
	CONSTRAINT sizes_pkey PRIMARY KEY (size_id),
	CONSTRAINT size_ukey UNIQUE (size_name)
);

CREATE TABLE alignments (
	alignment_id bigint GENERATED ALWAYS AS IDENTITY,
	alignments_name varchar(50) NOT NULL,
	description varchar(255),
	CONSTRAINT alignments_pkey PRIMARY KEY (alignment_id),
	CONSTRAINT alignment_ukey UNIQUE (alignments_name)
);

CREATE TABLE languages (
	language_id bigint GENERATED ALWAYS AS IDENTITY,
	languages_name varchar(50) NOT NULL,
	CONSTRAINT langages_pkey PRIMARY KEY (language_id),
	CONSTRAINT languages_ukey UNIQUE (languages_name)
);

CREATE TABLE special_abilities (
	special_ability_id bigint GENERATED ALWAYS AS IDENTITY,
	special_ability_name varchar(50) NOT NULL,
	special_ability_description varchar(1500) NOT NULL,
	CONSTRAINT special_ability_pkey PRIMARY KEY (special_ability_id),
	CONSTRAINT special_ability_ukey UNIQUE (special_ability_name, special_ability_description)
);

CREATE TABLE monster_models (
	model_id bigint GENERATED ALWAYS AS IDENTITY,
	monster_name varchar(100) NOT NULL,
	alignment_id bigint,
	hit_points SMALLINT NOT NULL,
	hit_points_roll varchar(30) NOT NULL,
	strength SMALLINT NOT NULL,
	dexterity SMALLINT NOT NULL,
	constitution SMALLINT NOT NULL,
	intelligence SMALLINT NOT NULL,
	wisdom SMALLINT NOT NULL,
	charisma SMALLINT NOT NULL,
	challenge_rating NUMERIC(5,2) NOT NULL,
	xp integer NOT NULL,
	image_url varchar(200),
	dnd5_native boolean NOT NULL DEFAULT FALSE,
	passive_perception SMALLINT NOT NULL,
	darkvision SMALLINT,
	walk SMALLINT,
	swim SMALLINT,
	fly SMALLINT,
	armor_class SMALLINT NOT NULL,
	monster_type_id bigint NOT NULL,
	size_id bigint NOT NULL,
	armor_id bigint NOT NULL,
	CONSTRAINT monter_pkey PRIMARY KEY (model_id),
	CONSTRAINT monster_ukey UNIQUE (monster_name),
	CONSTRAINT monster_type_fkey FOREIGN KEY (monster_type_id) REFERENCES monster_types(monster_type_id),
	CONSTRAINT size_fkey FOREIGN KEY (size_id) REFERENCES sizes(size_id),
	CONSTRAINT armor_fkey FOREIGN KEY (armor_id) REFERENCES armor_types(armor_types_id),
	CONSTRAINT alignment_fkey FOREIGN KEY (alignment_id) REFERENCES alignments(alignment_id)
);

CREATE TABLE monster_languages (
	monster_id bigint NOT NULL,
	language_id bigint NOT NULL,
	CONSTRAINT monster_languages_pkey PRIMARY KEY (monster_id,language_id),
	CONSTRAINT language_fkey FOREIGN KEY (language_id) REFERENCES languages(language_id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monster_models(model_id) ON DELETE CASCADE
);

CREATE TABLE monster_special_abilities (
	monster_id bigint NOT NULL,
	special_ability_id bigint NOT NULL,
	CONSTRAINT monster_special_ability_pkey PRIMARY KEY (monster_id,special_ability_id),
	CONSTRAINT special_ability_fkey FOREIGN KEY (special_ability_id) REFERENCES special_abilities(special_ability_id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monster_models(model_id) ON DELETE CASCADE
);

CREATE TABLE monster_vulnerabilities (
	vulnerability_id bigint NOT NULL,
	monster_id bigint NOT NULL,
	CONSTRAINT monster_vulnerability_pkey PRIMARY KEY (vulnerability_id,monster_id),
	CONSTRAINT vulnerability_fkey FOREIGN KEY (vulnerability_id) REFERENCES damage_types(damage_type_id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monster_models(model_id) ON DELETE CASCADE
);

CREATE TABLE monster_resistances (
	resistance_id bigint NOT NULL,
	monster_id bigint NOT NULL,
	CONSTRAINT monster_resistances_pkey PRIMARY KEY (resistance_id,monster_id),
	CONSTRAINT resistance_fkey FOREIGN KEY (resistance_id) REFERENCES damage_types(damage_type_id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monster_models(model_id) ON DELETE CASCADE
);

CREATE TABLE monster_imunities (
	imunity_id bigint NOT NULL,
	monster_id bigint NOT NULL,
	CONSTRAINT monster_imunity_pkey PRIMARY KEY (imunity_id,monster_id),
	CONSTRAINT imunity_fkey FOREIGN KEY (imunity_id) REFERENCES damage_types(damage_type_id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monster_models(model_id) ON DELETE CASCADE 
);

CREATE TABLE monster_condition_immunities (
	condition_id bigint NOT NULL,
	monster_id bigint NOT NULL,
	CONSTRAINT monster_condition_immunities_pkey PRIMARY KEY (condition_id,monster_id),
	CONSTRAINT condition_imunity_fkey FOREIGN KEY (condition_id) REFERENCES conditions(condition_id),
	CONSTRAINT monster_fkey FOREIGN KEY (monster_id) REFERENCES monster_models(model_id) ON DELETE CASCADE
);

CREATE TABLE users (
	user_id bigint GENERATED ALWAYS AS IDENTITY,
	user_name varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	user_password varchar(255) NOT NULL,
	CONSTRAINT user_pkey PRIMARY KEY (user_id),
	CONSTRAINT user_ukey UNIQUE (user_name),
	CONSTRAINT email_ukey UNIQUE (email)
);

CREATE TABLE campaigns (
	campaign_id bigint GENERATED ALWAYS AS IDENTITY,
	campaign_name varchar(200) NOT NULL,
	user_id bigint NOT NULL,
	creation_date timestamp DEFAULT current_timestamp,
	CONSTRAINT campaigns_pkey PRIMARY KEY (campaign_id),
	CONSTRAINT campaign_ukey UNIQUE (campaign_name),
	CONSTRAINT unique_campaign UNIQUE (campaign_name, user_id),
	CONSTRAINT user_fkey FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE battles (
	battle_id bigint GENERATED ALWAYS AS IDENTITY,
	battle_name varchar(200) NOT NULL,
	campaign_id bigint NOT NULL,
	turn SMALLINT NOT NULL DEFAULT 0,
	CONSTRAINT battle_pkey PRIMARY KEY (battle_id),
	CONSTRAINT battle_ukey UNIQUE (battle_name, campaign_id),
	CONSTRAINT campaing_fkey FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id) ON DELETE CASCADE
);

CREATE TABLE monsters (
	monster_id bigint GENERATED ALWAYS AS IDENTITY,
	current_hit_points SMALLINT NOT NULL,
	max_hit_points SMALLINT NOT NULL,
	monster_name varchar(100) NOT NULL,
	initiative SMALLINT DEFAULT NULL,
	model_id bigint NOT NULL,
	battle_id bigint NOT NULL,
	his_turn boolean DEFAULT FALSE,
	have_play_this_round boolean DEFAULT FALSE,
	ACTION boolean DEFAULT FALSE,
	MOVE boolean DEFAULT FALSE,
	bonus_action boolean DEFAULT FALSE,
	CONSTRAINT battle_monster_pkey PRIMARY KEY (monster_id),
	CONSTRAINT monster_fkey FOREIGN KEY (model_id) REFERENCES monster_models(model_id),
	CONSTRAINT battle_fkey FOREIGN KEY (battle_id) REFERENCES battles(battle_id) ON DELETE CASCADE
);