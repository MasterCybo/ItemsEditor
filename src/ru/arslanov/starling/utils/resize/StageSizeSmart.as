package ru.arslanov.starling.utils.resize
{
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.events.ResizeEvent;
	
	/**
	 * Подстраивает размер картинки под размер экрана, "резиновый" дизайн
	 * @author Artem Arslanov
	 */
	public class StageSizeSmart implements IStageSize
	{
		private var _starling:Starling;
		private var _scaleFactor:int;
		private var _baseWidth:uint;
		private var _baseHeight:uint;
		
		public function StageSizeSmart( starling:Starling, baseStageWidth:uint = 480, baseStageHeight:uint = 320 ) 
		{
			_starling = starling;
			_baseWidth = baseStageWidth;
			_baseHeight = baseStageHeight;
			
			applySize( _baseWidth, _baseHeight );
			
			super();
		}
		
		public function dispose():void {
			_starling = null;
		}
		
		public function get starling():Starling { return _starling; }
		public function get scaleFactor():int { return _scaleFactor; }
		
		private function applySize( width:uint, height:uint ):void
		{
			var stage:Stage = starling.nativeStage;
			var s:int;
			var k:Number;
			
			if ( stage.stageWidth / width > stage.stageHeight / height )
			{
				s = stage.stageWidth / width;
				k = stage.stageWidth / stage.stageHeight;
				starling.stage.stageWidth = stage.stageHeight * k / s;
				starling.stage.stageHeight = stage.stageHeight / s;
			}
			else
			{
				s = stage.stageHeight / height;
				k = stage.stageHeight / stage.stageWidth;
				starling.stage.stageWidth = stage.stageWidth / s;
				starling.stage.stageHeight = stage.stageWidth * k / s;
			}
			
			starling.viewPort = new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight );
			
			_scaleFactor = Math.round( starling.contentScaleFactor );
		}
	}

}