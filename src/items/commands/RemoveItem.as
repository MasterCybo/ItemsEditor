package items.commands
{
	import base.commands.Command;
	
	import core.models.DataStore;
	
	import items.models.MoItem;
	
	public class RemoveItem extends Command
	{
		private var _item:MoItem;
		
		public function RemoveItem(item:MoItem)
		{
			super();
			_item = item;
		}
		
		override public function execute(data:* = null):void
		{
			DataStore.me.itemsManager.removeItem(_item);
			complete();
		}
	}
}
