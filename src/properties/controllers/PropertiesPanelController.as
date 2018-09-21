package properties.controllers
{
	import items.collections.ItemPropertyEnum;
	import items.events.ItemListEvent;
	import items.models.MoItem;
	
	import properties.events.PropertyEditorEvent;
	import properties.views.PropertiesPanel;
	
	import ru.aa.enums.Enum;
	import ru.aa.march.controllers.ControllerFeathers;
	
	public class PropertiesPanelController extends ControllerFeathers
	{
		private var _item:MoItem;
		
		public function PropertiesPanelController(view:PropertiesPanel)
		{
			super(view);
		}
		
		public function get view():PropertiesPanel {return getView() as PropertiesPanel;}
		
		override protected function initialize():void
		{
			super.initialize();
			
			view.addEventListener(PropertyEditorEvent.CHANGED_VALUE, changeValueHandler);
			eventDispatcher.addEventListener(ItemListEvent.SELECTED_ITEM, selectedItemHandler);
		}
		
		override public function destroy():void
		{
			eventDispatcher.removeEventListener(ItemListEvent.SELECTED_ITEM, selectedItemHandler);
			view.removeEventListener(PropertyEditorEvent.CHANGED_VALUE, changeValueHandler);
			super.destroy();
		}
		
		private function selectedItemHandler(event:ItemListEvent):void
		{
			_item = event.item;
			view.setData(_item);
		}
		
		private function changeValueHandler(event:PropertyEditorEvent):void
		{
			var property:ItemPropertyEnum = Enum.getElementByValue(event.property, ItemPropertyEnum) as ItemPropertyEnum;
			_item.setValue(property, event.value);
		}
	}
}
