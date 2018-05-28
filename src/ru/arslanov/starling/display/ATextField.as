package ru.arslanov.starling.display
{
	import flash.geom.Point;

	import ru.arslanov.starling.interfaces.IKillableStarling;

	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.text.TextFormat;
	
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class ATextField extends TextField implements IKillableStarling
	{
		static public var defaultAutoScale:Boolean = false;
		static public var defaultAutoSize:String = TextFieldAutoSize.BOTH_DIRECTIONS;
		
		private var _isKilled:Boolean = false;
		private var _pos:Point = new Point();
		private var _textFormat:TextFormat = new TextFormat();
		
		public function ATextField(text:String = "",
								   width:int = 50,
								   height:int = 50,
								   fontName:String = "Verdana",
								   fontSize:Number = 12,
								   color:uint = 0,
								   bold:Boolean = false)
		{
			_textFormat.font = fontName;
			_textFormat.size = fontSize;
			_textFormat.color = color;
			_textFormat.bold = bold;
			super(width, height, text, _textFormat);

			touchable = false;
			autoScale = defaultAutoScale;
			//autoSize = defaultAutoSize;
			
			alignPivot("left", "top");
			
			//border = true;
			//autoFit();
		}
		
		public function get isKilled():Boolean { return _isKilled; }

		public function kill():void
		{
			if (_isKilled) throw ( new Error("StBaseText already killed!") ).getStackTrace();
			
			removeFromParent(true);
			_pos = null;
			_isKilled = true;
			
			dispose();
			
			// override me
		}
		
		private var _autoScale:Boolean;
		
		public function autoFit():void
		{
			_autoScale = autoScale;
			
			autoScale = false;
			
			//dispose();
			
			width = 1500;
			
			width = textBounds.width + 5;
			height = textBounds.height + 5;
			
			autoScale = _autoScale;
		}
		
		public function get pos():Point
		{
			_pos.setTo(x, y);
			return _pos;
		}
		
		public function set pos(value:Point):void
		{
			_pos = value;
			
			x = _pos.x;
			y = _pos.y;
		}
		
		public function setXY(x:Number = 0, y:Number = 0, round:Boolean = true):void
		{
			super.x = round ? Math.round(x) : x;
			super.y = round ? Math.round(y) : y;
			
			_pos.setTo(super.x, super.y);
		}
	}
}