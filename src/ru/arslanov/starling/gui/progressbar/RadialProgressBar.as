package ru.arslanov.starling.gui.progressbar {
	import ru.arslanov.starling.display.ASprite;

	import starling.display.Canvas;
	import starling.display.DisplayObject;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class RadialProgressBar extends ASprite {
		
		private var _background:DisplayObject;
		private var _indicator:DisplayObject;
		private var _pieMask:RadialMask;
		private var _canvas:Canvas;
		private var _progress:Number = 0;

		private var _rad:Number = Math.PI / 180;
		private var _ratio:Number = 1;
		
		public function RadialProgressBar(indicator:DisplayObject, maskRadius:Number = 50, rotation:Number = 0, sides:int = 6)
		{
			_indicator = indicator;
			
			_indicator.x = -_indicator.width / 2;
			_indicator.y = -_indicator.height / 2;
			
			_canvas = new Canvas();
			_pieMask = new RadialMask(_canvas, 0, maskRadius, 0, 0, rotation, sides);
			_indicator.mask = _canvas;
			
			super();
			
			addChild(_indicator);
			addChild(_canvas);
		}
		
		override public function kill():void
		{
			if (_background) _background.dispose();
			_indicator.dispose();
			_pieMask = null;
			_canvas.clear();
			_canvas = null;

			super.kill();
		}

		public function setSector(beginAngle:Number, sectorAngle:Number):void
		{
			_pieMask.rotation = beginAngle * _rad;
			_ratio = sectorAngle / 360;
		}
		
		public function reset():void
		{
			//_pieMask.drawWithFill(NaN); // TODO not working
			//_pieMask.draw(NaN);
		}
		
		public function set background(value:DisplayObject):void
		{
			if (_background) {
				_background.dispose();
				removeChild(_background);
				_background = null;
			}
			
			_background = value;
			if (_background) {
				_background.x = -_background.width / 2;
				_background.y = -_background.height / 2;
				
				addChild(_background);
				addChild(_indicator);
				addChild(_canvas);
			}
		}
		
		public function get progress():Number { return _progress; }
		public function set progress(value:Number):void
		{
			_progress = Math.min(Math.max(0, value * _ratio), _ratio);
			update();
		}
		
		private function update():void
		{
			_pieMask.drawWithFill(progress);
		}
	}

}