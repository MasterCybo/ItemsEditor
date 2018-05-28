package base.views
{
	import feathers.core.IFeathersEventDispatcher;
	import feathers.layout.ILayoutData;
	
	public interface ITextEditor extends IFeathersEventDispatcher
	{
		function get text():String;
		function set text(value:String):void;
		
		function get layoutData():ILayoutData;
		function set layoutData(value:ILayoutData):void;
	}
}
