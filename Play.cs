using Godot;
using System;

public class Play : MeshInstance
{
	[Export]
	public float speed = 14f;
	
	public override void _Process(float delta)
	{
		var direction = Vector3.Zero;

		if (Input.IsActionPressed("move_right"))
		{
			direction.x = 1;
		}
		if (Input.IsActionPressed("move_left"))
		{
			direction.x -= 1;
		}
		if (Input.IsActionPressed("move_forward"))
		{
			direction.z -= 1;
		}
		if (Input.IsActionPressed("move_back"))
		{
			direction.z = 1;
		}

		if (direction != Vector3.Zero)
		{
			Translate(direction * delta);
		}
	}
}
