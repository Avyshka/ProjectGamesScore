package by.framework {
	
	public class ATween {

		public function ATween() {}
		
		// xVel = velElastic(ball.x, mouseX, .2, .75, xVel);
		// замедление по типу пружны
		public static function velElastic(orig:Number, dest:Number, springConst:Number, damp:Number, elas:Number):Number{
			elas += -springConst*(orig-dest);
			return elas*=damp;
		}
		
		// ball.x += velFriction(ball.x, mouseX, 8);
		// замедление на основе парадокса Зенона
		public static function velFriction(orig:Number, dest:Number, coeff:Number):Number {
			return (dest-orig)/coeff;
		}
		
		// замедление на основе парадокса Зенона
		public static function velFade(speed:Number, coeff:Number):Number {
			return speed*coeff;
		}
	}
	
}
