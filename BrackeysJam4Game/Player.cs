using Godot;
using System;

public class Player : KinematicBody2D
{
	[Export]
	public float moveSpeed = 300;
	[Export]
	public float gravity = 33f;
	[Export]
	public float maxGravity = 500;
	[Export]
	public float jumpSpeed = -700f;
	public Vector2 velocity = Vector2.Zero;
	public override void _PhysicsProcess(float delta)
	{
		velocity.x = (Input.GetActionStrength("moveRight") - Input.GetActionStrength("moveLeft")) * moveSpeed;

		if (Input.IsActionJustPressed("jump"))
		{
			GD.Print("jump yayayya");
			velocity.y = jumpSpeed;
		}
		else
		{
			velocity.y += gravity;
			velocity.y = Mathf.Clamp(velocity.y, jumpSpeed, maxGravity);
		}

		MoveAndSlide(velocity, upDirection: Vector2.Up);
	}
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
