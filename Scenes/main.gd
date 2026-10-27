extends Control
@onready var race_menu: OptionButton = $RaceMenu
@onready var health_value: OptionButton = $HealthValue
@onready var fire_value: OptionButton = $FireValue
@onready var electric_value: OptionButton = $ElectricValue
@onready var poison_value: OptionButton = $PoisonValue
@onready var ice_value: OptionButton = $IceValue
@onready var physical_value: OptionButton = $PhysicalValue
@onready var energy_value: OptionButton = $EnergyValue
@onready var energy_regen_value: OptionButton = $EnergyRegenValue
@onready var attack_mult_value: OptionButton = $AttackMultValue
@onready var defense_value: OptionButton = $DefenseValue
@onready var fire_imune: CheckBox = $FireImune
@onready var electric_immune: CheckBox = $ElectricImmune
@onready var poison_immune: CheckBox = $PoisonImmune
@onready var ice_immune: CheckBox = $IceImmune
@onready var physical_immune: CheckBox = $PhysicalImmune
@onready var jump_value: OptionButton = $JumpValue
@onready var generate: Button = $Generate
@onready var ability_list: ItemList = $AbilityList
@onready var accept_dialog: AcceptDialog = $AcceptDialog


const ABILITIES := [
	{"label": "Day Regen", "id": "om_rtdayregen"},
	{"label": "Night Regen", "id": "om_rtnightregen"},
	{"label": "Regen (Out-of-Combat)", "id": "om_rtregeneration"},
	{"label": "Regeneration", "id": "om_rtregeneration2"},
	{"label": "Water Regen", "id": "om_rtwaterregen"},
	{"label": "Slime Regen", "id": "om_rtslimeregen"},
	{"label": "Rage", "id": "om_rtrage"},
	{"label": "Combat Rage", "id": "om_rtrage2"},
	{"label": "Defensive Combat", "id": "om_rtcombatbuff"},
	{"label": "Swim Boost (Alt.)", "id": "om_rtswimboost"},
	{"label": "Swim Boost", "id": "swimboost"},
	{"label": "Slower Swimming", "id": "om_rtswimdebuff"},
	{"label": "Underwater Breathing", "id": "om_rtbreath"},
	{"label": "Suffocate Instantly", "id": "om_rtnoairdeath"},
	{"label": "Liquid Vulnerability", "id": "om_rtwaterdebuff"},
	{"label": "Liquid Immunity", "id": "liquidimmunity"},
	{"label": "Avid Explorer", "id": "om_rtexplorer1"},
	{"label": "Subterranean", "id": "om_rtexplorer2"},
	{"label": "Nomadic", "id": "om_rtnomad1"},
	{"label": "Don't Starve", "id": "dontstarve"},
	{"label": "Head Light", "id": "headlamp"},
	{"label": "Low Gravity", "id": "lowgrav"},
	{"label": "Glow", "id": "om_rtglow"},
	{"label": "Colourful Glow", "id": "om_rtlightglow1"},
	{"label": "Ghostly Glow", "id": "om_rtghostlyglow"},
	{"label": "Nova", "id": "om_rtnova"},
	{"label": "Colourful Nova", "id": "om_rtnovacolourmatch"},
	{"label": "Fire Aura", "id": "om_rtfireaura"},
	{"label": "Ice Aura", "id": "om_rticeaura"},
	{"label": "Electric Aura", "id": "om_rtelectricaura"},
	{"label": "Poison Aura", "id": "om_rtpoisonaura"},
	{"label": "Acid Blood", "id": "om_rtacidblood"},
	{"label": "Explosive Death", "id": "om_rtexplode"},
]

const MOD_SUFFIX := "Traits"
const STATUS_PATCH_PATH := "stats/effects/om_customstats/om_racetraits/om_racetraits.statuseffect.patch"
const MOD_AUTHOR := "ProjectMayhem"
const HDR := "^#00A9FF;"

