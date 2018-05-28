package items.controllers
{
	import base.controllers.ControllerFeathers;
	
	import contents.events.ContentsEvent;
	
	import feathers.core.FeathersControl;
	
	import items.collections.ItemPropertyEnum;
	
	import items.events.ItemPropertyEvent;
	import items.events.ListItemRendererEvent;
	
	import items.models.MoItem;
	
	import items.views.ItemListItemRenderer;
	
	import starling.events.Event;
	
	public class ItemListItemRendererController extends ControllerFeathers
	{
		private var _item:MoItem;
		
		public function ItemListItemRendererController(view:ItemListItemRenderer)
		{
			super(view);
		}
		
		public function get view():ItemListItemRenderer {return getView() as ItemListItemRenderer;}
		
		override protected function initialize():void
		{
			super.initialize();
			initializeData();
			view.addEventListener(ListItemRendererEvent.CHANGED_DATA, changedDataHandler);
		}
		
		override public function destroy():void
		{
			removeDataListeners(_item);
			view.removeEventListener(ListItemRendererEvent.CHANGED_DATA, changedDataHandler);
			super.destroy();
		}
		
		private function changedDataHandler(event:Event):void
		{
			initializeData();
		}
		
		private function initializeData():void
		{
			removeDataListeners(_item);
			
			_item = view.data as MoItem;
			updateListItemRenderer();
			
			addDataListeners(_item);
		}
		
		private function addDataListeners(item:MoItem):void
		{
			if (!item) return;
			item.addEventListener(ItemPropertyEvent.CHANGED_VALUE, itemChangedHandler);
			item.addEventListener(ContentsEvent.UPDATE_CONTENT, contentsChangedHandler);
		}
		
		private function removeDataListeners(item:MoItem):void
		{
			if (!item) return;
			item.removeEventListener(ItemPropertyEvent.CHANGED_VALUE, itemChangedHandler);
			item.removeEventListener(ContentsEvent.UPDATE_CONTENT, contentsChangedHandler);
		}
		
		private function contentsChangedHandler(event:ContentsEvent):void
		{
			updateListItemRenderer();
		}
		
		private function itemChangedHandler(event:ItemPropertyEvent):void
		{
			updateListItemRenderer();
		}
		
		private function updateListItemRenderer():void
		{
			var image:String;
			if (_item) {
				image = _item.getValue(ItemPropertyEnum.IMAGE);
				
				var name:String = _item.getValue(ItemPropertyEnum.NAME);
				var price:Number = _item.getValue(ItemPropertyEnum.PRICE);
				var weight:Number = _item.getValue(ItemPropertyEnum.WEIGHT);
				view.label = name + " × " + _item.numContent +
						"\n" + price + " rub, " + weight + " kg";
			} else {
				view.label = "null";
			}
			
			view.image = image;
		}
	}
}
