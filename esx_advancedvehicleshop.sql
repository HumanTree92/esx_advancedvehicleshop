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
	(8,'Fire Truck','firetruk',750,'boss'),
	(9,'Maverick','polmav',1000,'boss')
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
	(10,'Police Cruiser','police2',750,'boss'),
	(11,'Maverick','polmav',1000,'boss')
;

CREATE TABLE `vs_aircraft_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_aircraft_categories` (name, label) VALUES
	('plane','Planes'),
	('heli','Helicopters')
;

CREATE TABLE `vs_aircrafts` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `vs_aircrafts` (name, model, price, category) VALUES
	('Alpha Z1','alphaz1',1121000,'plane'),
	('Besra','besra',1000000,'plane'),
	('Cuban 800','cuban800',240000,'plane'),
	('Dodo','dodo',500000,'plane'),
	('Duster','duster',175000,'plane'),
	('Howard NX25','howard',975000,'plane'),
	('Luxor','luxor',1500000,'plane'),
	('Luxor Deluxe ','luxor2',1750000,'plane'),
	('Mallard','stunt',250000,'plane'),
	('Mammatus','mammatus',300000,'plane'),
	('Nimbus','nimbus',900000,'plane'),
	('Rogue','rogue',1000000,'plane'),
	('Sea Breeze','seabreeze',850000,'plane'),
	('Shamal','shamal',1150000,'plane'),
	('Ultra Light','microlight',50000,'plane'),
	('Velum','velum2',450000,'plane'),
	('Vestra','vestra',950000,'plane'),
	('Buzzard','buzzard2',500000,'heli'),
	('Frogger','frogger',800000,'heli'),
	('Havok','havok',250000,'heli'),
	('Maverick','maverick',750000,'heli'),
	('Sea Sparrow','seasparrow',815000,'heli'),
	('SuperVolito','supervolito',1000000,'heli'),
	('SuperVolito Carbon','supervolito2',1250000,'heli'),
	('Swift','swift',1000000,'heli'),
	('Swift Deluxe','swift2',1250000,'heli'),
	('Volatus','volatus',1250000,'heli')
;

CREATE TABLE `vs_boat_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_boat_categories` (name, label) VALUES
	('boat','Boats'),
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
	('Dinghy 4Seat','dinghy',25000,'boat'),
	('Dinghy 2Seat','dinghy2',20000,'boat'),
	('Dinghy Yacht','dinghy4',25000,'boat'),
	('Jetmax','jetmax',30000,'boat'),
	('Marquis','marquis',45000,'boat'),
	('Seashark','seashark',10000,'boat'),
	('Seashark Yacht','seashark3',10000,'boat'),
	('Speeder','speeder',40000,'boat'),
	('Squalo','squalo',32000,'boat'),
	('Suntrap','suntrap',34000,'boat'),
	('Toro','toro',38000,'boat'),
	('Toro Yacht','toro2',38000,'boat'),
	('Tropic','tropic',27000,'boat'),
	('Tropic Yacht','tropic2',27000,'boat'),
	('Kraken','submersible2',31000,'subs'),
	('Submarine','submersible',29000,'subs')
;

CREATE TABLE `vs_car_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vs_car_categories` (name, label) VALUES
	('compacts','Compacts'),
	('coupes','Coupes'),
	('sedans','Sedans'),
	('sports','Sports'),
	('sportsclassics','Sports Classics'),
	('super','Super'),
	('muscle','Muscle'),
	('offroad','Off Road'),
	('suvs','SUVs'),
	('vans','Vans'),
	('motorcycles','Motos')
;

