using Godot;
using System.Collections.Generic;
public class Rewind : RigidBody2D {
	[Export]
	public int positionsMaxCount;
	List<Vector2> positions;
	bool rewinding = false;
	public override void _Ready()
	{
		positions = new List<Vector2>();
	}
	public override void _Process(float delta) 
	{
		if (Input.IsActionJustPressed("rewind"))
		{
			if (rewinding)
			{
				rewinding = false;
				Mode = ModeEnum.Rigid;
			} else
			{
				Mode = ModeEnum.Kinematic;
				rewinding = true;
			}
			
		}

		if (rewinding)
		{
			if (positions.Count != 0)
			{
				GD.Print("rewind start");
				var lastIndex = positions.Count - 1;
				GlobalPosition = positions[lastIndex];
				positions.RemoveAt(lastIndex);
				GD.Print("rewind over");
			} else
			{
				rewinding = false;
				Mode = ModeEnum.Rigid;
			}
		}
		else
		{
			if (positions.Count > positionsMaxCount)
				positions.RemoveAt(0);
			positions.Add(GlobalPosition);
		}
	}
}
