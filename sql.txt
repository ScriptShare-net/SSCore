SSCore Database
    - Users(PK discord, permid, groups)
    - Character(FK discord, characterSlot, firstname, lastname, skin, age, job, group, position, status)
        foreign key (discord) references Users.discord
    - bans(FK discord, time, reason, bannedBy)
        foreign key (discord) references Users.discord
    - inventory(FK discord, FK characterSlot, items, weapons, accounts)
        foreign key (discord) references Users.discord
        foreign key (characterSlot) references Users.characterSlot
    - businesses(PK businessesName, businessLabel, accounts (DEFUALT NIL))
    - bussinessRoles(FK businessesName, roleName, roleLabel, pay, outfit)
        foreign key (businessesName) references business.businessesName
