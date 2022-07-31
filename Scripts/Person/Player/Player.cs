using Godot;
using System;

public class Player : KinematicBody
{
	[Signal]
	public delegate void Hit();
	[Export]
	public int jumpImpulse = 20;
	[Export]
	public float speed = 14f;
	[Export]
	public float speedAceliration = 35f;
	[Export]
	public float speedRot = 35f;
	[Export]
	public float gravity = -9.8f;
	[Export]
	public float rotX = 0f;
	[Export]
	public float rotY = 0f;
	public Vector3 posY = new Vector3(0,1,0); 

	private Vector3 _velocity = Vector3.Zero;

	public override void _Ready()
	{
		Input.SetMouseMode(Input.MouseMode.Captured);
	}

	public override void _Process(float delta)
	{
		var direction = Vector3.Zero;
		// direction.y = gravity;

		if (Input.IsActionJustPressed("ui_cancel"))
		{
			GetTree().Quit();
		}

		if (Input.IsActionPressed("move_right"))
		{
			direction.x -= 1;
		}
		if (Input.IsActionPressed("move_left"))
		{
			direction.x = 1;
		}
		if (Input.IsActionPressed("move_forward"))
		{
			direction.z = 1;
		}
		if (Input.IsActionPressed("move_back"))
		{
			direction.z -= 1;
		}

		if (direction != Vector3.Zero)
		{
			direction *= speed * delta;
			direction = direction.Rotated(posY, Rotation.y);
		}

		// else
		// {
		// 	GetNode<AnimationPlayer>("AnimationPlayer").PlaybackSpeed = 1;
		// }
		if (Input.IsActionPressed("acceleration"))
		{
			_velocity.x = direction.x * speedAceliration;
			_velocity.z = direction.z * speedAceliration;
		}
		else
		{
			_velocity.x = direction.x * speed;
			_velocity.z = direction.z * speed;
		}

		_velocity.y += gravity * delta;
		
		if (IsOnFloor() && Input.IsActionJustPressed("jump"))
		{
			_velocity.y += jumpImpulse;
		}

		_velocity = MoveAndSlide(_velocity, posY);

		// for (int index = 0; index < GetSlideCount(); index++)
		// {
		// 	KinematicCollision collision = GetSlideCollision(index);
		// 	if (collision.Collider is Mob mob && mob.IsInGroup("mob"))
		// 	{
		// 		if (Vector3.Up.Dot(collision.Normal) > 0.1f)
		// 		{
		// 			mob.Squash();
		// 			_velocity.y = bounceImpuls;
		// 		}
		// 	}
		// }

		var pivot = GetNode<Spatial>("Pivot");
		pivot.Rotation = new Vector3(Mathf.Pi / 6f * _velocity.y / jumpImpulse, pivot.Rotation.y, pivot.Rotation.z);
	}

	public override void _Input(InputEvent @event)
	{
		if (@event is InputEventMouseMotion mouseMotion)
		{
			// modify accumulated mouse rotation
			rotX -= mouseMotion.Relative.x * speedRot;
			rotY += mouseMotion.Relative.y * speedRot;

			// reset rotation
			Transform transform = Transform;
			transform.basis = Basis.Identity;
			Transform = transform;
			var Euler = GetNode<Spatial>("Euler");

			if (rotY > 1f)
			{
				RotateObjectLocal(Vector3.Up, rotX);
				GD.Print("> 1:" + rotY);
				rotY = 1;
				RotateObjectLocal(Vector3.Right, rotY);
			}
			else if (rotY == 1f)
			{
				RotateObjectLocal(Vector3.Up, rotX); // first rotate about Y
				GD.Print("== 1:" + rotY);
				rotY = 1;
				RotateObjectLocal(Vector3.Right, rotY);
			}
			else if (rotY < -1f)
			{
				RotateObjectLocal(Vector3.Up, rotX);
				GD.Print("< -1:" + rotY);
				rotY = -1;
				RotateObjectLocal(Vector3.Right, rotY);
			}
			else if (rotY == -1f)
			{
				RotateObjectLocal(Vector3.Up, rotX); // first rotate about Y
				GD.Print("== -1:" + rotY);
				rotY = -1;
				RotateObjectLocal(Vector3.Right, rotY);
			}
			else
			{
				RotateObjectLocal(Vector3.Up, rotX); // first rotate about Y
				GD.Print(rotY);
				RotateObjectLocal(Vector3.Right, rotY);
			}
		}
	}

	// private void Die()
	// {
	// 	EmitSignal(nameof(Hit));
	// 	QueueFree();
	// }

	// private void OnMobDetectorBodyEntered(object body)
	// {
	// 	Die();
	// }
}
