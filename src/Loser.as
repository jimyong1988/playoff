package
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class Loser extends Sprite
	{
		private var winner:TextField;
		private var score1:String;
		private var score2:String;
		private var teamid1:int;
		private var teamid2:int;
		public var matchid:int;
		
		public function Loser(s1:String, s2:String, t1:int, t2:int, p:Point)
		{
			score1 = s1;
			score2 = s2;
			teamid1 = t1;
			teamid2 = t2;
			x = p.x / 2 - 100;
			y = p.y + 30;
			winner = new TextField;
			addChild(winner);
			winner.x = 0;
			winner.y = 0;
			winner.width = 200;
			winner.autoSize = TextFieldAutoSize.CENTER;

			winner.addEventListener(MouseEvent.MOUSE_OVER, over);
			winner.addEventListener(MouseEvent.MOUSE_OUT, out);
			winner.selectable = false;
			addChild(winner);
			this.buttonMode = true;
			this.useHandCursor = true;
		}
		
		public function setMatchid(mid:int):void
		{
			matchid = mid;
			var t:Team;
			t = Global.getTeamById(teamid1);
			var team1:String = t?t.teamname:"无";
			t = Global.getTeamById(teamid2);
			var team2:String = t?t.teamname:"无";
			if(score1 == "")
			{
				score1 = "?";
			}
			if(score2 == "")
			{
				score2 = "?";
			}
			winner.htmlText = "<a href=\"" + Global.matchurl + matchid + "\" target=\"_blank\">" + 
				team1 + " " + score1 + " : " + score2 + " " + team2 + "</a>";
		}
		
		public function over(e:MouseEvent = null):void
		{
			winner.textColor = 0xFF0000;
		}
		
		public function out(e:MouseEvent = null):void
		{
			winner.textColor = 0x0;
		}
	}
}