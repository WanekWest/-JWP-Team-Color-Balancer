# -JWP-Team-Color-Balancer
Плагин добавляет в меню Командира новый пункт: Распределить на команды.
Данный плагин позволяет распределить зэков(террористов) на 2,3,4 команды,с учетом времени,которое будет необходимо Командиру(30 сек,60 сек,120 сек).

JailWestTeamer.sp закинуть по пути: addons/sourcemod/scripting  (Не обязательно).

JailWestTeamer.smx закинуть по пути: addons/sourcemod/plugins


В jwp_modules.phrases.txt добавить (На выбор):

    "Team_Color_Menu"
    {
        "en" "Team coloring"
    }

    "Team_Color_Menu"
    {
        "ru"    "Распределить по командам"
    }

В warden_menu.txt добавить:

    "teamcolor"
    {
        "flag"  ""
    }