#List of all the species. Some of these I couldn't tell what the actual display name would be and there are too many to unpack and look at specifics, so I will rely on user feedback
var speciesList = [
	"Addison","Aegi","Agaran","Akkimari","Albino Penguin","Alicorn","Alpaca","Alrune","Altmer","Android","Angel","Apex","Arachne","Aranean","Arcanian","Armol","Attarran","Avali","Avesauria","Avian","Avikan","Avioscale","Aylied",
	"Bajorn","Balloonoid","Barometta","Batpony","Beldehor","Bennacht","Betazoid","Blattra","Borg","Bosmer","Braixen","Brokentons","Brute","Bubblekin","Bulletkin","Bunkin","Bunnykin","Burmecian",
	"Calliote","Callistan","Calskies","Carbon","Carkin","Carodont","Cat","Catus","Celestial","Centens","Ceranae","Changling","Chimer","Clownkin","Coatlica","Crewkin","Crocodillian","Crylan","Cryoguin","Crystatllite","Cyberman",
	"Deadbeat","Deadbeats","Deerclops","Deerfolk","Deerkin","Delphox","Demon","Denelaun","Dibarushi","Dragon","Drayx","Dreemurrers","Droden","Drone","Dunmer","Duraalien","Duragoblin","Duramerling","Duraoni","Durasharkling","Dvarians","Dwemer",
	"Eevee","Elite","Elunite","Elys","Elysian", "Emlos","Epshadow","Espeon","Ethereos","Everis",
	"Ferro Morphs", "Facebox","Falmer","Familiar","Faun","Felicornus","Felin","Female Feolviera","Female Veenaravaviera","Fenerox","Fennix","Fennix Race","Ferengi",	"Floran","Founder","Frog",
	"Gamayun","Gamer","Gardevan","Gelsemis","Geode","Gilten","Gingerbread Man","Glaceon Fox","Glitch","Glutt","Gnolls","Goblin","Golgian","Greckan","Gremlins","Gyrusen","Gyrusen Kid",
	"Halfsea","Haranak","Harpy","Harse","Healeons","Hippogriff","Hisuzor","HM Robots Mk1","Hitch","Holideer","Hubsnugget","Human","Hylotl",
	"Ichthysian","Indix","Inkling","Insanitized",
	"Jelly","Jem Hadar","Jolte",
	"Kanashimi","Karemma","Kazdra","Kemono","Kirhos","Kitsune","Klingon","Kobold","Kyani",
	"Lagi","Lamia","Landfish","Lanthura","Lastree","Lepidoptian","Lombax","Lopunny","Lucario","Lunarian","Lycanroc","Lyceen","Lyru",
	"Majin","Maldacht","Male Feolviera","Male Veenaravaviera","Mannikin","Mantid","Maomer","Marli","Mauskin","Merrkin","Mindflayer","Mobian","Mobian Race","Mollopod","Mons","Moogle","Mootant","Munari","Murder Drone",
	"Namekian","Narfins","Nebulac","Neko","Nevrean 1","Nevrean 2","Nightar","Nightgaunt","Nightmares","Ningen","Nostos","Novakid","Novali","Nuu","Nyablos",
	"Octoling","Odigreos","Om Harpy","Om Ruined","Omen Race","Ooze","Orcana","Orcs","Orion","Orsimer",
	"Pandorasbox Penguin","Pandorasbox Sheye","Pariah","Pegasus","Peglaci","Penguin","Pengukin","Phantasm","Phox","Pony","Ponex","Pop Fiend","Poptop","Protogen",
	"Race Base","Radion","Remorian","Reploid","Romulan","Ryophi",
	"Saiyan","Sarasinor","Satkyterran","Saturn","Saturn 2","Saturn Mothman","Saurian","Scorsheep","Scyphojel","Selachii","Sergal","Shade","Shadow","Shadow 2","Shark Kin","Shizubelle","Shoggoth","Sirene","Skath","Skelekin","Skiffcat","Skumks","Smol Avali","Smol Kobold","Snosti","Space Kidds","Spectwing","Spirit Tree","Springeontons","Squamaeft","Starshroom","Su Gem",
	"Talimiman Aquoren","Talimiman Satyr","Talimiman Straciran","Talimiman Werewolf","Tauren","Taurikin","Technitoon","Terrakin","Thelean","Throg","Tirastrolls","Toon","Trill","Trink","Tsaiqir",
	"UC NPC","UC Swarmer","Umbreon","Unicorn",
	"Vampires","Vanta","Vaporeon","Vash Knaaren","Vash Knaaren Biped","Vesperian","Vespoid","Viera","Void Glitches","Vorta","Vulcan","Vulpera","Vulpes",
	"Wasphive","Windy","Woggle","Worker Drone","Wyvernis",
	"Xenomorph","Xenonian","Xmunfrogg",
	"Yautja","Luigi","Zombie","Zoroark"
	]
	
