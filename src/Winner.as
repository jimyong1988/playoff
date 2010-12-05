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
	
	public class Winner extends Sprite
	{
		public var matchid:int;
		
		private var length:int;
		
		private var score1:TextField;
		private var score2:TextField;
		private var team1:int;
		private var team2:int;
		
		private var bg:Sprite = new Sprite;
		private var team:Sprite = new Sprite;
		
		private var winner:TextField;
		
		public function Winner(p1:Point, p2:Point, 
							   t1:int = 0, t2:int = 0,
								s1:String = "", s2:String = "")
		{
			team1 = t1;
			team2 = t2;
			length = Math.abs(p2.x - p1.x);
			
			
			score1 = new TextField;
			score2 = new TextField;
			winner = new TextField;
			score1.selectable = false;
			score2.selectable = false;
			score1.text = "?";
			score2.text = "?";
			addChild(score1);
			addChild(score2);
			addChild(winner);
			x = p1.x;
			y = p1.y - 40;
			score1.x = 0;
			score1.y = 20;
			score2.x = length - 20;
			score2.y = 20;
			score2.width = 20;
			score2.autoSize = TextFieldAutoSize.RIGHT;
			winner.x = 0;
			winner.y = 0;
			winner.width = length;
			winner.autoSize = TextFieldAutoSize.CENTER;
			winner.selectable = false;
			winner.addEventListener(MouseEvent.MOUSE_OVER, onwinover);
			winner.addEventListener(MouseEvent.MOUSE_OUT, onwinout);
			if(s1 == "")
			{
				s1 = "-1";
			}
			if(s2 == "")
			{
				s2 = "-1";
			}
			setScore(int(s1), int(s2));
			
			team.alpha = 0;
			addChild(team);
			
			var g:Graphics = bg.graphics;
			g.beginFill(0xFFFF00, 1);
			g.drawRect(0, 20, length, 20);
			g.endFill();
			bg.alpha = 0;
			bg.buttonMode = true;
			bg.useHandCursor = true;
			bg.addEventListener(MouseEvent.MOUSE_OVER, onover);
			bg.addEventListener(MouseEvent.MOUSE_OUT, onout);
			addChild(bg);
			bg.addEventListener(MouseEvent.CLICK, onclick);
		}
		
		private function onclick(e:MouseEvent):void
		{
			navigateToURL(new URLRequest(Global.matchurl + matchid.toString()), "_blank");
		}
		
		private function onwinover(e:MouseEvent):void
		{
			winner.textColor = 0xFF0000;
			var t:Team;
			var s1:int = int(score1.text);
			var s2:int = int(score2.text);
			if(s1 > s2)
			{
				t = Global.getTeamById(team1);
			}
			if(s2 > s1)
			{
				t = Global.getTeamById(team2);
			}
			t.over(e);
		}
		
		private function onwinout(e:MouseEvent):void
		{
			winner.textColor = 0x0;
			var t:Team;
			var s1:int = int(score1.text);
			var s2:int = int(score2.text);
			if(s1 > s2)
			{
				t = Global.getTeamById(team1);
			}
			if(s2 > s1)
			{
				t = Global.getTeamById(team2);
			}
			t.out(e);
		}
		
		private function onover(e:MouseEvent):void
		{
			bg.alpha = 0.6;
			score1.textColor = 0xFF0000;
			score2.textColor = 0xFF0000;
			var team:Team;
			team = Global.getTeamById(team1);
			if(team)
			{
				team.over();
			}
			team = Global.getTeamById(team2);
			if(team)
			{
				team.over();
			}
		}
		
		private function onout(e:MouseEvent):void
		{
			bg.alpha = 0;
			score1.textColor = 0x0;
			score2.textColor = 0x0;
			var team:Team;
			team = Global.getTeamById(team1);
			if(team)
			{
				team.out();
			}
			team = Global.getTeamById(team2);
			if(team)
			{
				team.out();
			}
		}
		
		public function setTeam(tid:int):void
		{
			team.alpha = 1;
			var g:Graphics = team.graphics;
			g.clear();
			var s1:int = int(score1.text);
			var s2:int = int(score2.text);
			if(score1.text == "?")
			{
				s1 = -1;
			}
			if(score2.text == "?")
			{
				s2 = -1;
			}
			g.lineStyle(3, 0x0FF000);
			if(team1 == tid)
			{
				if(s1 > s2)
				{
					g.moveTo(0, 40);
					g.lineTo(length / 2, 40);
					if(s1 != -1 && s2 != -1)
					{
						g.moveTo(length / 2, 40);
						g.lineTo(length / 2, 20);
					}
				}
			}
			if(team2 == tid)
			{
				if(s1 < s2)
				{
					g.moveTo(length / 2, 40);
					g.lineTo(length, 40);
					if(s1 != -1 && s2 != -1)
					{
						g.moveTo(length / 2, 40);
						g.lineTo(length / 2, 20);
					}
				}
			}
		}
		
		public function hideTeam():void
		{
			team.alpha = 0;
		}
		
		public function setScore(s1:int = -1, s2:int = -1):void
		{
			winner.text = "";
			var g:Graphics = this.graphics;
			g.clear();
			if(s1 != -1 && s2 != -2)
			{
				score1.text = s1.toString();
				score2.text = s2.toString();
				g.lineStyle(2, 0xFF0000);
				var t:Team;
				if(s1 > s2)
				{
					t = Global.getTeamById(team1);
					winner.text = t.teamname;
				}
				if(s1 < s2)
				{
					t = Global.getTeamById(team2);
					winner.text = t.teamname;
				}
			}
			else
			{
				g.lineStyle(1.5, 0x0);
			}
			
			g.moveTo(0, 40);
			if(s1 > s2)
			{
				g.lineStyle(2, 0xFF0000);
				g.lineTo(length / 2, 40);
				g.lineStyle(1.5, 0x0);
				g.lineTo(length, 40);
				g.lineStyle(2, 0xFF0000);
				g.moveTo(length / 2, 40);
				g.lineTo(length / 2, 20);
			}
			else if(s1 < s2)
			{
				g.lineStyle(1.5, 0x0);
				g.lineTo(length / 2, 40);
				g.lineStyle(2, 0xFF0000);
				g.lineTo(length, 40);
				g.moveTo(length / 2, 40);
				g.lineTo(length / 2, 20);
			}
			else
			{
				g.lineStyle(1.5, 0x0);
				g.lineTo(length, 40);
			}
		}
	}
}