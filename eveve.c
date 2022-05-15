namespace Setup;
int DateTime, Nonce, nDone;
int FlushLength = 450 * 1000000;
int nShard, nTotal, UID_Est, ZoneShift;
bool NEW;					// new kuavail-based processing

string News = "CHANGO MESTIZO";//BANGSALDEOTA BANGSSOUL CHANGO";			//MESTIZO GALEA MENEER";
btree bNew = btree(50, 500);
forall(News, " ") {reserved string Next; bNew.append(Next);}

array Hours[], Unavail[];
string EstName, Joined, Out, Summ, TimeZone, NoAvail = string(10000);
float TimeStep;
string Files = string(1000);
string AreaList = string(10000);

namespace Client;
namespace Sizes {int Covers, Duration, Spots, Tables[];}
table tArea, tComb, tUnavail;
table tAvail;					// +15/10/21
int aArea[], MinSize, MaxSize;

action Flush() {
	string File = form("$DATA/shards/Shard_{iTask}_{nShard}.json");
	Joined.tailtrim(",\n");
	//File = File.filename();
	Joined.filesave(File);
	if (ALONE) {
		Joined += "]}"; Joined.clipset();
		printf("Save {File}\n");
	}
	Files += " " + File;
	Joined.clear();
	++nShard;
}

string Human;
action string GetUTC(int Date, float TOD) {
	int Local, UTC;
	Local = $DateTime.DateAndTime(Date, TOD);
	UTC = Local - ZoneShift;
	Human = $DateTime.DateTime(Local);
	if (HUMAN) return form("\34{Human}\34");
	else return form("{UTC}");
}

string respArea = "{{\034party_size\034:{Size},
\034room_id\034:\034{UID_Est}_{UID_Area}\034,
\034room_name\034:\034{AreaName}\034}
";

string respAny = "{{\034party_size\034:{Size},
\034room_id\034:\034{UID_Est}_0\034,
\034room_name\034:\034\034}
";
string respParty = "{{\034party_size\034:{Size}}";

action SlotOut(int UID_Area, Size, Date, float TOD) {
	string AreaName, Extra, Resource;
//printf("SlotOut {Date}/{TOD} covers={Size}\n");
//if (UID_Area > 0) return;///TBD
	if (UID_Area < 0) {
/*
		if (TMS.AreaRWG) {
			Resource = form(respAny);
		}
		else */
		Resource = form(respParty);
		if (tUnavail.find(/Area)) tUnavail.select(-1, /Area, equal(), 0);
		else tUnavail.all();
		
	} else {
		tUnavail.select(UID_Area, /Area, equal(), 0);
		if (tArea.uidset(UID_Area)) {
			if (tArea.Name == "Any") AreaName = "";
			else AreaName = tArea.Name.unicode(3);
		}
		else AreaName = form("{UID");
		Resource = form(respArea);
	}
	tUnavail.select(Date, /Date, equal(), 1);
	if (!tUnavail.select(Size, /Covers, equal(), 1)) {
		return;
	}
	forall(cursor(tUnavail)) {
		string DD; float Unavail[]; int Avail;
		Unavail = tUnavail.Hours;
//if (UID_Area < 0) {print(tUnavail); debug();}
		DD = GetUTC(Date, TOD);
		if (Unavail.find(TOD)) {
//printf("Unavail for {Size} at {TOD} DT={DT}\n");
			Avail = 0;
//					// 6/11/20: RWG needs to show times with no avail as valid bookable times
//					continue;		// +25/3/19, don't report slots with zero availability
		} else {
			Avail = 5; ++nTotal;
		}
//SS = form("{Date}+{TOD}");
		Out += form("{{\034spots_total\034:5,\n\034spots_open\034:{Avail},\n");
		Extra = form("\034service_id\034:\0341000\034,\n\034merchant_id\034:\034{tService.UID}\034");
		Out += form("\034start_sec\034:{DD},		# {Human}\n");
		Out += form("\034duration_sec\034:7200,\n{Extra},\n");
		Out += form("\034resources\034:{Resource}");
//if (Resource.find("Any")) {Out.clipset(); debug();}
//print(tUnavail); print(Out); debug();
		Out += "},\n";
	}
}

