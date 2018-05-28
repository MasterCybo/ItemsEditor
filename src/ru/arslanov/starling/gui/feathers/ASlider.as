package ru.arslanov.starling.gui.feathers
{
	import feathers.controls.Slider;
	
	import flash.geom.Point;
	
	import ru.arslanov.starling.interfaces.IKillableStarling;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class ASlider extends Slider implements IKillableStarling
	{
		private var _isKilled:Boolean;
		private var _pos:Point = new Point();
		
		public function ASlider()
		{
			super();
		}
		
		/* INTERFACE ru.arslanov.starling.interfaces.IKillableStarling */
		
		public function kill():void
		{
			_pos = null;
		}
		
		public function get isKilled():Boolean { return _isKilled; }
		
		public function get pos():Point { return _pos; }
		
		public function set pos(value:Point):void
		{
			if ((pos.x == value.x) && (pos.y == value.y)) return;
			
			_pos = value;
			applyPosition();
		}
		
		public function setXY(x:Number = 0, y:Number = 0, round:Boolean = true):void
		{
			_pos.setTo(round ? Math.round(x) : x, round ? Math.round(y) : y);
			applyPosition();
		}
		
		private function applyPosition():void
		{
			x = pos.x;
			y = pos.y;
		}
	}
}