# Some mods have weird file names, or the display name doesn't format correctly, this fixes those issues
const SPECIES_ID_OVERRIDES := {
	"Albino Penguin": "albinopenguin",
	"Alrune": "Alrune",
	"Attarran": "Attarran",
	"Changling": "changeling",
	"Crystatllite": "crystallite",
	"Ferro Morphs": "edraxferromorphs",
	"Female Feolviera": "femalefeolviera",
	"Female Veenaravaviera": "femaleveenaravaviera",
	"Fennix Race": "fennixracemod",
	"Bajorn": "bajoran", 
	"Futara Dragon": "FutaraDragon",
	"GIC Android": "gic_android",
	"GIC Humanoid Combat Robot": "gic_humanoidcombatrobot",
	"GIC Otherworld Human": "gic_otherworldhuman",
	"GIC Realistic Floran": "gic_realisticfloran",
	"GIC Realistic Glitch": "gic_realisticglitch",
	"GIC Realistic Human": "gic_realistichuman",
	"GIC Realistic Novakid": "gic_realisticnovakid",
	"GIC Undead Skeleton": "gic_undeadskeleton",
	"Indix": "Indix",
	"Kobold": "koboldracebobbymonboy",
	"Lepidoptian": "Lepidoptian",
	"Mobian Race": "Mobian Race",
	"Om Harpy": "om_harpy",
	"Om Ruined": "om_ruined",
	"Pop Fiend": "pop_fiend",
	"Protogen": "protogenrace1",
	"Su Gem": "su_gem",
	"Talimiman Aquoren": "talimimanAquoren",
	"Talimiman Satyr": "talimimanSatyr",
	"Talimiman Straciran": "talimimanStraciran",
	"Talimiman Werewolf": "talimimanWerewolf",
	"Umbreon": "Umbreon",
	"Luigi": "zcrab_luigi",
	"Vulpera": "Vulpera"
}

# Set the location the mod will generate
var output_root := ProjectSettings.globalize_path("user://")

# Get the local username to add to the mod info file instead of setting my user name
func _get_username() -> String:
	var name := OS.get_environment("USERNAME")   # Windows
	if name == "":
		name = OS.get_environment("USER")        # Linux / macOS
	if name == "":
		name = OS.get_environment("LOGNAME")     # fallback on some Unix setups
	if name == "":
		name = "Unknown"
	return name

func _species_id(display_name: String) -> String:
	if SPECIES_ID_OVERRIDES.has(display_name):
		return SPECIES_ID_OVERRIDES[display_name]
	return display_name.replace(" ", "").to_lower()

func _val(b: OptionButton) -> int:
	return b.get_item_text(b.selected).to_int()

func _mult(percent: int) -> float:
	return snappedf(1.0 + percent / 100.0, 0.001)

