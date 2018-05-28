package categories.views
{
	import categories.controllers.CategoryListItemRendererController;
	import categories.models.MoCategory;
	
	import feathers.controls.Label;
	
	import feathers.controls.List;
	import feathers.controls.ToggleButton;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.layout.HorizontalLayout;
	
	import starling.display.DisplayObject;
	
	public class CategoryListItemRenderer extends ToggleButton implements IListItemRenderer
	{
		private var _index:int;
		private var _owner:List;
		private var _factoryID:String;
		private var _data:MoCategory;
		private var _titleLabel:Label;
		private var _typeLabel:Label;
		private var _countLabel:Label;
		
		public function CategoryListItemRenderer()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			paddingTop = paddingBottom = 10;
			paddingLeft = paddingRight = 20;
			
			_typeLabel = new Label();
			addChild(_typeLabel);
			
			_titleLabel = new Label();
			addChild(_titleLabel);
			
			_countLabel = new Label();
			addChild(_countLabel);
			
			new CategoryListItemRendererController(this);
		}
		
		override public function dispose():void
		{
			_data = null;
			_owner = null;
			super.dispose();
		}
		
		public function setInfo(type:String, title:String, counter:Number):void
		{
			_typeLabel.text = type.substr(0, 1).toUpperCase();
			_titleLabel.text = title;
			_countLabel.text = "" + counter;
			
			_typeLabel.validate();
			_titleLabel.validate();
			_countLabel.validate();
			
			invalidate(INVALIDATION_FLAG_SIZE);
		}
		
		override public function invalidate(flag:String = "all"):void
		{
			super.invalidate(flag);
			
			if (flag == INVALIDATION_FLAG_SIZE) {
				var hh:int = Math.max(_typeLabel.height, _titleLabel.height, _countLabel.height) + paddingTop + paddingBottom;
				setSize(width, hh);
				
				_typeLabel.x = paddingLeft;
				_typeLabel.y = int((height - _typeLabel.height) / 2);
				
				_titleLabel.x = 50;
				_titleLabel.y = int((height - _titleLabel.height) / 2);
				
				_countLabel.x = width - paddingRight - _countLabel.width;
				_countLabel.y = int((height - _countLabel.height) / 2);
			}
		}
		
		public function get data():Object {return _data;}
		public function set data(value:Object):void
		{
			if (value == _data) return;
			_data = MoCategory(value);
			invalidate(INVALIDATION_FLAG_SIZE);
		}
		
		public function get index():int {return _index;}
		public function set index(value:int):void {_index = value;}
		
		public function get owner():List {return _owner;}
		public function set owner(value:List):void {_owner = value;}
		
		public function get factoryID():String {return _factoryID;}
		public function set factoryID(value:String):void {_factoryID = value;}
	}
}
