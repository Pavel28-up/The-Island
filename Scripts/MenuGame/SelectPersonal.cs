using Godot;
using System;

public class SelectPersonal : Node
{
	[Export]
	public string levelNameGame;
	[Export]
	public string levelNameMenu;

	private void OnSelectGamePressed()
	{
		var global = GetNode<Global>("/root/Global");
		global.GotoScene("res://Scenes/"+levelNameGame+".tscn");
	}

	private void OnBackPressed()
	{
		var global = GetNode<Global>("/root/Global");
		global.GotoScene("res://Scenes/"+levelNameMenu+".tscn");
	}
}



