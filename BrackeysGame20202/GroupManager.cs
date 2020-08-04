using Godot;
using System;

public class GroupManager : Node2D
{
	[Export]
	public string groupName;
	public override void _Ready()
	{
		for (int i = 0; i < GetChildCount(); i++)
			GetChild<RigidBody2D>(i).AddToGroup(groupName);
	}
}
