# About esx_advancedvehicleshop:
Advanced Vehicle Shop for ESX Legacy - Edited/Made by Human Tree92 ([Velociti Entertainment Customs & Wiki]( http://www.velocitientertainment.com/customs/ ))

# Creating Issues
* Check the [Closed Topics]( https://github.com/HumanTree92/esx_advancedvehicleshop/issues?q=is%3Aissue+is%3Aclosed ) & [Wiki]( http://www.velocitientertainment.com/customs/ ) before opening an issue to see if your issue has already been Answered.
* Do NOT Delete the Pre-Written Text in the issue.
* Failue to due any of the above will result in Topic being deleted & you being Blocked. The Pre-Written text helps me with getting to the Bottom of the Issues & i hate explaining things over & over.

# Helpfull Info:
* This Vehicle Shops works exactly like esx_vehicleshop.
* Currently has 11 Different Vehicle Shops.
  * Ambulance, Police, Mechanic, Taxi, Aircrafts, Boats, Cars, Trucks, & 3 VIP Shops (Aircrafts, Boats & Cars)
* To make this Script fully work with `esx_policejob & esx_ambulancejob`
  * edit `client/vehicle.lua` and do a search for `esx_vehicleshop` & change it to `esx_advancedvehicleshop` then edit the `fxmanifest.lua` & remove the dependency for `esx_vehicleshop`.
* You can only sell vehicles at the shop you bought it from.
  * Example: If you a buy a vehicle at the Truck Shop you won't be able to sell it at the Car Shop.
* If you want to use the Ambulance or Police Shop you will need to Edit the sql to your needs before you upload it.
* I have added my VIP Aircraft, Boat & Car Shop but you will need to setup that on your own. There will be no help from me.
* This works perfectly with my esx_advancedgarage. I suggest using it over any other garage system including esx_policejob & esx_ambulancejob Garages.
* New System will pull Vehicle Name & Vehicle Category & save it in the Database. This way you don't need a vehicle_names.lua file.
* In order to Migrate Vehicle go to fxmanifest.lua and uncomment the 'server/migrate.lua'
* Config.Main.PlateUseSpace will add a Double Space in between the Letters and Numbers.

# Requirements:
* Required:
  * FiveM Client/Server Build 4267 or Higher
  * Set Game Build to Tuner Update `+set sv_enforceGameBuild tuner`
  * [ESX Legacy]( https://github.com/esx-framework/esx-legacy )
* Optional:
  * [esx_advancedgarage]( https://github.com/HumanTree92/esx_advancedgarage )
  * [esx_dmvschool]( https://github.com/esx-framework/esx-legacy/tree/main/%5Besx_addons%5D/esx_dmvschool )
  * [esx_licenseshop]( https://github.com/HumanTree92/esx_licenseshop )

# Download & Installation:
1) Download Master or Release & Extract the .zip or Open the .zip.
2) Edit the `config.lua` before starting the script. By default everything is turned off.
3) Import the `esx_advancedvehicleshop.sql` into your database.
4) Place `esx_advancedvehicleshop` in your ESX Directory
5) Add `start esx_advancedvehicleshop` to your server.cfg
6) Add `setr esx_MenuAlign "top-right"` to your server.cfg

# How to use Ambulance or Police Shop
1) For `vs_ambulance_categories` & `vs_police_categories` & `vs_mechanic_categories` & `vs_taxi_categories`
  * The column `name` should be the job_grades name
  * The column `label` should be the job_grades label
2) For `vs_ambulance` & `vs_police` & `vs_mechanic` & `vs_taxi`
  * The column `id` should start at 1 and so on.
  * The column `name` should be the vehicle name.
  * The column `model` should be spawn name.
  * The column `price` should be the vehicles price.
  * The column `category` should be the job_grades name
3) You can find Examples in the `esx_advancedvehicleshop.sql`

# Credits/Original Code:
* [ESX-Framework]( https://github.com/esx-framework )
  * [esx_vehicleshop]( https://github.com/esx-framework/esx-legacy/tree/main/%5Besx_addons%5D/esx_vehicleshop )

# Other Scripts:
If you like this please check out some of my other stuff like
* [esx_advancedbanking]( https://github.com/HumanTree92/esx_advancedbanking )
* [esx_advancedgarage]( https://github.com/HumanTree92/esx_advancedgarage )
* [esx_advancedholdup]( https://github.com/HumanTree92/esx_advancedholdup )
* [esx_advancedhospital]( https://github.com/HumanTree92/esx_advancedhospital )
* [esx_advancedjail]( https://github.com/HumanTree92/esx_advancedjail )
* [esx_advancedvehicleshop]( https://github.com/HumanTree92/esx_advancedvehicleshop )
* [esx_advancedweaponshop]( https://github.com/HumanTree92/esx_advancedweaponshop )
* [esx_extraitems]( https://github.com/HumanTree92/esx_extraitems )
* [esx_joblisting]( https://github.com/HumanTree92/esx_joblisting )
* [esx_licenseshop]( https://github.com/HumanTree92/esx_licenseshop )
* [esx_vehiclespawner]( https://github.com/HumanTree92/esx_vehiclespawner )
* [esx_vehicletheft]( https://github.com/HumanTree92/esx_vehicletheft )
* [FiveM_CustomMapAddons]( https://github.com/HumanTree92/FiveM_CustomMapAddons )

# Archived Scripts:
Scripts that will no longer be Maintained.
* [esx_aircraftshop]( https://github.com/HumanTree92/esx_aircraftshop )
* [esx_boatshop]( https://github.com/HumanTree92/esx_boatshop )
* [esx_truckshop]( https://github.com/HumanTree92/esx_truckshop )
* [esx_plasticsurgery]( https://github.com/HumanTree92/esx_plasticsurgery )
* [esx_hospital]( https://github.com/HumanTree92/esx_hospital )
* [esx_panicbutton]( https://github.com/HumanTree92/esx_panicbutton )

# Visit Velociti Entertainment:
* [Discord]( https://discord.velocitientertainment.com )
* [Website]( https://velocitientertainment.com )
* [Forums]( https://velocitientertainment.com/forum )
* [About Us]( https://velocitientertainment.com/pc-gaming )
* [Donate]( https://velocitientertainment.com/donations )
* [Patreon] ( https://www.patreon.com/VelocitiEntertainment?fan_landing=true )
* [Steam Group]( https://steamcommunity.com/groups/velocitientertainment )
* [Facebook]( https://facebook.com/VelocitiEntertainment )
* [Twitter]( https://twitter.com/VelocitiEnt )
* [YouTube]( https://youtube.com/user/HumanTree92 )
* [Twitch]( https://twitch.tv/humantree92 )
* [GitHub]( https://github.com/HumanTree92 )

# Legal
### License
esx_advancedvehicleshop - Multi Vehicle Shop for ESX Legacy

Copyright (C) 2022 Velociti Entertainment

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.
