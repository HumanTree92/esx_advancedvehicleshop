USE `es_extended`;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('aircraft','Aircraft License'),
	('boating','Boating License')
;

CREATE TABLE `owned_vehicles` (
	`owner` varchar(40) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`vehicle` longtext,
	`type` VARCHAR(20) NOT NULL DEFAULT 'car',
	`job` VARCHAR(20) NOT NULL DEFAULT 'civ',
	`category` VARCHAR(50) DEFAULT NULL,
	`name` varchar(60) NOT NULL DEFAULT 'Unknown',
	`fuel` int(11) NOT NULL DEFAULT '100',
	`stored` TINYINT(1) NOT NULL DEFAULT '0',

	PRIMARY KEY (`plate`)
);

CREATE TABLE `vs_ambulance_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_ambulance_categories` (name, label) VALUES
	('ambulance','Jr. EMT'),
	('doctor','EMT'),
	('chief_doctor','Sr. EMT'),
	('boss','EMT Supervisor')
;

CREATE TABLE `vs_ambulance` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `vs_ambulance` (id, name, model, price, category) VALUES
	(1,'Ambulance','ambulance',500,'ambulance'),
	(2,'Fire Truck','firetruk',750,'ambulance'),
	(3,'Ambulance','ambulance',500,'doctor'),
	(4,'Fire Truck','firetruk',750,'doctor'),
	(5,'Ambulance','ambulance',500,'chief_doctor'),
	(6,'Fire Truck','firetruk',750,'chief_doctor'),
	(7,'Ambulance','ambulance',500,'boss'),
	(8,'Fire Truck','firetruk',750,'boss')
;

CREATE TABLE `vs_police_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_police_categories` (name, label) VALUES
	('recruit','Recruit'),
	('officer','Officer'),
	('sergeant','Sergeant'),
	('lieutenant','Lieutenant'),
	('boss','Chief')
;

CREATE TABLE `vs_police` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `vs_police` (id, name, model, price, category) VALUES
	(1,'Police Cruiser','police',500,'recruit'),
	(2,'Police Cruiser','police2',750,'recruit'),
	(3,'Police Cruiser','police',500,'officer'),
	(4,'Police Cruiser','police2',750,'officer'),
	(5,'Police Cruiser','police',500,'sergeant'),
	(6,'Police Cruiser','police2',750,'sergeant'),
	(7,'Police Cruiser','police',500,'lieutenant'),
	(8,'Police Cruiser','police2',750,'lieutenant'),
	(9,'Police Cruiser','police',500,'boss'),
	(10,'Police Cruiser','police2',750,'boss')
;

CREATE TABLE `vs_division_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_division_categories` (name, label) VALUES
	('aviation','Aviation')
;

CREATE TABLE `vs_divisions` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `vs_divisions` (id, name, model, price, category) VALUES
	(1,'Maverick','polmav',1000,'aviation')
;

CREATE TABLE `vs_mecano_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_mecano_categories` (name, label) VALUES
	('recrue','Recruit'),
	('novice','Novice'),
	('experimente','Experienced'),
	('chief','Chief'),
	('boss','Boss')
;

CREATE TABLE `vs_mecano` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `vs_mecano` (id, name, model, price, category) VALUES
	(1,'Flatbed','flatbed',500,'recrue'),
	(2,'Tow Truck','towtruck2',750,'recrue'),
	(3,'Flatbed','flatbed',500,'novice'),
	(4,'Tow Truck','towtruck2',750,'novice'),
	(5,'Flatbed','flatbed',500,'experimente'),
	(6,'Tow Truck','towtruck2',750,'experimente'),
	(7,'Flatbed','flatbed',500,'chief'),
	(8,'Tow Truck','towtruck2',750,'chief'),
	(9,'Flatbed','flatbed',500,'boss'),
	(10,'Tow Truck','towtruck2',750,'boss')
;

CREATE TABLE `vs_aircraft_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_aircraft_categories` (name, label) VALUES
	('helis','Helicopters'),
	('planes','Planes')
;

