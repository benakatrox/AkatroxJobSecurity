Config = {}

-- Mesleklere göre silah izni ayarlama aşağıda eklediğiniz silahı yanında belirttiğiniz meslekler dışında kimse kullanamayacaktır.

-- ["Silah Adı"] = {"Meslek1","Meslek2"},

Config.RestrictedItems = {
    weapons = {
        ["weapon_glock"] = {"police"},
        ["weapon_smg"] = {"sheriff"}
    },
    ammo = {
        ["pistol_ammo2"] = {"police"},
        ["pistol_ammo3"] = {"sheriff"}
    }
}

-- Mesleklere göre araç izni ayarlama aşağıda eklediğiniz aracı yanında belirttiğiniz meslekler dışında kimse kullanamayacaktır. (şoför hariç diğer koltuklara oturabilirler),

-- ["Meslek Adı"] = {"Araç1","Araç2"},

Config.RestrictedVehicles = {
    ["police"] = {"police", "police2", "police3"},
    ["sheriff"] = {"sheriff", "sheriff2"}
}
