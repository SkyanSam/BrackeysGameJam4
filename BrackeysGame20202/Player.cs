using Godot;
using System;

public class Player : Node2D
{
	[Export]
	public float moveSpeed = 300;
	[Export]
	public float gravity = 33f;
	[Export]
	public float maxGravity = 500;
	[Export]
	public float jumpSpeed = -700f;

	KinematicBody2D kinematicBody2D;

	public Vector2 velocity = Vector2.Zero;
	public override void _PhysicsProcess(float delta)
	{
		velocity.x = (Input.GetActionStrength("moveRight") - Input.GetActionStrength("moveLeft")) * moveSpeed;

		if (Input.IsActionJustPressed("jump") && kinematicBody2D.IsOnFloor())
		{
			
			velocity.y = jumpSpeed;
		}
		else
		{
			velocity.y += gravity;
			velocity.y = Mathf.Clamp(velocity.y, jumpSpeed, maxGravity);
		}

		kinematicBody2D.MoveAndSlide(velocity, upDirection: Vector2.Up, infiniteInertia: false);
	}
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		kinematicBody2D = GetParent() as KinematicBody2D;
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
