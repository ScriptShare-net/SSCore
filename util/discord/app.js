const Eris = require('./util/discord/libs/eris/');
const fs = require('fs');
init();

const discord = new Eris.Client(config.token, {
    intents: ["guilds", "guildMessages", "guildMembers", "guildBans", "guildPresences"],
    disabledEvents: { CHANNEL_CREATE: true, CHANNEL_CREATE: true },
    getAllUsers: true
});

discord.commands = new Map();
discord.commandAliases = {};

const commandFiles = fs.readdirSync(`${GetResourcePath(GetCurrentResourceName())}/util/discord/commands`).filter(file => file.endsWith('.js'));
for (const file of commandFiles) {
    const command = require(`./util/discord/commands/${file}`);
    discord.commands.set(command.name, command);
    if (command.alias) discord.commandAliases[command.alias] = command.name;
}

discord.on('ready', () => {
    console.log(`Logged in on Discord as ${discord.user.username}!`);
    if (config.statusMessages) statusUpdater();
});

discord.on("error", (err) => { console.error(err); });

discord.on("messageCreate", async (msg) => {
    if (msg.guildID !== config.guildid || msg.author.bot) return;
    if (!msg.content.startsWith(config.prefix)) return;
    msg.nickname = msg.member.nick || msg.member.username;
    msg.staffRole = "none";
    if (msg.member.roles.includes(config.modRole)) msg.staffRole = "mod";
    if (msg.member.roles.includes(config.adminRole)) msg.staffRole = "admin";
    if (msg.member.roles.includes(config.godRole)) msg.staffRole = "god";

    const args = msg.content.slice(config.prefix.length).trim().split(/ +/);
    const command = args.shift().toLowerCase();
    if (!discord.commands.has(command) && !discord.commandAliases[command]) return;
    const cmd = discord.commands.has(command) ? discord.commands.get(command) : discord.commands.get(discord.commandAliases[command]);
    if (cmd.role && !hasPermission(cmd.role, msg.staffRole)) return;
    try {
        cmd.run(discord, msg, args);
    } catch (error) {
        console.error(error);
        discord.createMessage(msg.channel.id, "Something went wrong trying to run this command.");
    }
});

discord.connect();

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

let liveloop = false;
async function statusUpdater() {
    if (liveloop) return;
    liveloop == true;
    while (true) {
        try {
            let msg = config.statusMessages[Math.floor(Math.random() * config.statusMessages.length)].replaceGlobals()
            discord.editStatus("online", { name: msg, type: 3 });
        } catch (e) { console.error(e) }
        await sleep(30000);
    }
}

function init() { // Damn hoisting and wanting things clean
    Object.defineProperty(String.prototype, "replaceGlobals", {
        value: function () {
            return this
                .replace(/{{servername}}/g, config.serverName)
                .replace(/{{invite}}/g, config.discordInvite)
                .replace(/{{playercount}}/g, GetNumPlayerIndices())
                .replace(/{{prefix}}/g, config.prefix)
        }
    });
}

function hasPermission(required, has) {
    const ranks = {
        "none": 0,
        "mod": 1,
        "admin": 2,
        "god": 3,
    }
    if (ranks[has] >= ranks[required]) return true;
    return false;
}
