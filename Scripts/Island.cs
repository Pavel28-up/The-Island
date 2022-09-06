using Godot;
using System;

public class Island : Spatial
{
	[Export]
	public float speed = 0.1f;
	[Export]
	public Vector3 _velocity = new Vector3(0, 1, 0);

	public override void _Process(float delta)
	{
		Rotate(_velocity, speed * delta);
	}
}