action SlotOutNew(int UID_Area, Size, Date, float TOD) {
	string AreaName, Extra, Resource;
//printf("SlotOut {Date}/{TOD} covers={Size}\n");
//if (UID_Area > 0) return;///TBD
	if (UID_Area < 0) {
		Resource = form(respParty);
//		if (tUnavail.find(/Area)) tUnavail.select(-1, /Area, equal(), 0);
//		else tUnavail.all();
		tAvail.all();
		
	} else {
		tAvail.select(UID_Area, /UID_Area, equal(), 0);
		if (tArea.uidset(UID_Area)) {
			if (tArea.Name == "Any") AreaName = "";
			else AreaName = tArea.Name.unicode(3);
		}
		else AreaName = form("{UID");
		Resource = form(respArea);
	}
	tAvail.select(Date, /Date, equal(), 1);
	if (!tAvail.select(Size, /Covers, equal(), 1)) {
		return;
	}
	forall(cursor(tAvail)) {
		string DD; float Avail[]; int AvailCount;
		Avail = tAvail.Times;
//if (UID_Area < 0) {print(tAvail); debug();}
		DD = GetUTC(Date, TOD);
		if (Avail.find(TOD)) {
//printf("Unavail for {Size} at {TOD} DT={DT}\n");
			AvailCount = 5; ++nTotal;
		} else {
			AvailCount = 0;
		}
//SS = form("{Date}+{TOD}");
		Out += form("{{\034spots_total\034:5,\n\034spots_open\034:{AvailCount},\n");
		Extra = form("\034service_id\034:\0341000\034,\n\034merchant_id\034:\034{tService.UID}\034");
		Out += form("\034start_sec\034:{DD},		# {Human}\n");
		Out += form("\034duration_sec\034:7200,\n{Extra},\n");
		Out += form("\034resources\034:{Resource}");
//if (Resource.find("Any")) {Out.clipset(); debug();}
//print(tAvail); print(Out); debug();
		Out += "},\n";
	}
}

action AvailDate(int Date) {
	table tHours; string DD, DO, SS; float Hours[]; int Size;
//string SS;
	ZoneShift = ZoneAt(Date, 12.0);
//printf("{Date}: shift={ZoneShift}\n");
//forall(tUnavail) print(tUnavail);
	if (NEW) tHours = tAvail; else tHours = tUnavail;
	if (!tHours.select(Date, /Date, equal(), 0)) return;
	if (!tHours.select(0, /Covers, equal(), 1)) return;
	if (NEW) Hours = tHours.Times;
	else Hours = tHours.Hours;
	DD = $Date.DDMMYY(Date);
//print(Hours);
	forall(Hours) {
		reserved float TOD;
		forall(aArea) {
			reserved int UID_Area;
			for (Size = MinSize; Size <= MaxSize; ++Size) {
				if (NEW) SlotOutNew(UID_Area, Size, Date, TOD);
				else SlotOut(UID_Area, Size, Date, TOD);
				Summ += form("{DD} at {TOD} for {Size} pax");
				if (UID_Area > 0) Summ += form(", area {UID_Area}");
				Summ += "\n";
			}
		}
	}
//print(Out); Out.clipset(); debug();
}


action string AvailRWG() {
	int Date;
string DD;
	nTotal = 0;
	Out = string(1000000);
	Summ = string(100000);
	MinSize = max(TMS.InternetBookMin, MinCovers);
	MaxSize = min(TMS.InternetBookMax, MaxCovers);
//printf("min={MinSize}, max={MaxSize}\n");
	for (Date = $Date.now + DateOffset; Date < $Date.now + DateOffset + Horizon; ++Date) {
//DD = $Date.Easy(Date); printf("AvailRWG: Date={DD}\n");
		AvailDate(Date);
	}
//	if (Mode != "production")
	Out.filesave(form("c:/data/RWG/Reports/Human/{tService.EstName}.txt"));
	Summ.filesave(form("c:/data/RWG/Reports/Summary/{tService.EstName}.txt"));
	int NN = Out.strip("\9#", "\n");
	return Out;
}

action bool ZoneCheck(string Zone, Service) {
	int Need = $DateTime.DateAndTime($Date.now + 60, 12.0);
	if (!tDST.select(Zone, /Zone, equal(), 0)) {
		printf("Invalid timezone for {Service}: '{Zone}'\n");
		return false;
	}
	forall(cursor(tDST)) {
		if (To > Need) return true;
	}
	printf("There is no future shift data for timezone {Zone} for {Service}\n");
	debug();
	return false;
}

