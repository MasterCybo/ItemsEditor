package properties.views
{
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalLayout;
	
	import items.collections.ItemPropertyEnum;
	import items.models.MoItem;
	
	import starling.display.DisplayObject;
	
	public class PropertiesList extends LayoutGroup
	{
		private static var _thisLayout:VerticalLayout;
		
		public function PropertiesList()
		{
			super();
		}
		
		private static function thisLayout():VerticalLayout
		{
			if (!_thisLayout) {
				_thisLayout = new VerticalLayout();
				_thisLayout.horizontalAlign = HorizontalAlign.JUSTIFY;
				_thisLayout.gap = 3;
			}
			return _thisLayout;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			layout = thisLayout();
		}
		
		public function setData(item:MoItem = null):void
		{
			removeChildren();
			
			if (!item) return;
			
			var property:ItemPropertyEnum;
			var propView:DisplayObject;
			
			var props:Vector.<ItemPropertyEnum> = item.properties;
			
			for (var i:int = 0; i < props.length; i++) {
				property = props[ i ];
				if (property.editable) {
					switch (true) {
						case property == ItemPropertyEnum.DESCRIPTION:
							propView = new PropertyAreaEditor(property.getString(), item.getValue(property));
							break;
						case property == ItemPropertyEnum.IMAGE:
							propView = new PropertyImageSelector(property.getString(), item.getValue(property));
							break;
						case property.equalsType(String):
							propView = new PropertyStringEditor(property.getString(), item.getValue(property));
							break;
						case property.equalsType(Number):
							propView = new PropertyNumberEditor(property.getString(), item.getValue(property));
							break;
					}
					
					addChild(propView);
				}
			}
		}
	}
}