func _read_choices() -> Dictionary:
	return {
		"health": _val(health_value),
		"energy": _val(energy_value),
		"energy_regen": _val(energy_regen_value),
		"attack": _val(attack_mult_value),
		"defense": _val(defense_value),
		"fire": _val(fire_value),
		"electric": _val(electric_value),
		"poison": _val(poison_value),
		"ice": _val(ice_value),
		"physical": _val(physical_value),
		"jump": _val(jump_value),
		"fire_immune": fire_imune.button_pressed,
		"electric_immune": electric_immune.button_pressed,
		"poison_immune": poison_immune.button_pressed,
		"ice_immune": ice_immune.button_pressed,
	}


func _build_stats(c: Dictionary, extra_stats: Array = []) -> Array:
	var stats: Array = [
		{"stat": "maxHealth", "baseMultiplier": _mult(c.health)},
		{"stat": "maxEnergy", "baseMultiplier": _mult(c.energy)},
		{"stat": "energyRegenPercentageRate", "baseMultiplier": _mult(c.energy_regen)},
		{"stat": "powerMultiplier", "baseMultiplier": _mult(c.attack)},
		{"stat": "protection", "effectiveMultiplier": _mult(c.defense)},
		{"stat": "fireResistance", "amount": c.fire / 100.0},
		{"stat": "fireStatusImmunity", "amount": 1.0 if c.fire_immune else 0.0},
		{"stat": "electricResistance", "amount": c.electric / 100.0},
		{"stat": "electricStatusImmunity", "amount": 1.0 if c.electric_immune else 0.0},
		{"stat": "poisonResistance", "amount": c.poison / 100.0},
		{"stat": "poisonStatusImmunity", "amount": 1.0 if c.poison_immune else 0.0},
		{"stat": "iceResistance", "amount": c.ice / 100.0},
		{"stat": "iceStatusImmunity", "amount": 1.0 if c.ice_immune else 0.0},
		{"stat": "physicalResistance", "amount": c.physical / 100.0},
	]
	stats.append_array(extra_stats)
	return stats

func _build_status_patch(species_id: String, stats: Array, jump: int, benefit_ids: Array) -> Array:
	var base := "/effectConfig/0/" + species_id
	return [
		{"op": "replace", "path": base + "/stats", "value": stats},
		{"op": "add", "path": base + "/controlModifiers/airJumpModifier", "value": _mult(jump)},
		{"op": "replace", "path": base + "/benefits", "value": benefit_ids},
	]


func _stat_value(stats: Array, stat_name: String, key: String, default_value: float) -> float:
	for s in stats:
		if s.get("stat", "") == stat_name:
			return float(s.get(key, default_value))
	return default_value

func _line(label: String, pct: int) -> String:
	if pct == 0:
		return "^darkgray;" + label + ": -^reset;"
	var color := "^green;" if pct > 0 else "^red;"
	var sign_str := "+" if pct > 0 else ""
	return "^white;" + label + "^reset;: " + color + sign_str + str(pct) + "%^reset;"

func _mult_pct(stats: Array, stat_name: String, key: String) -> int:
	return roundi((_stat_value(stats, stat_name, key, 1.0) - 1.0) * 100.0)

func _res_pct(stats: Array, stat_name: String) -> int:
	return roundi(_stat_value(stats, stat_name, "amount", 0.0) * 100.0)

