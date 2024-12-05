extends Node

var tower_names = {
	"FIRE_GROUND_EFFECT":	"Flame Trap",
	"FIRE_CONTINUOUS":			"Inferno",
	"FIRE_BEAM":			"Lava Beam",
	"FIRE_MISSILE":			"Ember Missile",
	"FIRE_SHIELD":			"Blazing Barrier",
	"FIRE_ROCK":			"Magma Boulder",

	"LIGHTNING_GROUND_EFFECT":	"Storm Field",
	"LIGHTNING_CONTINUOUS":			"Plasma Blast",
	"LIGHTNING_BEAM":			"Thunderstrike Beam",
	"LIGHTNING_MISSILE":		"Zap Missile",
	"LIGHTNING_SHIELD":			"Static Wall",
	"LIGHTNING_ROCK":			"Charged Boulder",

	"PIERCING_GROUND_EFFECT":	"Spike Field",
	"PIERCING_CONTINUOUS":			"Arrow Flare",
	"PIERCING_BEAM":			"Penetration Beam",
	"PIERCING_MISSILE":			"Piercing Bolt",
	"PIERCING_SHIELD":			"Barbed Shield",
	"PIERCING_ROCK":			"Shard Boulder",

	"SLASHING_GROUND_EFFECT":	"Blade Vortex",
	"SLASHING_CONTINUOUS":			"Infernal Blade",
	"SLASHING_BEAM":			"Cutting Beam",
	"SLASHING_MISSILE":			"Bladed Missile",
	"SLASHING_SHIELD":			"Razor Wall",
	"SLASHING_ROCK":			"Shrapnel Boulder",

	"BLUDGEONING_GROUND_EFFECT":	"Earthquake",
	"BLUDGEONING_CONTINUOUS":			"Molten Hammer",
	"BLUDGEONING_BEAM":			"Crushing Beam",
	"BLUDGEONING_MISSILE":		"Boulder Shot",
	"BLUDGEONING_SHIELD":		"Heavy Wall",
	"BLUDGEONING_ROCK":			"Boulder",

	"HOLY_GROUND_EFFECT":		"Sanctified Zone",
	"HOLY_CONTINUOUS":				"Holy Flame",
	"HOLY_BEAM":				"Divine Ray",
	"HOLY_MISSILE":				"Angel's Spear",
	"HOLY_SHIELD":				"Sacred Barrier",
	"HOLY_ROCK":				"Blessed Boulder",

	"SHADOW_GROUND_EFFECT":		"Shadow Veil",
	"SHADOW_CONTINUOUS":				"Abyssal Flame",
	"SHADOW_BEAM":				"Obsidian Ray",
	"SHADOW_MISSILE":			"Cursed Missile",
	"SHADOW_SHIELD":			"Dark Barrier",
	"SHADOW_ROCK":				"Void Boulder",

	"MAGIC_GROUND_EFFECT":		"Arcane Circle",
	"MAGIC_CONTINUOUS":				"Enchanted Flame",
	"MAGIC_BEAM":				"Mana Beam",
	"MAGIC_MISSILE":			"Mystic Missile",
	"MAGIC_SHIELD":				"Runic Barrier",
	"MAGIC_ROCK":				"Arcane Boulder",

	"COLD_GROUND_EFFECT":		"Frost Patch",
	"COLD_CONTINUOUS":				"Freezing Flame",
	"COLD_BEAM":				"Cryo Beam",
	"COLD_MISSILE":				"Frost Missile",
	"COLD_SHIELD":				"Glacial Barrier",
	"COLD_ROCK":				"Ice Boulder"
}

