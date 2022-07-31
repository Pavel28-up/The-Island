using Godot;
using System;

public class Global : Node
{
	[Export]
	public Node currentScene {get; set;}
	[Export]
	public string level;
	[Export]
	public string levelName;
	
	public override void _Ready()
	{
		var Viewport = GetTree().GetRoot();
		currentScene = GetChild(GetChildCount() -1 );
		GD.Print(currentScene);
	}

	public void GotoScene(string path)
	{
		CallDeferred(nameof(DeferredGotoScene), path);
	}

	public void DeferredGotoScene(string path)
	{
		currentScene.Free();

		var nextScene = (PackedScene)GD.Load(path);
		currentScene = nextScene.Instance();

		GetTree().SetCurrentScene(currentScene);
	}

	// public void OnGamePressed()
	// {
	// 	var global = GetNode<MenuGame>("/root/Global");
	// 	GD.Print(global);
	// 	global.GotoScene("res://Scenes" + levelName +".tscn");
	// }
}
