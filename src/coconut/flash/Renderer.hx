package coconut.flash;

import coconut.diffing.Applicator;
import coconut.diffing.Cursor;
import coconut.diffing.Differ;
import coconut.diffing.Rendered;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;

class Renderer {
	static final DIFFER = new Differ(new FlashBackend());

	public static function mountInto(target:DisplayObjectContainer, vdom:RenderResult) {
		DIFFER.render([vdom], target);
	}

	public static macro function mount(target, markup);

	public static macro function hxx(e);
}

private class FlashCursor implements Cursor<DisplayObject> {
	final container:DisplayObjectContainer;
	var childIndex:Int;

	public function new(container:DisplayObjectContainer, childIndex:Int) {
		this.container = container;
		this.childIndex = childIndex;
	}

	public function insert(real:DisplayObject):Bool {
		var inserted = real.parent != container;
		container.addChildAt(real, childIndex);
		if (inserted) {
			childIndex++;
		}
		return inserted;
	}

	public function step():Bool {
		if (childIndex >= container.numChildren) {
			return false;
		} else {
			childIndex++;
			return childIndex == container.numChildren;
		}
	}

	public function delete():Bool {
		if (childIndex >= container.numChildren) {
			return false;
		} else {
			container.removeChildAt(childIndex);
			return true;
		}
	}

	public function current():DisplayObject {
		if (childIndex >= container.numChildren) {
			return null;
		} else {
			return container.getChildAt(childIndex);
		}
	}
}

private class NoopCursor implements Cursor<DisplayObject> {
	function new() {}
	public static final instance = new NoopCursor();

	public function insert(real:DisplayObject):Bool {
		return false;
	}

	public function step():Bool {
		return false;
	}

	public function delete():Bool {
		return false;
	}

	public function current():DisplayObject {
		return null;
	}
}

private class FlashBackend implements Applicator<DisplayObject> {
	static final PLACEHOLDER:RenderResult = new Shape();

	// TODO: on OpenFL/JS we can set last renders to the object to avoid mapping (see coconut.vdom)
	final registry:Map<DisplayObject, Rendered<DisplayObject>> = new Map();

	public function new() {}

	public function unsetLastRender(target:DisplayObject):Rendered<DisplayObject> {
		var ret = registry[target];
		registry.remove(target);
		return ret;
	}

	public function traverseSiblings(first:DisplayObject) {
		return new FlashCursor(first.parent, first.parent.getChildIndex(first));
	}

	public function traverseChildren(parent:DisplayObject) {
		return switch (Std.downcast(parent, DisplayObjectContainer)) {
			case null: NoopCursor.instance; // TODO: is it right that coconut calls this on non-container objects?
			case container: new FlashCursor(container, 0);
		};
	}

	public function placeholder(target):RenderResult {
		return PLACEHOLDER;
	}

	public function getLastRender(target:DisplayObject):Null<Rendered<DisplayObject>> {
		return registry[target];
	}

	public function setLastRender(target:DisplayObject, r:Rendered<DisplayObject>) {
		registry[target] = r;
	}
}
