package cocoflash;

import coconut.flash.Children;
import coconut.flash.View;
import flash.display.Sprite;

class VBox extends View {
	@:attribute var spacing:Float = 0;
	@:attribute var children:Children;

	@:ref var container:Sprite;

	function render() '
		<Sprite ref=${container}>
			<for ${child in children}>
				<Sprite>${child}</Sprite>
			</for>
		</Sprite>
	';

	override function viewDidRender() {
		var yPosition = 0.0;
		for (i in 0...container.numChildren) {
			var child = container.getChildAt(i);
			child.y = yPosition;
			yPosition += child.height + spacing;
		}
	}
}
