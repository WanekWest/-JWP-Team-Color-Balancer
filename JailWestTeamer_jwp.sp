#pragma semicolon 1
#pragma newdecls required

#include <jwp>

#define ITEM "teamcolor"

public Plugin myinfo =
{
	name        = 	"JailWestTeamer",
	author      = 	"WanekWest",
	version     = 	"1.1",
	url         = 	"https://vk.com/wanek_west"
};

bool TimeWork = false;

int teams;

public void OnPluginStart()
{
	HookEvent("round_start", Event_OnRoundStart);
	HookEvent("round_end", Event_OnRoundStart);

	LoadTranslations("jwp_modules.phrases");
}

public void OnAllPluginsLoaded()
{
	if (JWP_IsStarted()) JWP_Started();
}

public void Event_OnRoundStart(Event event, const char[] name, bool dontBroadcast)
{
	if(TimeWork)
	{
		for (int i = 1; i <= MaxClients; ++i)
		{
			if(IsClientConnected(i) && IsClientInGame(i) && !IsClientSourceTV(i)  && IsPlayerAlive(i))
			{
				if(GetClientTeam(i) == 2)
				{
					SetEntityRenderMode(i, RENDER_TRANSCOLOR);
					SetEntityRenderColor(i, 255, 255, 255, 255);
				}
			}
		}
	}
	TimeWork = false;
}

public void JWP_Started()
{
	JWP_AddToMainMenu(ITEM, OnFuncDisplay, OnFuncSelect);
}

public void OnPluginEnd()
{
	JWP_RemoveFromMainMenu();
}

public bool OnFuncDisplay(int client, char[] buffer, int maxlength, int style)
{
	Format(buffer, maxlength, "%T", "Team_Color_Menu", LANG_SERVER);
	return true;
}

public bool OnFuncSelect(int Client)
{
	teamer(Client);
	return true;
}

public Action teamer(int iClient)
{
	Menu hMenu = new Menu(MenuHandler_MyMenu, MenuAction_Select|MenuAction_Cancel);
	hMenu.SetTitle("Разделить игроков на команды");
	hMenu.AddItem("item1", "2 команды");
	hMenu.AddItem("item2", "3 команды");
	hMenu.AddItem("item3", "4 команды");
	hMenu.AddItem("item4", "Убрать резделление команд");
	hMenu.Display(iClient, 20);
}

public Action timeteam(int iClient)
{
	Menu tMenu = new Menu(MenuHandler_TimeMenu, MenuAction_Select|MenuAction_Cancel);
	tMenu.SetTitle("Время на которое разделять команды");
	tMenu.AddItem("item1", "30 секунд");
	tMenu.AddItem("item2", "60 секунд");
	tMenu.AddItem("item3", "2 минуты");
	tMenu.Display(iClient, 20);
}

public int MenuHandler_MyMenu(Menu hMenu, MenuAction action, int iClient, int iItem)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			if(!TimeWork)
			{
				if(iItem == 0)
				{
					teams = 2;
					timeteam(iClient);
				}

				else if(iItem == 1)
				{
					teams = 3;
					timeteam(iClient);
				}

				else if(iItem == 2)
				{
					teams = 4;
					timeteam(iClient);
				}
			}
			else
			{
				if(iItem == 3 && TimeWork)
				{
				TimeWork = true;
				CreateTimer(0.2, Timer_Team, _, TIMER_FLAG_NO_MAPCHANGE);
				}
			}
		}

		case MenuAction_End:
		{
			delete hMenu;
		} 
	}
	return 0;
}

public int MenuHandler_TimeMenu(Menu tMenu, MenuAction action, int iClient, int pynkt)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			if(!TimeWork)
			{
				if(pynkt == 0)
				{
					coloring(teams);
					TimeWork = true;
					CreateTimer(30.0, Timer_Team, _, TIMER_FLAG_NO_MAPCHANGE);
				}
			
				else if(pynkt == 1)
				{
					coloring(teams);
					TimeWork = true;
					CreateTimer(60.0, Timer_Team, _, TIMER_FLAG_NO_MAPCHANGE);
				}

				else if(pynkt == 2)
				{
					coloring(teams);
					TimeWork = true;
					CreateTimer(120.0, Timer_Team, _, TIMER_FLAG_NO_MAPCHANGE);
				}
			}
		}
		case MenuAction_End:
		{
			delete tMenu;
		}
	}
		   
}

public Action Timer_Team(Handle hTimer, any UserId) // Каллбек нашего таймера
{
	TimeWork = false;
	for (int i = 1; i <= MaxClients; ++i)
	{
		if(IsClientConnected(i) && IsClientInGame(i) && IsPlayerAlive(i) && !IsClientSourceTV(i))
		{
			if(GetClientTeam(i) == 2)
			{
				SetEntityRenderMode(i, RENDER_TRANSCOLOR);
				SetEntityRenderColor(i, 255, 255, 255, 255);
			}
		}
	}
	return Plugin_Stop;
}

public Action coloring(int Args)
{
	int j=0;
	if(Args == 2)
	{
		for (int i = 1; i <= MaxClients; ++i)
		{
			if(IsClientConnected(i) && IsClientInGame(i) && !IsClientSourceTV(i)  && IsPlayerAlive(i))
			{
				if(GetClientTeam(i) == 2)
				{
					++j;
					if(j == 1)
					{
						SetEntityRenderColor(i, 255, 0, 0, 255);
					}

					else if(j == 2)
					{
						SetEntityRenderColor(i, 0, 65, 255, 255);
						j=0;
					}
				}
			}
		}
	}
	else if(Args == 3)
	{
		for (int i = 1; i <= MaxClients; ++i)
		{
			if(IsClientConnected(i) && IsClientInGame(i) && !IsClientSourceTV(i)  && IsPlayerAlive(i))
			{
				if(GetClientTeam(i) == 2)
				{
					++j;
					if(j == 1)
					{
						SetEntityRenderColor(i, 255, 0, 0, 255);
					}

					else if(j == 2)
					{
						SetEntityRenderColor(i, 0, 65, 255, 255);
					}

					else if(j == 3)
					{
						SetEntityRenderColor(i, 255, 255, 0, 255);
						j=0;
					}
				}
			}
		}
	}
	else if(Args == 4)
	{
		for (int i = 1; i <= MaxClients; ++i)
		{
			if(IsClientConnected(i) && IsClientInGame(i)  && IsPlayerAlive(i))
			{
				if(GetClientTeam(i) == 2)
				{
					++j;
					if(j == 1)
					{
						SetEntityRenderColor(i, 255, 0, 0, 255); // red
					}

					else if(j == 2)
					{
						SetEntityRenderColor(i, 0, 65, 255, 255); // blue
					}

					else if(j == 3)
					{
						SetEntityRenderColor(i, 255, 80, 0, 255); // orange
					}

					else if(j == 4)
					{
						SetEntityRenderColor(i, 20, 255, 20, 255); // green
						j=0;
					}
				}
			}
		}
	}
}