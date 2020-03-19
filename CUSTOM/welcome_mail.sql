
SET @MAX_MAIL := (SELECT IFNULL(MAX(`id`), 0) FROM CHARS_DB.`mail`);
SET @ITEM := 60000;
SET @ITEM1 := 40042;

REPLACE INTO WORLD_DB.`item_template` (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `StatsCount`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`, `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`) VALUES
(60000, 0, 5, -1, 'Let\'s go home', 6418, 1, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 54406, 0, -1, 0, 0, 59, 1000, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 12340);

DROP TABLE IF EXISTS CHARS_DB.`temp_mail`;
CREATE TEMPORARY TABLE CHARS_DB.`temp_mail` (
    `id` INT(10) NOT NULL AUTO_INCREMENT,
    `guid` INT(10) NULL DEFAULT '0',
    `name` VARCHAR(12) NULL DEFAULT '0',
    `joindate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX `id` (`id`)
);

INSERT INTO CHARS_DB.`temp_mail` (`guid`, `name`, `joindate`)
SELECT `guid`, `name`, `account`.`joindate`
FROM CHARS_DB.`characters`
INNER JOIN AUTH_DB.`account`
ON AUTH_DB.`account`.`id` = `characters`.`account`;


INSERT INTO CHARS_DB.`mail` (`id`, `messageType`, `stationery`, `mailTemplateId`, `sender`, `receiver`, `subject`, `body`, `has_items`, `expire_time`, `deliver_time`, `money`, `cod`, `checked`)
SELECT @MAX_MAIL + `id`, 0, 61, 0, `guid`, `guid`,'From Spidernet Team - Welcome', CONCAT("Hello,\n\nWelcome back ", `name`, "! It’s been a while, hasn’t it?\nIt was exactly on ", DATE_FORMAT(`joindate`, "%e %M %Y")," when we first met.\n\nJoin us again in Dalaran for a few pints!"), 1, 0, 0, 0, 0, 0 FROM CHARS_DB.`temp_mail`;

SET @MIN_TEMP_MAIL := (SELECT IFNULL(MAX(`id`), 1) FROM CHARS_DB.`temp_mail`) + @MAX_MAIL;
SET @MAX_TEMP_MAIL := (SELECT IFNULL(MAX(`id`), 1) FROM CHARS_DB.`temp_mail`) + @MAX_MAIL;
SET @MAX_ITEM_INSTANCE := (SELECT IFNULL(MAX(`guid`), 0) FROM CHARS_DB.`item_instance`);

INSERT INTO CHARS_DB.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`)
SELECT @MAX_ITEM_INSTANCE + `id`, @ITEM, `guid`, 0, 0, 1, 0, '-1 0 0 0 0 ', 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 0, 0, ''
FROM CHARS_DB.`temp_mail`;

INSERT INTO CHARS_DB.`mail_items` (`mail_id`, `item_guid`, `receiver`)
SELECT @MAX_MAIL + `id`,  @MAX_ITEM_INSTANCE + `id`, `guid` FROM CHARS_DB.`temp_mail`;


SET @MAX_ITEM_INSTANCE := (SELECT IFNULL(MAX(`guid`), 1) FROM CHARS_DB.`item_instance`);

INSERT INTO CHARS_DB.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`)
SELECT @MAX_ITEM_INSTANCE + `id`, @ITEM1, `guid`, 0, 0, 10, 0, '-1 0 0 0 0 ', 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 0, 0, ''
FROM CHARS_DB.`temp_mail`;

INSERT INTO CHARS_DB.`mail_items` (`mail_id`, `item_guid`, `receiver`)
SELECT @MAX_MAIL + `id`,  @MAX_ITEM_INSTANCE + `id`, `guid` FROM CHARS_DB.`temp_mail`;

DROP TABLE CHARS_DB.`temp_mail`;