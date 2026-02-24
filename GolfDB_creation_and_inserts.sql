DROP TABLE IF EXISTS Sponsored_by;
DROP TABLE IF EXISTS Sponsors;
DROP TABLE IF EXISTS Coached_by;
DROP TABLE IF EXISTS Coaches;
DROP TABLE IF EXISTS Tour_wins;
DROP TABLE IF EXISTS World_ranking;
DROP TABLE IF EXISTS Caddies;
DROP TABLE IF EXISTS Golf_pros;

PRAGMA foreign_keys = ON;

CREATE TABLE Golf_pros (
	golf_pro_id INTEGER PRIMARY KEY,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	nationality TEXT,
	birth_year INT,
	turned_pro INT
);

CREATE TABLE Caddies (
	caddie_id INTEGER PRIMARY KEY,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	birth_year INT,
	nationality TEXT,
	golf_pro_id INT NOT NULL UNIQUE,
	FOREIGN KEY (golf_pro_id) REFERENCES Golf_pros(golf_pro_id)
		ON DELETE CASCADE
);

CREATE TABLE World_ranking (
	world_ranking_id INTEGER PRIMARY KEY,
	rank INT NOT NULL,
	total_points FLOAT NOT NULL,
	avg_points FLOAT NOT NULL,
	events_played_div INT NOT NULL,
	golf_pro_id INT NOT NULL UNIQUE,
	FOREIGN KEY (golf_pro_id) REFERENCES Golf_pros(golf_pro_id)
		ON DELETE CASCADE
);

CREATE TABLE Tour_wins (
	tour_wins_id INTEGER PRIMARY KEY,
	PGA_tour_wins INT NOT NULL,
	European_tour_wins INT NOT NULL,
	other_wins INT NOT NULL,
	golf_pro_id INT NOT NULL UNIQUE,
	FOREIGN KEY (golf_pro_id) REFERENCES Golf_pros(golf_pro_id)
		ON DELETE CASCADE
);

CREATE TABLE Coaches (
	coach_id INTEGER PRIMARY KEY,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	birth_year INT,
	nationality TEXT
);

CREATE TABLE Coached_by (
	coach_id INT NOT NULL,
	golf_pro_id INT NOT NULL,
	coach_type TEXT,
	
	PRIMARY KEY (coach_id, golf_pro_id),
	
	FOREIGN KEY (coach_id)
		REFERENCES Coaches(coach_id)
		ON DELETE RESTRICT ON UPDATE CASCADE,
		
	FOREIGN KEY (golf_pro_id)
		REFERENCES Golf_pros(golf_pro_id)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Sponsors (
	sponsor_id INTEGER PRIMARY KEY,
	name TEXT NOT NULL UNIQUE
);

CREATE TABLE Sponsored_by (
	sponsor_id INT NOT NULL,
	golf_pro_id INT NOT NULL,
	sponsorship_type TEXT,
	
	PRIMARY KEY (sponsor_id, golf_pro_id),
	
	FOREIGN KEY (sponsor_id)
		REFERENCES Sponsors(sponsor_id)
		ON DELETE RESTRICT ON UPDATE CASCADE,

	FOREIGN KEY (golf_pro_id)
		REFERENCES Golf_pros(golf_pro_id)
		ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO Golf_pros (first_name, last_name, nationality, birth_year, turned_pro) VALUES ('Scottie', 'Scheffler', 'USA', 1996, 2018), 

('Rory', 'McIlroy', 'NIR', 1989, 2007),

('Xander', 'Schauffele', 'USA', 1993, 2015),

('Collin', 'Morikawa', 'USA', 1997, 2019),

('Justin', 'Thomas', 'USA', 1993, 2013);

INSERT INTO Caddies (first_name, last_name, birth_year, nationality, golf_pro_id) VALUES ('Ted', 'Scott', NULL, 'USA', 1),

('Harry', 'Diamond', 1984, 'IRE' ,2),

('Austin', 'Kaiser', 1992, 'USA', 3),

('Joe', 'Greiner', NULL, 'USA', 4),

('Jim', 'Mackay', NULL, 'USA', 5);

INSERT INTO Tour_wins (PGA_tour_wins, European_tour_wins, other_wins, golf_pro_id) VALUES (16, 4, 5, 1),

(29, 19, 6, 2),

(9, 4, 3, 3),

(6, 4, 0, 4),

(16, 4, 4, 5);

INSERT INTO World_ranking (rank, total_points, avg_points, events_played_div, golf_pro_id) VALUES (1, 752.50286, 18.3537, 41, 1),

(2, 506.46087, 11.0100, 46, 2),

(3, 292.59617, 7.3149, 40, 3),

(4, 253.09418, 6.1730, 41, 4),

(5, 264.26399, 6.0060, 44, 5);

INSERT INTO Sponsors (name) VALUES ('Nike'), ('TaylorMade'), ('NetJets'), ('Rolex'), ('Veritex Community Bank'),

('Nike'), ('Omega'), ('Optum'), ('Workday'), ('FM'), ('NBC Sports'),

('Callaway'), ('Blue owl'), ('Descente'), ('Adidas'), ('Avis'),

('KPMG'), ('Zurich insurance'), ('US Bank'), ('Youth on course'),

('Titleist'), ('FootJoy'), ('Greyson Clothiers');

INSERT INTO Coaches (first_name, last_name, birth_year, nationality) VALUES ('Randy', 'Smith', 1952, 'USA'), ('Phil', 'Kenyon', 1956, 'USA'),

('Michael', 'Bannon', NULL, 'NIR'),

('Chris', 'Como', NULL, 'USA'),
('Derek', 'Uyeda', NULL, 'USA'),
('Stefan', 'Schauffele', 1964, 'GER'),

('Rick', 'Sessinghaus', 1972, 'USA'),
('Stephen', 'Sweeney', 1975, 'IRE'),
('Mark', 'Blackburn', 1978, 'ENG'),

('Mike', 'Thomas', 1970, 'USA'),
('John', 'Graham', NULL, 'USA'),
('Matt', 'Killen', NULL, 'USA');

INSERT INTO Sponsored_by (sponsor_id, golf_pro_id, sponsorship_type) VALUES (1, 1, 'Apparel'), (2, 1, 'Equipment'), (3, 1, 'Travel'), (4, 1, 'Luxury'), (5, 1, 'Finance'),

(1, 2, 'Apparel'), (2, 2, 'Equipment'), (7, 2, 'Watch'), (8, 2, 'Health'),
(9, 2, 'Finance'), (11, 2, 'Media'),

(12, 3, 'Equipment'), (13, 3, 'Finance'), (14, 3, 'Apparel'),

(15, 4, 'Apparel'), (16, 4, 'Travel'), (17, 4, 'Professional services'),
(18, 4, 'Insurance'), (19, 4, 'Banking'),

(19, 5, 'Charity/Youth'), (20, 5, 'Equipment'), (21, 5, 'Apparel'),
(22, 5, 'Apparel');

INSERT INTO Coached_by (coach_id, golf_pro_id, coach_type) VALUES (1, 1, 'Swing coach'), (2, 1, 'Putting coach'),

(3, 2, 'Swing Coach'),

(4, 3, 'Swing Coach'),
(5, 3, 'Putting Coach'),
(6, 3, 'Mind Coach'),

(7, 4, 'Swing Coach'),
(8, 4, 'Putting Coach'),
(9, 4, 'Swing Coach'),

(10, 5, 'Swing Coach'),
(11, 5, 'Putting Coach'),
(12, 5, 'Short Game Coach');