var tower_descriptions = {
	"FIRE_GROUND_EFFECT":	"Scorches enemies on the ground over time.",
	"FIRE_CONTINUOUS":			"Engulfs enemies in flames with high damage.",
	"FIRE_BEAM":			"Melts through armor with intense heat.",
	"FIRE_MISSILE":			"Launches explosive fire projectiles.",
	"FIRE_SHIELD":			"Burns attackers who strike it.",
	"FIRE_ROCK":			"Rolls fiery boulders at enemies.",

	"LIGHTNING_GROUND_EFFECT":	"Electrifies the ground, stunning enemies.",
	"LIGHTNING_CONTINUOUS":			"Fires arcing bolts of energy.",
	"LIGHTNING_BEAM":			"Continuous shocking beam.",
	"LIGHTNING_MISSILE":		"Homes in and chains electricity between enemies.",
	"LIGHTNING_SHIELD":			"Reflects and shocks attackers.",
	"LIGHTNING_ROCK":			"Electrifies enemies on impact.",

	"PIERCING_GROUND_EFFECT":	"Deals constant piercing damage.",
	"PIERCING_CONTINUOUS":			"Launches flaming arrows that pierce targets.",
	"PIERCING_BEAM":			"Pierces through all enemies in its path.",
	"PIERCING_MISSILE":			"Homes in and punches through multiple targets.",
	"PIERCING_SHIELD":			"Reflects piercing damage.",
	"PIERCING_ROCK":			"Shatters into piercing fragments.",

	"SLASHING_GROUND_EFFECT":	"Spins blades on the ground, cutting enemies.",
	"SLASHING_CONTINUOUS":			"Ignites slashes with fiery energy.",
	"SLASHING_BEAM":			"Slices through enemies cleanly.",
	"SLASHING_MISSILE":			"Launches spinning bladed projectiles.",
	"SLASHING_SHIELD":			"Damages attackers with sharp edges.",
	"SLASHING_ROCK":			"Explodes into cutting shards.",

	"BLUDGEONING_GROUND_EFFECT":	"Shakes the ground to bludgeon enemies.",
	"BLUDGEONING_CONTINUOUS":			"Smashes enemies with fiery strikes.",
	"BLUDGEONING_BEAM":			"Delivers concussive force.",
	"BLUDGEONING_MISSILE":		"Lobs heavy bludgeoning projectiles.",
	"BLUDGEONING_SHIELD":		"Slams attackers with blunt force.",
	"BLUDGEONING_ROCK":			"Cracks the ground on impact.",

	"HOLY_GROUND_EFFECT":		"Purifies enemies over time.",
	"HOLY_CONTINUOUS":				"Burns enemies with sacred fire.",
	"HOLY_BEAM":				"Focused beam of holy light.",
	"HOLY_MISSILE":				"Smite enemies with heavenly missiles.",
	"HOLY_SHIELD":				"Protects allies and damages foes on contact.",
	"HOLY_ROCK":				"Radiates holy energy on impact.",

	"SHADOW_GROUND_EFFECT":		"Weakens enemies over time.",
	"SHADOW_CONTINUOUS":				"Corrupts enemies with dark fire.",
	"SHADOW_BEAM":				"Destroys enemies with concentrated darkness.",
	"SHADOW_MISSILE":			"Tracks enemies and spreads corruption.",
	"SHADOW_SHIELD":			"Absorbs and retaliates with dark energy.",
	"SHADOW_ROCK":				"Implodes and draws enemies into darkness.",

	"MAGIC_GROUND_EFFECT":		"Enhances magic and damages enemies.",
	"MAGIC_CONTINUOUS":				"Burns enemies with magical fire.",
	"MAGIC_BEAM":				"Continuous arcane damage.",
	"MAGIC_MISSILE":			"Homes in and explodes with magic.",
	"MAGIC_SHIELD":				"Protects with a shield of magic runes.",
	"MAGIC_ROCK":				"Infused with magical force on impact.",

	"COLD_GROUND_EFFECT":		"Slows and damages enemies over time.",
	"COLD_CONTINUOUS":				"Chills enemies with icy fire.",
	"COLD_BEAM":				"Freezes enemies solid.",
	"COLD_MISSILE":				"Tracks and freezes targets.",
	"COLD_SHIELD":				"Protects and freezes attackers.",
	"COLD_ROCK":				"Crashes into enemies with chilling force."
}

var tower_type_price_dict = {
	TOWER_TYPE.GROUND_EFFECT: 10,
	TOWER_TYPE.CONTINUOUS: 5,
	TOWER_TYPE.BEAM: 30,
	TOWER_TYPE.MISSILE: 20,
	TOWER_TYPE.SHIELD: 10,
	TOWER_TYPE.ROCK: 1,
}
var damage_type_price_dict = {
	DAMAGE_TYPE.LIGHTNING: 10,
	DAMAGE_TYPE.FIRE: 5,
	DAMAGE_TYPE.PIERCING: 5,
	DAMAGE_TYPE.SLASHING: 5,
	DAMAGE_TYPE.BLUDGEONING: 5,
	DAMAGE_TYPE.HOLY: 15,
	DAMAGE_TYPE.MAGIC: 10,
	DAMAGE_TYPE.SHADOW: 15,
	DAMAGE_TYPE.COLD: 5
}
var tier_type_price_dict = {
	TIER_TYPE.I : 2,
	TIER_TYPE.II : 4,
	TIER_TYPE.III : 16,
	TIER_TYPE.IV : 256,
	TIER_TYPE.V : 65536
}
var money : int = 150000000

