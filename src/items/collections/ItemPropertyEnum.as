package items.collections
{
	import ru.aa.enums.EnumString;
	
	public class ItemPropertyEnum extends EnumString
	{
		public static const ID:ItemPropertyEnum = new ItemPropertyEnum("id", "ID", String, false);
		public static const NAME:ItemPropertyEnum = new ItemPropertyEnum("name", "Имя", String);
		public static const DESCRIPTION:ItemPropertyEnum = new ItemPropertyEnum("description", "Описание", String);
		public static const IMAGE:ItemPropertyEnum = new ItemPropertyEnum("image", "Вид", String);
		public static const PRICE:ItemPropertyEnum = new ItemPropertyEnum("price", "Цена", Number);
		public static const WEIGHT:ItemPropertyEnum = new ItemPropertyEnum("weight", "Вес", Number);
		
		private var _type:Class;
		private var _editable:Boolean;
		private var _locale:String;
		
		public function ItemPropertyEnum(val:String, locale:String, type:Class = null, editable:Boolean = true)
		{
			_type = type;
			_locale = locale;
			_editable = editable;
			super(val);
		}
		
		public function equalsType(type:Class):Boolean {return type == _type;}
		
		public function get editable():Boolean {return _editable;}
		
		public function get locale():String {return _locale;}
	}
}
