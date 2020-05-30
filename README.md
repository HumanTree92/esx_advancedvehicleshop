# About esx_advancedvehicleshop:
Advanced Vehicle Shop for ESX - Edited/Made by Human Tree92 ([Velociti Entertainment Customs & Wiki](http://www.velocitientertainment.com/customs/))

I can not Guarantee that this will work with the Latest es_extended V2.

# Helpfull Info:
* This Vehicle Shops works exactly like esx_vehicleshop.
* Players can Buy/Sell Aircrafts, Boats, Cars, & Trucks.
* Ambulance/Police can Buy/Sell Cars & Helicopters
* This is mainly for those that don't want to have/use the esx_vehicleshop Car Dealer Job.
  * I don't have the need to use Car Dealer Job. (This script will never support it.)
* To make this Script fully work with `esx_policejob & esx_ambulancejob` edit `client/vehicle.lua` and do a search for `esx_vehicleshop` & change it to `esx_advancedvehicleshop` then edit the `fxmanifest.lua` & remove the dependency for `esx_vehicleshop`.
* You can only sell vehicles at the shop you bought it from.
  * Example: If you a buy a vehicle at the Truck Shop you won't be able to sell it at the Car Shop.
* If you want to use the Ambulance or Police Shop you will need to Edit the sql to your needs before you upload it.
* I have added my VIP Shop but you will need to setup that on your own. There will be no help from me.

# Requirements:
* Required:
  * [es_extended V1 Final](https://github.com/ESX-Org/es_extended) or [extendedmode](https://github.com/extendedmode/extendedmode)
  * [esx_dmvschool](https://github.com/ESX-Org/esx_dmvschool)
  * [esx_licenseshop](https://github.com/HumanTree92/esx_licenseshop)
* Optional:
  * [esx_advancedgarage](https://github.com/HumanTree92/esx_advancedgarage)

# Download & Installation:
1) Download the .zip.
2) Extract the .zip or Open the .zip.
3) Import the `esx_advancedvehicleshop.sql` into your database.
4) Place `esx_advancedvehicleshop` in your ESX Directory
5) Add `start esx_advancedvehicleshop` to your server.cfg

# How to use Ambulance or Police Shop
1) For `vs_ambulance_categories` &/or `vs_police_categories`
  * The column `name` should be the job_grades name
  * The column `label` should be the job_grades label
2) For `vs_ambulance` &/or `vs_police`
  * The column `id` should start at 1 and so on.
  * The column `name` should be the vehicle name.
  * The column `model` should be spawn name.
  * The column `price` should be the vehicles price.
  * The column `category` should be the job_grades name
3) You can find Examples in the `esx_advancedvehicleshop.sql`

# Credits/Original Code:
* [ESX-Org](https://github.com/ESX-Org)
  * [esx_vehicleshop](https://github.com/ESX-Org/esx_vehicleshop)

# Other Scripts:
If you like this please check out some of my other stuff like
* [esx_advancedbanking](https://github.com/HumanTree92/esx_advancedbanking)
* [esx_advancedfuel](https://github.com/HumanTree92/esx_advancedfuel)
* [esx_advancedgarage](https://github.com/HumanTree92/esx_advancedgarage)
* [esx_advancedholdup](https://github.com/HumanTree92/esx_advancedholdup)
* [esx_advancedhospital](https://github.com/HumanTree92/esx_advancedhospital)
* [esx_advancedjail](https://github.com/HumanTree92/esx_advancedjail)
* [esx_advancedvehicleshop](https://github.com/HumanTree92/esx_advancedvehicleshop)
* [esx_advancedweaponshop](https://github.com/HumanTree92/esx_advancedweaponshop)
* [esx_extraitems](https://github.com/HumanTree92/esx_extraitems)
* [esx_joblisting](https://github.com/HumanTree92/esx_joblisting)
* [esx_licenseshop](https://github.com/HumanTree92/esx_licenseshop)
* [esx_vehiclespawner](https://github.com/HumanTree92/esx_vehiclespawner)
* [FiveM_CustomMapAddons](https://github.com/HumanTree92/FiveM_CustomMapAddons)

# Archived Scripts:
Scripts that will no longer be Maintained.
* [esx_aircraftshop](https://github.com/HumanTree92/esx_aircraftshop)
* [esx_boatshop](https://github.com/HumanTree92/esx_boatshop)
* [esx_truckshop](https://github.com/HumanTree92/esx_truckshop)
* [esx_plasticsurgery](https://github.com/HumanTree92/esx_plasticsurgery)
* [esx_hospital](https://github.com/HumanTree92/esx_hospital)
* [esx_panicbutton](https://github.com/HumanTree92/esx_panicbutton)

# Visit Velociti Entertainment:
* TS3 - ts3.velocitientertainment.com
* [Discord](http://discord.velocitientertainment.com)
* [Website](http://velocitientertainment.com/)
* [Forums](http://velocitientertainment.com/forum)
* [About Us](http://velocitientertainment.com/pc-gaming/)
* [Donate](http://velocitientertainment.com/donations/)
* [Steam Group](http://steamcommunity.com/groups/velocitientertainment)
* [Facebook](http://facebook.com/VelocitiEntertainment)
* [Twitter](http://twitter.com/VelocitiEnt)
* [YouTube](http://youtube.com/user/HumanTree92)
* [Twitch](http://twitch.tv/humantree92)
* [eBay](http://ebay.com/usr/humantree92)

# Legal
### License
esx_advancedvehicleshop - Multi Vehicle Shop for ESX

Copyright (C) 2011-2020 Velociti Entertainment

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.
