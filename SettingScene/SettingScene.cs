using Godot;
using System;

public partial class SettingScene : Control
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
	
	public void _on_back_button_pressed()
	{
		GetTree().ChangeSceneToFile("res://MenuScene/MainMenu.tscn");
	}
}
