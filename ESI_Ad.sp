#pragma semicolon 1

#define DEBUG

#define ESI " \x01[\x0EESI\x01]\x01"
#define ESIC "[ESI]"

#define PLUGIN_AUTHOR "Senor"
#define PLUGIN_VERSION "1.1.2"

#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <geoip>

#pragma newdecls required

EngineVersion g_Game;

public Plugin myinfo = 
{
	name = "[ESI] Advertisement System",
	author = PLUGIN_AUTHOR,
	description = "",
	version = PLUGIN_VERSION,
	url = ""
};

Handle FindAd;
Handle FindCM;
Handle FindDM;

public void OnPluginStart()
{
	g_Game = GetEngineVersion();
	if(g_Game != Engine_CSGO && g_Game != Engine_CSS)
	{
		SetFailState("This plugin is for CSGO/CSS only.");	
	}
	// ESI ALL-SERVERS Advertisement  //
	// * Teamspeak 3 Advertisement   //
	// * Wesbite Advertisement      //
	// * ESI Servers Advertisement //
	CreateConVar("esi_advertisement_enabled", "1", "Enables the ESI ad system");
	FindAd = FindConVar("esi_advertisement_enabled");
	
	CreateTimer(180.0, ESITS, _, TIMER_REPEAT);
	CreateTimer(160.0, ESIWEB, _, TIMER_REPEAT);
	CreateTimer(200.0, ESISERVERS, _, TIMER_REPEAT);
	CreateTimer(210.0, ESIDIS, _, TIMER_REPEAT);
	
	//ESI CONNECT-MESSAGE//
	CreateConVar("esi_cm_enabled", "1", "Enables the ESI connect-message");
	CreateConVar("esi_dm_enabled", "1", "Enables the ESI disconnect-message");
	FindCM = FindConVar("esi_cm_enabled");
	FindDM = FindConVar("esi_dm_enabled");
	
	//ESI Server-List//
	RegConsoleCmd("sm_servers", Command_Servers, "Shows ESI Server List");
	RegConsoleCmd("sm_server", Command_Servers, "Shows ESI Server List");
	RegConsoleCmd("sm_esi", Command_ESI, "Shows ESI Soical Medias");
	
	//ESI Menu-CommandList//
	RegAdminCmd("sm_ad", Command_Ad, ADMFLAG_BAN);
}

public Action ESITS(Handle Timer)
{
	static int numPrinted = 0;
	if (numPrinted >= 1)
    {
        {
        numPrinted = 0;
        return Plugin_Stop;
        }
    }
	if (GetConVarInt(FindAd) == 1)
	{
		PrintToChatAll("%s \x01Wanna play with someone? You are more than welcome to join our Teamspeak at : \x06ts.esi.org.il", ESI);
	}
	
	return Plugin_Stop;
}

public Action ESIWEB(Handle Timer)
{
	static int numPrinted = 0;
	if (numPrinted >= 1)
    {
        {
        numPrinted = 0;
        return Plugin_Stop;
        }
    }
	if (GetConVarInt(FindAd) == 1)
	{
		PrintToChatAll("%s \x01We are always looking for more staff members, Join our website now and introduce yourself at : \x06www.esi.org.il", ESI);
	}
	
	return Plugin_Stop;
}

public Action ESISERVERS(Handle Timer)
{
	static int numPrinted = 0;
	if (numPrinted >= 1)
    {
        {
        numPrinted = 0;
        return Plugin_Stop;
        }
    }
	if (GetConVarInt(FindAd) == 1)
	{
		PrintToChatAll("%s \x01Visit our other servers! by write \x06!servers\x01 you will see all of them", ESI);
	}
	
	return Plugin_Stop;
}
public Action ESIDIS(Handle Timer)
{
	static int numPrinted = 0;
	if (numPrinted >= 1)
    {
        {
        numPrinted = 0;
        return Plugin_Stop;
        }
    }
	if (GetConVarInt(FindAd) == 1)
	{
		PrintToChatAll("%s \x01Wanna talk with someone? You are more than welcome to join our Discord at : \x06discord.me/esisrael", ESI);
	}
	
	return Plugin_Stop;
}

public void OnClientAuthorized(int client, const char[] auth){
	if (GetConVarInt(FindCM) == 1)
	{
	char pName[32];
	char STEAMID[32];
	char IP[3];
	char ccode[3];
	
	GetClientName(client, pName, sizeof(pName));
	
	GetClientAuthId(client, AuthId_Steam2, STEAMID, 32);
	
	GetClientIP(client, IP, sizeof(IP));
	
	GeoipCode2(IP, ccode);
	if (!GeoipCode2(IP, ccode))
	{
		PrintToChatAll("%s %s\x01 [\x06%s\x01] has \x06connected\x01 to the server." ,ESI, pName, STEAMID);
	}
	if (IsFakeClient(client))
	{
		return;
	}
	
	PrintToChatAll("%s %s\x01 [\x06%s\x01] has \x06connected\x01 from \x06%s" ,ESI, pName, STEAMID, ccode);
	}
}


