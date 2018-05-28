package
{
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import ru.arslanov.starling.StarlingManager;
	
	[SWF(width=1024, height=800, frameRate=60)]
	public class Main extends Sprite
	{
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			StarlingManager.create(App, stage);
		}
	}
}
