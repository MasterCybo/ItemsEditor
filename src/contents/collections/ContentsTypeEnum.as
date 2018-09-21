package contents.collections
{
	import ru.aa.enums.EnumString;
	
	public class ContentsTypeEnum extends EnumString
	{
		public static const CONTAINER:ContentsTypeEnum = new ContentsTypeEnum("container");
		public static const EFFECTS:ContentsTypeEnum = new ContentsTypeEnum("effects");
		
		public function ContentsTypeEnum(val:String = null)
		{
			super(val);
		}
	}
}
