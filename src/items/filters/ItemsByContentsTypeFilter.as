package items.filters
{
	import contents.collections.ContentsTypeEnum;
	
	import items.models.MoItem;
	
	public class ItemsByContentsTypeFilter implements IItemsFilter
	{
		private var _contentsType:ContentsTypeEnum;
		
		public function ItemsByContentsTypeFilter(contentsType:ContentsTypeEnum)
		{
			_contentsType = contentsType;
		}
		
		public function filter(item:MoItem, index:int, vector:Vector.<MoItem>):Boolean
		{
			return item.category.contentsType.equals(_contentsType);
		}
	}
}
