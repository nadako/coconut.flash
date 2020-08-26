package coconut.flash.macros;

#if macro
import haxe.macro.Compiler;

class Setup {
	static function run() {
		Compiler.addMetadata("@:hxx.delegate((_ : coconut.flash.renderers.SpriteRenderer))", "flash.display.Sprite");
		Compiler.addMetadata("@:hxx.delegate((_ : coconut.flash.renderers.BitmapRenderer))", "flash.display.Bitmap");
		Compiler.addMetadata("@:hxx.delegate((_ : coconut.flash.renderers.TextFieldRenderer))", "flash.text.TextField");
	}
}
#end