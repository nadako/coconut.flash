package coconut.flash.macros;

#if macro
import haxe.macro.Compiler;

class Setup {
	static function run() {
		var toplevelPackage = #if openfl "openfl" #else "flash" #end;
		Compiler.addMetadata("@:hxx.delegate((_ : coconut.flash.renderers.SpriteRenderer))", toplevelPackage + ".display.Sprite");
		Compiler.addMetadata("@:hxx.delegate((_ : coconut.flash.renderers.BitmapRenderer))", toplevelPackage + ".display.Bitmap");
		Compiler.addMetadata("@:hxx.delegate((_ : coconut.flash.renderers.TextFieldRenderer))", toplevelPackage + ".text.TextField");
	}
}
#end