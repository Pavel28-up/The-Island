using Godot;
using System;

public class Euler : Camera
{
	public Vector3 pos = new Vector3(0,0,0);
	public Vector3 posY = new Vector3(0,1,0); 
	public override void _Process(float delta)
	{
		// pos = Translate;
		// LookAt(pos, posY);
	}
}
