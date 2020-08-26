package coconut.flash;

import haxe.macro.Expr;

class Renderer {
	static public function hxx(e:Expr):Expr {
		return coconut.flash.macros.HXX.parse(e);
	}

	static function mount(target:Expr, markup:Expr):Expr {
		return coconut.ui.macros.Helpers.mount(macro coconut.flash.Renderer.mountInto, target, markup, hxx);
	}
}
