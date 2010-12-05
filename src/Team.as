package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class Team extends Sprite
	{
		private var team:TextField = new TextField;
		public var teamid:int;
		public var teamname:String;
		
		public function Team(tname:String, tid:int)
		{
			teamname = tname;
			team.htmlText = "<a href=\"" + Global.teamurl + tid + "\" target=\"_blank\">" + tname + "</a>";
			teamid = tid;
			team.width = 120;
			team.height = 20;
			team.selectable = false;
			team.addEventListener(MouseEvent.MOUSE_OVER, over);
			team.addEventListener(MouseEvent.MOUSE_OUT, out);
			addChild(team);
		}
		
		public function over(e:MouseEvent = null):void
		{
			team.textColor = 0xFF0000;
			if(e == null || teamid == 0)
			{
				return;
			}
			var i:int;
			var m:Match;
			var w:Winner;
			for(i=0;i<Global.matchbox.numChildren;i++)
			{
				if(Global.matchbox.getChildAt(i) is Match)
				{
					m = Match(Global.matchbox.getChildAt(i));
					m.setTeam(teamid);
				}
				if(Global.matchbox.getChildAt(i) is Winner)
				{
					w = Winner(Global.matchbox.getChildAt(i));
					w.setTeam(teamid);
				}
			}
		}
		
		public function out(e:MouseEvent = null):void
		{
			team.textColor = 0x0;
			if(e == null || teamid == 0)
			{
				return;
			}
			var i:int;
			var m:Match;
			var w:Winner;
			for(i=0;i<Global.matchbox.numChildren;i++)
			{
				if(Global.matchbox.getChildAt(i) is Match)
				{
					m = Match(Global.matchbox.getChildAt(i));
					m.hideTeam();
				}
				if(Global.matchbox.getChildAt(i) is Winner)
				{
					w = Winner(Global.matchbox.getChildAt(i));
					w.hideTeam();
				}
			}
		}
	}
}