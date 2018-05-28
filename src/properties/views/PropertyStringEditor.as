package properties.views
{
	import base.views.AppTextInput;
	import base.views.ITextEditor;
	
	import feathers.controls.Label;
	
	public class PropertyStringEditor extends PropertyEditorAbstract
	{
		public function PropertyStringEditor(name:String, value:String = null)
		{
			super(name, value);
		}
		
		override protected function titleFactory():Label
		{
			return new Label();
		}
		
		override protected function textInputFactory():ITextEditor
		{
			return new AppTextInput();
		}
	}
}
