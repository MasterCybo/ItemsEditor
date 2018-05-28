package ru.arslanov.starling.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;

	import ru.arslanov.starling.interfaces.IKillableStarling;

	import starling.display.Image;
	import starling.textures.Texture;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class AImage extends Image implements IKillableStarling
	{

		static public function getFromBitmap(bitmap:Bitmap,
											 generateMipMaps:Boolean = true,
											 optimizeForRenderToTexture:Boolean = false,
											 scale:Number = 1):AImage
		{
			return new AImage(Texture.fromBitmap(bitmap, generateMipMaps, optimizeForRenderToTexture, scale));
		}

		static public function getFromBitmapData(bitmapData:BitmapData,
												 generateMipMaps:Boolean = true,
												 optimizeForRenderToTexture:Boolean = true,
												 scale:Number = 1):AImage
		{
			return new AImage(Texture.fromBitmapData(bitmapData,
															 generateMipMaps,
															 optimizeForRenderToTexture,
															 scale));
		}


		public var customData:Object;

		private var _isKilled:Boolean;
		private var _pos:Point = new Point();

		public function AImage(texture:Texture = null)
		{
			texture = texture ? texture : Texture.fromBitmapData(new BitmapData(10, 10, true, 0x80ff0000));
			super(texture);
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
		}
		
		public function get isKilled():Boolean
		{
			return _isKilled;
		}
		
		public function kill():void
		{
			if (_isKilled) {
				throw ( new Error(this + " already killed!") ).getStackTrace();
			}
			
			removeFromParent(true);
			//texture.dispose();
//			dispose();
			
			customData = null;
			_pos = null;
			_isKilled = true;
			// override me
		}
	}
}