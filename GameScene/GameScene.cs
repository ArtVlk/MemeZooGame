using Godot;
using System;

public partial class GameScene : Node2D
{
	private Camera2D camera;
	private Button menuButton;

	public override void _Ready()
	{
		// Получаем ссылки на камеру и кнопку
		camera = GetNode<Camera2D>("UI/CameraController");
		if (camera == null) { GD.PrintErr("Camera not found!"); }
		menuButton = GetNode<Button>("MenuButton/Button");
		if (menuButton == null) { GD.PrintErr("MenuButton/Button not found!"); }
		// Подключаем сигнал кнопки
		menuButton.Pressed += OnMenuButtonPressed;
	}

	public override void _Process(double delta)
	{
		// Обновляем позицию кнопки относительно камеры
		UpdateMenuButtonPosition();
	}

	private void UpdateMenuButtonPosition()
	{
		// Получаем позицию камеры в мировых координатах
		Vector2 cameraPosition = camera.GlobalPosition;

		// Получаем размеры окна просмотра
		Vector2 viewportSize = GetViewport().GetVisibleRect().Size;

		// Устанавливаем позицию кнопки в левом верхнем углу камеры
		menuButton.GlobalPosition = cameraPosition - viewportSize / 2 + new Vector2(20, 20); // 20 — отступ от края
	}

	private void OnMenuButtonPressed()
	{
		// Обработка нажатия на кнопку "Меню"
		GD.Print("Menu button pressed");
	}
}
