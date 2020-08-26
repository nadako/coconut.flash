package coconut.flash;

import haxe.macro.Expr;

class View {
	static function hxx(_, e:Expr):Expr {
		return coconut.flash.macros.HXX.parse(e);
	}

	static function autoBuild():Array<Field> {
		return coconut.diffing.macros.ViewBuilder.autoBuild(macro : coconut.flash.RenderResult);
	}
}
