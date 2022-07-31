using Godot;
using System;

public class Global : Godot.Node
{
	[Export]
	public Node currentScene {get; set;}
	
	public override void _Ready()
	{
		Viewport Root = GetTree().GetRoot();
		currentScene = Root.GetChild(Root.GetChildCount() -1 );
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
		
		GetTree().GetRoot().AddChild(currentScene);
		GetTree().SetCurrentScene(currentScene);
	}
}
