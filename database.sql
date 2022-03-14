CREATE DATABASE `sscore`;

-- users - PermID, Identifier, Name, Groups
CREATE TABLE `sscore`.`users` ( `PermID` INT(99) NOT NULL AUTO_INCREMENT , `Identifier` VARCHAR(99) NOT NULL , `Name` VARCHAR(99) NOT NULL , `Groups` LONGTEXT NOT NULL , PRIMARY KEY (`PermID`)) ENGINE = InnoDB;

-- characters - PermID, Identifier, CharacterSlot, FirstName, LastName, MetaData
CREATE TABLE `sscore`.`characters` ( `PermID` INT(99) NOT NULL , `Identifier` VARCHAR(99) NOT NULL , `CharacterSlot` INT(99) NOT NULL , `FirstName` VARCHAR(99) NOT NULL , `LastName` VARCHAR(99) NOT NULL , `MetaData` LONGTEXT NOT NULL , PRIMARY KEY (`PermID`, `CharacterSlot`)) ENGINE = InnoDB;

-- identifiers - PermID, Identifier, Discords, Steams, GTAs, Lives, Xboxs, IPs, FiveMs, GTA2s, Tokens
CREATE TABLE `sscore`.`identifiers` ( `PermID` INT(99) NOT NULL , `Identifier` VARCHAR(99) NOT NULL , `Discords` LONGTEXT NOT NULL , `Steams` LONGTEXT NOT NULL , `GTAs` LONGTEXT NOT NULL , `Lives` LONGTEXT NOT NULL , `Xboxs` LONGTEXT NOT NULL , `IPs` LONGTEXT NOT NULL , `FiveMs` LONGTEXT NOT NULL , `GTA2s` LONGTEXT NOT NULL , `Tokens` LONGTEXT NOT NULL , PRIMARY KEY (`PermID`)) ENGINE = InnoDB;

-- bans - Identifier, Identifiers, Time, Reason, Banner
CREATE TABLE `sscore`.`bans` ( `Identifier` VARCHAR(99) NOT NULL , `Identifiers` LONGTEXT NOT NULL , `Time` VARCHAR(99) NOT NULL , `Reason` VARCHAR(99) NOT NULL , `Banner` VARCHAR(99) NOT NULL , PRIMARY KEY (`Identifier`)) ENGINE = InnoDB;

-- groups - Name, Priority, Permissions
CREATE TABLE `sscore`.`groups` ( `Name` VARCHAR(99) NOT NULL , `Priority` INT(99) NOT NULL , `Permissions` LONGTEXT NOT NULL , PRIMARY KEY (`Name`)) ENGINE = InnoDB;
INSERT INTO `sscore`.`groups` (`Name`, `Priority`, `Permissions`) VALUES ('default', '10000', '{}');

-- gangs - Name, Owner, Members, Ranks, MetaData
CREATE TABLE `sscore`.`gangs` ( `Name` VARCHAR(99) NOT NULL , `Owner` VARCHAR(99) NOT NULL , `Members` LONGTEXT NOT NULL , `Ranks` LONGTEXT NOT NULL , `MetaData` LONGTEXT NOT NULL , PRIMARY KEY (`Name`)) ENGINE = InnoDB;

-- vehicles - ID, Type, Owner, MetaData
CREATE TABLE `sscore`.`vehicles` ( `ID` INT(99) NOT NULL AUTO_INCREMENT , `Type` VARCHAR(99) NOT NULL , `Owner` VARCHAR(99) NOT NULL , `MetaData` LONGTEXT NOT NULL , PRIMARY KEY (`ID`)) ENGINE = InnoDB;

-- businesses - Name, Owner, Members, Ranks, MetaData
CREATE TABLE `sscore`.`businesses` ( `Name` VARCHAR(99) NOT NULL , `Owner` VARCHAR(99) NOT NULL , `Ranks` LONGTEXT NOT NULL , `MetaData` LONGTEXT NOT NULL , PRIMARY KEY (`Name`)) ENGINE = InnoDB;

-- entities - ID, Type, MetaData 
CREATE TABLE `sscore`.`entities` ( `ID` INT(99) NOT NULL AUTO_INCREMENT , `Type` VARCHAR(99) NOT NULL , `MetaData` LONGTEXT NOT NULL , PRIMARY KEY (`ID`)) ENGINE = InnoDB;