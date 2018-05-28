package contents.commands
{
	import base.commands.Command;
	
	import contents.models.IContentItem;
	import contents.models.ItemContent;
	
	import items.models.MoItem;
	
	import contents.models.EffectContent;
	
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
