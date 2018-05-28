package ru.arslanov.starling.gui.feathers
{
	import feathers.controls.Label;

	import flash.geom.Point;

	import ru.arslanov.starling.interfaces.IKillableStarling;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class ALabel extends Label implements IKillableStarling
	{
		private var _isKilled:Boolean;
		private var _pos:Point = new Point();
		
		public function ALabel()
		{
			super();
		}

		override public function set text(value:String):void
		{
			super.text = value;
			validate();
		}

		public function kill():void
		{
			removeFromParent(true);
			_pos = null;
			_isKilled = true;
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