CREATE TABLE `vs_aircrafts` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `vs_aircrafts` (name, model, price, category) VALUES
	('Buzzard','buzzard2',500000,'helis'),
	('Frogger','frogger',750000,'helis'),
	('Havok','havok',250000,'helis'),
	('Maverick','maverick',625000,'helis'),
	('Sea Sparrow','seasparrow',375000,'helis'),
	('SuperVolito','supervolito',875000,'helis'),
	('SuperVolito Carbon','supervolito2',875000,'helis'),
	('Swift','swift',875000,'helis'),
	('Swift Deluxe','swift2',875000,'helis'),
	('Volatus','volatus',875000,'helis'),
	('Alpha Z1','alphaz1',450000,'planes'),
	('Besra','besra',500000,'planes'),
	('Cuban 800','cuban800',200000,'planes'),
	('Dodo','dodo',350000,'planes'),
	('Duster','duster',100000,'planes'),
	('Howard NX25','howard',450000,'planes'),
	('Luxor','luxor',700000,'planes'),
	('Luxor Deluxe','luxor2',750000,'planes'),
	('Mammatus','mammatus',250000,'planes'),
	('Ultra Light','microlight',50000,'planes'),
	('Nimbus','nimbus',600000,'planes'),
	('Rogue','rogue',450000,'planes'),
	('Sea Breeze','seabreeze',400000,'planes'),
	('Shamal','shamal',650000,'planes'),
	('Mallard','stunt',150000,'planes'),
	('Velum','velum',300000,'planes'),
	('Velum 5-Seater','velum2',300000,'planes'),
	('Vestra','vestra',500000,'planes')
;

CREATE TABLE `vs_boat_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_boat_categories` (name, label) VALUES
	('boats','Boats'),
	('subs','Submersibles')
;

CREATE TABLE `vs_boats` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `vs_boats` (name, model, price, category) VALUES
	('Dinghy 1','dinghy',15000,'boats'),
	('Dinghy 2','dinghy2',15000,'boats'),
	('Dinghy 3','dinghy3',15000,'boats'),
	('Dinghy 4','dinghy4',15000,'boats'),
	('Jetmax','jetmax',22500,'boats'),
	('Marquis','marquis',37500,'boats'),
	('Longfin','longfin',40000,'boats'),
	('Seashark','seashark',8000,'boats'),
	('Seashark 3','seashark3',8000,'boats'),
	('Speeder','speeder',35000,'boats'),
	('Speeder 2','speeder2',35000,'boats'),
	('Squalo','squalo',25000,'boats'),
	('Suntrap','suntrap',27500,'boats'),
	('Toro','toro',30000,'boats'),
	('Toro 2','toro2',32500,'boats'),
	('Tropic','tropic',20000,'boats'),
	('Tropic 2','tropic2',20000,'boats'),
	('Avisa','avisa',35000,'subs'),
	('Kraken','submersible2',32500,'subs'),
	('Submarine','submersible',30000,'subs')
;

CREATE TABLE `vs_car_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_car_categories` (name, label) VALUES
	('cycles','Cycles'),
	('compacts','Compacts'),
	('coupes','Coupes'),
	('motorcycles','Motorcycles'),
	('muscles','Muscles'),
	('offroads','Off-Roads'),
	('sedans','Sedans'),
	('sports','Sports'),
	('sportsclassics','Sports Classics'),
	('supers','Supers'),
	('suvs','SUVs'),
	('vans','Vans')
;

