package coconut.flash;

import coconut.diffing.VNode;
import flash.display.DisplayObject;

@:pure
abstract RenderResult(VNode<DisplayObject>) to VNode<DisplayObject> from VNode<DisplayObject> {
	inline function new(n) {
		this = n;
	}

	@:from static function ofNode(n:DisplayObject):RenderResult {
		return VNativeInst(n);
	}

	@:from static function ofView(v:View):RenderResult {
		return VWidgetInst(v);
	}
}
