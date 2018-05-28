package contents.collections
{
	import ru.arslanov.core.enum.EnumString;
	
	public class EffectContentEnum extends EnumString
	{
		public static const HEALTH:EffectContentEnum = new EffectContentEnum("health");
		public static const ARMOR:EffectContentEnum = new EffectContentEnum("armor");
		public static const DAMAGE:EffectContentEnum = new EffectContentEnum("damage");
		public static const HUNGER:EffectContentEnum = new EffectContentEnum("hunger");
		public static const THIRST:EffectContentEnum = new EffectContentEnum("thirst");
		public static const ENERGY:EffectContentEnum = new EffectContentEnum("energy");
		
		public function EffectContentEnum(val:String = null)
		{
			super(val);
		}
	}
}