action int ZoneAt(int Date, float Time) {						// get timezone shift at specified date
	int Diff = 0;
	int When = $DateTime.DateAndTime(Date, Time);
	if (!tDST.select(TimeZone, /Zone, equal(), 0)) {
		printf("\n\nNo timezone data for {TimeZone}\ntype 'r' to go on UTC+0");
		debug();
		return;
	}
	tDST.sort(/To);
	forall(cursor(tDST)) {
//print(tDST);
		int Diff = round(Shift * 3600);
		if (To > When) {
			return Diff;
		}
	}
	printf("\n\n*** there is no suitable timezone change for timezone {TimeZone}\ntype 'r' to go on UTC+0");
	debug();
	return Diff;
}

action AreaSet(bool AREAS) {
	aArea.clear();
	if (AREAS) {
		forall(tArea) {
//print(tArea);
			if (Closed) continue;
			switch(Bookable) {
			case "", "Both", "Online":
				aArea.append(UID);
				break;
			default: break;
			}
		}
		if (TMS.AnyRWG) {
			aArea.append(-1);			// 3/2/21
		}
	} else aArea.append(-1);
}

action array TimesGet(string List) {
	float aTimes[];
	forall(List, " ") {
		reserved string Next; float TOD;
		TOD = Next.numget() * 0.25;
		aTimes.append(TOD);
	}
	return aTimes;
}

action Show(table tSend) {
	string DD; int Date;
	Date = $Date.now + 1;
	tSend.select(Date, /Date, equal(), 0);
	forall(cursor(tSend)) {
		string DD = $Date.DDMMYY(Date);
		print(tSend);
//		printf("{DD} {Hours}\n");
	}
	#
}


bool STAT;
namespace TMS {string EstName; int InternetBookMin, InternetBookMax; bool AreaRWG, AnyRWG;}
action PlanGetNew() {
	namespace NS; table tPlan, tSetup; int NN;
	STAT = true;
	tSetup = Client.$TMS.GetNamed(/tSetup);
	TMS.clear(false);			// 9.2.8 does not support areas
	TMS.copy(tSetup);
if (TMS.AreaRWG) {
	printf("\n*** {tService.EstName} has RWG areas set\n\n");
//	debug();
}
//printf("New processing for {tService.EstName}\n");
	tArea = Client.$TMS.GetNamed(/tArea);
	if (tSetup[0].AreaSelect) {
		NN = aArea.length();
		AreaList.append(form("{tService.EstName} ({UID_Est}) has {NN} areas\n"));
	}
	TimeZone = tSetup[0].TimeZone;
	if (!ZoneCheck(TimeZone, tService.EstName)) {
		STAT = false;
		return;
	}
	TimeStep = tSetup.TimeStepOnline;
	if (!/TimeStep) TimeStep = tSetup.TimeStep;
	tPlan = Client.$TMS.GetNamed(/tPlan);
	tComb = tPlan[0].tComb;
	if (!tSetup[0].AreaSelect) TMS.AreaRWG = false;			// +18/2/21
	AreaSet(TMS.AreaRWG);
	if (TMS.AreaRWG) {
		NS = Client.$TMS.@DAPI.@RWGF.Get(aArea);
	} else {
		NS = Client.$TMS.@DAPI.@RWGF.Get(aArea);
	}
	tUnavail = null(table);
	tAvail = NS.tAvail;
}

action PlanGet() {
	namespace NS; table tPlan, tSetup; int NN;
	STAT = true;
	tSetup = Client.$TMS.GetNamed(/tSetup);
	TMS.clear(false);			// 9.2.8 does not support areas
	TMS.copy(tSetup);
if (TMS.AreaRWG) {
	printf("\n*** {tService.EstName} has RWG areas set\n\n");
//	debug();
}
	tArea = Client.$TMS.GetNamed(/tArea);
	if (tSetup[0].AreaSelect) {
		NN = aArea.length();
		AreaList.append(form("{tService.EstName} ({UID_Est}) has {NN} areas\n"));
	}
	TimeZone = tSetup[0].TimeZone;
	if (!ZoneCheck(TimeZone, tService.EstName)) {
		STAT = false;
		return;
	}
	TimeStep = tSetup.TimeStepOnline;
	if (!/TimeStep) TimeStep = tSetup.TimeStep;
	tPlan = Client.$TMS.GetNamed(/tPlan);
	tComb = tPlan[0].tComb;
	if (!tSetup[0].AreaSelect) TMS.AreaRWG = false;			// +18/2/21
	if (TMS.AreaRWG) {
		NS = Client.$TMS.@JS.RWGUnavail(Horizon + DateOffset);
		tUnavail = NS.tUnavail;
		AreaSet(true);
	} else {
		NS = Client.$TMS.@UnJSON.Get(0, Horizon + DateOffset);
//if (tSetup.EstName == "OGAMBUZINO")
//Show(NS.tUnavail);
		tUnavail = NS.tUnavail;
		AreaSet(false);
		tUnavail.append(/Float, array);
		forall(tUnavail) {
			Float = TimesGet(Hours);
		}
		tUnavail.delete(/Hours);
		tUnavail.rename(/Float, /Hours);
	}
}