public void OnClientDisconnect(int client)
{
	if (GetConVarInt(FindDM) == 1)
	{
		char name[32];
		char STEAMID[32];
		
		GetClientName(client, name, sizeof(name));
		
		GetClientAuthId(client, AuthId_Steam2, STEAMID, 32);
		if (IsFakeClient(client))
		{
			return;
		}
		
		PrintToChatAll("%s %s\x01 [\x07%s\x01] has \x07disconnected\x01 from the server" ,ESI, name, STEAMID);
	}
}

public Action Command_Servers(int client, int args)
{
	ServersMenu(client, args);
}

public Action Command_ESI(int client, int args)
{
	ESIMenu(client, args);
}

public int MenuHandler1337(Menu m, MenuAction a, int p1, int p2)
 {
 	if (a == MenuAction_Select)
 	{
 		char args1[32];
 		GetMenuItem(m, p2, args1, sizeof(args1));
 		// * Prints To Console + Chat because ReplyToCommand prints colors that doesnt work to console (\x01) etc... //
 		if(StrEqual(args1, "retakes"))
 		{
 			PrintToChat(p1, "%s Our \x06Retakes #1\x01 Server will be opened soon.", ESI);
 			PrintToConsole(p1, "%s Our Retakes #1 Server will be opened soon.", ESIC);
 		}
 		else if (StrEqual(args1, "retakes2"))
 		{
 			PrintToChat(p1, "%s Our \x06Retakes #2\x01 Server will be opened soon.", ESI);
 			PrintToConsole(p1, "%s Our Retakes #2 Server will be opened soon.", ESIC);
 		}
 		else if(StrEqual(args1, "arena"))
 		{
 			PrintToChat(p1, "%s Our \x06Arena Multi-1vs1\x01 Server will be opened soon.", ESI);
 			PrintToConsole(p1, "%s Our Arena Multi-1vs1 Sserver will be opened soon.", ESIC);
 		}
 		else if(StrEqual(args1, "casual"))
 		{
 			PrintToChat(p1, "%s Our \x06Casual - FFA\x01 Server will be opened soon.", ESI);
 			PrintToConsole(p1, "%s Our Casual - FFA Server will be opened soon.", ESIC);
 		}
 	}
 }

public void ServersMenu(int client, int args){
 Menu menu = new Menu(MenuHandler1337);
 menu.SetTitle("ESI Links :");
 menu.AddItem("retakes", "Retakes #1");
 menu.AddItem("retakes2", "Retakes #2");
 menu.AddItem("arena", "Arena Multi-1vs1");
 menu.AddItem("casual", "Casual - FFA");

 menu.ExitButton = true;
 menu.Display(client, 20);
 
 PrintToChat(client, "%s Our \x06Soical Medias\x01 available! write \x06!esi\x01 to see them");
}

public int MenuHandler3(Menu m, MenuAction a, int p1, int p2)
 {
 	if (a == MenuAction_Select)
 	{
 		char args1[32];
 		GetMenuItem(m, p2, args1, sizeof(args1));
 		// * Prints To Console + Chat because ReplyToCommand prints colors that doesnt work to console (\x01) etc... //
 		if(StrEqual(args1, "forum"))
 		{
 			PrintToChat(p1, "%s Our \x06Forum\x01 linked at : \x06www.esi.org.il", ESI);
 			PrintToConsole(p1, "%s Our 06Forum linked at : www.esi.org.il", ESIC);
 		}
 		else if (StrEqual(args1, "teamspeak"))
 		{
 			PrintToChat(p1, "%s Our \x06Teamspeak 3 Server\x01 linked at : \x06ts.esi.org.il", ESI);
 			PrintToConsole(p1, "%s Our Teamspeak 3 Server linked at : ts.esi.org.il", ESIC);
 		}
 		else if (StrEqual(args1, "discord"))
 		{
 			PrintToChat(p1, "%s Our \x06Discord\x01 linked at : \x06discord.me/esisrael", ESI);
 			PrintToConsole(p1, "%s Our Discord linked at : discord.me/esisrael", ESIC);
 		}
 	}
 }

