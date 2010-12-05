package
{
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.osmf.display.ScaleMode;
	
	[SWF(width="550",height="300", frameRate="12")]
	public class playoff extends Sprite
	{
		private var matches:Sprite = new Sprite;
		
		public function playoff()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = "noScale";
			var myContextMenu:ContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			//声明菜单新项
			var item:ContextMenuItem=new ContextMenuItem("源码已托管至Google Code，点击打开...");
			//添加到菜单显示项目数组
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, youjian);
			
			myContextMenu.customItems.push(item);
			this.contextMenu=myContextMenu;
			

			Global.matchbox = this.matches;
			addChild(matches);
			addChild(Global.teambox);
			matches.x = 100;
			matches.y = 20;
			Global.teambox.y = 10;
			if(stage.loaderInfo.parameters.hasOwnProperty("matchurl"))
			{
				Global.matchurl =  stage.loaderInfo.parameters["matchurl"];
			}
			if(stage.loaderInfo.parameters.hasOwnProperty("nofinal") &&
				stage.loaderInfo.parameters["nofinal"] == "true")
			{
				Global.nofinal =  true;
			}
			if(stage.loaderInfo.parameters.hasOwnProperty("nolink") &&
				stage.loaderInfo.parameters["nolink"] == "true")
			{
				Global.nolink =  true;
			}
			draw();
		}
		
		private function youjian(event:ContextMenuEvent):void {
			var req:URLRequest=new URLRequest("http://code.google.com/a/eclipselabs.org/p/playoff/");
			navigateToURL(req,"_blank");
			
		}
		
		private function test():void
		{
			Global.total = 16;
		}
		
		private function draw():void
		{
			var i:int;
			var j:int;
			var team:Team;
			var teaminfo:Array;
			var teams:String = stage.loaderInfo.parameters["teams"];
			var teamarr:Array = teams.split(":");
			var teamids:Array = new Array;
			Global.total = teamarr.length;
			var rightx:int = Math.log(Global.total) / Math.log(2) * 100;
			for(i=0;i<Global.total/2;i++)
			{
				teaminfo = teamarr[j++].split(",");
				teamids.push(teaminfo[1]);
				team = new Team(teaminfo[0], teaminfo[1]);
				team.x = 0;
				team.y = i * 30;
				Global.teambox.addChild(team);
			}
			for(i=0;i<Global.total/2;i++)
			{
				teaminfo = teamarr[j++].split(",");
				teamids.push(teaminfo[1]);
				team = new Team(teaminfo[0], teaminfo[1]);
				team.x = rightx + 100;
				team.y = i * 30;
				Global.teambox.addChild(team);
			}
			var matchdata:String = stage.loaderInfo.parameters["matches"];
			var matcharr:Array = matchdata.split(":");
			j = 0;
			var k:int;
			var match:Match;
			var matchinfo:Array;
			for(i=0;i<Global.total/4;i++)
			{
				matchinfo = matcharr[k++].split(",");
				match = new Match(new Point(0, i*60), new Point(0, i*60 + 30), false, teamids[j], teamids[j+1], matchinfo[1], matchinfo[2]);
				match.matchid = matchinfo[0];
				j+=2;
				matches.addChild(match);
			}
			for(i=0;i<Global.total/4;i++)
			{
				matchinfo = matcharr[k++].split(",");
				match = new Match(new Point(rightx, i*60), new Point(rightx, i*60 + 30), true, teamids[j], teamids[j+1], matchinfo[1], matchinfo[2]);
				match.matchid = matchinfo[0];
				j+=2;
				matches.addChild(match);
			}
			var m1:Match;
			var m2:Match;
			var maxy:int;
			for(i=0;i<matches.numChildren - 2;i+=2)
			{
				m1 = Match(matches.getChildAt(i));
				m2 = Match(matches.getChildAt(i+1));
				if(m1.y > maxy)
				{
					maxy = m1.y;
				}
				if(m2.y > maxy)
				{
					maxy = m2.y;
				}
				matchinfo = matcharr[k++].split(",");
				match = new Match(m1.next, m2.next, m1.revers, m1.nextteam, m2.nextteam, matchinfo[1], matchinfo[2]);
				match.matchid = matchinfo[0];
				matches.addChild(match);
			}
			m1 = Match(matches.getChildAt(i++));
			m2 = Match(matches.getChildAt(i++));
			if(Global.nofinal == false)
			{
				matchinfo = matcharr[k++].split(",");
				var winner:Winner = new Winner(m1.next, m2.next, m1.nextteam, m2.nextteam, matchinfo[1], matchinfo[2]);
				winner.matchid = matchinfo[0];
				matches.addChild(winner);
				matchinfo = matcharr[k++].split(",");
				var loser:Loser = new Loser(matchinfo[1], matchinfo[2], m1.loseteam, m2.loseteam, new Point(matches.width, maxy));
				loser.setMatchid(matchinfo[0]);
				matches.addChild(loser);
			}
		}
	}
}