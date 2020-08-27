package coconut.flash.renderers;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.events.MouseEvent;

typedef DisplayObjectAttr = {
	@:optional var x:Int;
	@:optional var y:Int;
	@:optional var width:Float;
	@:optional var height:Float;
	@:optional var rotation:Float;
	@:optional var scaleX:Float;
	@:optional var scaleY:Float;
	@:optional var alpha:Float;
	@:optional var visible:Bool;
	@:optional var cacheAsBitmap:Bool;
	@:optional var name:String;
}

typedef InteractiveObjectAttr = DisplayObjectAttr & {
	@:optional var mouseEnabled:Bool;

	@:optional var onClick:MouseEvent->Void;
	@:optional var onMouseDown:MouseEvent->Void;
	@:optional var onMouseUp:MouseEvent->Void;
	@:optional var onMouseMove:MouseEvent->Void;
	@:optional var onMouseOver:MouseEvent->Void;
	@:optional var onMouseOut:MouseEvent->Void;
	@:optional var onMouseWheel:MouseEvent->Void;
	@:optional var onRollOver:MouseEvent->Void;
	@:optional var onRollOut:MouseEvent->Void;
}

typedef DisplayObjectContainerAttr = InteractiveObjectAttr & {
	@:optional var mouseChildren:Bool;
}

function setDisplayObjectAttrs(w:DisplayObject, old:DisplayObjectAttr, nu:DisplayObjectAttr) {
	w.x = opt(nu.x, 0);
	w.y = opt(nu.y, 0);

	if (nu.width != null) {
		w.width = nu.width;
	} else {
		w.scaleX = 1;
	}
	if (nu.height != null) {
		w.height = nu.height;
	} else {
		w.scaleY = 1;
	}

	w.rotation = opt(nu.rotation, 0);
	w.scaleX = opt(nu.scaleX, 1);
	w.scaleY = opt(nu.scaleY, 1);
	w.alpha = opt(nu.alpha, 1);
	w.visible = opt(nu.visible, true);
	w.cacheAsBitmap = opt(nu.cacheAsBitmap, false);

	w.name = opt(nu.name, ""); // TODO: preserver original name somehow
}

function setInteractiveObjectAttrs(w:InteractiveObject, old:InteractiveObjectAttr, nu:InteractiveObjectAttr) {
	setDisplayObjectAttrs(w, old, nu);
	w.mouseEnabled = opt(nu.mouseEnabled, true);
	evt(MouseEvent.CLICK, w, old.onClick, nu.onClick);
	evt(MouseEvent.MOUSE_DOWN, w, old.onMouseDown, nu.onMouseDown);
	evt(MouseEvent.MOUSE_UP, w, old.onMouseUp, nu.onMouseUp);
	evt(MouseEvent.MOUSE_MOVE, w, old.onMouseMove, nu.onMouseMove);
	evt(MouseEvent.MOUSE_OVER, w, old.onMouseOver, nu.onMouseOver);
	evt(MouseEvent.MOUSE_OUT, w, old.onMouseOut, nu.onMouseOut);
	evt(MouseEvent.MOUSE_WHEEL, w, old.onMouseWheel, nu.onMouseWheel);
	evt(MouseEvent.ROLL_OVER, w, old.onRollOver, nu.onRollOver);
	evt(MouseEvent.ROLL_OUT, w, old.onRollOut, nu.onRollOut);
}

function setDisplayObjectContainerAttrs(w:DisplayObjectContainer, old:DisplayObjectContainerAttr, nu:DisplayObjectContainerAttr) {
	setInteractiveObjectAttrs(w, old, nu);
	w.mouseChildren = opt(nu.mouseChildren, true);
}

inline function opt<T>(o:Null<T>, def:T):T {
	return if (o != null) o else def;
}

inline function evt<T>(type:String, obj:DisplayObject, old:Null<T->Void>, nu:Null<T->Void>) {
	if (old != null) obj.removeEventListener(type, old);
	if (nu != null) obj.addEventListener(type, nu);
}
