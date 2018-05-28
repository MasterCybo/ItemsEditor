package items.views
{
	import feathers.controls.List;
	import feathers.controls.ToggleButton;
	import feathers.controls.renderers.IListItemRenderer;
	
	import flash.geom.Rectangle;
	
	import graphics.Assets;
	
	import items.collections.ItemPropertyEnum;
	
	import items.controllers.ItemListItemRendererController;
	import items.events.ListItemRendererEvent;
	import items.models.MoItem;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	public class ItemListItemRenderer extends ToggleButton implements IListItemRenderer
	{
		private static const FRAME:Rectangle = new Rectangle(0, 0, 40, 40);
		
		private var _index:int;
		private var _owner:List;
		private var _factoryID:String;
		private var _data:MoItem;
		private var _image:Image;
		private var _defaultTexture:Texture = Texture.fromColor(FRAME.width, FRAME.height, 0xFFFFFF);
		private var _textureBounds:Rectangle = new Rectangle();
		
		public function ItemListItemRenderer()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			paddingTop = paddingBottom = 10;
			paddingLeft = paddingRight = 20;
			
//			_defaultTexture = Texture.fromColor(FRAME.width, FRAME.height, 0xFFFFFF)
			
			_image = new Image(_defaultTexture);
			addChild(_image);
			
			new ItemListItemRendererController(this);
		}
		
		override public function dispose():void
		{
			_data = null;
			_owner = null;
			super.dispose();
		}
		
		public function set image(value:String):void
		{
			var texture:Texture = Assets.me.getTexture(value);
			if (texture) {
				_image.texture = texture;
			} else {
				_image.texture = _defaultTexture;
			}
			validateImage();
		}
		
		private function validateImage():void
		{
			_image.getBounds(_image, _textureBounds);
			RectangleUtil.fit(_textureBounds, FRAME, ScaleMode.SHOW_ALL, false, _textureBounds);
			_image.readjustSize(_textureBounds.width, _textureBounds.height);
			_image.x = 10;
			_image.y = int((height - _image.height) / 2);
		}
		
		override public function invalidate(flag:String = "all"):void
		{
			super.invalidate(flag);
			
			if (flag == INVALIDATION_FLAG_SIZE) {
				validateImage();
			}
		}
		
		public function get data():Object {return _data;}
		public function set data(value:Object):void
		{
			if (value == _data) return;
			_data = MoItem(value);
			dispatchEvent(new ListItemRendererEvent(ListItemRendererEvent.CHANGED_DATA));
		}
		
		public function get index():int {return _index;}
		public function set index(value:int):void {_index = value;}
		
		public function get owner():List {return _owner;}
		public function set owner(value:List):void {_owner = value;}
		
		public function get factoryID():String {return _factoryID;}
		public function set factoryID(value:String):void {_factoryID = value;}
	}
}
