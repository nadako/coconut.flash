package coconut.flash.macros;

#if macro
import coconut.ui.macros.Helpers;
import haxe.macro.Expr;
import tink.hxx.Generator;

class HXX {
	static final generator = new Generator();

	static public function parse(e:Expr):Expr {
		return Helpers.parse(e, generator, 'coconut.diffing.VNode.fragment');
	}
}
#end
