local SSCore = exports["SSCore"]

if SSCore:GetConfigValue("Skin") then

	local models = {
		[808859815] = {
			sex = 1,
			model = "a_f_m_beach_01",
			hash = 808859815,
		},
		[-1106743555] = {
			sex = 1,
			model = "a_f_m_bevhills_01",
			hash = -1106743555,
		},
		[-1606864033] = {
			sex = 1,
			model = "a_f_m_bevhills_02",
			hash = -1606864033,
		},
		[1004114196] = {
			sex = 1,
			model = "a_f_m_bodybuild_01",
			hash = 1004114196,
		},
		[532905404] = {
			sex = 1,
			model = "a_f_m_business_02",
			hash = 532905404,
		},
		[1699403886] = {
			sex = 1,
			model = "a_f_m_downtown_01",
			hash = 1699403886,
		},
		[-1656894598] = {
			sex = 1,
			model = "a_f_m_eastsa_01",
			hash = -1656894598,
		},
		[1674107025] = {
			sex = 1,
			model = "a_f_m_eastsa_02",
			hash = 1674107025,
		},
		[-88831029] = {
			sex = 1,
			model = "a_f_m_fatbla_01",
			hash = -88831029,
		},
		[-1244692252] = {
			sex = 1,
			model = "a_f_m_fatcult_01",
			hash = -1244692252,
		},
		[951767867] = {
			sex = 1,
			model = "a_f_m_fatwhite_01",
			hash = 951767867,
		},
		[1388848350] = {
			sex = 1,
			model = "a_f_m_ktown_01",
			hash = 1388848350,
		},
		[1090617681] = {
			sex = 1,
			model = "a_f_m_ktown_02",
			hash = 1090617681,
		},
		[379310561] = {
			sex = 1,
			model = "a_f_m_prolhost_01",
			hash = 379310561,
		},
		[-569505431] = {
			sex = 1,
			model = "a_f_m_salton_01",
			hash = -569505431,
		},
		[-1332260293] = {
			sex = 1,
			model = "a_f_m_skidrow_01",
			hash = -1332260293,
		},
		[1951946145] = {
			sex = 1,
			model = "a_f_m_soucent_01",
			hash = 1951946145,
		},
		[-215821512] = {
			sex = 1,
			model = "a_f_m_soucent_02",
			hash = -215821512,
		},
		[-840346158] = {
			sex = 1,
			model = "a_f_m_soucentmc_01",
			hash = -840346158,
		},
		[1347814329] = {
			sex = 1,
			model = "a_f_m_tourist_01",
			hash = 1347814329,
		},
		[1224306523] = {
			sex = 1,
			model = "a_f_m_tramp_01",
			hash = 1224306523,
		},
		[-1935621530] = {
			sex = 1,
			model = "a_f_m_trampbeac_01",
			hash = -1935621530,
		},
		[1640504453] = {
			sex = 1,
			model = "a_f_o_genstreet_01",
			hash = 1640504453,
		},
		[-1160266880] = {
			sex = 1,
			model = "a_f_o_indian_01",
			hash = -1160266880,
		},
		[1204772502] = {
			sex = 1,
			model = "a_f_o_ktown_01",
			hash = 1204772502,
		},
		[-855671414] = {
			sex = 1,
			model = "a_f_o_salton_01",
			hash = -855671414,
		},
		[1039800368] = {
			sex = 1,
			model = "a_f_o_soucent_01",
			hash = 1039800368,
		},
		[-1519524074] = {
			sex = 1,
			model = "a_f_o_soucent_02",
			hash = -1519524074,
		},
		[-945854168] = {
			sex = 1,
			model = "a_f_y_beach_01",
			hash = -945854168,
		},
		[1146800212] = {
			sex = 1,
			model = "a_f_y_bevhills_01",
			hash = 1146800212,
		},
		[1546450936] = {
			sex = 1,
			model = "a_f_y_bevhills_02",
			hash = 1546450936,
		},
		[549978415] = {
			sex = 1,
			model = "a_f_y_bevhills_03",
			hash = 549978415,
		},
		[920595805] = {
			sex = 1,
			model = "a_f_y_bevhills_04",
			hash = 920595805,
		},
		[664399832] = {
			sex = 1,
			model = "a_f_y_business_01",
			hash = 664399832,
		},
		[826475330] = {
			sex = 1,
			model = "a_f_y_business_02",
			hash = 826475330,
		},
		[-1366884940] = {
			sex = 1,
			model = "a_f_y_business_03",
			hash = -1366884940,
		},
		[-1211756494] = {
			sex = 1,
			model = "a_f_y_business_04",
			hash = -1211756494,
		},
		[1744231373] = {
			sex = 1,
			model = "a_f_y_clubcust_01",
			hash = 1744231373,
		},
		[357447289] = {
			sex = 1,
			model = "a_f_y_clubcust_02",
			hash = 357447289,
		},
		[10751269] = {
			sex = 1,
			model = "a_f_y_clubcust_03",
			hash = 10751269,
		},
		[-173013091] = {
			sex = 1,
			model = "a_f_y_eastsa_01",
			hash = -173013091,
		},
		[70821038] = {
			sex = 1,
			model = "a_f_y_eastsa_02",
			hash = 70821038,
		},
		[1371553700] = {
			sex = 1,
			model = "a_f_y_eastsa_03",
			hash = 1371553700,
		},
		[1755064960] = {
			sex = 1,
			model = "a_f_y_epsilon_01",
			hash = 1755064960,
		},
		[1348537411] = {
			sex = 1,
			model = "a_f_y_femaleagent",
			hash = 1348537411,
		},
		[1165780219] = {
			sex = 1,
			model = "a_f_y_fitness_01",
			hash = 1165780219,
		},
		[331645324] = {
			sex = 1,
			model = "a_f_y_fitness_02",
			hash = 331645324,
		},
		[793439294] = {
			sex = 1,
			model = "a_f_y_genhot_01",
			hash = 793439294,
		},
		[2111372120] = {
			sex = 1,
			model = "a_f_y_golfer_01",
			hash = 2111372120,
		},
		[813893651] = {
			sex = 1,
			model = "a_f_y_hiker_01",
			hash = 813893651,
		},
		[343259175] = {
			sex = 1,
			model = "a_f_y_hippie_01",
			hash = 343259175,
		},
		[-2109222095] = {
			sex = 1,
			model = "a_f_y_hipster_01",
			hash = -2109222095,
		},
		[-1745486195] = {
			sex = 1,
			model = "a_f_y_hipster_02",
			hash = -1745486195,
		},
		[-1514497514] = {
			sex = 1,
			model = "a_f_y_hipster_03",
			hash = -1514497514,
		},
		[429425116] = {
			sex = 1,
			model = "a_f_y_hipster_04",
			hash = 429425116,
		},
		[153984193] = {
			sex = 1,
			model = "a_f_y_indian_01",
			hash = 153984193,
		},
		[-619494093] = {
			sex = 1,
			model = "a_f_y_juggalo_01",
			hash = -619494093,
		},
		[-951490775] = {
			sex = 1,
			model = "a_f_y_runner_01",
			hash = -951490775,
		},
		[1064866854] = {
			sex = 1,
			model = "a_f_y_rurmeth_01",
			hash = 1064866854,
		},
		[-614546432] = {
			sex = 1,
			model = "a_f_y_scdressy_01",
			hash = -614546432,
		},
		[1767892582] = {
			sex = 1,
			model = "a_f_y_skater_01",
			hash = 1767892582,
		},
		[744758650] = {
			sex = 1,
			model = "a_f_y_soucent_01",
			hash = 744758650,
		},
		[1519319503] = {
			sex = 1,
			model = "a_f_y_soucent_02",
			hash = 1519319503,
		},
		[-2018356203] = {
			sex = 1,
			model = "a_f_y_soucent_03",
			hash = -2018356203,
		},
		[1426880966] = {
			sex = 1,
			model = "a_f_y_tennis_01",
			hash = 1426880966,
		},
		[-1661836925] = {
			sex = 1,
			model = "a_f_y_topless_01",
			hash = -1661836925,
		},
		[1446741360] = {
			sex = 1,
			model = "a_f_y_tourist_01",
			hash = 1446741360,
		},
		[-1859912896] = {
			sex = 1,
			model = "a_f_y_tourist_02",
			hash = -1859912896,
		},
		[435429221] = {
			sex = 1,
			model = "a_f_y_vinewood_01",
			hash = 435429221,
		},
		[-625565461] = {
			sex = 1,
			model = "a_f_y_vinewood_02",
			hash = -625565461,
		},
		[933092024] = {
			sex = 1,
			model = "a_f_y_vinewood_03",
			hash = 933092024,
		},
		[-85696186] = {
			sex = 1,
			model = "a_f_y_vinewood_04",
			hash = -85696186,
		},
		[-1004861906] = {
			sex = 1,
			model = "a_f_y_yoga_01",
			hash = -1004861906,
		},
		[-1860463438] = {
			sex = 1,
			model = "a_f_y_gencaspat_01",
			hash = -1860463438,
		},
		[279228114] = {
			sex = 1,
			model = "a_f_y_smartcaspat_01",
			hash = 279228114,
		},
		[-1779492637] = {
			sex = 1,
			model = "cs_amandatownley",
			hash = -1779492637,
		},
		[650367097] = {
			sex = 1,
			model = "cs_ashley",
			hash = 650367097,
		},
		[-321892375] = {
			sex = 1,
			model = "cs_debra",
			hash = -321892375,
		},
		[1870669624] = {
			sex = 1,
			model = "cs_denise",
			hash = 1870669624,
		},
		[261428209] = {
			sex = 1,
			model = "cs_guadalope",
			hash = 261428209,
		},
		[-1022036185] = {
			sex = 1,
			model = "cs_gurk",
			hash = -1022036185,
		},
		[808778210] = {
			sex = 1,
			model = "cs_janet",
			hash = 808778210,
		},
		[1145088004] = {
			sex = 1,
			model = "cs_jewelass",
			hash = 1145088004,
		},
		[1269774364] = {
			sex = 1,
			model = "cs_karen_daniels",
			hash = 1269774364,
		},
		[1477887514] = {
			sex = 1,
			model = "cs_magenta",
			hash = 1477887514,
		},
		[161007533] = {
			sex = 1,
			model = "cs_maryann",
			hash = 161007533,
		},
		[1890499016] = {
			sex = 1,
			model = "cs_michelle",
			hash = 1890499016,
		},
		[1167167044] = {
			sex = 1,
			model = "cs_molly",
			hash = 1167167044,
		},
		[1270514905] = {
			sex = 1,
			model = "cs_movpremf_01",
			hash = 1270514905,
		},
		[1334976110] = {
			sex = 1,
			model = "cs_mrs_thornhill",
			hash = 1334976110,
		},
		[-872569905] = {
			sex = 1,
			model = "cs_mrsphillips",
			hash = -872569905,
		},
		[1325314544] = {
			sex = 1,
			model = "cs_natalia",
			hash = 1325314544,
		},
		[-544533759] = {
			sex = 1,
			model = "cs_patricia",
			hash = -544533759,
		},
		[1123963760] = {
			sex = 1,
			model = "cs_tanisha",
			hash = 1123963760,
		},
		[101298480] = {
			sex = 1,
			model = "cs_tracydisanto",
			hash = 101298480,
		},
		[-1988720319] = {
			sex = 1,
			model = "csb_abigail",
			hash = -1988720319,
		},
		[117698822] = {
			sex = 1,
			model = "csb_anita",
			hash = 117698822,
		},
		[-2101379423] = {
			sex = 1,
			model = "csb_bride",
			hash = -2101379423,
		},
		[2006035933] = {
			sex = 1,
			model = "csb_bryony",
			hash = 2006035933,
		},
		[-1249041111] = {
			sex = 1,
			model = "csb_denise_friend",
			hash = -1249041111,
		},
		[-1127975477] = {
			sex = 1,
			model = "csb_maude",
			hash = -1127975477,
		},
		[-1652965338] = {
			sex = 1,
			model = "csb_mrs_r",
			hash = -1652965338,
		},
		[1528799427] = {
			sex = 1,
			model = "csb_paige",
			hash = 1528799427,
		},
		[-1948177172] = {
			sex = 1,
			model = "csb_screen_writer",
			hash = -1948177172,
		},
		[-1360365899] = {
			sex = 1,
			model = "csb_stripper_01",
			hash = -1360365899,
		},
		[-2126242959] = {
			sex = 1,
			model = "csb_stripper_02",
			hash = -2126242959,
		},
		[1665391897] = {
			sex = 1,
			model = "csb_tonya",
			hash = 1665391897,
		},
		[756308504] = {
			sex = 1,
			model = "csb_agatha",
			hash = 756308504,
		},
		[-2069778150] = {
			sex = 1,
			model = "g_f_importexport_01",
			hash = -2069778150,
		},
		[-2069778150] = {
			sex = 1,
			model = "g_f_importexport_01",
			hash = -2069778150,
		},
		[361513884] = {
			sex = 1,
			model = "g_f_y_ballas_01",
			hash = 361513884,
		},
		[1309468115] = {
			sex = 1,
			model = "g_f_y_families_01",
			hash = 1309468115,
		},
		[-44746786] = {
			sex = 1,
			model = "g_f_y_lost_01",
			hash = -44746786,
		},
		[1520708641] = {
			sex = 1,
			model = "g_f_y_vagos_01",
			hash = 1520708641,
		},
		[2139205821] = {
			sex = 1,
			model = "mp_f_bennymech_01",
			hash = 2139205821,
		},
		[848542158] = {
			sex = 1,
			model = "mp_f_boatstaff_01",
			hash = 848542158,
		},
		[606876839] = {
			sex = 1,
			model = "mp_f_cardesign_01",
			hash = 606876839,
		},
		[-1007230075] = {
			sex = 1,
			model = "mp_f_chbar_01",
			hash = -1007230075,
		},
		[1264941816] = {
			sex = 1,
			model = "mp_f_cocaine_01",
			hash = 1264941816,
		},
		[-1215761931] = {
			sex = 1,
			model = "mp_f_counterfeit_01",
			hash = -1215761931,
		},
		[1943971979] = {
			sex = 1,
			model = "mp_f_deadhooker",
			hash = 1943971979,
		},
		[1126998116] = {
			sex = 1,
			model = "mp_f_execpa_01",
			hash = 1126998116,
		},
		[1500695792] = {
			sex = 1,
			model = "mp_f_execpa_02",
			hash = 1500695792,
		},
		[2014985464] = {
			sex = 1,
			model = "mp_f_forgery_01",
			hash = 2014985464,
		},
		[-1667301416] = {
			sex = 1,
			model = "mp_f_freemode_01",
			hash = -1667301416,
		},
		[431423238] = {
			sex = 1,
			model = "mp_f_helistaff_01",
			hash = 431423238,
		},
		[-760054079] = {
			sex = 1,
			model = "mp_f_meth_01",
			hash = -760054079,
		},
		[-785842275] = {
			sex = 1,
			model = "mp_f_misty_01",
			hash = -785842275,
		},
		[695248020] = {
			sex = 1,
			model = "mp_f_stripperlite",
			hash = 695248020,
		},
		[-1301974109] = {
			sex = 1,
			model = "mp_f_weed_01",
			hash = -1301974109,
		},
		[373000027] = {
			sex = 1,
			model = "s_f_m_fembarber",
			hash = 373000027,
		},
		[-527186490] = {
			sex = 1,
			model = "s_f_m_maid_01",
			hash = -527186490,
		},
		[-1371020112] = {
			sex = 1,
			model = "s_f_m_shop_high",
			hash = -1371020112,
		},
		[824925120] = {
			sex = 1,
			model = "s_f_m_sweatshop_01",
			hash = 824925120,
		},
		[1567728751] = {
			sex = 1,
			model = "s_f_y_airhostess_01",
			hash = 1567728751,
		},
		[2014052797] = {
			sex = 1,
			model = "s_f_y_bartender_01",
			hash = 2014052797,
		},
		[1250841910] = {
			sex = 1,
			model = "s_f_y_baywatch_01",
			hash = 1250841910,
		},
		[-1054459573] = {
			sex = 1,
			model = "s_f_y_clubbar_01",
			hash = -1054459573,
		},
		[368603149] = {
			sex = 1,
			model = "s_f_y_cop_01",
			hash = 368603149,
		},
		[1777626099] = {
			sex = 1,
			model = "s_f_y_factory_01",
			hash = 1777626099,
		},
		[42647445] = {
			sex = 1,
			model = "s_f_y_hooker_01",
			hash = 42647445,
		},
		[348382215] = {
			sex = 1,
			model = "s_f_y_hooker_02",
			hash = 348382215,
		},
		[51789996] = {
			sex = 1,
			model = "s_f_y_hooker_03",
			hash = 51789996,
		},
		[-715445259] = {
			sex = 1,
			model = "s_f_y_migrant_01",
			hash = -715445259,
		},
		[587253782] = {
			sex = 1,
			model = "s_f_y_movprem_01",
			hash = 587253782,
		},
		[-1614285257] = {
			sex = 1,
			model = "s_f_y_ranger_01",
			hash = -1614285257,
		},
		[-1420211530] = {
			sex = 1,
			model = "s_f_y_scrubs_01",
			hash = -1420211530,
		},
		[1096929346] = {
			sex = 1,
			model = "s_f_y_sheriff_01",
			hash = 1096929346,
		},
		[-1452399100] = {
			sex = 1,
			model = "s_f_y_shop_low",
			hash = -1452399100,
		},
		[1055701597] = {
			sex = 1,
			model = "s_f_y_shop_mid",
			hash = 1055701597,
		},
		[1381498905] = {
			sex = 1,
			model = "s_f_y_stripper_01",
			hash = 1381498905,
		},
		[1846523796] = {
			sex = 1,
			model = "s_f_y_stripper_02",
			hash = 1846523796,
		},
		[1544875514] = {
			sex = 1,
			model = "s_f_y_stripperlite",
			hash = 1544875514,
		},
		[-2063419726] = {
			sex = 1,
			model = "s_f_y_sweatshop_01",
			hash = -2063419726,
		},
		[-1131233579] = {
			sex = 1,
			model = "s_f_y_casino_01",
			hash = -1131233579,
		},
		[1074457665] = {
			sex = 1,
			model = "ig_abigail",
			hash = 1074457665,
		},
		[610988552] = {
			sex = 1,
			model = "ig_agent",
			hash = 610988552,
		},
		[1830688247] = {
			sex = 1,
			model = "ig_amandatownley",
			hash = 1830688247,
		},
		[2129936603] = {
			sex = 1,
			model = "ig_ashley",
			hash = 2129936603,
		},
		[1633872967] = {
			sex = 1,
			model = "ig_bride",
			hash = 1633872967,
		},
		[-2113195075] = {
			sex = 1,
			model = "ig_denise",
			hash = -2113195075,
		},
		[-75756443] = {
			sex = 1,
			model = "ig_djblamadon",
			hash = -75756443,
		},
		[-1322513804] = {
			sex = 1,
			model = "ig_djtalaurelia",
			hash = -1322513804,
		},
		[225287241] = {
			sex = 1,
			model = "ig_janet",
			hash = 225287241,
		},
		[257763003] = {
			sex = 1,
			model = "ig_jewelass",
			hash = 257763003,
		},
		[-346957479] = {
			sex = 1,
			model = "ig_karen_daniels",
			hash = -346957479,
		},
		[1530648845] = {
			sex = 1,
			model = "ig_kerrymcintosh",
			hash = 1530648845,
		},
		[-666714478] = {
			sex = 1,
			model = "ig_kerrymcintosh_02",
			hash = -666714478,
		},
		[-868827412] = {
			sex = 1,
			model = "ig_lacey_jones_02",
			hash = -868827412,
		},
		[-52653814] = {
			sex = 1,
			model = "ig_magenta",
			hash = -52653814,
		},
		[411185872] = {
			sex = 1,
			model = "ig_marnie",
			hash = 411185872,
		},
		[-1552967674] = {
			sex = 1,
			model = "ig_maryann",
			hash = -1552967674,
		},
		[1005070462] = {
			sex = 1,
			model = "ig_maude",
			hash = 1005070462,
		},
		[-1080659212] = {
			sex = 1,
			model = "ig_michelle",
			hash = -1080659212,
		},
		[-1358701087] = {
			sex = 1,
			model = "ig_molly",
			hash = -1358701087,
		},
		[503621995] = {
			sex = 1,
			model = "ig_mrs_thornhill",
			hash = 503621995,
		},
		[946007720] = {
			sex = 1,
			model = "ig_mrsphillips",
			hash = 946007720,
		},
		[-568861381] = {
			sex = 1,
			model = "ig_natalia",
			hash = -568861381,
		},
		[357551935] = {
			sex = 1,
			model = "ig_paige",
			hash = 357551935,
		},
		[-982642292] = {
			sex = 1,
			model = "ig_patricia",
			hash = -982642292,
		},
		[-1689993] = {
			sex = 1,
			model = "ig_screen_writer",
			hash = -1689993,
		},
		[226559113] = {
			sex = 1,
			model = "ig_tanisha",
			hash = 226559113,
		},
		[-892841148] = {
			sex = 1,
			model = "ig_tonya",
			hash = -892841148,
		},
		[-566941131] = {
			sex = 1,
			model = "ig_tracydisanto",
			hash = -566941131,
		},
		[1855569864] = {
			sex = 1,
			model = "ig_agatha",
			hash = 1855569864,
		},
		[773063444] = {
			sex = 1,
			model = "u_f_m_corpse_01",
			hash = 773063444,
		},
		[1095737979] = {
			sex = 1,
			model = "u_f_m_miranda",
			hash = 1095737979,
		},
		[-340063052] = {
			sex = 1,
			model = "u_f_m_miranda_02",
			hash = -340063052,
		},
		[-1576494617] = {
			sex = 1,
			model = "u_f_m_promourn_01",
			hash = -1576494617,
		},
		[894928436] = {
			sex = 1,
			model = "u_f_o_moviestar",
			hash = 894928436,
		},
		[-988619485] = {
			sex = 1,
			model = "u_f_o_prolhost_01",
			hash = -988619485,
		},
		[-96953009] = {
			sex = 1,
			model = "u_f_y_bikerchic",
			hash = -96953009,
		},
		[-1230338610] = {
			sex = 1,
			model = "u_f_y_comjane",
			hash = -1230338610,
		},
		[-1670377315] = {
			sex = 1,
			model = "u_f_y_corpse_01",
			hash = -1670377315,
		},
		[228356856] = {
			sex = 1,
			model = "u_f_y_corpse_02",
			hash = 228356856,
		},
		[222643882] = {
			sex = 1,
			model = "u_f_y_danceburl_01",
			hash = 222643882,
		},
		[130590395] = {
			sex = 1,
			model = "u_f_y_dancelthr_01",
			hash = 130590395,
		},
		[-1394433551] = {
			sex = 1,
			model = "u_f_y_dancerave_01",
			hash = -1394433551,
		},
		[-1768198658] = {
			sex = 1,
			model = "u_f_y_hotposh_01",
			hash = -1768198658,
		},
		[-254493138] = {
			sex = 1,
			model = "u_f_y_jewelass_01",
			hash = -254493138,
		},
		[1573528872] = {
			sex = 1,
			model = "u_f_y_mistress",
			hash = 1573528872,
		},
		[602513566] = {
			sex = 1,
			model = "u_f_y_poppymich",
			hash = 602513566,
		},
		[1823868411] = {
			sex = 1,
			model = "u_f_y_poppymich_02",
			hash = 1823868411,
		},
		[-756833660] = {
			sex = 1,
			model = "u_f_y_princess",
			hash = -756833660,
		},
		[1535236204] = {
			sex = 1,
			model = "u_f_y_spyactress",
			hash = 1535236204,
		},
		[-1156746507] = {
			sex = 1,
			model = "u_f_m_casinocash_01",
			hash = -1156746507,
		},
		[338154536] = {
			sex = 1,
			model = "u_f_m_casinoshop_01",
			hash = 338154536,
		},
		[223828550] = {
			sex = 1,
			model = "u_f_m_debbie_01",
			hash = 223828550,
		},
		[1415150394] = {
			sex = 1,
			model = "u_f_o_carol",
			hash = 1415150394,
		},
		[-1664281608] = {
			sex = 1,
			model = "u_f_o_eileen",
			hash = -1664281608,
		},
		[-1791002229] = {
			sex = 1,
			model = "u_f_y_beth",
			hash = -1791002229,
		},
		[967594628] = {
			sex = 1,
			model = "u_f_y_lauren",
			hash = 967594628,
		},
		[450271392] = {
			sex = 1,
			model = "u_f_y_taylor",
			hash = 450271392,
		},
		[1413662315] = {
			sex = 0,
			model = "a_m_m_acult_01",
			hash = 1413662315,
		},
		[-781039234] = {
			sex = 0,
			model = "a_m_m_afriamer_01",
			hash = -781039234,
		},
		[1077785853] = {
			sex = 0,
			model = "a_m_m_beach_01",
			hash = 1077785853,
		},
		[2021631368] = {
			sex = 0,
			model = "a_m_m_beach_02",
			hash = 2021631368,
		},
		[1423699487] = {
			sex = 0,
			model = "a_m_m_bevhills_01",
			hash = 1423699487,
		},
		[1068876755] = {
			sex = 0,
			model = "a_m_m_bevhills_02",
			hash = 1068876755,
		},
		[2120901815] = {
			sex = 0,
			model = "a_m_m_business_01",
			hash = 2120901815,
		},
		[-106498753] = {
			sex = 0,
			model = "a_m_m_eastsa_01",
			hash = -106498753,
		},
		[131961260] = {
			sex = 0,
			model = "a_m_m_eastsa_02",
			hash = 131961260,
		},
		[-1806291497] = {
			sex = 0,
			model = "a_m_m_farmer_01",
			hash = -1806291497,
		},
		[1641152947] = {
			sex = 0,
			model = "a_m_m_fatlatin_01",
			hash = 1641152947,
		},
		[115168927] = {
			sex = 0,
			model = "a_m_m_genfat_01",
			hash = 115168927,
		},
		[330231874] = {
			sex = 0,
			model = "a_m_m_genfat_02",
			hash = 330231874,
		},
		[-1444213182] = {
			sex = 0,
			model = "a_m_m_golfer_01",
			hash = -1444213182,
		},
		[1809430156] = {
			sex = 0,
			model = "a_m_m_hasjew_01",
			hash = 1809430156,
		},
		[1822107721] = {
			sex = 0,
			model = "a_m_m_hillbilly_01",
			hash = 1822107721,
		},
		[2064532783] = {
			sex = 0,
			model = "a_m_m_hillbilly_02",
			hash = 2064532783,
		},
		[-573920724] = {
			sex = 0,
			model = "a_m_m_indian_01",
			hash = -573920724,
		},
		[-782401935] = {
			sex = 0,
			model = "a_m_m_ktown_01",
			hash = -782401935,
		},
		[803106487] = {
			sex = 0,
			model = "a_m_m_malibu_01",
			hash = 803106487,
		},
		[-578715987] = {
			sex = 0,
			model = "a_m_m_mexcntry_01",
			hash = -578715987,
		},
		[-1302522190] = {
			sex = 0,
			model = "a_m_m_mexlabor_01",
			hash = -1302522190,
		},
		[1746653202] = {
			sex = 0,
			model = "a_m_m_og_boss_01",
			hash = 1746653202,
		},
		[-322270187] = {
			sex = 0,
			model = "a_m_m_paparazzi_01",
			hash = -322270187,
		},
		[-1445349730] = {
			sex = 0,
			model = "a_m_m_polynesian_01",
			hash = -1445349730,
		},
		[-1760377969] = {
			sex = 0,
			model = "a_m_m_prolhost_01",
			hash = -1760377969,
		},
		[1001210244] = {
			sex = 0,
			model = "a_m_m_rurmeth_01",
			hash = 1001210244,
		},
		[1328415626] = {
			sex = 0,
			model = "a_m_m_salton_01",
			hash = 1328415626,
		},
		[1626646295] = {
			sex = 0,
			model = "a_m_m_salton_02",
			hash = 1626646295,
		},
		[-1299428795] = {
			sex = 0,
			model = "a_m_m_salton_03",
			hash = -1299428795,
		},
		[-1773858377] = {
			sex = 0,
			model = "a_m_m_salton_04",
			hash = -1773858377,
		},
		[-640198516] = {
			sex = 0,
			model = "a_m_m_skater_01",
			hash = -640198516,
		},
		[32417469] = {
			sex = 0,
			model = "a_m_m_skidrow_01",
			hash = 32417469,
		},
		[193817059] = {
			sex = 0,
			model = "a_m_m_socenlat_01",
			hash = 193817059,
		},
		[1750583735] = {
			sex = 0,
			model = "a_m_m_soucent_01",
			hash = 1750583735,
		},
		[-1620232223] = {
			sex = 0,
			model = "a_m_m_soucent_02",
			hash = -1620232223,
		},
		[-1948675910] = {
			sex = 0,
			model = "a_m_m_soucent_03",
			hash = -1948675910,
		},
		[-1023672578] = {
			sex = 0,
			model = "a_m_m_soucent_04",
			hash = -1023672578,
		},
		[-1029146878] = {
			sex = 0,
			model = "a_m_m_stlat_02",
			hash = -1029146878,
		},
		[1416254276] = {
			sex = 0,
			model = "a_m_m_tennis_01",
			hash = 1416254276,
		},
		[-929103484] = {
			sex = 0,
			model = "a_m_m_tourist_01",
			hash = -929103484,
		},
		[516505552] = {
			sex = 0,
			model = "a_m_m_tramp_01",
			hash = 516505552,
		},
		[1404403376] = {
			sex = 0,
			model = "a_m_m_trampbeac_01",
			hash = 1404403376,
		},
		[-521758348] = {
			sex = 0,
			model = "a_m_m_tranvest_01",
			hash = -521758348,
		},
		[-150026812] = {
			sex = 0,
			model = "a_m_m_tranvest_02",
			hash = -150026812,
		},
		[1430544400] = {
			sex = 0,
			model = "a_m_o_acult_01",
			hash = 1430544400,
		},
		[1268862154] = {
			sex = 0,
			model = "a_m_o_acult_02",
			hash = 1268862154,
		},
		[-2077764712] = {
			sex = 0,
			model = "a_m_o_beach_01",
			hash = -2077764712,
		},
		[-1386944600] = {
			sex = 0,
			model = "a_m_o_genstreet_01",
			hash = -1386944600,
		},
		[355916122] = {
			sex = 0,
			model = "a_m_o_ktown_01",
			hash = 355916122,
		},
		[539004493] = {
			sex = 0,
			model = "a_m_o_salton_01",
			hash = 539004493,
		},
		[718836251] = {
			sex = 0,
			model = "a_m_o_soucent_01",
			hash = 718836251,
		},
		[1082572151] = {
			sex = 0,
			model = "a_m_o_soucent_02",
			hash = 1082572151,
		},
		[238213328] = {
			sex = 0,
			model = "a_m_o_soucent_03",
			hash = 238213328,
		},
		[390939205] = {
			sex = 0,
			model = "a_m_o_tramp_01",
			hash = 390939205,
		},
		[-1251702741] = {
			sex = 0,
			model = "a_m_y_acult_01",
			hash = -1251702741,
		},
		[-2132435154] = {
			sex = 0,
			model = "a_m_y_acult_02",
			hash = -2132435154,
		},
		[-771835772] = {
			sex = 0,
			model = "a_m_y_beach_01",
			hash = -771835772,
		},
		[600300561] = {
			sex = 0,
			model = "a_m_y_beach_02",
			hash = 600300561,
		},
		[-408329255] = {
			sex = 0,
			model = "a_m_y_beach_03",
			hash = -408329255,
		},
		[2114544056] = {
			sex = 0,
			model = "a_m_y_beachvesp_01",
			hash = 2114544056,
		},
		[-900269486] = {
			sex = 0,
			model = "a_m_y_beachvesp_02",
			hash = -900269486,
		},
		[1982350912] = {
			sex = 0,
			model = "a_m_y_bevhills_01",
			hash = 1982350912,
		},
		[1720428295] = {
			sex = 0,
			model = "a_m_y_bevhills_02",
			hash = 1720428295,
		},
		[933205398] = {
			sex = 0,
			model = "a_m_y_breakdance_01",
			hash = 933205398,
		},
		[-1697435671] = {
			sex = 0,
			model = "a_m_y_busicas_01",
			hash = -1697435671,
		},
		[-912318012] = {
			sex = 0,
			model = "a_m_y_business_01",
			hash = -912318012,
		},
		[-1280051738] = {
			sex = 0,
			model = "a_m_y_business_02",
			hash = -1280051738,
		},
		[-1589423867] = {
			sex = 0,
			model = "a_m_y_business_03",
			hash = -1589423867,
		},
		[-1481174974] = {
			sex = 0,
			model = "a_m_y_clubcust_01",
			hash = -1481174974,
		},
		[-969978574] = {
			sex = 0,
			model = "a_m_y_clubcust_02",
			hash = -969978574,
		},
		[-722081089] = {
			sex = 0,
			model = "a_m_y_clubcust_03",
			hash = -722081089,
		},
		[-37334073] = {
			sex = 0,
			model = "a_m_y_cyclist_01",
			hash = -37334073,
		},
		[-12678997] = {
			sex = 0,
			model = "a_m_y_dhill_01",
			hash = -12678997,
		},
		[766375082] = {
			sex = 0,
			model = "a_m_y_downtown_01",
			hash = 766375082,
		},
		[-1538846349] = {
			sex = 0,
			model = "a_m_y_eastsa_01",
			hash = -1538846349,
		},
		[377976310] = {
			sex = 0,
			model = "a_m_y_eastsa_02",
			hash = 377976310,
		},
		[2010389054] = {
			sex = 0,
			model = "a_m_y_epsilon_01",
			hash = 2010389054,
		},
		[-1434255461] = {
			sex = 0,
			model = "a_m_y_epsilon_02",
			hash = -1434255461,
		},
		[-775102410] = {
			sex = 0,
			model = "a_m_y_gay_01",
			hash = -775102410,
		},
		[-1519253631] = {
			sex = 0,
			model = "a_m_y_gay_02",
			hash = -1519253631,
		},
		[-1736970383] = {
			sex = 0,
			model = "a_m_y_genstreet_01",
			hash = -1736970383,
		},
		[891398354] = {
			sex = 0,
			model = "a_m_y_genstreet_02",
			hash = 891398354,
		},
		[-685776591] = {
			sex = 0,
			model = "a_m_y_golfer_01",
			hash = -685776591,
		},
		[-512913663] = {
			sex = 0,
			model = "a_m_y_hasjew_01",
			hash = -512913663,
		},
		[1358380044] = {
			sex = 0,
			model = "a_m_y_hiker_01",
			hash = 1358380044,
		},
		[2097407511] = {
			sex = 0,
			model = "a_m_y_hippy_01",
			hash = 2097407511,
		},
		[587703123] = {
			sex = 0,
			model = "a_m_y_hipster_01",
			hash = 587703123,
		},
		[349505262] = {
			sex = 0,
			model = "a_m_y_hipster_02",
			hash = 349505262,
		},
		[1312913862] = {
			sex = 0,
			model = "a_m_y_hipster_03",
			hash = 1312913862,
		},
		[706935758] = {
			sex = 0,
			model = "a_m_y_indian_01",
			hash = 706935758,
		},
		[767028979] = {
			sex = 0,
			model = "a_m_y_jetski_01",
			hash = 767028979,
		},
		[-1849016788] = {
			sex = 0,
			model = "a_m_y_juggalo_01",
			hash = -1849016788,
		},
		[452351020] = {
			sex = 0,
			model = "a_m_y_ktown_01",
			hash = 452351020,
		},
		[696250687] = {
			sex = 0,
			model = "a_m_y_ktown_02",
			hash = 696250687,
		},
		[321657486] = {
			sex = 0,
			model = "a_m_y_latino_01",
			hash = 321657486,
		},
		[1768677545] = {
			sex = 0,
			model = "a_m_y_methhead_01",
			hash = 1768677545,
		},
		[810804565] = {
			sex = 0,
			model = "a_m_y_mexthug_01",
			hash = 810804565,
		},
		[1694362237] = {
			sex = 0,
			model = "a_m_y_motox_01",
			hash = 1694362237,
		},
		[2007797722] = {
			sex = 0,
			model = "a_m_y_motox_02",
			hash = 2007797722,
		},
		[1264920838] = {
			sex = 0,
			model = "a_m_y_musclbeac_01",
			hash = 1264920838,
		},
		[-920443780] = {
			sex = 0,
			model = "a_m_y_musclbeac_02",
			hash = -920443780,
		},
		[-2088436577] = {
			sex = 0,
			model = "a_m_y_polynesian_01",
			hash = -2088436577,
		},
		[-178150202] = {
			sex = 0,
			model = "a_m_y_roadcyc_01",
			hash = -178150202,
		},
		[623927022] = {
			sex = 0,
			model = "a_m_y_runner_01",
			hash = 623927022,
		},
		[-2076336881] = {
			sex = 0,
			model = "a_m_y_runner_02",
			hash = -2076336881,
		},
		[-681546704] = {
			sex = 0,
			model = "a_m_y_salton_01",
			hash = -681546704,
		},
		[-1044093321] = {
			sex = 0,
			model = "a_m_y_skater_01",
			hash = -1044093321,
		},
		[-1342520604] = {
			sex = 0,
			model = "a_m_y_skater_02",
			hash = -1342520604,
		},
		[-417940021] = {
			sex = 0,
			model = "a_m_y_soucent_01",
			hash = -417940021,
		},
		[-1398552374] = {
			sex = 0,
			model = "a_m_y_soucent_02",
			hash = -1398552374,
		},
		[-1007618204] = {
			sex = 0,
			model = "a_m_y_soucent_03",
			hash = -1007618204,
		},
		[-1976105999] = {
			sex = 0,
			model = "a_m_y_soucent_04",
			hash = -1976105999,
		},
		[-812470807] = {
			sex = 0,
			model = "a_m_y_stbla_01",
			hash = -812470807,
		},
		[-1731772337] = {
			sex = 0,
			model = "a_m_y_stbla_02",
			hash = -1731772337,
		},
		[-2039163396] = {
			sex = 0,
			model = "a_m_y_stlat_01",
			hash = -2039163396,
		},
		[605602864] = {
			sex = 0,
			model = "a_m_y_stwhi_01",
			hash = 605602864,
		},
		[919005580] = {
			sex = 0,
			model = "a_m_y_stwhi_02",
			hash = 919005580,
		},
		[-1222037748] = {
			sex = 0,
			model = "a_m_y_sunbathe_01",
			hash = -1222037748,
		},
		[-356333586] = {
			sex = 0,
			model = "a_m_y_surfer_01",
			hash = -356333586,
		},
		[-1047300121] = {
			sex = 0,
			model = "a_m_y_vindouche_01",
			hash = -1047300121,
		},
		[1264851357] = {
			sex = 0,
			model = "a_m_y_vinewood_01",
			hash = 1264851357,
		},
		[1561705728] = {
			sex = 0,
			model = "a_m_y_vinewood_02",
			hash = 1561705728,
		},
		[534725268] = {
			sex = 0,
			model = "a_m_y_vinewood_03",
			hash = 534725268,
		},
		[835315305] = {
			sex = 0,
			model = "a_m_y_vinewood_04",
			hash = 835315305,
		},
		[-1425378987] = {
			sex = 0,
			model = "a_m_y_yoga_01",
			hash = -1425378987,
		},
		[1561088805] = {
			sex = 0,
			model = "a_m_m_mlcrisis_01",
			hash = 1561088805,
		},
		[-1694204705] = {
			sex = 0,
			model = "a_m_y_gencaspat_01",
			hash = -1694204705,
		},
		[553826858] = {
			sex = 0,
			model = "a_m_y_smartcaspat_01",
			hash = 553826858,
		},
		[-413773017] = {
			sex = 0,
			model = "cs_andreas",
			hash = -413773017,
		},
		[-1755309778] = {
			sex = 0,
			model = "cs_bankman",
			hash = -1755309778,
		},
		[1767447799] = {
			sex = 0,
			model = "cs_barry",
			hash = 1767447799,
		},
		[-1267809450] = {
			sex = 0,
			model = "cs_beverly",
			hash = -1267809450,
		},
		[-270159898] = {
			sex = 0,
			model = "cs_brad",
			hash = -270159898,
		},
		[1915268960] = {
			sex = 0,
			model = "cs_bradcadaver",
			hash = 1915268960,
		},
		[-1932625649] = {
			sex = 0,
			model = "cs_carbuyer",
			hash = -1932625649,
		},
		[-359228352] = {
			sex = 0,
			model = "cs_casey",
			hash = -359228352,
		},
		[819699067] = {
			sex = 0,
			model = "cs_chengsr",
			hash = 819699067,
		},
		[-1041006362] = {
			sex = 0,
			model = "cs_chrisformage",
			hash = -1041006362,
		},
		[-607414220] = {
			sex = 0,
			model = "cs_clay",
			hash = -607414220,
		},
		[216536661] = {
			sex = 0,
			model = "cs_dale",
			hash = 216536661,
		},
		[-2054740852] = {
			sex = 0,
			model = "cs_davenorton",
			hash = -2054740852,
		},
		[788622594] = {
			sex = 0,
			model = "cs_devin",
			hash = 788622594,
		},
		[1198698306] = {
			sex = 0,
			model = "cs_dom",
			hash = 1198698306,
		},
		[1012965715] = {
			sex = 0,
			model = "cs_dreyfuss",
			hash = 1012965715,
		},
		[-1549575121] = {
			sex = 0,
			model = "cs_drfriedlander",
			hash = -1549575121,
		},
		[1191403201] = {
			sex = 0,
			model = "cs_fabien",
			hash = 1191403201,
		},
		[1482427218] = {
			sex = 0,
			model = "cs_fbisuit_01",
			hash = 1482427218,
		},
		[103106535] = {
			sex = 0,
			model = "cs_floyd",
			hash = 103106535,
		},
		[1531218220] = {
			sex = 0,
			model = "cs_hunter",
			hash = 1531218220,
		},
		[60192701] = {
			sex = 0,
			model = "cs_jimmyboston",
			hash = 60192701,
		},
		[-1194552652] = {
			sex = 0,
			model = "cs_jimmydisanto",
			hash = -1194552652,
		},
		[-258122199] = {
			sex = 0,
			model = "cs_joeminuteman",
			hash = -258122199,
		},
		[-91572095] = {
			sex = 0,
			model = "cs_johnnyklebitz",
			hash = -91572095,
		},
		[1167549130] = {
			sex = 0,
			model = "cs_josef",
			hash = 1167549130,
		},
		[1158606749] = {
			sex = 0,
			model = "cs_josh",
			hash = 1158606749,
		},
		[1162230285] = {
			sex = 0,
			model = "cs_lamardavis",
			hash = 1162230285,
		},
		[949295643] = {
			sex = 0,
			model = "cs_lazlow",
			hash = 949295643,
		},
		[1598839101] = {
			sex = 0,
			model = "cs_lazlow_2",
			hash = 1598839101,
		},
		[-1248528957] = {
			sex = 0,
			model = "cs_lestercrest",
			hash = -1248528957,
		},
		[1918178165] = {
			sex = 0,
			model = "cs_lifeinvad_01",
			hash = 1918178165,
		},
		[-72125238] = {
			sex = 0,
			model = "cs_manuel",
			hash = -72125238,
		},
		[1129928304] = {
			sex = 0,
			model = "cs_martinmadrazo",
			hash = 1129928304,
		},
		[-1217776881] = {
			sex = 0,
			model = "cs_milton",
			hash = -1217776881,
		},
		[-1922568579] = {
			sex = 0,
			model = "cs_movpremmale",
			hash = -1922568579,
		},
		[-1010001291] = {
			sex = 0,
			model = "cs_mrk",
			hash = -1010001291,
		},
		[2023152276] = {
			sex = 0,
			model = "cs_nervousron",
			hash = 2023152276,
		},
		[-515400693] = {
			sex = 0,
			model = "cs_nigel",
			hash = -515400693,
		},
		[518814684] = {
			sex = 0,
			model = "cs_old_man1a",
			hash = 518814684,
		},
		[-1728452752] = {
			sex = 0,
			model = "cs_old_man2",
			hash = -1728452752,
		},
		[-1955548155] = {
			sex = 0,
			model = "cs_omega",
			hash = -1955548155,
		},
		[-1389097126] = {
			sex = 0,
			model = "cs_orleans",
			hash = -1389097126,
		},
		[1798879480] = {
			sex = 0,
			model = "cs_paper",
			hash = 1798879480,
		},
		[1299047806] = {
			sex = 0,
			model = "cs_priest",
			hash = 1299047806,
		},
		[512955554] = {
			sex = 0,
			model = "cs_prolsec_02",
			hash = 512955554,
		},
		[1179785778] = {
			sex = 0,
			model = "cs_russiandrunk",
			hash = 1179785778,
		},
		[-1064078846] = {
			sex = 0,
			model = "cs_siemonyetarian",
			hash = -1064078846,
		},
		[-154017714] = {
			sex = 0,
			model = "cs_solomon",
			hash = -154017714,
		},
		[-1528782338] = {
			sex = 0,
			model = "cs_stevehains",
			hash = -1528782338,
		},
		[-1992464379] = {
			sex = 0,
			model = "cs_stretch",
			hash = -1992464379,
		},
		[-2006710211] = {
			sex = 0,
			model = "cs_taocheng",
			hash = -2006710211,
		},
		[1397974313] = {
			sex = 0,
			model = "cs_taostranslator",
			hash = 1397974313,
		},
		[1545995274] = {
			sex = 0,
			model = "cs_tenniscoach",
			hash = 1545995274,
		},
		[978452933] = {
			sex = 0,
			model = "cs_terry",
			hash = 978452933,
		},
		[1776856003] = {
			sex = 0,
			model = "cs_tom",
			hash = 1776856003,
		},
		[-1945119518] = {
			sex = 0,
			model = "cs_tomepsilon",
			hash = -1945119518,
		},
		[-765011498] = {
			sex = 0,
			model = "cs_wade",
			hash = -765011498,
		},
		[-357782800] = {
			sex = 0,
			model = "cs_zimbor",
			hash = -357782800,
		},
		[-680474188] = {
			sex = 0,
			model = "csb_agent",
			hash = -680474188,
		},
		[1925887591] = {
			sex = 0,
			model = "csb_alan",
			hash = 1925887591,
		},
		[-1513650250] = {
			sex = 0,
			model = "csb_anton",
			hash = -1513650250,
		},
		[406009421] = {
			sex = 0,
			model = "csb_avon",
			hash = 406009421,
		},
		[-1410400252] = {
			sex = 0,
			model = "csb_ballasog",
			hash = -1410400252,
		},
		[1594283837] = {
			sex = 0,
			model = "csb_bogdan",
			hash = 1594283837,
		},
		[-1931689897] = {
			sex = 0,
			model = "csb_burgerdrug",
			hash = -1931689897,
		},
		[71501447] = {
			sex = 0,
			model = "csb_car3guy1",
			hash = 71501447,
		},
		[327394568] = {
			sex = 0,
			model = "csb_car3guy2",
			hash = 327394568,
		},
		[-1555576182] = {
			sex = 0,
			model = "csb_chef",
			hash = -1555576182,
		},
		[-1369710022] = {
			sex = 0,
			model = "csb_chef2",
			hash = -1369710022,
		},
		[-1463670378] = {
			sex = 0,
			model = "csb_chin_goon",
			hash = -1463670378,
		},
		[-890640939] = {
			sex = 0,
			model = "csb_cletus",
			hash = -890640939,
		},
		[-1699520669] = {
			sex = 0,
			model = "csb_cop",
			hash = -1699520669,
		},
		[-1538297973] = {
			sex = 0,
			model = "csb_customer",
			hash = -1538297973,
		},
		[-337629947] = {
			sex = 0,
			model = "csb_dix",
			hash = -337629947,
		},
		[-761757122] = {
			sex = 0,
			model = "csb_englishdave",
			hash = -761757122,
		},
		[466359675] = {
			sex = 0,
			model = "csb_fos_rep",
			hash = 466359675,
		},
		[-1567723049] = {
			sex = 0,
			model = "csb_g",
			hash = -1567723049,
		},
		[2058033618] = {
			sex = 0,
			model = "csb_groom",
			hash = 2058033618,
		},
		[-396800478] = {
			sex = 0,
			model = "csb_grove_str_dlr",
			hash = -396800478,
		},
		[-325152996] = {
			sex = 0,
			model = "csb_hao",
			hash = -325152996,
		},
		[1863555924] = {
			sex = 0,
			model = "csb_hugh",
			hash = 1863555924,
		},
		[-482210853] = {
			sex = 0,
			model = "csb_imran",
			hash = -482210853,
		},
		[1153203121] = {
			sex = 0,
			model = "csb_jackhowitzer",
			hash = 1153203121,
		},
		[-1040164288] = {
			sex = 0,
			model = "csb_janitor",
			hash = -1040164288,
		},
		[-1734476390] = {
			sex = 0,
			model = "csb_money",
			hash = -1734476390,
		},
		[1841036427] = {
			sex = 0,
			model = "csb_mp_agent14",
			hash = 1841036427,
		},
		[1631478380] = {
			sex = 0,
			model = "csb_mweather",
			hash = 1631478380,
		},
		[-1059388209] = {
			sex = 0,
			model = "csb_ortega",
			hash = -1059388209,
		},
		[-199280229] = {
			sex = 0,
			model = "csb_oscar",
			hash = -199280229,
		},
		[1635617250] = {
			sex = 0,
			model = "csb_popov",
			hash = 1635617250,
		},
		[793443893] = {
			sex = 0,
			model = "csb_porndudes",
			hash = 793443893,
		},
		[-267695653] = {
			sex = 0,
			model = "csb_prologuedriver",
			hash = -267695653,
		},
		[2141384740] = {
			sex = 0,
			model = "csb_prolsec",
			hash = 2141384740,
		},
		[-1031795266] = {
			sex = 0,
			model = "csb_ramp_gang",
			hash = -1031795266,
		},
		[-2054384456] = {
			sex = 0,
			model = "csb_ramp_hic",
			hash = -2054384456,
		},
		[569740212] = {
			sex = 0,
			model = "csb_ramp_hipster",
			hash = 569740212,
		},
		[1634506681] = {
			sex = 0,
			model = "csb_ramp_marine",
			hash = 1634506681,
		},
		[-162605104] = {
			sex = 0,
			model = "csb_ramp_mex",
			hash = -162605104,
		},
		[411081129] = {
			sex = 0,
			model = "csb_rashcosvki",
			hash = 411081129,
		},
		[776079908] = {
			sex = 0,
			model = "csb_reporter",
			hash = 776079908,
		},
		[-1436281204] = {
			sex = 0,
			model = "csb_roccopelosi",
			hash = -1436281204,
		},
		[1324952405] = {
			sex = 0,
			model = "csb_sol",
			hash = 1324952405,
		},
		[-902822792] = {
			sex = 0,
			model = "csb_talcc",
			hash = -902822792,
		},
		[-509558803] = {
			sex = 0,
			model = "csb_talmm",
			hash = -509558803,
		},
		[1566545691] = {
			sex = 0,
			model = "csb_tonyprince",
			hash = 1566545691,
		},
		[-567724045] = {
			sex = 0,
			model = "csb_trafficwarden",
			hash = -567724045,
		},
		[-277325206] = {
			sex = 0,
			model = "csb_undercover",
			hash = -277325206,
		},
		[1224690857] = {
			sex = 0,
			model = "csb_vagspeak",
			hash = 1224690857,
		},
		[1427949869] = {
			sex = 0,
			model = "csb_avery",
			hash = 1427949869,
		},
		[-933188075] = {
			sex = 0,
			model = "csb_brucie2",
			hash = -933188075,
		},
		[-208086447] = {
			sex = 0,
			model = "csb_thornton",
			hash = -208086447,
		},
		[-806300485] = {
			sex = 0,
			model = "csb_tomcasino",
			hash = -806300485,
		},
		[520636071] = {
			sex = 0,
			model = "csb_vincent",
			hash = 520636071,
		},
		[-1130181398] = {
			sex = 0,
			model = "g_m_importexport_01",
			hash = -1130181398,
		},
		[-236444766] = {
			sex = 0,
			model = "g_m_m_armboss_01",
			hash = -236444766,
		},
		[-39239064] = {
			sex = 0,
			model = "g_m_m_armgoon_01",
			hash = -39239064,
		},
		[-412008429] = {
			sex = 0,
			model = "g_m_m_armlieut_01",
			hash = -412008429,
		},
		[-166363761] = {
			sex = 0,
			model = "g_m_m_chemwork_01",
			hash = -166363761,
		},
		[-1176698112] = {
			sex = 0,
			model = "g_m_m_chiboss_01",
			hash = -1176698112,
		},
		[275618457] = {
			sex = 0,
			model = "g_m_m_chicold_01",
			hash = 275618457,
		},
		[2119136831] = {
			sex = 0,
			model = "g_m_m_chigoon_01",
			hash = 2119136831,
		},
		[-9308122] = {
			sex = 0,
			model = "g_m_m_chigoon_02",
			hash = -9308122,
		},
		[891945583] = {
			sex = 0,
			model = "g_m_m_korboss_01",
			hash = 891945583,
		},
		[1466037421] = {
			sex = 0,
			model = "g_m_m_mexboss_01",
			hash = 1466037421,
		},
		[1226102803] = {
			sex = 0,
			model = "g_m_m_mexboss_02",
			hash = 1226102803,
		},
		[-984709238] = {
			sex = 0,
			model = "g_m_y_armgoon_02",
			hash = -984709238,
		},
		[1752208920] = {
			sex = 0,
			model = "g_m_y_azteca_01",
			hash = 1752208920,
		},
		[-198252413] = {
			sex = 0,
			model = "g_m_y_ballaeast_01",
			hash = -198252413,
		},
		[588969535] = {
			sex = 0,
			model = "g_m_y_ballaorig_01",
			hash = 588969535,
		},
		[599294057] = {
			sex = 0,
			model = "g_m_y_ballasout_01",
			hash = 599294057,
		},
		[-398748745] = {
			sex = 0,
			model = "g_m_y_famca_01",
			hash = -398748745,
		},
		[-613248456] = {
			sex = 0,
			model = "g_m_y_famdnf_01",
			hash = -613248456,
		},
		[-2077218039] = {
			sex = 0,
			model = "g_m_y_famfor_01",
			hash = -2077218039,
		},
		[611648169] = {
			sex = 0,
			model = "g_m_y_korean_01",
			hash = 611648169,
		},
		[-1880237687] = {
			sex = 0,
			model = "g_m_y_korean_02",
			hash = -1880237687,
		},
		[2093736314] = {
			sex = 0,
			model = "g_m_y_korlieut_01",
			hash = 2093736314,
		},
		[1330042375] = {
			sex = 0,
			model = "g_m_y_lost_01",
			hash = 1330042375,
		},
		[1032073858] = {
			sex = 0,
			model = "g_m_y_lost_02",
			hash = 1032073858,
		},
		[850468060] = {
			sex = 0,
			model = "g_m_y_lost_03",
			hash = 850468060,
		},
		[-1109568186] = {
			sex = 0,
			model = "g_m_y_mexgang_01",
			hash = -1109568186,
		},
		[653210662] = {
			sex = 0,
			model = "g_m_y_mexgoon_01",
			hash = 653210662,
		},
		[832784782] = {
			sex = 0,
			model = "g_m_y_mexgoon_02",
			hash = 832784782,
		},
		[-1773333796] = {
			sex = 0,
			model = "g_m_y_mexgoon_03",
			hash = -1773333796,
		},
		[1329576454] = {
			sex = 0,
			model = "g_m_y_pologoon_01",
			hash = 1329576454,
		},
		[-1561829034] = {
			sex = 0,
			model = "g_m_y_pologoon_02",
			hash = -1561829034,
		},
		[-1872961334] = {
			sex = 0,
			model = "g_m_y_salvaboss_01",
			hash = -1872961334,
		},
		[663522487] = {
			sex = 0,
			model = "g_m_y_salvagoon_01",
			hash = 663522487,
		},
		[846439045] = {
			sex = 0,
			model = "g_m_y_salvagoon_02",
			hash = 846439045,
		},
		[62440720] = {
			sex = 0,
			model = "g_m_y_salvagoon_03",
			hash = 62440720,
		},
		[-48477765] = {
			sex = 0,
			model = "g_m_y_strpunk_01",
			hash = -48477765,
		},
		[228715206] = {
			sex = 0,
			model = "g_m_y_strpunk_02",
			hash = 228715206,
		},
		[1020431539] = {
			sex = 0,
			model = "g_m_m_casrn_01",
			hash = 1020431539,
		},
		[1822283721] = {
			sex = 0,
			model = "mp_g_m_pros_01",
			hash = 1822283721,
		},
		[-1676424299] = {
			sex = 0,
			model = "mp_m_avongoon",
			hash = -1676424299,
		},
		[-933295480] = {
			sex = 0,
			model = "mp_m_boatstaff_01",
			hash = -933295480,
		},
		[1297520375] = {
			sex = 0,
			model = "mp_m_bogdangoon",
			hash = 1297520375,
		},
		[-1057787465] = {
			sex = 0,
			model = "mp_m_claude_01",
			hash = -1057787465,
		},
		[1456705429] = {
			sex = 0,
			model = "mp_m_cocaine_01",
			hash = 1456705429,
		},
		[-1739208332] = {
			sex = 0,
			model = "mp_m_counterfeit_01",
			hash = -1739208332,
		},
		[1161072059] = {
			sex = 0,
			model = "mp_m_exarmy_01",
			hash = 1161072059,
		},
		[1048844220] = {
			sex = 0,
			model = "mp_m_execpa_01",
			hash = 1048844220,
		},
		[866411749] = {
			sex = 0,
			model = "mp_m_famdd_01",
			hash = 866411749,
		},
		[1558115333] = {
			sex = 0,
			model = "mp_m_fibsec_01",
			hash = 1558115333,
		},
		[1631482011] = {
			sex = 0,
			model = "mp_m_forgery_01",
			hash = 1631482011,
		},
		[1885233650] = {
			sex = 0,
			model = "mp_m_freemode_01",
			hash = 1885233650,
		},
		[-995747907] = {
			sex = 0,
			model = "mp_m_g_vagfun_01",
			hash = -995747907,
		},
		[943915367] = {
			sex = 0,
			model = "mp_m_marston_01",
			hash = 943915367,
		},
		[-306958529] = {
			sex = 0,
			model = "mp_m_meth_01",
			hash = -306958529,
		},
		[-287649847] = {
			sex = 0,
			model = "mp_m_niko_01",
			hash = -287649847,
		},
		[-634611634] = {
			sex = 0,
			model = "mp_m_securoguard_01",
			hash = -634611634,
		},
		[416176080] = {
			sex = 0,
			model = "mp_m_shopkeep_01",
			hash = 416176080,
		},
		[-140033735] = {
			sex = 0,
			model = "mp_m_waremech_01",
			hash = -140033735,
		},
		[921328393] = {
			sex = 0,
			model = "mp_m_weapexp_01",
			hash = 921328393,
		},
		[1099321454] = {
			sex = 0,
			model = "mp_m_weapwork_01",
			hash = 1099321454,
		},
		[-1853959079] = {
			sex = 0,
			model = "mp_m_weed_01",
			hash = -1853959079,
		},
		[-839953400] = {
			sex = 0,
			model = "mp_s_m_armoured_01",
			hash = -839953400,
		},
		[233415434] = {
			sex = 0,
			model = "s_m_m_ammucountry",
			hash = 233415434,
		},
		[-1782092083] = {
			sex = 0,
			model = "s_m_m_armoured_01",
			hash = -1782092083,
		},
		[1669696074] = {
			sex = 0,
			model = "s_m_m_armoured_02",
			hash = 1669696074,
		},
		[68070371] = {
			sex = 0,
			model = "s_m_m_autoshop_01",
			hash = 68070371,
		},
		[-261389155] = {
			sex = 0,
			model = "s_m_m_autoshop_02",
			hash = -261389155,
		},
		[-1613485779] = {
			sex = 0,
			model = "s_m_m_bouncer_01",
			hash = -1613485779,
		},
		[-907676309] = {
			sex = 0,
			model = "s_m_m_ccrew_01",
			hash = -907676309,
		},
		[788443093] = {
			sex = 0,
			model = "s_m_m_chemsec_01",
			hash = 788443093,
		},
		[1650288984] = {
			sex = 0,
			model = "s_m_m_ciasec_01",
			hash = 1650288984,
		},
		[436345731] = {
			sex = 0,
			model = "s_m_m_cntrybar_01",
			hash = 436345731,
		},
		[349680864] = {
			sex = 0,
			model = "s_m_m_dockwork_01",
			hash = 349680864,
		},
		[-730659924] = {
			sex = 0,
			model = "s_m_m_doctor_01",
			hash = -730659924,
		},
		[-306416314] = {
			sex = 0,
			model = "s_m_m_fiboffice_01",
			hash = -306416314,
		},
		[653289389] = {
			sex = 0,
			model = "s_m_m_fiboffice_02",
			hash = 653289389,
		},
		[2072724299] = {
			sex = 0,
			model = "s_m_m_fibsec_01",
			hash = 2072724299,
		},
		[-1453933154] = {
			sex = 0,
			model = "s_m_m_gaffer_01",
			hash = -1453933154,
		},
		[1240094341] = {
			sex = 0,
			model = "s_m_m_gardener_01",
			hash = 1240094341,
		},
		[411102470] = {
			sex = 0,
			model = "s_m_m_gentransport",
			hash = 411102470,
		},
		[1099825042] = {
			sex = 0,
			model = "s_m_m_hairdress_01",
			hash = 1099825042,
		},
		[-245247470] = {
			sex = 0,
			model = "s_m_m_highsec_01",
			hash = -245247470,
		},
		[691061163] = {
			sex = 0,
			model = "s_m_m_highsec_02",
			hash = 691061163,
		},
		[-1452549652] = {
			sex = 0,
			model = "s_m_m_janitor",
			hash = -1452549652,
		},
		[-1635724594] = {
			sex = 0,
			model = "s_m_m_lathandy_01",
			hash = -1635724594,
		},
		[-570394627] = {
			sex = 0,
			model = "s_m_m_lifeinvad_01",
			hash = -570394627,
		},
		[-610530921] = {
			sex = 0,
			model = "s_m_m_linecook",
			hash = -610530921,
		},
		[1985653476] = {
			sex = 0,
			model = "s_m_m_lsmetro_01",
			hash = 1985653476,
		},
		[2124742566] = {
			sex = 0,
			model = "s_m_m_mariachi_01",
			hash = 2124742566,
		},
		[-220552467] = {
			sex = 0,
			model = "s_m_m_marine_01",
			hash = -220552467,
		},
		[-265970301] = {
			sex = 0,
			model = "s_m_m_marine_02",
			hash = -265970301,
		},
		[-317922106] = {
			sex = 0,
			model = "s_m_m_migrant_01",
			hash = -317922106,
		},
		[1684083350] = {
			sex = 0,
			model = "s_m_m_movalien_01",
			hash = 1684083350,
		},
		[-664900312] = {
			sex = 0,
			model = "s_m_m_movprem_01",
			hash = -664900312,
		},
		[-407694286] = {
			sex = 0,
			model = "s_m_m_movspace_01",
			hash = -407694286,
		},
		[-1286380898] = {
			sex = 0,
			model = "s_m_m_paramedic_01",
			hash = -1286380898,
		},
		[-413447396] = {
			sex = 0,
			model = "s_m_m_pilot_01",
			hash = -413447396,
		},
		[-163714847] = {
			sex = 0,
			model = "s_m_m_pilot_02",
			hash = -163714847,
		},
		[1650036788] = {
			sex = 0,
			model = "s_m_m_postal_01",
			hash = 1650036788,
		},
		[1936142927] = {
			sex = 0,
			model = "s_m_m_postal_02",
			hash = 1936142927,
		},
		[1456041926] = {
			sex = 0,
			model = "s_m_m_prisguard_01",
			hash = 1456041926,
		},
		[1092080539] = {
			sex = 0,
			model = "s_m_m_scientist_01",
			hash = 1092080539,
		},
		[-681004504] = {
			sex = 0,
			model = "s_m_m_security_01",
			hash = -681004504,
		},
		[451459928] = {
			sex = 0,
			model = "s_m_m_snowcop_01",
			hash = 451459928,
		},
		[2035992488] = {
			sex = 0,
			model = "s_m_m_strperf_01",
			hash = 2035992488,
		},
		[469792763] = {
			sex = 0,
			model = "s_m_m_strpreach_01",
			hash = 469792763,
		},
		[-829353047] = {
			sex = 0,
			model = "s_m_m_strvend_01",
			hash = -829353047,
		},
		[1498487404] = {
			sex = 0,
			model = "s_m_m_trucker_01",
			hash = 1498487404,
		},
		[-1614577886] = {
			sex = 0,
			model = "s_m_m_ups_01",
			hash = -1614577886,
		},
		[-792862442] = {
			sex = 0,
			model = "s_m_m_ups_02",
			hash = -792862442,
		},
		[-1382092357] = {
			sex = 0,
			model = "s_m_o_busker_01",
			hash = -1382092357,
		},
		[1644266841] = {
			sex = 0,
			model = "s_m_y_airworker",
			hash = 1644266841,
		},
		[-1643617475] = {
			sex = 0,
			model = "s_m_y_ammucity_01",
			hash = -1643617475,
		},
		[1657546978] = {
			sex = 0,
			model = "s_m_y_armymech_01",
			hash = 1657546978,
		},
		[-1306051250] = {
			sex = 0,
			model = "s_m_y_autopsy_01",
			hash = -1306051250,
		},
		[-442429178] = {
			sex = 0,
			model = "s_m_y_barman_01",
			hash = -442429178,
		},
		[189425762] = {
			sex = 0,
			model = "s_m_y_baywatch_01",
			hash = 189425762,
		},
		[-1275859404] = {
			sex = 0,
			model = "s_m_y_blackops_01",
			hash = -1275859404,
		},
		[2047212121] = {
			sex = 0,
			model = "s_m_y_blackops_02",
			hash = 2047212121,
		},
		[1349953339] = {
			sex = 0,
			model = "s_m_y_blackops_03",
			hash = 1349953339,
		},
		[-654717625] = {
			sex = 0,
			model = "s_m_y_busboy_01",
			hash = -654717625,
		},
		[261586155] = {
			sex = 0,
			model = "s_m_y_chef_01",
			hash = 261586155,
		},
		[71929310] = {
			sex = 0,
			model = "s_m_y_clown_01",
			hash = 71929310,
		},
		[1299424319] = {
			sex = 0,
			model = "s_m_y_clubbar_01",
			hash = 1299424319,
		},
		[-673538407] = {
			sex = 0,
			model = "s_m_y_construct_01",
			hash = -673538407,
		},
		[-973145378] = {
			sex = 0,
			model = "s_m_y_construct_02",
			hash = -973145378,
		},
		[1581098148] = {
			sex = 0,
			model = "s_m_y_cop_01",
			hash = 1581098148,
		},
		[-459818001] = {
			sex = 0,
			model = "s_m_y_dealer_01",
			hash = -459818001,
		},
		[-1688898956] = {
			sex = 0,
			model = "s_m_y_devinsec_01",
			hash = -1688898956,
		},
		[-2039072303] = {
			sex = 0,
			model = "s_m_y_dockwork_01",
			hash = -2039072303,
		},
		[579932932] = {
			sex = 0,
			model = "s_m_y_doorman_01",
			hash = 579932932,
		},
		[1976765073] = {
			sex = 0,
			model = "s_m_y_dwservice_01",
			hash = 1976765073,
		},
		[-175076858] = {
			sex = 0,
			model = "s_m_y_dwservice_02",
			hash = -175076858,
		},
		[1097048408] = {
			sex = 0,
			model = "s_m_y_factory_01",
			hash = 1097048408,
		},
		[-1229853272] = {
			sex = 0,
			model = "s_m_y_fireman_01",
			hash = -1229853272,
		},
		[-294281201] = {
			sex = 0,
			model = "s_m_y_garbage",
			hash = -294281201,
		},
		[815693290] = {
			sex = 0,
			model = "s_m_y_grip_01",
			hash = 815693290,
		},
		[1939545845] = {
			sex = 0,
			model = "s_m_y_hwaycop_01",
			hash = 1939545845,
		},
		[1702441027] = {
			sex = 0,
			model = "s_m_y_marine_01",
			hash = 1702441027,
		},
		[1490458366] = {
			sex = 0,
			model = "s_m_y_marine_02",
			hash = 1490458366,
		},
		[1925237458] = {
			sex = 0,
			model = "s_m_y_marine_03",
			hash = 1925237458,
		},
		[1021093698] = {
			sex = 0,
			model = "s_m_y_mime",
			hash = 1021093698,
		},
		[1209091352] = {
			sex = 0,
			model = "s_m_y_pestcont_01",
			hash = 1209091352,
		},
		[-1422914553] = {
			sex = 0,
			model = "s_m_y_pilot_01",
			hash = -1422914553,
		},
		[1596003233] = {
			sex = 0,
			model = "s_m_y_prismuscl_01",
			hash = 1596003233,
		},
		[-1313105063] = {
			sex = 0,
			model = "s_m_y_prisoner_01",
			hash = -1313105063,
		},
		[-277793362] = {
			sex = 0,
			model = "s_m_y_ranger_01",
			hash = -277793362,
		},
		[-1067576423] = {
			sex = 0,
			model = "s_m_y_robber_01",
			hash = -1067576423,
		},
		[-1320879687] = {
			sex = 0,
			model = "s_m_y_sheriff_01",
			hash = -1320879687,
		},
		[1846684678] = {
			sex = 0,
			model = "s_m_y_shop_mask",
			hash = 1846684678,
		},
		[-1837161693] = {
			sex = 0,
			model = "s_m_y_strvend_01",
			hash = -1837161693,
		},
		[-1920001264] = {
			sex = 0,
			model = "s_m_y_swat_01",
			hash = -1920001264,
		},
		[-905948951] = {
			sex = 0,
			model = "s_m_y_uscg_01",
			hash = -905948951,
		},
		[999748158] = {
			sex = 0,
			model = "s_m_y_valet_01",
			hash = 999748158,
		},
		[-1387498932] = {
			sex = 0,
			model = "s_m_y_waiter_01",
			hash = -1387498932,
		},
		[1221043248] = {
			sex = 0,
			model = "s_m_y_waretech_01",
			hash = 1221043248,
		},
		[1426951581] = {
			sex = 0,
			model = "s_m_y_winclean_01",
			hash = 1426951581,
		},
		[1142162924] = {
			sex = 0,
			model = "s_m_y_xmech_01",
			hash = 1142162924,
		},
		[-1105135100] = {
			sex = 0,
			model = "s_m_y_xmech_02",
			hash = -1105135100,
		},
		[337826907] = {
			sex = 0,
			model = "s_m_y_casino_01",
			hash = 337826907,
		},
		[-1575488699] = {
			sex = 0,
			model = "s_m_y_westsec_01",
			hash = -1575488699,
		},
		[994527967] = {
			sex = 0,
			model = "hc_driver",
			hash = 994527967,
		},
		[193469166] = {
			sex = 0,
			model = "hc_gunman",
			hash = 193469166,
		},
		[-1715797768] = {
			sex = 0,
			model = "hc_hacker",
			hash = -1715797768,
		},
		[610988552] = {
			sex = 0,
			model = "ig_agent",
			hash = 610988552,
		},
		[1206185632] = {
			sex = 0,
			model = "ig_andreas",
			hash = 1206185632,
		},
		[-52268862] = {
			sex = 0,
			model = "ig_avon",
			hash = -52268862,
		},
		[-1492432238] = {
			sex = 0,
			model = "ig_ballasog",
			hash = -1492432238,
		},
		[-1868718465] = {
			sex = 0,
			model = "ig_bankman",
			hash = -1868718465,
		},
		[797459875] = {
			sex = 0,
			model = "ig_barry",
			hash = 797459875,
		},
		[-994634286] = {
			sex = 0,
			model = "ig_benny",
			hash = -994634286,
		},
		[1464257942] = {
			sex = 0,
			model = "ig_bestmen",
			hash = 1464257942,
		},
		[-1113448868] = {
			sex = 0,
			model = "ig_beverly",
			hash = -1113448868,
		},
		[-1111799518] = {
			sex = 0,
			model = "ig_brad",
			hash = -1111799518,
		},
		[-2063996617] = {
			sex = 0,
			model = "ig_car3guy1",
			hash = -2063996617,
		},
		[1975732938] = {
			sex = 0,
			model = "ig_car3guy2",
			hash = 1975732938,
		},
		[-520477356] = {
			sex = 0,
			model = "ig_casey",
			hash = -520477356,
		},
		[1240128502] = {
			sex = 0,
			model = "ig_chef",
			hash = 1240128502,
		},
		[-2054645053] = {
			sex = 0,
			model = "ig_chef2",
			hash = -2054645053,
		},
		[-1427838341] = {
			sex = 0,
			model = "ig_chengsr",
			hash = -1427838341,
		},
		[678319271] = {
			sex = 0,
			model = "ig_chrisformage",
			hash = 678319271,
		},
		[1825562762] = {
			sex = 0,
			model = "ig_clay",
			hash = 1825562762,
		},
		[-1660909656] = {
			sex = 0,
			model = "ig_claypain",
			hash = -1660909656,
		},
		[-429715051] = {
			sex = 0,
			model = "ig_cletus",
			hash = -429715051,
		},
		[1182012905] = {
			sex = 0,
			model = "ig_dale",
			hash = 1182012905,
		},
		[365775923] = {
			sex = 0,
			model = "ig_davenorton",
			hash = 365775923,
		},
		[1952555184] = {
			sex = 0,
			model = "ig_devin",
			hash = 1952555184,
		},
		[-86969715] = {
			sex = 0,
			model = "ig_dix",
			hash = -86969715,
		},
		[914073350] = {
			sex = 0,
			model = "ig_djblamrupert",
			hash = 914073350,
		},
		[-1237168065] = {
			sex = 0,
			model = "ig_djblamryans",
			hash = -1237168065,
		},
		[-73600578] = {
			sex = 0,
			model = "ig_djdixmanager",
			hash = -73600578,
		},
		[-1714117555] = {
			sex = 0,
			model = "ig_djgeneric_01",
			hash = -1714117555,
		},
		[1241432569] = {
			sex = 0,
			model = "ig_djsolfotios",
			hash = 1241432569,
		},
		[-1808665269] = {
			sex = 0,
			model = "ig_djsoljakob",
			hash = -1808665269,
		},
		[2123514453] = {
			sex = 0,
			model = "ig_djsolmanager",
			hash = 2123514453,
		},
		[795497466] = {
			sex = 0,
			model = "ig_djsolmike",
			hash = 795497466,
		},
		[1194880004] = {
			sex = 0,
			model = "ig_djsolrobt",
			hash = 1194880004,
		},
		[-1507505719] = {
			sex = 0,
			model = "ig_djtalignazio",
			hash = -1507505719,
		},
		[-1674727288] = {
			sex = 0,
			model = "ig_dom",
			hash = -1674727288,
		},
		[-628553422] = {
			sex = 0,
			model = "ig_dreyfuss",
			hash = -628553422,
		},
		[-872673803] = {
			sex = 0,
			model = "ig_drfriedlander",
			hash = -872673803,
		},
		[205318924] = {
			sex = 0,
			model = "ig_englishdave",
			hash = 205318924,
		},
		[-795819184] = {
			sex = 0,
			model = "ig_fabien",
			hash = -795819184,
		},
		[988062523] = {
			sex = 0,
			model = "ig_fbisuit_01",
			hash = 988062523,
		},
		[-1313761614] = {
			sex = 0,
			model = "ig_floyd",
			hash = -1313761614,
		},
		[-2078561997] = {
			sex = 0,
			model = "ig_g",
			hash = -2078561997,
		},
		[-20018299] = {
			sex = 0,
			model = "ig_groom",
			hash = -20018299,
		},
		[1704428387] = {
			sex = 0,
			model = "ig_hao",
			hash = 1704428387,
		},
		[-837606178] = {
			sex = 0,
			model = "ig_hunter",
			hash = -837606178,
		},
		[2050158196] = {
			sex = 0,
			model = "ig_jay_norris",
			hash = 2050158196,
		},
		[-308279251] = {
			sex = 0,
			model = "ig_jimmyboston",
			hash = -308279251,
		},
		[1135976220] = {
			sex = 0,
			model = "ig_jimmyboston_02",
			hash = 1135976220,
		},
		[1459905209] = {
			sex = 0,
			model = "ig_jimmydisanto",
			hash = 1459905209,
		},
		[-1105179493] = {
			sex = 0,
			model = "ig_joeminuteman",
			hash = -1105179493,
		},
		[-2016771922] = {
			sex = 0,
			model = "ig_johnnyklebitz",
			hash = -2016771922,
		},
		[-518348876] = {
			sex = 0,
			model = "ig_josef",
			hash = -518348876,
		},
		[2040438510] = {
			sex = 0,
			model = "ig_josh",
			hash = 2040438510,
		},
		[1706635382] = {
			sex = 0,
			model = "ig_lamardavis",
			hash = 1706635382,
		},
		[-538688539] = {
			sex = 0,
			model = "ig_lazlow",
			hash = -538688539,
		},
		[-2063317268] = {
			sex = 0,
			model = "ig_lazlow_2",
			hash = -2063317268,
		},
		[1302784073] = {
			sex = 0,
			model = "ig_lestercrest",
			hash = 1302784073,
		},
		[1849883942] = {
			sex = 0,
			model = "ig_lestercrest_2",
			hash = 1849883942,
		},
		[1401530684] = {
			sex = 0,
			model = "ig_lifeinvad_01",
			hash = 1401530684,
		},
		[666718676] = {
			sex = 0,
			model = "ig_lifeinvad_02",
			hash = 666718676,
		},
		[-239294183] = {
			sex = 0,
			model = "ig_malc",
			hash = -239294183,
		},
		[-46035440] = {
			sex = 0,
			model = "ig_manuel",
			hash = -46035440,
		},
		[-886023758] = {
			sex = 0,
			model = "ig_milton",
			hash = -886023758,
		},
		[939183526] = {
			sex = 0,
			model = "ig_money",
			hash = 939183526,
		},
		[-67533719] = {
			sex = 0,
			model = "ig_mp_agent14",
			hash = -67533719,
		},
		[-304305299] = {
			sex = 0,
			model = "ig_mrk",
			hash = -304305299,
		},
		[-1124046095] = {
			sex = 0,
			model = "ig_nervousron",
			hash = -1124046095,
		},
		[-927525251] = {
			sex = 0,
			model = "ig_nigel",
			hash = -927525251,
		},
		[1906124788] = {
			sex = 0,
			model = "ig_old_man1a",
			hash = 1906124788,
		},
		[-283816889] = {
			sex = 0,
			model = "ig_old_man2",
			hash = -283816889,
		},
		[1625728984] = {
			sex = 0,
			model = "ig_omega",
			hash = 1625728984,
		},
		[768005095] = {
			sex = 0,
			model = "ig_oneil",
			hash = 768005095,
		},
		[1641334641] = {
			sex = 0,
			model = "ig_orleans",
			hash = 1641334641,
		},
		[648372919] = {
			sex = 0,
			model = "ig_ortega",
			hash = 648372919,
		},
		[-1717894970] = {
			sex = 0,
			model = "ig_paper",
			hash = -1717894970,
		},
		[645279998] = {
			sex = 0,
			model = "ig_popov",
			hash = 645279998,
		},
		[1681385341] = {
			sex = 0,
			model = "ig_priest",
			hash = 1681385341,
		},
		[666086773] = {
			sex = 0,
			model = "ig_prolsec_02",
			hash = 666086773,
		},
		[-449965460] = {
			sex = 0,
			model = "ig_ramp_gang",
			hash = -449965460,
		},
		[1165307954] = {
			sex = 0,
			model = "ig_ramp_hic",
			hash = 1165307954,
		},
		[-554721426] = {
			sex = 0,
			model = "ig_ramp_hipster",
			hash = -554721426,
		},
		[-424905564] = {
			sex = 0,
			model = "ig_ramp_mex",
			hash = -424905564,
		},
		[940330470] = {
			sex = 0,
			model = "ig_rashcosvki",
			hash = 940330470,
		},
		[-709209345] = {
			sex = 0,
			model = "ig_roccopelosi",
			hash = -709209345,
		},
		[1024089777] = {
			sex = 0,
			model = "ig_russiandrunk",
			hash = 1024089777,
		},
		[1476581877] = {
			sex = 0,
			model = "ig_sacha",
			hash = 1476581877,
		},
		[1283141381] = {
			sex = 0,
			model = "ig_siemonyetarian",
			hash = 1283141381,
		},
		[-508849828] = {
			sex = 0,
			model = "ig_sol",
			hash = -508849828,
		},
		[-2034368986] = {
			sex = 0,
			model = "ig_solomon",
			hash = -2034368986,
		},
		[941695432] = {
			sex = 0,
			model = "ig_stevehains",
			hash = 941695432,
		},
		[915948376] = {
			sex = 0,
			model = "ig_stretch",
			hash = 915948376,
		},
		[-466345309] = {
			sex = 0,
			model = "ig_talcc",
			hash = -466345309,
		},
		[1182156569] = {
			sex = 0,
			model = "ig_talmm",
			hash = 1182156569,
		},
		[-597926235] = {
			sex = 0,
			model = "ig_taocheng",
			hash = -597926235,
		},
		[2089096292] = {
			sex = 0,
			model = "ig_taostranslator",
			hash = 2089096292,
		},
		[-1573167273] = {
			sex = 0,
			model = "ig_tenniscoach",
			hash = -1573167273,
		},
		[1728056212] = {
			sex = 0,
			model = "ig_terry",
			hash = 1728056212,
		},
		[-847807830] = {
			sex = 0,
			model = "ig_tomepsilon",
			hash = -847807830,
		},
		[761829301] = {
			sex = 0,
			model = "ig_tonyprince",
			hash = 761829301,
		},
		[1461287021] = {
			sex = 0,
			model = "ig_trafficwarden",
			hash = 1461287021,
		},
		[1382414087] = {
			sex = 0,
			model = "ig_tylerdix",
			hash = 1382414087,
		},
		[1511543927] = {
			sex = 0,
			model = "ig_tylerdix_02",
			hash = 1511543927,
		},
		[-100858228] = {
			sex = 0,
			model = "ig_vagspeak",
			hash = -100858228,
		},
		[-1835459726] = {
			sex = 0,
			model = "ig_wade",
			hash = -1835459726,
		},
		[188012277] = {
			sex = 0,
			model = "ig_zimbor",
			hash = 188012277,
		},
		[-1692214353] = {
			sex = 0,
			model = "player_one",
			hash = -1692214353,
		},
		[-1686040670] = {
			sex = 0,
			model = "player_two",
			hash = -1686040670,
		},
		[225514697] = {
			sex = 0,
			model = "player_zero",
			hash = 225514697,
		},
		[-1206698129] = {
			sex = 0,
			model = "ig_avery",
			hash = -1206698129,
		},
		[-401698464] = {
			sex = 0,
			model = "ig_brucie2",
			hash = -401698464,
		},
		[-1812018217] = {
			sex = 0,
			model = "ig_thornton",
			hash = -1812018217,
		},
		[55858852] = {
			sex = 0,
			model = "ig_tomcasino",
			hash = 55858852,
		},
		[736659122] = {
			sex = 0,
			model = "ig_vincent",
			hash = 736659122,
		},
		[-252946718] = {
			sex = 0,
			model = "u_m_m_aldinapoli",
			hash = -252946718,
		},
		[-1022961931] = {
			sex = 0,
			model = "u_m_m_bankman",
			hash = -1022961931,
		},
		[1984382277] = {
			sex = 0,
			model = "u_m_m_bikehire_01",
			hash = 1984382277,
		},
		[1646160893] = {
			sex = 0,
			model = "u_m_m_doa_01",
			hash = 1646160893,
		},
		[712602007] = {
			sex = 0,
			model = "u_m_m_edtoh",
			hash = 712602007,
		},
		[874722259] = {
			sex = 0,
			model = "u_m_m_fibarchitect",
			hash = 874722259,
		},
		[728636342] = {
			sex = 0,
			model = "u_m_m_filmdirector",
			hash = 728636342,
		},
		[1169888870] = {
			sex = 0,
			model = "u_m_m_glenstank_01",
			hash = 1169888870,
		},
		[-1001079621] = {
			sex = 0,
			model = "u_m_m_griff_01",
			hash = -1001079621,
		},
		[-835930287] = {
			sex = 0,
			model = "u_m_m_jesus_01",
			hash = -835930287,
		},
		[-1395868234] = {
			sex = 0,
			model = "u_m_m_jewelsec_01",
			hash = -1395868234,
		},
		[-422822692] = {
			sex = 0,
			model = "u_m_m_jewelthief",
			hash = -422822692,
		},
		[479578891] = {
			sex = 0,
			model = "u_m_m_markfost",
			hash = 479578891,
		},
		[-2114499097] = {
			sex = 0,
			model = "u_m_m_partytarget",
			hash = -2114499097,
		},
		[1888624839] = {
			sex = 0,
			model = "u_m_m_prolsec_01",
			hash = 1888624839,
		},
		[-829029621] = {
			sex = 0,
			model = "u_m_m_promourn_01",
			hash = -829029621,
		},
		[1624626906] = {
			sex = 0,
			model = "u_m_m_rivalpap",
			hash = 1624626906,
		},
		[-1408326184] = {
			sex = 0,
			model = "u_m_m_spyactor",
			hash = -1408326184,
		},
		[1813637474] = {
			sex = 0,
			model = "u_m_m_streetart_01",
			hash = 1813637474,
		},
		[-1871275377] = {
			sex = 0,
			model = "u_m_m_willyfist",
			hash = -1871275377,
		},
		[732742363] = {
			sex = 0,
			model = "u_m_o_filmnoir",
			hash = 732742363,
		},
		[1189322339] = {
			sex = 0,
			model = "u_m_o_finguru_01",
			hash = 1189322339,
		},
		[-1709285806] = {
			sex = 0,
			model = "u_m_o_taphillbilly",
			hash = -1709285806,
		},
		[1787764635] = {
			sex = 0,
			model = "u_m_o_tramp_01",
			hash = 1787764635,
		},
		[-257153498] = {
			sex = 0,
			model = "u_m_y_abner",
			hash = -257153498,
		},
		[-815646164] = {
			sex = 0,
			model = "u_m_y_antonb",
			hash = -815646164,
		},
		[-636391810] = {
			sex = 0,
			model = "u_m_y_babyd",
			hash = -636391810,
		},
		[1380197501] = {
			sex = 0,
			model = "u_m_y_baygor",
			hash = 1380197501,
		},
		[-1954728090] = {
			sex = 0,
			model = "u_m_y_burgerdrug_01",
			hash = -1954728090,
		},
		[610290475] = {
			sex = 0,
			model = "u_m_y_chip",
			hash = 610290475,
		},
		[-1799184321] = {
			sex = 0,
			model = "u_m_y_corpse_01",
			hash = -1799184321,
		},
		[755956971] = {
			sex = 0,
			model = "u_m_y_cyclist_01",
			hash = 755956971,
		},
		[1443057394] = {
			sex = 0,
			model = "u_m_y_danceburl_01",
			hash = 1443057394,
		},
		[-92584602] = {
			sex = 0,
			model = "u_m_y_dancelthr_01",
			hash = -92584602,
		},
		[2145639711] = {
			sex = 0,
			model = "u_m_y_dancerave_01",
			hash = 2145639711,
		},
		[-2051422616] = {
			sex = 0,
			model = "u_m_y_fibmugger_01",
			hash = -2051422616,
		},
		[-961242577] = {
			sex = 0,
			model = "u_m_y_guido_01",
			hash = -961242577,
		},
		[-1289578670] = {
			sex = 0,
			model = "u_m_y_gunvend_01",
			hash = -1289578670,
		},
		[-264140789] = {
			sex = 0,
			model = "u_m_y_hippie_01",
			hash = -264140789,
		},
		[880829941] = {
			sex = 0,
			model = "u_m_y_imporage",
			hash = 880829941,
		},
		[-1863364300] = {
			sex = 0,
			model = "u_m_y_juggernaut_01",
			hash = -1863364300,
		},
		[2109968527] = {
			sex = 0,
			model = "u_m_y_justin",
			hash = 2109968527,
		},
		[-927261102] = {
			sex = 0,
			model = "u_m_y_mani",
			hash = -927261102,
		},
		[1191548746] = {
			sex = 0,
			model = "u_m_y_militarybum",
			hash = 1191548746,
		},
		[1346941736] = {
			sex = 0,
			model = "u_m_y_paparazzi",
			hash = 1346941736,
		},
		[921110016] = {
			sex = 0,
			model = "u_m_y_party_01",
			hash = 921110016,
		},
		[-598109171] = {
			sex = 0,
			model = "u_m_y_pogo_01",
			hash = -598109171,
		},
		[2073775040] = {
			sex = 0,
			model = "u_m_y_prisoner_01",
			hash = 2073775040,
		},
		[-2057423197] = {
			sex = 0,
			model = "u_m_y_proldriver_01",
			hash = -2057423197,
		},
		[1011059922] = {
			sex = 0,
			model = "u_m_y_rsranger_01",
			hash = 1011059922,
		},
		[1794381917] = {
			sex = 0,
			model = "u_m_y_sbike",
			hash = 1794381917,
		},
		[-848871003] = {
			sex = 0,
			model = "u_m_y_smugmech_01",
			hash = -848871003,
		},
		[-1852518909] = {
			sex = 0,
			model = "u_m_y_staggrm_01",
			hash = -1852518909,
		},
		[-1800524916] = {
			sex = 0,
			model = "u_m_y_tattoo_01",
			hash = -1800524916,
		},
		[-1404353274] = {
			sex = 0,
			model = "u_m_y_zombie_01",
			hash = -1404353274,
		},
		[-1751606120] = {
			sex = 0,
			model = "u_m_m_blane",
			hash = -1751606120,
		},
		[-133862795] = {
			sex = 0,
			model = "u_m_m_curtis",
			hash = -133862795,
		},
		[-1767998346] = {
			sex = 0,
			model = "u_m_m_vince",
			hash = -1767998346,
		},
		[-106226549] = {
			sex = 0,
			model = "u_m_o_dean",
			hash = -106226549,
		},
		[-144649940] = {
			sex = 0,
			model = "u_m_y_caleb",
			hash = -144649940,
		},
		[-100858228] = {
			sex = 0,
			model = "ig_vagspeak",
			hash = -100858228,
		},
		[1278330017] = {
			sex = 0,
			model = "u_m_y_gabriel",
			hash = 1278330017,
		},
		[-76805225] = {
			sex = 0,
			model = "u_m_y_ushi",
			hash = -76805225,
		},
	}

	exports("getFemaleModels", function()
		local femaleModels = {}
		for hash, tbl in pairs(models) do
			if not tbl.sex then
				table.insert(femaleModels, tbl.model)
			end
		end
		return femaleModels
	end)

	exports("getMaleModels", function()
		local maleModels = {}
		for hash, tbl in pairs(models) do
			if tbl.sex then
				table.insert(maleModels, tbl.model)
			end
		end
		return maleModels
	end)

	exports("getModels", function()
		return models
	end)

	exports("getModelFromHash", function(hash)
		return models[hash].model
	end)

	exports("getSexFromModel", function(model)
		return models[GetHashKey(model)].sex
	end)
	
end