CREATE TABLE `vs_cars` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `vs_cars` (name, model, price, category) VALUES
	('Asbo','asbo',15000,'compacts'),
	('Blista','blista',15000,'compacts'),
	('Brioso R/A','brioso',17500,'compacts'),
	('Brioso 300','brioso2',12500,'compacts'),
	('Club','club',12500,'compacts'),
	('Dilettante','dilettante',15000,'compacts'),
	('Issi','issi2',15000,'compacts'),
	('Issi Classic','issi3',12500,'compacts'),
	('Kanjo Blista','kanjo',15000,'compacts'),
	('Panto','panto',15000,'compacts'),
	('Prairie','prairie',15000,'compacts'),
	('Rhapsody','rhapsody',12500,'compacts'),
	('WeEvil','weevil',12500,'compacts'),
	('Asea','asea',15000,'sedans'),
	('Asterope','asterope',15000,'sedans'),
	('Cognoscenti 55','cog55',50000,'sedans'),
	('Cognoscenti 55 Armored','cog552',75000,'sedans'),
	('Cognoscenti','cognoscenti',50000,'sedans'),
	('Cognoscenti Armored','cognoscenti2',75000,'sedans'),
	('Emperor','emperor',12500,'sedans'),
	('Emperor 2','emperor2',10000,'sedans'),
	('Fugitive','fugitive',15000,'sedans'),
	('Glendale','glendale',12500,'sedans'),
	('Glendale Custom','glendale2',15000,'sedans'),
	('Ingot','ingot',12500,'sedans'),
	('Intruder','intruder',15000,'sedans'),
	('Premier','premier',15000,'sedans'),
	('Primo','primo',12500,'sedans'),
	('Primo Custom','primo2',15000,'sedans'),
	('Regina','regina',12500,'sedans'),
	('Romero Hearse','romero',15000,'sedans'),
	('Schafter','schafter2',15000,'sedans'),
	('Schafter V12 Armored','schafter5',40000,'sedans'),
	('Schafter LWB Armored','schafter6',40000,'sedans'),
	('Stafford','stafford',25000,'sedans'),
	('Stanier','stanier',12500,'sedans'),
	('Stratum','stratum',12500,'sedans'),
	('Stretch','stretch',50000,'sedans'),
	('Super Diamond','superd',50000,'sedans'),
	('Surge','surge',15000,'sedans'),
	('Tailgater','tailgater',15000,'sedans'),
	('Warrener','warrener',12500,'sedans'),
	('Washington','washington',12500,'sedans'),
	('Baller','baller',22500,'suvs'),
	('Baller 2','baller2',25000,'suvs'),
	('Baller LE','baller3',25000,'suvs'),
	('Baller LE LWB','baller4',25000,'suvs'),
	('Baller LE Armored','baller5',50000,'suvs'),
	('Baller LE LWB Armored','baller6',50000,'suvs'),
	('BeeJay XL','bjxl',22500,'suvs'),
	('Cavalcade','cavalcade',22500,'suvs'),
	('Cavalcade 2','cavalcade2',25000,'suvs'),
	('Contender','contender',45000,'suvs'),
	('Dubsta','dubsta',45000,'suvs'),
	('Dubsta Luxuary','dubsta2',45000,'suvs'),
	('Fhantom','fq2',22500,'suvs'),
	('Grabger','granger',22500,'suvs'),
	('Gresley','gresley',25000,'suvs'),
	('Habanero','habanero',22500,'suvs'),
	('Huntley S','huntley',25000,'suvs'),
	('Landstalker','landstalker',22500,'suvs'),
	('Landstalker XL','landstalker2',25000,'suvs'),
	('Mesa','mesa',22500,'suvs'),
	('Novak','novak',25000,'suvs'),
	('Patriot','patriot',25000,'suvs'),
	('Patriot Stretch','patriot2',45000,'suvs'),
	('Radius','radi',22500,'suvs'),
	('Rebla GTS','rebla',25000,'suvs'),
	('Rocoto','rocoto',25000,'suvs'),
	('Seminole','seminole',25000,'suvs'),
	('Seminole Frontier','seminole2',22500,'suvs'),
	('Serrano','serrano',22500,'suvs'),
	('Toros','toros',25000,'suvs'),
	('XLS','xls',25000,'suvs'),
	('XLS Armored','xls2',50000,'suvs'),
	('Cognoscenti Cabrio','cogcabrio',35000,'coupes'),
	('Exemplar','exemplar',35000,'coupes'),
	('F620','f620',45000,'coupes'),
	('Felon','felon',35000,'coupes'),
	('Felon GT','felon2',35000,'coupes'),
	('Jackal','jackal',35000,'coupes'),
	('Oracle XS','oracle',35000,'coupes'),
	('Oracle','oracle2',35000,'coupes'),
	('Sentinel','sentinel',35000,'coupes'),
	('Sentinel XS','sentinel2',35000,'coupes'),
	('Windsor','windsor',50000,'coupes'),
	('Windsor Drop','windsor2',50000,'coupes'),
	('Zion','zion',35000,'coupes'),
	('Zion Cabrio','zion2',35000,'coupes'),
	('Blade','blade',15000,'muscles'),
	('Buccaneer','buccaneer',15000,'muscles'),
	('Buccaneer Rider','buccaneer2',20000,'muscles'),
	('Chino','chino',15000,'muscles'),
	('Chino Custom','chino2',20000,'muscles'),
	('Clique','clique',20000,'muscles'),
	('Coquette BlackFin','coquette3',50000,'muscles'),
	('Deviant','deviant',30000,'muscles'),
	('Dominator','dominator',20000,'muscles'),
	('Dominator Pisswasser','dominator2',20000,'muscles'),
	('Dominator GTX','dominator3',30000,'muscles'),
	('Dukes','dukes',15000,'muscles'),
	('Dukes Beater','dukes3',15000,'muscles'),
	('Ellie','ellie',30000,'muscles'),
	('Faction','faction',15000,'muscles'),
	('Faction Custom','faction2',20000,'muscles'),
	('Faction Custom Donk','faction3',20000,'muscles'),
	('Gauntlet','gauntlet',20000,'muscles'),
	('Gauntlet Redwood','gauntlet2',20000,'muscles'),
	('Gauntlet Classic','gauntlet3',20000,'muscles'),
	('Gauntlet Hellfire','gauntlet4',30000,'muscles'),
	('Gauntlet Classic Custom','gauntlet5',20000,'muscles'),
	('Hermes','hermes',30000,'muscles'),
	('Hotknife','hotknife',30000,'muscles'),
	('Hustler','hustler',30000,'muscles'),
	('Impaler','impaler',15000,'muscles'),
	('Lurcher','lurcher',15000,'muscles'),
	('Manana Custom','manana2',15000,'muscles'),
	('Moonbeam','moonbeam',15000,'muscles'),
	('Moonbeam Custom','moonbeam2',20000,'muscles'),
	('Nightshade','nightshade',30000,'muscles'),
	('Peyote Gasser','peyote2',30000,'muscles'),
	('Phoenix','phoenix',15000,'muscles'),
	('Picador','picador',15000,'muscles'),
	('Rat-Loader','ratloader',12500,'muscles'),
	('Rat-Truck','ratloader2',15000,'muscles'),
	('Ruiner','ruiner',15000,'muscles'),
	('Sabre Turbo','sabregt',15000,'muscles'),
	('Sabre Turbo Custom','sabregt2',20000,'muscles'),
	('Slamtruck','slamtruck',20000,'muscles'),
	('Slamvan','slamvan',15000,'muscles'),
	('Slamvan Lost','slamvan2',15000,'muscles'),
	('Slamvan Custom','slamvan3',15000,'muscles'),
	('Stallion','stalion',15000,'muscles'),
	('Stallion Burger Shot','stalion2',15000,'muscles'),
	('Tampa','tampa',15000,'muscles'),
	('Tulip','tulip',15000,'muscles'),
	('Vamos','vamos',15000,'muscles'),
	('Vigero','vigero',15000,'muscles'),
	('Virgo','virgo',15000,'muscles'),
	('Virgo Classic Custom','virgo2',20000,'muscles'),
	('Virgo Classic','virgo3',15000,'muscles'),
	('Voodoo Custom','voodoo',20000,'muscles'),
	('Voodoo','voodoo2',12500,'muscles'),
	('Yosemite','yosemite',15000,'muscles'),
	('Yosemite Drift','yosemite2',20000,'muscles'),
	('Roosevelt','btype',40000,'sportsclassics'),
	('Franken Strange','btype3',50000,'sportsclassics'),
	('Roosevelt Valor','btype2',40000,'sportsclassics'),
	('Casco','casco',40000,'sportsclassics'),
	('Cheburek','cheburek',30000,'sportsclassics'),
	('Cheetah Classic','cheetah2',50000,'sportsclassics'),
	('Coquette Classic','coquette2',50000,'sportsclassics'),
	('Dynasty','dynasty',30000,'sportsclassics'),
	('Fagaloa','fagaloa',30000,'sportsclassics'),
	('Stirling GT','feltzer3',40000,'sportsclassics'),
	('GT 500','gt500',40000,'sportsclassics'),
	('Infernus Classic','infernus2',50000,'sportsclassics'),
	('Mamba','mamba',40000,'sportsclassics'),
	('Manana','manana',30000,'sportsclassics'),
	('Michelli GT','michelli',30000,'sportsclassics'),
	('Monroe','monroe',40000,'sportsclassics'),
	('Nebula Turbo','nebula',30000,'sportsclassics'),
	('Peyote','peyote',30000,'sportsclassics'),
	('Peyote Gasser','peyote3',35000,'sportsclassics'),
	('Pigalle','pigalle',30000,'sportsclassics'),
	('Rapid GT Classic','rapidgt3',35000,'sportsclassics'),
	('Retinue','retinue', 30000, 'sportsclassics'),
	('Retinue MK II','retinue2',35000,'sportsclassics'),
	('Savestra','savestra',35000,'sportsclassics'),
	('Stinger','stinger',35000,'sportsclassics'),
	('Stinger GT','stingergt',40000,'sportsclassics'),
	('Swinger','swinger',50000,'sportsclassics'),
	('Toreador','toreador',50000,'sportsclassics'),
	('Torero','torero',50000,'sportsclassics'),
	('Tornado','tornado',35000,'sportsclassics'),
	('Tornado 2','tornado2',35000,'sportsclassics'),
	('Tornado 3','tornado3',30000,'sportsclassics'),
	('Tornado 4','tornado4',30000,'sportsclassics'),
	('Tornado Custom','tornado5',35000,'sportsclassics'),
	('Tornado Rat Rod','tornado6',35000,'sportsclassics'),
	('Turismo Classic','turismo2',50000,'sportsclassics'),
	('Viseris','viseris',40000,'sportsclassics'),
	('190z','z190',40000,'sportsclassics'),
	('Zion Classic','zion3',30000,'sportsclassics'),
	('Z-Type','ztype',40000,'sportsclassics'),
	('Alpha','alpha',50000,'sports'),
	('Banshee','banshee',75000,'sports'),
	('Bestia GTS','bestiagts',50000,'sports'),
	('Blista Compact','blista2',25000,'sports'),
	('Blista Go Go Monkey','blista3',25000,'sports'),
	('Buffalo','buffalo',50000,'sports'),
	('Buffalo S','buffalo2',50000,'sports'),
	('Buffalo Sprunk','buffalo3',50000,'sports'),
	('Carbonizzare','carbonizzare',75000,'sports'),
	('Comet','comet2',50000,'sports'),
	('Comet Retro Custom','comet3',52500,'sports'),
	('Comet Safari','comet4',50000,'sports'),
	('Comet SR','comet5',55000,'sports'), 
	('Coquette','coquette',75000,'sports'),
	('Coquette D10','coquette4',100000,'sports'),
	('8F Drafter','drafter',50000,'sports'),
	('Elegy Retro Custom','elegy',50000,'sports'),
	('Elegy RH8','elegy2',50000,'sports'),
	('Feltzer','feltzer2',50000,'sports'),
	('Flash GT','flashgt',50000,'sports'),
	('Furore GT','furoregt',50000,'sports'),
	('Fusilade','fusilade',50000,'sports'),
	('Futo','futo',25000,'sports'),
	('GB200','gb200',37500,'sports'),
	('Hotring Sabre','hotring',50000,'sports'),
	('Imorgon','imorgon',75000,'sports'),
	('Issi Sport','issi7',37500,'sports'),
	('Itali GTO','italigto',100000,'sports'),
	('Itali RSX','italirsx',100000,'sports'),
	('Jester','jester',75000,'sports'),
	('Jester (Racecar)','jester2',75000,'sports'),
	('Jester Classic','jester3',37500,'sports'),
	('Jugular','jugular',50000,'sports'),
	('Khamelion','khamelion',50000,'sports'),
	('Komoda','komoda',50000,'sports'),
	('Kuruma','kuruma',50000,'sports'),
	('Locust','locust',75000,'sports'),
	('Lynx','lynx',50000,'sports'),
	('Massacro','massacro',50000,'sports'),
	('Massacro (Racecar)','massacro2',50000,'sports'),
	('Neo','neo',50000,'sports'),
	('Neon','neon',50000,'sports'),
	('9F','ninef',50000,'sports'),
	('9F Cabrio','ninef2',50000,'sports'),
	('Omnis','omnis',37500,'sports'),
	('Paragon R','paragon',50000,'sports'),
	('Pariah','pariah',50000,'sports'),
	('Penumbra','penumbra',37500,'sports'),
	('Penumbra FF','penumbra2',37500,'sports'),
	('Raiden','raiden',50000,'sports'),
	('Rapid GT','rapidgt',50000,'sports'),
	('Rapid GT 2','rapidgt2',50000,'sports'),
	('Raptor','raptor',37500,'sports'),
	('Revolter','revolter',50000,'sports'),
	('Ruston','ruston',75000,'sports'),
	('Schafter V12','schafter3',25000,'sports'),
	('Schafter LWB','schafter4',25000,'sports'),
	('Schlagen GT','schlagen',50000,'sports'),
	('Schwartzer','schwarzer',37500,'sports'),
	('Sentinel Classic','sentinel3',37500,'sports'),
	('Seven 70','seven70',50000,'sports'),
	('Specter','specter',50000,'sports'),
	('Specter Custom','specter2',50000,'sports'),
	('Streiter','streiter',50000,'sports'),
	('Sugoi','sugoi',50000,'sports'),
	('Sultan','sultan',25000,'sports'),
	('Sultan Classic','sultan2',37500,'sports'),
	('Surano','surano',50000,'sports'),
	('Drift Tampa','tampa2',75000,'sports'),
	('Tropos Rallye','tropos',50000,'sports'),
	('Verlierer','verlierer2',75000,'sports'),
	('V-STR','vstr',50000,'sports'),
	('Adder','adder',250000,'supers'),
	('Autarch','autarch',375000,'supers'),
	('Banshee 900R','banshee2',250000,'supers'),
	('Bullet','bullet',250000,'supers'),
	('Cheetah','cheetah',250000,'supers'),
	('Cyclone','cyclone',250000,'supers'),
	('Deveste Eight','deveste',375000,'supers'),
	('Emerus','emerus',375000,'supers'),
	('Entity XF','entityxf',250000,'supers'),
	('Entity XXR','entity2',300000,'supers'),
	('FMJ','fmj',375000,'supers'),
	('PR4','formula',500000,'supers'),
	('R88','formula2',500000,'supers'),
	('Furia','furia',300000,'supers'),
	('GP1','gp1',375000,'supers'),
	('Infernus','infernus',250000,'supers'),
	('Itali GTB','italigtb',375000,'supers'),
	('Itali GTB Custom','italigtb2',375000,'supers'),
	('Krieger','krieger',375000,'supers'),
	('RE-7B','le7b',375000,'supers'),
	('Nero','nero',300000,'supers'),
	('Nero Custom','nero2',300000,'supers'),
	('BR8','openwheel1',500000,'supers'),
	('DR1','openwheel2',500000,'supers'),
	('Osiris','osiris',300000,'supers'),
	('Penetrator','penetrator',250000,'supers'),
	('Pfister 811','pfister811',300000,'supers'),
	('X80 Proto','prototipo',375000,'supers'),
	('Reaper','reaper',375000,'supers'),
	('S80RR','s80',375000,'supers'),
	('SC1','sc1',300000,'supers'),
	('ETR1','sheava',250000,'supers'),
	('Sultan RS','sultanrs',250000,'supers'),
	('T20','t20',300000,'supers'),
	('Taipan','taipan',375000,'supers'),
	('Tempesta','tempesta',375000,'supers'),
	('Tezeract','tezeract',375000,'supers'),
	('Tigon','tigon',375000,'supers'),
	('Thrax','thrax',375000,'supers'),
	('Turismo R','turismor',375000,'supers'),
	('Tyrant','tyrant',300000,'supers'),
	('Tyrus','tyrus',375000,'supers'),
	('Vacca','vacca',300000,'supers'),
	('Vagner','vagner',375000,'supers'),
	('Visione','visione',375000,'supers'),
	('Voltic','voltic',250000,'supers'),
	('XA-21','xa21',375000,'supers'),
	('Zentorno','zentorno',375000,'supers'),
	('Zorrusso','zorrusso',375000,'supers'),
	('Akuma','akuma',10000,'motorcycles'),
	('Avarus','avarus',20000,'motorcycles'),
	('Bagger','bagger',20000,'motorcycles'),
	('Bati 801','bati',15000,'motorcycles'),
	('Bati 801RR','bati2',15000,'motorcycles'),
	('BF400','bf400',7500,'motorcycles'),
	('Caddy','caddy',5000,'motorcycles'),
	('Caddy 2','caddy2',5000,'motorcycles'),
	('Caddy 3','caddy3',5000,'motorcycles'),
	('Carbon RS','carbonrs',15000,'motorcycles'),
	('Chimera','chimera',20000,'motorcycles'),
	('Cliffhanger','cliffhanger',7500,'motorcycles'),
	('Daemon','daemon',10000,'motorcycles'),
	('Daemon 2','daemon2',10000,'motorcycles'),
	('Defiler','defiler',10000,'motorcycles'),
	('Diabolus','diablous',15000,'motorcycles'),
	('Diabolus Custom','diablous2',15000,'motorcycles'),
	('Double T','double',15000,'motorcycles'),
	('Enduro','enduro',7500,'motorcycles'),
	('Esskey','esskey',7500,'motorcycles'),
	('Faggio Sport','faggio',2500,'motorcycles'),
	('Faggio','faggio2',2500,'motorcycles'),
	('Faggio Mod','faggio3',2500,'motorcycles'),
	('FCR 1000','fcr',10000,'motorcycles'),
	('FCR 1000 Custom','fcr2',10000,'motorcycles'),
	('Gargoyle','gargoyle',15000,'motorcycles'),
	('Hakuchou','hakuchou',15000,'motorcycles'),
	('Hakuchou Sport','hakuchou2',20000,'motorcycles'),
	('Hexer','hexer',20000,'motorcycles'),
	('Innovation','innovation',20000,'motorcycles'),
	('Lectro','lectro',15000,'motorcycles'),
	('Manchez','manchez',10000,'motorcycles'),
	('Manchez 2','manchez2',10000,'motorcycles'),
	('Nemesis','nemesis',10000,'motorcycles'),
	('Nightblade','nightblade',20000,'motorcycles'),
	('PCJ 600','pcj',10000,'motorcycles'),
	('Rat Bike','ratbike',20000,'motorcycles'),
	('Ruffian','ruffian',10000,'motorcycles'),
	('Sanchez','sanchez',10000,'motorcycles'),
	('Sanchez Sport','sanchez2',10000,'motorcycles'),
	('Sanctus','sanctus',20000,'motorcycles'),
	('Shotaro','shotaro',100000,'motorcycles'),
	('Stryder','stryder',20000,'motorcycles'),
	('Sovereign','sovereign',20000,'motorcycles'),
	('Thrust','thrust',20000,'motorcycles'),
	('Vader','vader',10000,'motorcycles'),
	('Veto Classic','veto',5000,'motorcycles'),
	('Veto Modern','veto2',5000,'motorcycles'),
	('Vindicator','vindicator',20000,'motorcycles'),
	('Vortex','vortex',10000,'motorcycles'),
	('Woflsbane','wolfsbane',10000,'motorcycles'),
	('Zombie Bobber','zombiea',10000,'motorcycles'),
	('Zombie Chopper','zombieb',10000,'motorcycles'),
	('Bf Injection','bfinjection',15000,'offroads'),
	('Bifta','bifta',15000,'offroads'),
	('Blazer','blazer',10000,'offroads'),
	('Blazer Hot Rod','blazer3',10000,'offroads'),
	('Blazer Sport','blazer4',10000,'offroads'),
	('Bodhi','bodhi2',15000,'offroads'),
	('Brawler','brawler',45000,'offroads'),
	('Caracara 4x4','caracara2',50000,'offroads'),
	('Duneloader','dloader',25000,'offroads'),
	('Dubsta 6x6','dubsta3',50000,'offroads'),
	('Dune Buggy','dune',10000,'offroads'),
	('Space Docker','dune2',10000,'offroads'),
	('Everon','everon',50000,'offroads'),
	('Freecrawler','freecrawler',25000,'offroads'),
	('Guardian','guardian',50000,'offroads'),
	('Hellion','hellion',25000,'offroads'),
	('Insurgent','insurgent2',75000,'offroads'),
	('Kalahari','kalahari',20000,'offroads'),
	('Kamacho', 'kamacho', 50000, 'offroads'),
	('Marshall','marshall',210000,'offroads'),
	('Mesa Trail','mesa3',50000,'offroads'),
	('Liberator','monster',210000,'offroads'),
	('Outlaw','outlaw',15000,'offroads'),
	('Rancher XL','rancherxl',25000,'offroads'),
	('Rusty Rebel','rebel',15000,'offroads'),
	('Rebel','rebel2',25000,'offroads'),
	('Riata', 'riata', 50000, 'offroads'),
	('Sadler','sadler',25000,'offroads'),
	('Sandking XL','sandking',50000,'offroads'),
	('Sandking SWB','sandking2',50000,'offroads'),
	('Squaddie','squaddie',75000,'offroads'),
	('Trophy Truck','trophytruck',75000,'offroads'),
	('Desert Raid','trophytruck2',75000,'offroads'),
	('Vagrant','vagrant',25000,'offroads'),
	('Verus','verus',10000,'offroads'),
	('Vetir','vetir',75000,'offroads'),
	('Winky','winky',25000,'offroads'),
	('Yosemite Rancher','yosemite3',25000,'offroads'),
	('Zhaba','zhaba',75000,'offroads'),
	('Bison','bison',25000,'vans'),
	('Bison 3','bison3',25000,'vans'),
	('Bobcat XL','bobcatxl',25000,'vans'),
	('Burrito','burrito3',20000,'vans'),
	('Camper','camper',25000,'vans'),
	('Gang Burrito','gburrito',20000,'vans'),
	('Gang Burrito 2','gburrito2',20000,'vans'),
	('Journey','journey',10000,'vans'),
	('Minivan','minivan',15000,'vans'),
	('Minivan Custom','minivan2',20000,'vans'),
	('Paradise','paradise',20000,'vans'),
	('Rumpo Trail','rumpo3',25000,'vans'),
	('Speedo','speedo',20000,'vans'),
	('Surfer','surfer',20000,'vans'),
	('Surfer 2','surfer2',10000,'vans'),
	('Youga','youga',20000,'vans'),
	('Youga Classic','youga2',20000,'vans'),
	('Youga Classic 4x4','youga3',25000,'vans'),
	('BMX','bmx',150,'cycles'),
	('Cruiser','cruiser',200,'cycles'),
	('Fixter','fixter',200,'cycles'),
	('Scorcher','scorcher',350,'cycles'),
	('Race bike Whippet','tribike',500,'cycles'),
	('Race bike Endurex','tribike2',500,'cycles'),
	('Race bike Tri-Cycles','tribike3',500,'cycles')
