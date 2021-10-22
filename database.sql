CREATE DATABASE sscore;

USE sscore;

CREATE TABLE users (
    permid int NOT NULL AUTO_INCREMENT,
    identifier bigint(99) NOT NULL,
    groups longtext NOT NULL,
	PRIMARY KEY (permid, identifier)
);

CREATE TABLE characters (
    identifier bigint(99) NOT NULL,
	characterSlot int DEFAULT 3,
	firstName varchar(99) NOT NULL,
	lastName varchar(99) NOT NULL,
	skin longtext NOT NULL,
	dob varchar(99) NOT NULL,
	job longtext NOT NUll,
	group longtext NOT NULL,
	coords longtext NOT NULL,
	health longtext NOT NULL,
	PRIMARY KEY (identifier, characterSlot)
);

CREATE TABLE identifiers (
    identifier bigint(99) NOT NULL,
	discords longtext NOT NULL,
	steams longtext NOT NULL,
	gtas longtext NOT NULL,
	tokens longtext NOT NULL,
	lives longtext NOT NULL,
	xboxs longtext NOT NULL,
	ips longtext NOT NULL,
	fivems longtext NOT NULL,
	gta2s longtext NOT NULL,
	PRIMARY KEY (identifier)
);

CREATE TABLE bans (
    identifier bigint(99) NOT NULL,
	identifiers longtext NOT NULL,
	`time` int NOT NULL,
	reason varchar(99),
	bannedBy varchar(99),
	PRIMARY KEY (identifier)
);

CREATE TABLE inventory (
    identifier bigint(99) NOT NULL,
	characterSlot int NOT NULL,
	items longtext NOT NULL,
	accounts longtext NOT NULL,
	`weight` int NOT NULL,
	PRIMARY KEY (identifier, characterSlot),
);