action PlanError() {
	STAT = false;
	printf("Error getting data from TMS system {tService.EstName}\n");
	debug();
}

action bool DataGet(string Node, int Port) {
	string File, Host;
	Host = Node + ".eveve.com";
	Client = new(namespace);
	Client.tcpclient(Host, Port, true);
//	Client.tcpclient("127.0.0.1", 3200, true);
	if (!Client.connect()) {
		printf("Cannot connect to {tService.EstName} on {Node}:{Port}\n");
		return false;
	}
	Client.nRetry = 60; Client.nReconnect = 4;
	Client.tReadFirst = Client.tReadNext = 16000;			// services may need to do a total recompute of unavilability
	NEW = bNew.find(tService.ESTNAME);
switch(tService.Node) {
case "AU5", "NZ4", "UK5", "UK6", "UK8", "US15", "US17", "US18": NEW = true;
default: break;
}
NEW = true;				/// new processing used for all services 29/11/21
	if (NEW) PlanGetNew(); else PlanGet();
	Client.disconnect();			// +6/12/21
//	else catch(PlanGet, PlanError);
	return STAT;
}

action Export(int iTask, nTask) {
string SS;
	int aService[];
	Init();
	Joined = string(75000000);
	if (ALONE) Joined += "{'availability':[\n";

	zoneshift(0);					// get everything on UTC
	NoAvail.clear();
	tService.select("Live", /LiveStatus, equal(), 0);
	tService.select(1, /RWG, equal(), 1);
//tService.select(7347, /UID, equal(), 0); debug();
	aService = tService.selection(/UID);
	aService.sort();
//aService = [2423];	//Test1
	forall(aService) {
		reserved int UID;
		if (!tService.uidset(UID_Est = UID)) debug();
		EstName = tService.EstName;
//		RECUR = (NewProc.find(UID_Est));
		with(tService) {
			string SS = octet(Release);
			if ((loop() % nTask) != iTask) continue;
//if (Country != "ES") continue;

//if (ESTNAME != "SOFRAGA") continue;
//			if (!bNew.find(ESTNAME)) continue;
			if (!/Street) Street = "";
			if (!/PostCode) PostCode = "";
			if (!/Region) Region = "";
/*
		if ((Street.empty() or PostCode.empty()) or Region.empty()) {
printf("Incomplete address for {EstName}\n");
				continue;
		}
		switch(Node) {
		case "UK5", "UK6", "US4", "US6", "US7": break;
		default: continue;
		}
*/
			if (!DataGet(Node, Port)) continue;
			if (!tDST.select(TimeZone, /Zone, equal(), 0)) {
				forall(tDST) {printf("zone='{Zone}'\n");}
				ErrorLog(form("No timezone '{TimeZone}}' for {EstName} ({UID})"));
				continue;
			}
			Joined += AvailRWG();
			if (Joined.length() > FlushLength) {
				Flush();
			}
//printf("{tService.EstName} total={nTotal}\n");
//if (UID == 2482) debug();

			if (!nTotal) NoAvail += EstName + "\n";
printf("service {nDone}={EstName} on {Node} release={SS}, total slots={nTotal}\n");
//if (EstName == "Nomad") {SS = Joined.tailget(1000); debug();}
			if (++nDone >= Limit) break;
		}
//if (nDone > 0) break;
	}
	NoAvail.filesave(form("$DATA/Reports/NoAvail_{iTask}.txt"));
	AreaList.filesave(form("$DATA/Reports/AreaList_{iTask}.txt"));
	if (!Joined.empty()) Flush();
//	WrapShards();
}

action Init() {
	srand(DateTime = $DateTime.now); Nonce = rand(100000000, 900000000);
	nShard = nDone = 0;
}