func _build_description(stats: Array, lore: String = "", special_traits: Array = []) -> String:
	var attrs := [
		_line("Max Health", _mult_pct(stats, "maxHealth", "baseMultiplier")),
		_line("Max Energy", _mult_pct(stats, "maxEnergy", "baseMultiplier")),
		_line("Energy Regen", _mult_pct(stats, "energyRegenPercentageRate", "baseMultiplier")),
		_line("Attack Multiplier", _mult_pct(stats, "powerMultiplier", "baseMultiplier")),
		_line("Defense", _mult_pct(stats, "protection", "effectiveMultiplier")),
	]
	var resists := [
		_line("Fire Resistance", _res_pct(stats, "fireResistance")),
		_line("Electric Resistance", _res_pct(stats, "electricResistance")),
		_line("Poison Resistance", _res_pct(stats, "poisonResistance")),
		_line("Ice Resistance", _res_pct(stats, "iceResistance")),
		_line("Physical Resistance", _res_pct(stats, "physicalResistance")),
	]

	var immunity_map := [
		["om_rtslowImmunity", "Slow"], ["fireStatusImmunity", "Fire"],
		["electricStatusImmunity", "Electric"], ["poisonStatusImmunity", "Poison"],
		["iceStatusImmunity", "Frost"],
	]
	var immunities: Array = []
	for pair in immunity_map:
		if _stat_value(stats, pair[0], "amount", 0.0) > 0.0:
			immunities.append(pair[1])

	var d := ""
	if lore != "":
		d += lore + "\n"
	d += "    " + HDR + "Attributes^reset;\n" + "\n".join(attrs)
	d += "\n    " + HDR + "Resistances^reset;\n" + "\n".join(resists)
	d += "\n    " + HDR + "Immunities^reset;: "
	d += ("^green;" + ", ".join(immunities)) if immunities.size() > 0 else "-"
	d += "\n    " + HDR + "Racial Traits^reset;: "
	d += ("^#AA72FF;" + ", ".join(special_traits)) if special_traits.size() > 0 else "-"
	return d

# File output
func _write_json(path: String, data) -> Error:
	DirAccess.make_dir_recursive_absolute(path.get_base_dir())
	var f := FileAccess.open(path, FileAccess.WRITE)
	if f == null:
		push_error("Could not write %s (error %d)" % [path, FileAccess.get_open_error()])
		return FileAccess.get_open_error()
	f.store_string(JSON.stringify(data, "\t"))
	f.close()
	return OK

func _on_generate_pressed() -> void:
	var display_name := race_menu.get_item_text(race_menu.selected)
	var species_id := _species_id(display_name)
	var folder_name := display_name.replace(" ", "") + MOD_SUFFIX  
	var mod_dir := output_root.path_join(folder_name)

	var choices := _read_choices()
	var stats := _build_stats(choices)         
	var lore := ""                             
	var benefit_ids: Array = []
	var trait_labels: Array = []
	for a in _selected_abilities():
		benefit_ids.append(a.id)
		trait_labels.append(a.label)

	var description := _build_description(stats, lore, trait_labels)

	# stats patch
	_write_json(mod_dir.path_join(STATUS_PATCH_PATH),
		_build_status_patch(species_id, stats, choices.jump, benefit_ids))

	#  species patch
	_write_json(mod_dir.path_join("species/%s.species.patch" % species_id), [
		{"op": "replace", "path": "/charCreationTooltip/description", "value": description}
	])

	#  .metadata file
	var meta := {
		"author": _get_username(),
		"description": "A set of custom traits for %s" % display_name,
		"friendlyName": display_name + " Traits",
		"link" : "",
		"name": folder_name,
		"priority": 999,
		"version": "1.0"
	}
	
	_write_json(mod_dir.path_join(".metadata"), meta)

	print("Mod written to: ", mod_dir)

func _ready() -> void:
	for race in speciesList:
		race_menu.add_item(race)
	for b in [health_value, fire_value, electric_value, poison_value, ice_value,
		physical_value, energy_value, energy_regen_value, attack_mult_value,
		defense_value, jump_value]:
		for i in range(-25, 26):
			b.add_item(str(i))
		b.select(25)
		

func _selected_abilities() -> Array:
	var chosen: Array = []
	var indices := ability_list.get_selected_items()
	indices.sort()
	for i in indices:
		chosen.append(ABILITIES[i])
	return chosen
	


func _on_close_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	DirAccess.make_dir_recursive_absolute(output_root)
	OS.shell_show_in_file_manager(output_root)


func _on_instructions_pressed() -> void:
	accept_dialog.show()


func _on_accept_dialog_confirmed() -> void:
	accept_dialog.hide()


func _on_accept_dialog_canceled() -> void:
	accept_dialog.hide()
