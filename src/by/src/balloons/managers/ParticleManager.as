package by.src.balloons.managers
{
	import by.framework.AMath;
	import by.framework.ComponentPool;
	import by.framework.particles.Particle;
	import by.src.data.ParticleData;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;
	import by.src.map.MapView;

	import starling.events.Event;

	public class ParticleManager
	{
		private static var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();
		private static var _mapView: MapView = MapView.getInstance();

		public function ParticleManager()
		{
			_dispatcher.addEventListener(Events.ADD_PARTICLES, onAddParticles);
		}

		private function onAddParticles(event: Event): void
		{
			const particleData: ParticleData = event.data as ParticleData;
			particleData.posY -= 55;

			const countColors: uint = particleData.vColors.length - 1;

			for (var i: int = 0; i < 20; i++)
			{
				const color: uint = particleData.vColors[AMath.random(0, countColors)];
				const particle: Particle = ComponentPool.get(Particle);
				particle.init(particleData.posX, particleData.posY);
				particle.setColor(color);
				_mapView.layerBalloons.addChild(particle);
			}
		}
	}
}
