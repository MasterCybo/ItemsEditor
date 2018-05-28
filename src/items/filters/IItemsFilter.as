package items.filters
{
	import items.models.MoItem;
	
	public interface IItemsFilter
	{
		function filter(item:MoItem, index:int, vector:Vector.<MoItem>):Boolean
	}
}
