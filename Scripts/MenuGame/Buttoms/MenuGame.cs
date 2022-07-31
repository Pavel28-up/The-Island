using Godot;
using System;

public class MenuGame : Godot.Node
{
	// [Export]
	// public Node currentScene {get; set;}
	[Export]
	public string level;
	[Export]
	public string levelName = "PrologueGame";

	public void OnGamePressed()
	{
		var global = GetNode<Global>("/root/Global");
		global.GotoScene("res://Scenes/"+levelName+".tscn");
	}
}
