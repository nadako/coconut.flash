package coconut.flash;

@:build(coconut.ui.macros.ViewBuilder.build((_ : coconut.flash.RenderResult)))
@:autoBuild(coconut.flash.View.autoBuild())
class View extends coconut.diffing.Widget<flash.display.DisplayObject> {
	macro function hxx(e);
}