enum TOWER_TYPE {GROUND_EFFECT, CONTINUOUS, BEAM, MISSILE, SHIELD, ROCK}
enum DAMAGE_TYPE {FIRE, LIGHTNING, PIERCING, SLASHING, BLUDGEONING, HOLY, SHADOW, MAGIC, COLD}
enum ENEMY_TYPE {MELEE, RANGED}
enum UPGRADE_TYPE {BASE_DAMAGE, ATTACK_SPEED, TIER, RANGE}
enum MONEY_LABEL_TYPE {PLAYER_MONEY, DAMAGE_TYPE_PRICE, TOWER_TYPE_PRICE, TIER_PRICE, TOTAL_PRICE, COST}
enum TIER_TYPE {I, II, III, IV, V}
enum QUALITY {POOR, COMMON, UNCOMMON, RARE, EPIC, LEGENDARY, ASCENDANT}
const TOWER_BASE_POSITION : int = 490
const e = 2.71828

signal buy_tower(tower_type : TowerType, cost : int)
signal show_error_message(error_msg : String)
signal update_coin_ui(new_coin_amount : int, money_label_type : MONEY_LABEL_TYPE)
signal send_layers_to_ui(layers : Array[TowerLayer])
signal request_layers()
signal update_upgrade_panel(tower_layer_stat_ranks : Dictionary)
signal increase_rank(upgrade_type : UPGRADE_TYPE, cost : int)
signal send_tower_info_to_ui(info_dict : Dictionary)
signal kill_enemy(enemy_reference : Enemy)
	
func _ready() -> void:
	update_coin_ui.emit(money, MONEY_LABEL_TYPE.PLAYER_MONEY)

func update_player_money(cost : int):
	# use negative cost to subtract_money
	money = money + cost
	update_coin_ui.emit(money, MONEY_LABEL_TYPE.PLAYER_MONEY)

func get_rank_color(rank : int):
	if rank >= 300:
		return get_quality_color(GameRules.QUALITY.ASCENDANT)
	elif rank >= 200:
		return get_quality_color(GameRules.QUALITY.LEGENDARY)
	elif rank >= 100:
		return get_quality_color(GameRules.QUALITY.EPIC)
	elif rank >= 50:
		return get_quality_color(GameRules.QUALITY.RARE)
	elif rank >= 25:
		return get_quality_color(GameRules.QUALITY.UNCOMMON)
	elif rank >= 10:
		return get_quality_color(GameRules.QUALITY.COMMON)
	else:
		return get_quality_color(GameRules.QUALITY.POOR)

func get_quality_color(quality: QUALITY):
	match quality:
		QUALITY.POOR:
			return "#9d9d9d"
		QUALITY.COMMON:
			return "#ffffff"
		QUALITY.UNCOMMON:
			return "#1eff00"
		QUALITY.RARE:
			return "#0070dd"
		QUALITY.EPIC:
			return "#a335ee"
		QUALITY.LEGENDARY:
			return "#ff8000"
		QUALITY.ASCENDANT:
			return "#e6cc80"
			

func get_tower_type_price(tower_type : TOWER_TYPE):
	return tower_type_price_dict[tower_type]

func get_damage_type_price(damage_type : DAMAGE_TYPE):
	return damage_type_price_dict[damage_type]
	
func get_tier_type_price(tier_type : TIER_TYPE):
	return tier_type_price_dict[tier_type]

func gen_tower_key(damage_type : DAMAGE_TYPE, tower_type : TOWER_TYPE):
	return DAMAGE_TYPE.find_key(damage_type) + "_" + TOWER_TYPE.find_key(tower_type)

func calculate_cost(rank : int) -> int:
	return roundi(1.7446 * pow(1.1464, rank))

func get_new_tower_type(tower_type : TOWER_TYPE, damage_type : DAMAGE_TYPE, tier_type: TIER_TYPE):
	var new_tower_layer_type = TowerType.new()
	new_tower_layer_type.name = tower_names[gen_tower_key(damage_type, tower_type)]
	new_tower_layer_type.tower_type = tower_type
	new_tower_layer_type.tier_type = tier_type
	new_tower_layer_type.base_damage_type = damage_type
	new_tower_layer_type.base_damage = (tier_type + 1) * 1
	new_tower_layer_type.attack_speed = 1
	new_tower_layer_type.range = 50
	return new_tower_layer_type
