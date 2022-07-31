using Godot;
using System;

public class Island : Spatial
{
	[Export]
	public float speed = 0.1f;
	[Export]
	public Vector3 _velocity = new Vector3(0, 1, 0);
	[Export]
	public string level;
	[Export]
	public string levelName;

	public override void _Process(float delta)
	{
		Rotate(_velocity, speed);

	}
	
	public void OnExitpressed()
	{
		// SceneTree.Quit(0);
		GetTree().Quit();
	}

	private void OnGamePressed()
	{
		// level = LoadScenec("res://Scenes/"+levelName+".tscn").Instance;
		// World.AddChild(level);
	}
}
