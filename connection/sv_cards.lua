SS.Connection.Cards = {}

SS.Connection.Cards.Whitelist = {
    ["type"] = "AdaptiveCard",
    ["body"] = {
        {
            ["type"] = "TextBlock",
            ["size"] = "Medium",
            ["weight"] = "Bolder",
            ["text"] = "Welcome to " .. SS.Config.ServerName
        },
        {
            ["type"] = "TextBlock",
            ["text"] = SS.Config.Connection.WhitelistMessage,
            ["wrap"] = true
        }
    },
    ["actions"] = {
        {
            ["type"] = "Action.OpenUrl",
            ["title"] = "Join Discord",
            ["url"] = SS.Config.Discord
        }
    },
    ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
    ["version"] = "1.3"
}

SS.Connection.Cards.Ban = function(reason, unbanTime, banLength, bannedBy, accountId)
    return {
        ["type"] = "AdaptiveCard",
        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
        ["version"] = "1.3",
        ["body"] = {
            {
                ["type"] = "Image",
                ["url"] = SS.Config.Connection.Banner
            },
            {
                ["type"] = "TextBlock",
                ["text"] = "You have been banned",
                ["wrap"] = true,
                ["weight"] = "Bolder"
            },
            {
                ["type"] = "ColumnSet",
                ["columns"] = {
                    {
                        ["type"] = "Column",
                        ["width"] = "90px",
                        ["items"] = {
                            {
                                ["type"] = "TextBlock",
                                ["text"] = "Reason",
                                ["wrap"] = true,
                                ["weight"] = "Bolder"
                            }
                        }
                    },
                    {
                        ["type"] = "Column",
                        ["width"] = "stretch",
                        ["items"] = {
                            {
                                ["type"] = "TextBlock",
                                ["text"] = reason,
                                ["wrap"] = true
                            }
                        }
                    }
                }
            },
            {
                ["type"] = "ColumnSet",
                ["columns"] = {
                    {
                        ["type"] = "Column",
                        ["width"] = "90px",
                        ["items"] = {
                            {
                                ["type"] = "TextBlock",
                                ["text"] = "Unban Time",
                                ["wrap"] = true,
                                ["weight"] = "Bolder"
                            }
                        },
                        ["horizontalAlignment"] = "Center"
                    },
                    {
                        ["type"] = "Column",
                        ["width"] = "stretch",
                        ["items"] = {
                            {
                                ["type"] = "TextBlock",
                                ["text"] = unbanTime,
                                ["wrap"] = true
                            }
                        }
                    }
                }
            },
            {
                ["type"] = "ColumnSet",
                ["columns"] = {
                    {
                        ["type"] = "Column",
                        ["width"] = "90px",
                        ["items"] = {
                            {
                                ["type"] = "TextBlock",
                                ["text"] = "Length",
                                ["wrap"] = true,
                                ["weight"] = "Bolder"
                            }
                        }
                    },
                    {
                        ["type"] = "Column",
                        ["width"] = "stretch",
                        ["items"] = {
                            {
                                ["type"] = "TextBlock",
                                ["text"] = banLength,
                                ["wrap"] = true
                            }
                        }
                    }
                }
            },
            {
                ["type"] = "ColumnSet",
                ["columns"] = {
                    {
                        ["type"] = "Column",
                        ["width"] = "90px",
                        ["items"] = {
                            {
                                ["type"] = "TextBlock",
                                ["text"] = "Banned By",
                                ["wrap"] = true,
                                ["weight"] = "Bolder"
                            }
                        }
                    },
                    {
                        ["type"] = "Column",
                        ["width"] = "stretch",
                        ["items"] = {
                            {
                                ["type"] = "TextBlock",
                                ["text"] = bannedBy,
                                ["wrap"] = true
                            }
                        }
                    }
                }
            },
            {
                ["type"] = "ColumnSet",
                ["columns"] = {
                    {
                        ["type"] = "Column",
                        ["width"] = "90px",
                        ["items"] = {
                            {
                                ["type"] = "TextBlock",
                                ["text"] = "Account ID",
                                ["wrap"] = true,
                                ["weight"] = "Bolder"
                            }
                        }
                    },
                    {
                        ["type"] = "Column",
                        ["width"] = "stretch",
                        ["items"] = {
                            {
                                ["type"] = "TextBlock",
                                ["text"] = accountId,
                                ["wrap"] = true
                            }
                        }
                    }
                }
            },
            {
                ["type"] = "ActionSet",
                ["actions"] = {
                    {
                        ["type"] = "Action.OpenUrl",
                        ["title"] = "Ban Appeal",
                        ["url"] = SS.Config.Connection.BanAppeal
                    }
                }
            }
        }
    }
end

SS.Connection.Cards.Queue = function(currentQueue, lengthQueue)
    return {
		["type"] = "AdaptiveCard",
		["body"] = {
			{
				["type"] = "Image",
				["url"] = SS.Config.Connection.Banner
			},
			{
				["type"] = "TextBlock",
				["size"] = "Medium",
				["weight"] = "Bolder",
				["text"] = SS.Config.ServerName,
				["horizontalAlignment"] = "Center"
			},
			{
				["type"] = "TextBlock",
				["text"] = "Welcome to " .. SS.Config.ServerName .. ".",
				["wrap"] = true,
				["horizontalAlignment"] = "Center"
			},
			{
				["type"] = "TextBlock",
				["text"] = SS.Config.Connection.QueueMessage,
				["wrap"] = true,
				["horizontalAlignment"] = "Center"
			},
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["width"] = "auto",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = "Current Queue:",
								["wrap"] = true,
								["horizontalAlignment"] = "Center"
							}
						}
					},
					{
						["type"] = "Column",
						["width"] = "auto",
						["items"] = {
							{
								["type"] = "ColumnSet",
								["columns"] = {
									{
										["type"] = "Column",
										["width"] = "auto",
										["items"] = {
											{
												["type"] = "TextBlock",
												["text"] = tostring(currentQueue),
												["wrap"] = true,
												["horizontalAlignment"] = "Center"
											}
										}
									},
									{
										["type"] = "Column",
										["width"] = "auto",
										["items"] = {
											{
												["type"] = "TextBlock",
												["text"] = "/",
												["wrap"] = true,
												["horizontalAlignment"] = "Center",
												["separator"] = true,
												["height"] = "stretch"
											}
										}
									},
									{
										["type"] = "Column",
										["width"] = "auto",
										["items"] = {
											{
												["type"] = "TextBlock",
												["text"] = tostring(lengthQueue),
												["wrap"] = true,
												["horizontalAlignment"] = "Center",
												["height"] = "stretch"
											}
										}
									}
								}
							}
						}
					}
				},
				["horizontalAlignment"] = "Center"
			},
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["width"] = "auto",
						["items"] = {
							{
								["type"] = "ActionSet",
								["actions"] = {
									{
										["type"] = "Action.OpenUrl",
										["title"] = "Forum",
										["url"] = SS.Config.Forum
									}
								}
							}
						}
					},
					{
						["type"] = "Column",
						["width"] = "auto",
						["items"] = {
							{
								["type"] = "ActionSet",
								["actions"] = {
									{
										["type"] = "Action.OpenUrl",
										["title"] = "Discord",
										["url"] = SS.Config.Discord
									}
								}
							}
						}
					}
				},
				["horizontalAlignment"] = "Center"
			}
		},
		["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
		["version"] = "1.3"
	}
end