public void ESIMenu(int client, int args){
 Menu menu = new Menu(MenuHandler3);
 menu.SetTitle("ESI Links :");
 menu.AddItem("forum", "Forum");
 menu.AddItem("teamspeak", "Teamspeak");
 menu.AddItem("discord", "Discord");
 
 menu.ExitButton = true;
 menu.Display(client, 20);
}

public int MenuHandler4(Menu m, MenuAction a, int p1, int p2)
 {
 	if (a == MenuAction_Select)
 	{
 		char args1[32];
 		GetMenuItem(m, p2, args1, sizeof(args1));
 		if(StrEqual(args1, "forum"))
 		{
 			PrintToChatAll("%s \x01We are always looking for more staff members, Join our website now and introduce yourself at : \x06www.esi.org.il", ESI);
 		}
 		else if(StrEqual(args1, "teamspeak"))
 		{
 			PrintToChatAll("%s \x01Wanna play with someone? You are more than welcome to join our Teamspeak at : \x06ts.esi.org.il", ESI);
 		}
 		else if(StrEqual(args1, "discord"))
 		{
 			PrintToChatAll("%s \x01Wanna talk with someone? You are more than welcome to join our Discord at : \x06discord.me/esisrael", ESI);
 		}
 		else if(StrEqual(args1, "enable"))
 		{
 			
 			if (GetConVarInt(FindAd) == 1){
 				PrintToChat(p1, "%s The Advertisement mod is already \x06Enabled\x01.", ESI);
 				return;
 			}
 			else if(GetConVarInt(FindAd) == 0)
 			{
 				SetConVarInt(FindConVar("esi_advertisement_enabled"), 1);
 				PrintToChat(p1, "%s The Advertisement mod is \x06Enabled\x01 now.", ESI);
 				return;
 			}
 			}
 			else if (StrEqual(args1, "disable"))
 			{
 				if (GetConVarInt(FindAd) == 0)
 				{
 					PrintToChat(p1, "%s The Advertisement mod is already \x07Disabled\x01.", ESI);
 					return;
 				}
 				else if (GetConVarInt(FindAd) == 1)
 				{
 					SetConVarInt(FindConVar("esi_advertisement_enabled"), 0);
 					PrintToChat(p1, "%s The Advertisement mod is now \x07Disabled\x01.", ESI);
 					return;
 				}
 			}
 			else if(StrEqual(args1, "connect"))
 			{
 				if ((GetConVarInt(FindCM) == 1) && (GetConVarInt(FindDM) == 1))
 				{
 					PrintToChat(p1, "%s \x06Connect \x01 & \x07Disconnect\x01 Message is already \x06Enabled\x01!", ESI);
	 				return;
	 			}
	 			else if ((GetConVarInt(FindCM) == 0) && (GetConVarInt(FindDM) == 0))
	 			{
	 				SetConVarInt(FindConVar("esi_cm_enabled"), 1);
	 				SetConVarInt(FindConVar("esi_dm_enabled"), 1);
	 				PrintToChat(p1, "%s \x06Connect \x01 & \x07Disconnect\x01 Message is now \x06Enabled\x01!", ESI);
	 				return;
	 			}
	 		}
	 		else if (StrEqual(args1, "disconnect"))
	 		{
	 			if ((GetConVarInt(FindCM) == 0) && (GetConVarInt(FindDM) == 0))
	 			{
	 				PrintToChat(p1, "%s \x06Connect \x01 & \x07Disconnect\x01 Message is already \x07Disabled\x01!", ESI);
	 			}
	 			else if ((GetConVarInt(FindCM) == 1) && (GetConVarInt(FindDM) == 1))
	 			{
	 				SetConVarInt(FindConVar("esi_cm_enabled"), 0);
	 				SetConVarInt(FindConVar("esi_dm_enabled"), 0);
	 				PrintToChat(p1, "%s \x06Connect \x01 & \x07Disconnect\x01 Message is now \x07Disabled\x01!", ESI);
	 				return;
 			}
 		}
 	}
 }




public Action Command_Ad(int client, int args)
{
	Menu menu = new Menu(MenuHandler4);
	menu.SetTitle("ESI Ad :");
	menu.AddItem("enable", "Enable AutoMessage [Online OnMapStarts]");
	menu.AddItem("disable", "Disable AutoMessage");
	menu.AddItem("connect", "Enable (Dis)Connect Message");
	menu.AddItem("disconnect", "Disable (Dis)connect Message");
	menu.AddItem("forum", "Forum");
	menu.AddItem("teamspeak", "Teamspeak");
	menu.AddItem("discord", "Discord");
	 
	menu.ExitButton = true;
	menu.Display(client, MENU_TIME_FOREVER);
}
