using Godot;

public partial class CameraController : Camera2D
{
	[Export] public float MapWidth = 1920f;
	[Export] public float MapHeight = 1080f;
	[Export] public float PanSpeed = 300.0f;
	[Export] public float ZoomSpeed = 0.1f;
	[Export] public Vector2 ZoomMinMax = new Vector2(0.5f, 2.0f);
	
	private Vector2 _lastViewportSize;

	public override void _EnterTree()
	{
		base._EnterTree();
		UpdateViewportSize();
		ClampPosition();
	}

	public override void _Process(double delta)
	{
		HandlePan(delta);
		HandleZoom();
		
		// Проверяем изменение размера окна
		if (GetViewport().GetVisibleRect().Size != _lastViewportSize)
		{
			UpdateViewportSize();
			ClampPosition();
		}
		else
		{
			ClampPosition();
		}
	}

	private void UpdateViewportSize()
	{
		_lastViewportSize = GetViewport().GetVisibleRect().Size;
	}

	private void ClampPosition()
	{
		Rect2 mapRect = new Rect2(0, 0, MapWidth, MapHeight);
		Vector2 visibleHalfSize = 0.5f * _lastViewportSize / Zoom;
		
		Rect2 cameraLimits = new Rect2(
			visibleHalfSize,
			new Vector2(MapWidth, MapHeight) - 2 * visibleHalfSize
		);

		// Корректируем границы если карта меньше видимой области
		if (cameraLimits.Size.X < 0)
		{
			cameraLimits.Position = new Vector2(MapWidth / 2, cameraLimits.Position.Y);
			cameraLimits.Size = new Vector2(0, cameraLimits.Size.Y);
		}
		
		if (cameraLimits.Size.Y < 0)
		{
			cameraLimits.Position = new Vector2(cameraLimits.Position.X, MapHeight / 2);
			cameraLimits.Size = new Vector2(cameraLimits.Size.X, 0);
		}

		Vector2 clampedPosition = new Vector2(
			Mathf.Clamp(Position.X, cameraLimits.Position.X, cameraLimits.Position.X + cameraLimits.Size.X),
			Mathf.Clamp(Position.Y, cameraLimits.Position.Y, cameraLimits.Position.Y + cameraLimits.Size.Y)
		);

		Position = clampedPosition;
	}

	private void HandlePan(double delta)
	{
		Vector2 direction = Vector2.Zero;
		
		if (Input.IsActionPressed("ui_right")) direction.X += 1;
		if (Input.IsActionPressed("ui_left")) direction.X -= 1;
		if (Input.IsActionPressed("ui_down")) direction.Y += 1;
		if (Input.IsActionPressed("ui_up")) direction.Y -= 1;

		direction = direction.Normalized();
		Position += direction * PanSpeed * (float)delta;
	}

	private void HandleZoom()
	{
		float zoomDelta = 0;
		if (Input.IsActionJustReleased("ui_scroll_up")) zoomDelta = -ZoomSpeed;
		if (Input.IsActionJustReleased("ui_scroll_down")) zoomDelta = ZoomSpeed;

		if (zoomDelta != 0)
		{
			Vector2 oldZoom = Zoom;
			Vector2 newZoom = new Vector2(
				Mathf.Clamp(oldZoom.X + zoomDelta, ZoomMinMax.X, ZoomMinMax.Y),
				Mathf.Clamp(oldZoom.Y + zoomDelta, ZoomMinMax.X, ZoomMinMax.Y)
			);
			
			// Корректировка позиции относительно мыши
			Vector2 mouseGlobalBefore = GetGlobalMousePosition();
			Zoom = newZoom;
			Vector2 mouseGlobalAfter = GetGlobalMousePosition();
			Position += mouseGlobalBefore - mouseGlobalAfter;
			
			// Форсируем обновление границ
			UpdateViewportSize();
			ClampPosition();
		}
	}
}
