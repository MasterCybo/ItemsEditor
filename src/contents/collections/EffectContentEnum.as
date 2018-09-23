package contents.collections
{
	import ru.aa.enums.EnumString;
	
	public class EffectContentEnum extends EnumString
	{
		public static const HEALTH:EffectContentEnum = new EffectContentEnum("health", "Здоровье");
		public static const ARMOR:EffectContentEnum = new EffectContentEnum("armor", "Броня");
		public static const DAMAGE:EffectContentEnum = new EffectContentEnum("damage", "Урон");
		public static const HUNGER:EffectContentEnum = new EffectContentEnum("hunger", "Голод");
		public static const THIRST:EffectContentEnum = new EffectContentEnum("thirst", "Жажда");
		public static const ENERGY:EffectContentEnum = new EffectContentEnum("energy", "Бодрость");
		
		private var _locale:String;
		
		public function EffectContentEnum(val:String, locale:String)
		{
			_locale = locale;
			super(val);
		}
		
		public function get locale():String {return _locale;}
	}
}
