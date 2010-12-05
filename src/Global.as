package
{
	import flash.display.Sprite;

	public class Global
	{
		
		public static var total:int;
		public static var matchurl:String = "/match?id=";
		public static var teamurl:String = "/qiudui/teams?id=";
		public static var nofinal:Boolean = false;
		public static var nolink:Boolean = false;
		
		public static var teambox:Sprite = new Sprite;
		public static var matchbox:Sprite;
		
		public function Global()
		{
		}
		
		public static function getTeamById(tid:int):Team
		{
			var i:int;
			for(i=0;i<teambox.numChildren;i++)
			{
				if(Team(teambox.getChildAt(i)).teamid == tid)
				{
					return Team(teambox.getChildAt(i));
				}
			}
			return null;
		}
	}
}