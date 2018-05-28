package properties.views
{
	import base.views.AppTextInputArea;
	import base.views.ITextEditor;
	
	import feathers.controls.Label;
	import feathers.core.FeathersControl;
	import feathers.layout.BaseLinearLayout;
	import feathers.layout.VerticalAlign;
	
	public class PropertyAreaEditor extends PropertyEditorAbstract
	{
		
		public function PropertyAreaEditor(name:String, value:* = null)
		{
			super(name, value);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var editorLayout:BaseLinearLayout = layout as BaseLinearLayout;
			editorLayout.verticalAlign = VerticalAlign.TOP;
		}
		
		override protected function titleFactory():Label
		{
			return new Label();
		}
		
		override protected function textInputFactory():ITextEditor
		{
			var area:AppTextInputArea = new AppTextInputArea();
			area.height = 80;
			return area;
		}
	}
}