;

CREATE TABLE `vs_truck_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_truck_categories` (name, label) VALUES
	('haul','Haulers'),
	('box','Boxed Trucks'),
	('trans','Transport Trucks'),
	('other','Other Trucks')
;

CREATE TABLE `vs_trucks` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `vs_trucks` (name, model, price, category) VALUES
	('Hauler','hauler',100000,'haul'),
	('Packer','packer',100000,'haul'),
	('Phantom','phantom',105000,'haul'),
	('Phantom Custom','phantom3',110000,'haul'),
	('Benson','benson',55000,'box'),
	('Boxville 1','boxville',45000,'box'),
	('Boxville 2','boxville2',45000,'box'),
	('Boxville 3','boxville3',45000,'box'),
	('Boxville 4','boxville4',45000,'box'),
	('Mule 1','mule',40000,'box'),
	('Mule 2','mule2',40000,'box'),
	('Mule 3','mule3',40000,'box'),
	('Pounder','pounder',55000,'box'),
	('Airport Bus','airbus',50000,'trans'),
	('Bus','bus',50000,'trans'),
	('Dashound','coach',50000,'trans'),
	('Festival Bus','pbus2',75000,'trans'),
	('Rental Bus','rentalbus',35000,'trans'),
	('Tour Bus','tourbus',35000,'trans'),
	('Biff','biff',30000,'other'),
	('Dozer','bulldozer',20000,'other'),
	('Forklift','forklift',5000,'other'),
	('Field Master','tractor2',15000,'other'),
	('Lawn Mower','mower',1500,'other'),
	('Mixer 1','mixer',30000,'other'),
	('Mixer 2','mixer2',30000,'other'),
	('Rubble','rubble',30000,'other'),
	('Scrap Truck','scrap',10000,'other'),
	('Tipper 1','tiptruck',30000,'other'),
	('Tipper 2','tiptruck2',30000,'other')
;

CREATE TABLE `vs_vip_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_vip_categories` (name, label) VALUES
	('motorcycles','Motos')
;

CREATE TABLE `vs_vips` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `vs_vips` (name, model, price, category) VALUES
	('Shotaro','shotaro',30000,'motorcycles')
;

CREATE TABLE `vs_vipboat_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_vipboat_categories` (name, label) VALUES
	('boats','Boats')
;

CREATE TABLE `vs_vipboats` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `vs_vipboats` (name, model, price, category) VALUES
	('Tropic Yacht','tropic2',27000,'boats')
;

