package contents.commands
{
	import contents.models.IContentItem;
	
	import items.models.MoItem;
	
	import ru.aa.march.commands.Command;
	
	public class RemoveContent extends Command
	{
		private var _item:MoItem;
		
		public function RemoveContent(item:MoItem)
		{
			super();
			_item = item;
		}
		
		override public function execute(data:* = null):void
		{
			var contentItem:IContentItem = data;
			_item.removeContent(contentItem);
			
			complete();
		}
	}
}
