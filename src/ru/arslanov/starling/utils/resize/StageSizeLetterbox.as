package ru.arslanov.starling.utils.resize
{
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	import starling.events.ResizeEvent;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	/**
	 * Сохраняет пропорции и центрирует картинку, оставляет полоски
	 * @author Artem Arslanov
	 */
	public class StageSizeLetterbox extends EventDispatcher implements IStageSize
	{
		private var _starling:Starling;
		private var _scaleFactor:int;
		private var _baseWidth:uint;
		private var _baseHeight:uint;
		
		public function StageSizeLetterbox( starling:Starling, baseStageWidth:uint = 480, baseStageHeight:uint = 320 ) 
		{
			_baseWidth = baseStageWidth;
			_baseHeight = baseStageHeight;
			_starling = starling;
			
			applySize( starling.nativeStage.fullScreenWidth, starling.nativeStage.fullScreenHeight );
			
			super();
		}
		
		public function dispose():void {
			_starling = null;
		}
		
		public function get starling():Starling { return _starling; }
		public function get scaleFactor():int { return _scaleFactor; }
		
		private function applySize( width:uint, height:uint ):void
		{
			var viewPort:Rectangle = RectangleUtil.fit( 
					new Rectangle( 0, 0, _baseWidth, _baseHeight )
					, new Rectangle( 0, 0, width, height )
					, ScaleMode.SHOW_ALL );
			//
			
			//trace( "1 viewPort : " + viewPort );
			viewPort.x = int(viewPort.x);
			viewPort.y = int(viewPort.y);
			viewPort.width = int(viewPort.width);
			viewPort.height = int(viewPort.height);
			//trace( "2 viewPort : " + viewPort );
			
			
			starling.viewPort = viewPort;
			starling.stage.stageWidth = _baseWidth;
			starling.stage.stageHeight = _baseHeight;
			
			_scaleFactor = Math.round( starling.contentScaleFactor );
			
			if ( starling.showStats ) {
				starling.showStatsAt( "center", "top" );
			}
		}
		
	}

}