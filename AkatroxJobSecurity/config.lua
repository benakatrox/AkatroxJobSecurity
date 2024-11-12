Config = {}

-- Mesleklere göre silah izni ayarlama aşağıda eklediğiniz silahı yanında belirttiğiniz meslekler dışında kimse kullanamayacaktır.
-- ["SilahAdı"] = {"Meslek1","Meslek2"},

-- Arranging gun permits according to professions. No one will be able to use the gun you added below except for the professions you specified.
-- ["WeaponName"] = {"Job1","Job2"},

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

-- Setting vehicle permits according to professions. No one will be able to use the vehicle you added below except for the professions you specified. (they can sit in other seats except the driver),
-- ["JobName"] = {"Vehicle1","Vehicle2"},

Config.RestrictedVehicles = {
    ["police"] = {"police", "police2", "police3"},
    ["sheriff"] = {"sheriff", "sheriff2"}
}
