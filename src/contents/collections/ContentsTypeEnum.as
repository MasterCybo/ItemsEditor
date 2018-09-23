package contents.collections
{
	import ru.aa.enums.EnumString;
	
	public class ContentsTypeEnum extends EnumString
	{
		public static const CONTAINER:ContentsTypeEnum = new ContentsTypeEnum("container", "Контейнер");
		public static const EFFECTS:ContentsTypeEnum = new ContentsTypeEnum("effects", "Предмет");
		
		private var _locale:String;
		
		public function ContentsTypeEnum(val:String, locale:String)
		{
			_locale = locale;
			super(val);
		}
		
		public function get locale():String {return _locale;}
	}
}
