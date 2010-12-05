package
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Match extends Sprite
	{
		public var matchid:int;
		
		private var length:int = 50;
		private var vlength:int;
		
		private var score1:TextField;
		private var score2:TextField;
		private var team1:int;
		private var team2:int;
		
		private var bg:Sprite = new Sprite;
		private var team:Sprite = new Sprite;
		
		public var revers:Boolean;
		
		public var next:Point;
		public var nextteam:int;
		public var loseteam:int;
		
		public function Match(p1:Point, p2:Point, r:Boolean = false,
							  t1:int = 0, t2:int = 0, s1:String = "", s2:String = "")
		{
			team1 = t1;
			team2 = t2;
			vlength = p2.y - p1.y;
			revers = r;
			
			if(s1 == "")
			{
				s1 = "-1";
			}
			if(s2 == "")
			{
				s2 = "-1";
			}
			
			score1 = new TextField;
			score2 = new TextField;
			score1.selectable = false;
			score2.selectable = false;
			score1.text = "?";
			score2.text = "?";
			addChild(score1);
			addChild(score2);
			score1.y = 0;
			score2.y = vlength;
			
			var g:Graphics = bg.graphics;
			g.beginFill(0xFFFF00, 1);
			if(r == false)
			{
				g.drawRect(0, 10, length, vlength);
				x = p1.x;
				y = p1.y - 10;
				score1.x = length;
				score2.x = length;
				next = new Point(x + length, y + 10 + vlength / 2);
			}
			else
			{
				g.drawRect(20, 10, length, vlength);
				x = p1.x - length - 20;
				y = p1.y - 10;
				score1.x = 0;
				score2.x = 0;
				score1.width = 20;
				score2.width = 20;
				score1.autoSize = TextFieldAutoSize.RIGHT;
				score2.autoSize = TextFieldAutoSize.RIGHT;
				next = new Point(x + 20, y + 10 + vlength / 2); 
			}
			g.endFill();
			setScore(int(s1), int(s2));
			
			team.alpha = 0;
			addChild(team);
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
		
		private function onover(e:MouseEvent):void
		{
			bg.alpha = 0.6;
			var tf:TextFormat = new TextFormat;
			tf.bold = true;
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
			var tf:TextFormat = new TextFormat;
			tf.bold = false;
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
				if(revers == false)
				{
					g.moveTo(0, 10);
					g.lineTo(length, 10);
					if(s1 > s2)
					{
						g.moveTo(length, 10);
						g.lineTo(length, 10 + vlength / 2);
					}
				}
				else
				{
					g.moveTo(20, 10);
					g.lineTo(20 + length, 10);
					if(s1 > s2)
					{
						g.moveTo(20, 10);
						g.lineTo(20, 10 + vlength / 2);
					}
				}
			}
			if(team2 == tid)
			{
				if(revers == false)
				{
					g.moveTo(0, 10 + vlength);
					g.lineTo(length, 10 + vlength);
					if(s1 < s2)
					{
						g.moveTo(length, 10 + vlength / 2);
						g.lineTo(length, 10 + vlength);
					}
				}
				else
				{
					g.moveTo(20, 10 + vlength);
					g.lineTo(20 + length, 10 + vlength);
					if(s1 < s2)
					{
						g.moveTo(20, 10 + vlength / 2);
						g.lineTo(20, 10 + vlength);
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
			var g:Graphics = this.graphics;
			g.clear();
			if(s1 != -1 && s2 != -1)
			{
				score1.text = s1.toString();
				score2.text = s2.toString();
				g.lineStyle(2, 0xFF0000);
				if(s1 > s2)
				{
					nextteam = team1;
					loseteam = team2;
				}
				else
				{
					nextteam = team2;
					loseteam = team1;
				}
			}
			else
			{
				nextteam = -1;
			}
			
			if(revers == false)
			{
				if(team1 > -1)
				{
					g.lineStyle(2, 0xFF0000);
				}
				else
				{
					g.lineStyle(1.5, 0x0);
				}
				g.moveTo(0, 10);
				g.lineTo(length, 10);
				if(team2 > -1)
				{
					g.lineStyle(2, 0xFF0000);
				}
				else
				{
					g.lineStyle(1.5, 0x0);
				}
				g.moveTo(0, vlength + 10);
				g.lineTo(length, vlength + 10);
				g.moveTo(length, 10);
				if(s1 > s2)
				{
					g.lineStyle(2, 0xFF0000);
					g.lineTo(length, vlength / 2 + 10);
					g.lineStyle(1.5, 0x0);
					g.lineTo(length, vlength + 10);
				}
				else if(s1 < s2)
				{
					g.lineStyle(1.5, 0x0);
					g.lineTo(length, vlength / 2 + 10);
					g.lineStyle(2, 0xFF0000);
					g.lineTo(length, vlength + 10);
				}
				else
				{
					g.lineStyle(1.5, 0x0);
					g.lineTo(length, vlength + 10);
				}
			}
			else
			{
				if(team1 > -1)
				{
					g.lineStyle(2, 0xFF0000);
				}
				else
				{
					g.lineStyle(1.5, 0x0);
				}
				g.moveTo(20, 10);
				g.lineTo(20 + length, 10);
				if(team2 > -1)
				{
					g.lineStyle(2, 0xFF0000);
				}
				else
				{
					g.lineStyle(1.5, 0x0);
				}
				g.moveTo(20, vlength + 10);
				g.lineTo(20 + length, vlength + 10);
				g.moveTo(20, 10);
				if(s1 > s2)
				{
					g.lineStyle(2, 0xFF0000);
					g.lineTo(20, vlength / 2 + 10);
					g.lineStyle(1.5, 0x0);
					g.lineTo(20, vlength + 10);
				}
				else if(s1 < s2)
				{
					g.lineStyle(1.5, 0x0);
					g.lineTo(20, vlength / 2 + 10);
					g.lineStyle(2, 0xFF0000);
					g.lineTo(20, vlength + 10);
				}
				else
				{
					g.lineStyle(1.5, 0x0);
					g.lineTo(20, vlength + 10);
				}
			}
		}
		
	}
}