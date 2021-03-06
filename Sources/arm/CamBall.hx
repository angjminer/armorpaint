package arm;

import iron.Trait;
import iron.system.Input;
import iron.math.Vec4;

@:keep
class CamBall extends Trait {

	public static var moved = false;

	public function new() {
		super();

		notifyOnUpdate(update);
	}

	function update() {
		if (Input.occupied) return;
		if (!UITrait.uienabled) return;
		if (UITrait.isScrolling) return;
		if (UITrait.isDragging) return;
		if (UITrait.cameraType != 0) return;
		if (!object.visible) return;

		var mouse = Input.getMouse();
		var kb = Input.getKeyboard();

		// Paint bounds
		if (mouse.x > iron.App.w()) return;
		// if (UINodes.show && mouse.y > UINodes.wy) return;
		// if (UINodesBrush.show && mouse.y > UINodesBrush.wy) return;

		if (mouse.down("right") || (mouse.down("left") && kb.down("ctrl"))) {
			UITrait.dirty = true;
			
			// Rotate
			object.transform.rotate(new Vec4(0, 0, 1), mouse.movementX / 100);
			object.transform.buildMatrix();
			var v = object.transform.right();
			v.normalize();
			object.transform.rotate(v, mouse.movementY / 100);
			object.transform.buildMatrix();
		}
	}
}
