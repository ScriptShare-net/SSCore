const config = {
    token: GetConvar("discord_token", "ODEyODcxNDI1MjQxMjUxODUw.YDHDgg.4o2p2IAWZRyfQ9l_Q6IUrTatxlo"),
	prefix: GetConvar("discord_prefix", "!"),
    serverName: GetConvar("discord_server_name", "Supremacy"),
    discordInvite: GetConvar("discord_invite", "https://discord.gg/fivem"),
    embedColor: 0xadd8e6,
    guildid: GetConvar("discord_guild_id", "687964561810128903"),
    modRole: GetConvar("discord_mod_role", "835785859646488586"),
    adminRole: GetConvar("discord_admin_role", "835785859646488586"),
    godRole: GetConvar("discord_god_role", "835785859646488586"),
    // The bot status message will randomly select one of these statuses every 30 seconds
    // {{playercount}} will automatically be replaced with the current number of users online
    // {{servername}} will be replaced the serverName above
    // {{invite}} will be replaced with the invite above
    // {{prefix}} will be replaced with the prefix currenting being used from above
    statusMessages: [
        "{{playercount}} person developing",
    ],
}