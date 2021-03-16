package coconut.flash;

import coconut.diffing.Applicator;
import coconut.diffing.Cursor;
import coconut.diffing.Root;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;

class Renderer {
	static final BACKEND = new FlashBackend();

	public static function mountInto(target:DisplayObject, vdom:RenderResult) {
		Root.fromNative(target, BACKEND).render(vdom);
	}

	public static macro function mount(target, markup);

	public static macro function hxx(e);
}

private class FlashCursor implements Cursor<DisplayObject> {
	public final applicator:Applicator<DisplayObject>;

	final container:DisplayObjectContainer;
	var childIndex:Int;

	public function new(backend:FlashBackend, container:DisplayObjectContainer, childIndex:Int) {
		applicator = backend;
		this.container = container;
		this.childIndex = childIndex;
	}

	public function insert(real:DisplayObject) {
		container.addChildAt(real, childIndex);
		// always increment child index, because it can't happen if we reinsert a node that already was before our pointer, according to Juraj ^^
		childIndex++;
	}

	public function delete(count:Int) {
		while (count-- > 0) {
			container.removeChildAt(childIndex);
		}
	}
}

private class NoopCursor implements Cursor<DisplayObject> {
	public final applicator:Applicator<DisplayObject>;

	public function new(backend:FlashBackend) {
		applicator = backend;
	}

	public function insert(real:DisplayObject) {}

	public function delete(count:Int) {}
}

private class FlashBackend implements Applicator<DisplayObject> {
	static final markerPool:Array<DisplayObject> = [];

	public function new() {}

	public function siblings(first:DisplayObject):Cursor<DisplayObject> {
		return new FlashCursor(this, first.parent, first.parent.getChildIndex(first));
	}

	public function children(parent:DisplayObject):Cursor<DisplayObject> {
		return switch (Std.downcast(parent, DisplayObjectContainer)) {
			case null: new NoopCursor(this); // TODO: do we still need this?
			case container: new FlashCursor(this, container, 0);
		};
	}

	public function createMarker():DisplayObject {
		return switch (markerPool.pop()) {
			case null: new Shape();
			case marker: marker;
		};
	}

	public function releaseMarker(marker:DisplayObject) {
		markerPool.push(marker);
	}
}