CREATE TABLE `vs_cars` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `vs_cars` (name, model, price, category) VALUES
	('Blade','blade',15000,'muscle'),
	('Buccaneer','buccaneer',18000,'muscle'),
	('Buccaneer Rider','buccaneer2',24000,'muscle'),
	('Chino','chino',15000,'muscle'),
	('Chino Luxe','chino2',19000,'muscle'),
	('Coquette BlackFin','coquette3',55000,'muscle'),
	('Dominator','dominator',35000,'muscle'),
	('Dukes','dukes',28000,'muscle'),
	('Gauntlet','gauntlet',30000,'muscle'),
	('Hermes','hermes',535000,'muscle'),
	('Hotknife','hotknife',125000,'muscle'),
	('Hustler','hustler',625000,'muscle'),
	('Faction','faction',20000,'muscle'),
	('Faction Rider','faction2',30000,'muscle'),
	('Faction XL','faction3',40000,'muscle'),
	('Nightshade','nightshade',65000,'muscle'),
	('Phoenix','phoenix',12500,'muscle'),
	('Picador','picador',18000,'muscle'),
	('Ruiner 2','ruiner2',5745600,'muscle'),
	('Sabre Turbo','sabregt',20000,'muscle'),
	('Sabre GT','sabregt2',25000,'muscle'),
	('Slam Van','slamvan3',11500,'muscle'),
	('Tampa','tampa',16000,'muscle'),
	('Virgo','virgo',14000,'muscle'),
	('Vigero','vigero',12500,'muscle'),
	('Voodoo','voodoo',7200,'muscle'),
	('Yosemite','yosemite',485000,'muscle'),
	('Blista','blista',8000,'compacts'),
	('Brioso R/A','brioso',18000,'compacts'),
	('Issi','issi2',10000,'compacts'),
	('Panto','panto',10000,'compacts'),
	('Prairie','prairie',12000,'compacts'),
	('Bison','bison',45000,'vans'),
	('Bobcat XL','bobcatxl',32000,'vans'),
	('Burrito','burrito3',19000,'vans'),
	('Burrito','gburrito2',29000,'vans'),
	('Camper','camper',42000,'vans'),
	('Gang Burrito','gburrito',45000,'vans'),
	('Journey','journey',6500,'vans'),
	('Minivan','minivan',13000,'vans'),
	('Moonbeam','moonbeam',18000,'vans'),
	('Moonbeam Rider','moonbeam2',35000,'vans'),
	('Paradise','paradise',19000,'vans'),
	('Rumpo','rumpo',15000,'vans'),
	('Rumpo Trail','rumpo3',19500,'vans'),
	('Surfer','surfer',12000,'vans'),
	('Youga','youga',10800,'vans'),
	('Youga Luxuary','youga2',14500,'vans'),
	('Asea','asea',5500,'sedans'),
	('Cognoscenti','cognoscenti',55000,'sedans'),
	('Emperor','emperor',8500,'sedans'),
	('Fugitive','fugitive',12000,'sedans'),
	('Glendale','glendale',6500,'sedans'),
	('Intruder','intruder',7500,'sedans'),
	('Premier','premier',8000,'sedans'),
	('Primo Custom','primo2',14000,'sedans'),
	('Regina','regina',5000,'sedans'),
	('Schafter','schafter2',25000,'sedans'),
	('Stretch','stretch',90000,'sedans'),
	('Super Diamond','superd',130000,'sedans'),
	('Tailgater','tailgater',30000,'sedans'),
	('Warrener','warrener',4000,'sedans'),
	('Washington','washington',9000,'sedans'),
	('Baller','baller2',40000,'suvs'),
	('Baller Sport','baller3',60000,'suvs'),
	('Cavalcade','cavalcade2',55000,'suvs'),
	('Contender','contender',70000,'suvs'),
	('Dubsta','dubsta',45000,'suvs'),
	('Dubsta Luxuary','dubsta2',60000,'suvs'),
	('Fhantom','fq2',17000,'suvs'),
	('Grabger','granger',50000,'suvs'),
	('Gresley','gresley',47500,'suvs'),
	('Huntley S','huntley',40000,'suvs'),
	('Landstalker','landstalker',35000,'suvs'),
	('Mesa','mesa',16000,'suvs'),
	('Mesa Trail','mesa3',40000,'suvs'),
	('Patriot','patriot',55000,'suvs'),
	('Radius','radi',29000,'suvs'),
	('Rocoto','rocoto',45000,'suvs'),
	('Seminole','seminole',25000,'suvs'),
	('XLS','xls',32000,'suvs'),
	('Ardent','ardent',1150000,'sportsclassics'),
	('Btype','btype',62000,'sportsclassics'),
	('Btype Luxe','btype3',85000,'sportsclassics'),
	('Btype Hotroad','btype2',155000,'sportsclassics'),
	('Casco','casco',30000,'sportsclassics'),
	('Coquette Classic','coquette2',40000,'sportsclassics'),
	('Deluxo','deluxo',4721500,'sportsclassics'),
	('GT 500','gt500',785000,'sportsclassics'),
	('Manana','manana',12800,'sportsclassics'),
	('Monroe','monroe',55000,'sportsclassics'),
	('Pigalle','pigalle',20000,'sportsclassics'),
	('Rapid GT3','rapidgt3',885000,'sportsclassics'),
	('Retinue','retinue', 615000, 'sportsclassics'),
	('Savestra','savestra',990000,'sportsclassics'),
	('Stinger','stinger',80000,'sportsclassics'),
	('Stinger GT','stingergt',75000,'sportsclassics'),
	('Stirling GT','feltzer3',65000,'sportsclassics'),
	('Viseris','viseris',875000,'sportsclassics'),
	('Z190','z190',900000,'sportsclassics'),
	('Z-Type','ztype',220000,'sportsclassics'),
	('Bifta','bifta',12000,'offroad'),
	('Bf Injection','bfinjection',16000,'offroad'),
	('Blazer','blazer',6500,'offroad'),
	('Blazer Sport','blazer4',8500,'offroad'),
	('blazer5', 'blazer5', 1755600, 'offroad'),
	('Brawler','brawler',45000,'offroad'),
	('Bubsta 6x6','dubsta3',120000,'offroad'),
	('Dune Buggy','dune',8000,'offroad'),
	('Guardian','guardian',45000,'offroad'),
	('Kamacho', 'kamacho', 345000, 'offroad'),
	('Rebel','rebel2',35000,'offroad'),
	('Riata', 'riata', 380000, 'offroad'),
	('Sandking','sandking',55000,'offroad'),
	('The Liberator','monster',210000,'offroad'),
	('Trophy Truck','trophytruck',60000,'offroad'),
	('Trophy Truck Limited','trophytruck2',80000,'offroad'),
	('Cognoscenti Cabrio','cogcabrio',55000,'coupes'),
	('Exemplar','exemplar',32000,'coupes'),
	('F620','f620',40000,'coupes'),
	('Felon','felon',42000,'coupes'),
	('Felon GT','felon2',55000,'coupes'),
	('Jackal','jackal',38000,'coupes'),
	('Oracle XS','oracle2',35000,'coupes'),
	('Sentinel','sentinel',32000,'coupes'),
	('Sentinel XS','sentinel2',40000,'coupes'),
	('Windsor','windsor',95000,'coupes'),
	('Windsor Drop','windsor2',125000,'coupes'),
	('Zion','zion',36000,'coupes'),
	('Zion Cabrio','zion2',45000,'coupes'),
	('9F','ninef',65000,'sports'),
	('9F Cabrio','ninef2',80000,'sports'),
	('Alpha','alpha',60000,'sports'),
	('Banshee','banshee',70000,'sports'),
	('Bestia GTS','bestiagts',55000,'sports'),
	('Buffalo','buffalo',12000,'sports'),
	('Buffalo S','buffalo2',20000,'sports'),
	('Carbonizzare','carbonizzare',75000,'sports'),
	('Comet','comet2',65000,'sports'),
	('Comet 5','comet5',1145000,'sports'), 
	('Coquette','coquette',65000,'sports'),
	('Drift Tampa','tampa2',80000,'sports'),
	('Elegy','elegy2',38500,'sports'),
	('Feltzer','feltzer2',55000,'sports'),
	('Furore GT','furoregt',45000,'sports'),
	('Fusilade','fusilade',40000,'sports'),
	('Jester','jester',65000,'sports'),
	('Jester(Racecar)','jester2',135000,'sports'),
	('Khamelion','khamelion',38000,'sports'),
	('Kuruma','kuruma',30000,'sports'),
	('Lynx','lynx',40000,'sports'),
	('Mamba','mamba',70000,'sports'),
	('Massacro','massacro',65000,'sports'),
	('Massacro(Racecar)','massacro2',130000,'sports'),
	('Neon','neon',1500000,'sports'),
	('Omnis','omnis',35000,'sports'),
	('Pariah','pariah',1420000,'sports'),
	('Penumbra','penumbra',28000,'sports'),
	('Raiden','raiden',1375000,'sports'),
	('Rapid GT','rapidgt',35000,'sports'),
	('Rapid GT Convertible','rapidgt2',45000,'sports'),
	('Revolter','revolter',1610000,'sports'),
	('Schafter V12','schafter3',50000,'sports'),
	('Sentinel3','sentinel3',650000,'sports'),
	('Seven 70','seven70',39500,'sports'),
	('Streiter','streiter',500000,'sports'),
	('Stromberg','stromberg',3185350,'sports'),
	('Sultan','sultan',15000,'sports'),
	('Surano','surano',50000,'sports'),
	('Tropos','tropos',40000,'sports'),
	('Verlierer','verlierer2',70000,'sports'),
	('Adder','adder',900000,'super'),
	('Autarch','autarch',1955000,'super'),
	('Banshee 900R','banshee2',255000,'super'),
	('Bullet','bullet',90000,'super'),
	('Cheetah','cheetah',375000,'super'),
	('Cyclone','cyclone',1890000,'super'), 
	('Entity XF','entityxf',425000,'super'),
	('ETR1','sheava',220000,'super'),
	('FMJ','fmj',185000,'super'),
	('Infernus','infernus',180000,'super'),
	('Oppressor','oppressor',3524500,'super'),
	('Osiris','osiris',160000,'super'),
	('Pfister','pfister811',85000,'super'),
	('RE-7B','le7b',325000,'super'),
	('Reaper','reaper',150000,'super'),
	('SC 1','sc1',1603000,'super'),
	('Sultan RS','sultanrs',65000,'super'),
	('T20','t20',300000,'super'),
	('Turismo R','turismor',350000,'super'),
	('Tyrus','tyrus',600000,'super'),
	('Vacca','vacca',120000,'super'),
	('Visione','visione',2250000,'super'),
	('Voltic','voltic',90000,'super'),
	('Voltic 2','voltic2',3830400,'super'),
	('X80 Proto','prototipo',2500000,'super'),
	('Zentorno','zentorno',1500000,'super'),
	('Akuma','AKUMA',7500,'motorcycles'),
	('Avarus','avarus',18000,'motorcycles'),
	('Bagger','bagger',13500,'motorcycles'),
	('Bati 801','bati',12000,'motorcycles'),
	('Bati 801RR','bati2',19000,'motorcycles'),
	('BF400','bf400',6500,'motorcycles'),
	('BMX (velo)','bmx',160,'motorcycles'),
	('Carbon RS','carbonrs',18000,'motorcycles'),
	('Chimera','chimera',38000,'motorcycles'),
	('Cliffhanger','cliffhanger',9500,'motorcycles'),
	('Cruiser (velo)','cruiser',510,'motorcycles'),
	('Daemon','daemon',11500,'motorcycles'),
	('Daemon High','daemon2',13500,'motorcycles'),
	('Defiler','defiler',9800,'motorcycles'),
	('Double T','double',28000,'motorcycles'),
	('Enduro','enduro',5500,'motorcycles'),
	('Esskey','esskey',4200,'motorcycles'),
	('Faggio','faggio',1900,'motorcycles'),
	('Vespa','faggio2',2800,'motorcycles'),
	('Fixter (velo)','fixter',225,'motorcycles'),
	('Gargoyle','gargoyle',16500,'motorcycles'),
	('Hakuchou','hakuchou',31000,'motorcycles'),
	('Hakuchou Sport','hakuchou2',55000,'motorcycles'),
	('Hexer','hexer',12000,'motorcycles'),
	('Innovation','innovation',23500,'motorcycles'),
	('Manchez','manchez',5300,'motorcycles'),
	('Nemesis','nemesis',5800,'motorcycles'),
	('Nightblade','nightblade',35000,'motorcycles'),
	('PCJ-600','pcj',6200,'motorcycles'),
	('Ruffian','ruffian',6800,'motorcycles'),
	('Sanchez','sanchez',5300,'motorcycles'),
	('Sanchez Sport','sanchez2',5300,'motorcycles'),
	('Sanctus','sanctus',25000,'motorcycles'),
	('Scorcher (velo)','scorcher',280,'motorcycles'),
	('Sovereign','sovereign',22000,'motorcycles'),
	('Shotaro Concept','shotaro',320000,'motorcycles'),
	('Thrust','thrust',24000,'motorcycles'),
	('Tri bike (velo)','tribike3',520,'motorcycles'),
	('Vader','vader',7200,'motorcycles'),
	('Vortex','vortex',9800,'motorcycles'),
	('Woflsbane','wolfsbane',9000,'motorcycles'),
	('Zombie','zombiea',9500,'motorcycles'),
	('Zombie Luxuary','zombieb',12000,'motorcycles')
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
	('Festival Bus','pbus2',125000,'trans'),
	('Rental Bus','rentalbus',35000,'trans'),
	('Tour Bus','tourbus',35000,'trans'),
	('Biff','biff',30000,'other'),
	('Dozer','bulldozer',20000,'other'),
	('Field Master','tractor2',15000,'other'),
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

