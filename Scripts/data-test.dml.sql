DELETE FROM users;
DELETE FROM monster_models;
DELETE FROM alignments;
DELETE FROM monster_types;
DELETE FROM sizes;
DELETE FROM armor_types;

INSERT INTO users (user_name,email,user_password) VALUES
	 ('test user','fake@mail.com','$2b$13$zsY//Yyn4NXtSs.a5JoqQuNlNS0XgWoUoxrY324zWamUenjeHhEGK'),
	 ('Hutkelm','hutkelm@hotmail.fr','$2b$13$kF5XGNjs9/OTUBZZzPZ0uOOK3lr1pJ2a2ExD.mvKwvFIabGxbYAdq');

INSERT INTO campaigns (campaign_name,user_id,creation_date) VALUES
	 ('retreter',(SELECT u.user_id  FROM users u WHERE u.email = 'fake@mail.com' ),'2025-08-08 18:43:33.806821'),
	 ('Mighty four', (SELECT u.user_id  FROM users u WHERE u.email = 'hutkelm@hotmail.fr' ),'2025-08-28 19:38:26.287396');

INSERT INTO battles (battle_name,campaign_id,turn) VALUES
	 ('Holy cave',(SELECT c.campaign_id  FROM campaigns c WHERE c.campaign_name  = 'retreter'),5),
	 ('road battle',(SELECT c.campaign_id  FROM campaigns c WHERE c.campaign_name  = 'retreter'),3),
	 ('tavern trouble',(SELECT c.campaign_id  FROM campaigns c WHERE c.campaign_name  = 'Mighty four'),9),
	 ('the carnaval',(SELECT c.campaign_id  FROM campaigns c WHERE c.campaign_name  = 'Mighty four'),1);

INSERT INTO alignments (alignments_name, description) VALUES
	('Lawful Evil','Lawful evil (LE) creatures methodically take what they want, within the limits of a code of tradition, loyalty, or order. Devils, blue dragons, and hobgoblins are lawful evil.'),
	('Chaotic Evil','Chaotic evil (CE) creatures act with arbitrary violence, spurred by their greed, hatred, or bloodlust. Demons, red dragons, and orcs are chaotic evil.');

INSERT INTO monster_types (type_name) VALUES 
	('humanoid'),
	('monstrosity');

INSERT INTO sizes (size_name) VALUES
	('Medium'),
	('Small'),
	('Gargantuan');

INSERT INTO armor_types (armor_type) VALUES 
	('armor'),
	('natural'),
	('dex');

INSERT INTO monster_models (monster_name,alignment_id,hit_points,hit_points_roll,strength,dexterity,constitution,intelligence,wisdom,
charisma,challenge_rating,xp,image_url,dnd5_native,passive_perception,darkvision,walk,swim,fly,armor_class,monster_type_id,size_id,armor_id) VALUES
	 ('Knight',NULL,52,'8d8+16',16,11,14,11,11,15,3.00,700,'http://127.0.0.1:5500/Knight.jpeg',true,10,NULL,30,NULL,NULL,18,(SELECT mt.monster_type_id FROM monster_types mt WHERE mt.type_name = 'humanoid'),(SELECT s.size_id FROM sizes s WHERE s.size_name = 'Medium'),(SELECT t.armor_types_id FROM armor_types t WHERE t.armor_type = 'armor')),
	 ('Kobold',(SELECT a.alignment_id FROM alignments a WHERE a.alignments_name = 'Lawful Evil'),5,'2d6-2',7,15,9,8,7,8,0.13,25,'http://127.0.0.1:5500/Kobold.jpeg',true,8,60,30,NULL,NULL,12,(SELECT mt.monster_type_id FROM monster_types mt WHERE mt.type_name = 'humanoid'),(SELECT s.size_id FROM sizes s WHERE s.size_name = 'Small'),(SELECT t.armor_types_id FROM armor_types t WHERE t.armor_type = 'natural')),
	 ('Kraken',(SELECT a.alignment_id FROM alignments a WHERE a.alignments_name = 'Chaotic Evil'),472,'27d20+189',30,11,25,22,18,20,23.00,50000,'http://127.0.0.1:5500/Kraken.jpeg',true,14,NULL,20,60,NULL,18,(SELECT mt.monster_type_id FROM monster_types mt WHERE mt.type_name = 'monstrosity'),(SELECT s.size_id FROM sizes s WHERE s.size_name = 'Gargantuan'),(SELECT t.armor_types_id FROM armor_types t WHERE t.armor_type = 'dex'));
