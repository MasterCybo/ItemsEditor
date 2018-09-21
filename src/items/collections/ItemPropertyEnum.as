package items.collections
{
	import ru.aa.enums.EnumString;
	
	public class ItemPropertyEnum extends EnumString
	{
		public static const ID:ItemPropertyEnum = new ItemPropertyEnum("id", String, false);
		public static const NAME:ItemPropertyEnum = new ItemPropertyEnum("name", String);
		public static const DESCRIPTION:ItemPropertyEnum = new ItemPropertyEnum("description", String);
		public static const IMAGE:ItemPropertyEnum = new ItemPropertyEnum("image", String);
		public static const PRICE:ItemPropertyEnum = new ItemPropertyEnum("price", Number);
		public static const WEIGHT:ItemPropertyEnum = new ItemPropertyEnum("weight", Number);
		
		private var _type:Class;
		private var _editable:Boolean;
		
		public function ItemPropertyEnum(val:String = null, type:Class = null, editable:Boolean = true)
		{
			_type = type;
			_editable = editable;
			super(val);
		}
		
		public function equalsType(type:Class):Boolean {return type == _type;}
		
		public function get editable():Boolean {return _editable;}
	}
}
