package items.commands
{
	import base.commands.Command;
	
	import categories.models.MoCategory;
	
	import core.models.DataStore;
	
	import items.models.MoItem;
	
	public class AddItem extends Command
	{
		private var _category:MoCategory;
		private var _nameItem:String;
		
		public function AddItem(category:MoCategory, nameItem:String)
		{
			super();
			_category = category;
			_nameItem = nameItem;
		}
		
		override public function execute(data:* = null):void
		{
			var item:MoItem = new MoItem();
			item.category = _category;
			item.name = _nameItem;
			
			DataStore.me.itemsManager.addItem(item);
			
			complete();
		}
	}
}
