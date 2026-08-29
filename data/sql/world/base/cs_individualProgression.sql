DELETE FROM `command` WHERE `name` IN ('ip get', 'ip set', 'ip setbot', 'ip setrep', 'ip tele', 'ip pet', 'ip pvp', 'ip attune');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('ip get', 0, 'Syntax: .ip get [$player]\nShows the current progression level for yourself, your target, or a named player.'),
('ip set', 2, 'Syntax: .ip set $progressionLevel\nSets the player to the given progression level.'),
('ip setbot', 0, 'Syntax: .ip setbot\nSets all bots in the group to your progression level.'),
('ip setrep', 0, 'Syntax: .ip setrep\nSets your reputation of certain factions to the same value as the character that has the highest value on your account.'),
('ip tele', 2, 'Syntax: .ip tele $location\nTeleports the player to the given location.'),
('ip pet', 0, 'Syntax: .ip pet $type\nShows the learned pet spells for yourself, your target, or a named player.'),
('ip attune', 0, 'Syntax: .ip attune $location\nGives all players in the group the required attument item.'),
('ip pvp', 0, 'Syntax: .ip pvp [$player]\nShows the current PvP rank and kills for yourself, your target, or a named player.');


-- AZEROTH CORE SERVER: global progression command hardening
--
-- Individual Progression no longer owns progression state.
-- Progression authority is mod-phase-progression:
--     .progression content <stage>
--
-- Keep all legacy .ip utilities GM-only, matching their C++ command
-- registration and preventing player access to administrative helpers.

UPDATE `command`
SET `security` = 2
WHERE `name` IN
(
    'ip get',
    'ip set',
    'ip pet',
    'ip tele',
    'ip setbot',
    'ip setrep',
    'ip pvp',
    'ip attune'
);

UPDATE `command`
SET `help` =
    'Individual progression is controlled globally by .progression content. This command no longer changes individual progression.'
WHERE `name` = 'ip set';

UPDATE `command`
SET `help` =
    'Bot progression is controlled globally by .progression content. This command no longer changes bot progression.'
WHERE `name` = 'ip setbot';
