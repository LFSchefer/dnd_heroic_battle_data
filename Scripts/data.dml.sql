DELETE FROM users;

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
