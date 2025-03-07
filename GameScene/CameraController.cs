using Godot;
using System;

public partial class CameraController : Camera2D
{
	// Скорость перемещения камеры
	[Export] public float PanSpeed = 300.0f;

	// Скорость зума камеры
	[Export] public float ZoomSpeed = 0.1f;

	// Минимальный и максимальный зум
	[Export] public Vector2 ZoomMinMax = new Vector2(0.5f, 2.0f);

	public override void _Process(double delta)
	{
		// Обработка перемещения камеры
		HandlePan(delta);

		// Обработка зума камеры
		HandleZoom();
	}

	private void HandlePan(double delta)
	{
		Vector2 direction = Vector2.Zero;

		// Обработка ввода с клавиатуры
		if (Input.IsActionPressed("ui_right"))
			direction.X += 1;
		if (Input.IsActionPressed("ui_left"))
			direction.X -= 1;
		if (Input.IsActionPressed("ui_down"))
			direction.Y += 1;
		if (Input.IsActionPressed("ui_up"))
			direction.Y -= 1;

		// Нормализация направления и применение скорости
		direction = direction.Normalized();
		Position += direction * PanSpeed * (float)delta;
	}

	private void HandleZoom()
	{
		// Обработка зума с помощью колеса мыши
		float zoomDelta = 0;
		if (Input.IsActionJustReleased("ui_scroll_up"))
			zoomDelta = -ZoomSpeed;
		if (Input.IsActionJustReleased("ui_scroll_down"))
			zoomDelta = ZoomSpeed;

		// Применение зума с ограничениями
		if (zoomDelta != 0)
		{
			Zoom = new Vector2(
				Mathf.Clamp(Zoom.X + zoomDelta, ZoomMinMax.X, ZoomMinMax.Y),
				Mathf.Clamp(Zoom.Y + zoomDelta, ZoomMinMax.X, ZoomMinMax.Y)
			);
		}
	}

	
}
