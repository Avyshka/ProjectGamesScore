package by.framework{
	
	public class AMath{
		
		// КОНСТРУКТОР
		public function AMath(){}
		
		
		//<---ОПРЕДЕЛЕНИЕ СТОЛКНОВЕНИЯ--->
		//
		// x1 - координата Х центра первого объекта
		// x2 - координата Х центра второго объекта
		// rangeWidth - дистанция по оси Х при которой должно произойти столкновени
		// y1 - координата Y центра первого объекта
		// y2 - координата Y центра второго объекта
		// rangeHeight - дистанция по оси Y при которой должно произойти столкновени
		public static function smash(x1:Number, x2:Number, rangeWidth:Number, y1:Number, y2:Number, rangeHeight:Number):Boolean{
			
			var rangeX1X2: Number = Math.abs(x1-x2); // абсолютная дистанция между точками по оси Х
			var rangeY1Y2: Number = Math.abs(y1-y2); // абсолютная дистанция между точками по оси Y
			// если дистанция по оси Х больше дистанции столкновения...
			if(rangeX1X2 < rangeWidth){
				// ... то столкновение не произошло
				//return true;
				// если дистанция по оси Y больше дистанции столкновения...
				if(rangeY1Y2 < rangeHeight){
					// ... то столкновение не произошло
					return true;
				}
			}
			
			// если ни одно из условий не выполнилось, значит столкновение произошло
			return false;
		}
		
		public static function smash2(angle:Number, x1:Number, x2:Number, y1:Number, y2:Number, distance:Number):Boolean{
			
			var rangeX1X2: Number; // абсолютная дистанция между точками по оси Х
			var rangeY1Y2: Number; // абсолютная дистанция между точками по оси Y
			
			switch(angle){
				case 0:
					rangeX1X2 = x2-x1;
					rangeY1Y2 = Math.abs(y1-y2);
				break;
				case 90:
					rangeY1Y2 = y2-y1;
					rangeX1X2 = Math.abs(x1-x2);
				break;
				case 180:
					rangeX1X2 = x1-x2;
					rangeY1Y2 = Math.abs(y1-y2);
				break;
				case 270:
					rangeY1Y2 = y1-y2;
					rangeX1X2 = Math.abs(x1-x2);
				break;
			}
			// если дистанция по оси Х меньше дистанции столкновения...
			if(angle == 0 || angle == 180){
				if(rangeX1X2 <= 48 && rangeX1X2 > 24){
					// ... и если дистанция по оси Y меньше дистанции столкновения...
					if(rangeY1Y2 < distance){
						// ... то столкновение не произошло
						return true;
					}
				}
			}
			//
			if(angle == 90 || angle == 270){
				if(rangeY1Y2 <= 48 && rangeY1Y2 > 24){
					// ... и если дистанция по оси Y меньше дистанции столкновения...
					if(rangeX1X2 < distance){
						// ... то столкновение не произошло
						return true;
					}
				}
			}
			// если ни одно из условий не выполнилось, значит столкновение не произошло
			return false;
		}
		
		//<---ПРИНАДЛЕЖИТ ЛИ ТОЧКА ПРЯМОУГОЛЬНИКУ--->
		//
		// recX1 - координата Х верхнего левого угла прямоугольника
		// recX2 - координата Х нижнего правого угла прямоугольника
		// recY1 - координата Y верхнего левого угла прямоугольника
		// recY2 - координата Y нижнего правого угла прямоугольника
		// pX    - координата Х точки
		// pY    - координата Y точки
		public static function inRectangle(recX1:Number, recY1:Number, recX2:Number, recY2:Number,
										pX:Number, pY:Number):Boolean{
			
			if(pX >= recX1 && pX <= recX2){
				if(pY >= recY1 && pY <= recY2){
					return true;
				}
			}
			
			return false;
		}
		
		//<---ОПРЕДЕЛЕНИЕ РАССТОЯНИЯ МЕЖДУ ДВУМЯ ОБЪЕКТАМИ--->
		//
		// x1 - координата Х центра первого объекта
		// x2 - координата Х центра второго объекта
		// y1 - координата Y центра первого объекта
		// y2 - координата Y центра второго объекта
		public static function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number{
			
			var X1X2: Number = Math.abs(x1-x2); // абсолютная дистанция между точками по оси Х
			var Y1Y2: Number = Math.abs(y1-y2); // абсолютная дистанция между точками по оси Y
			
			return Math.sqrt(Math.pow(X1X2, 2)+Math.pow(Y1Y2, 2));
		}
		
		//<---СЛУЧАЙНОЕ ЧИСЛО В ЗАДАННОМ ДИАПАЗОНЕ--->
		//
		// lower - нижняя граница
		// upper - верхняя граница
		// float - число знаков после запятой (по умолчанию: 0);
		public static function random(lower:Number, upper:Number, float = 0):Number{
			
			var grade: Number = Math.pow(10, float);//дробная часть
			//возвращаем случайное число в заданом диапазоне
			return (Math.floor(((upper-lower)*grade+.99)*Math.random()+(lower*grade)))/grade;
		}
		
		
		//<---ПЕРЕВОД УГЛА В ГРАДУСЫ--->
		//
		// radians - угол в радианах
		public static function toDegrees(radians:Number):Number{
			return radians*(180/Math.PI);
		}
		
		
		//<---ПЕРЕВОД УГЛА В РАДИАНЫ--->
		//
		// degrees - угол в градусах
		public static function toRadians(degrees:Number):Number{
			return degrees*(Math.PI/180);
		}
		
		
		/**
		 * Сравнивает два значения с заданной погрешностью.
		 * 
		 * @param a, b - сравниваемые значения.
		 * @param diff - допустимая погрешность.
		 * 
		 * @return возвращает true если значения равны, или false если не равны.
		 */
		public static function equal(a:Number, b:Number, diff:Number = 0.00001):Boolean
		{
			return (Math.abs(a - b) <= diff);
		}
		
		/**
		 * Возвращает угол между двумя точками радианах.
		 * 
		 * @param x1, y1 - координаты первой точки.
		 * @param x2, y2 - координаты второй точки.
		 * 
		 * @return угол между двумя точками в радианах.
		 */
		public static function getAngleRad(x1:Number, y1:Number, x2:Number, y2:Number, norm:Boolean = true):Number
		{
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			var angle:Number = Math.atan2(dy, dx);
			
			if (norm)
			{
				if (angle < 0)
				{
					angle = Math.PI * 2 + angle;
				}
				else if (angle >= Math.PI * 2)
				{
					angle = angle - Math.PI * 2;
				}
			}
			
			return angle;
		}
		
		/**
		 * Возвращает угол между двумя точками в градусах.
		 * 
		 * @param x1, y1 - координаты первой точки.
		 * @param x2, y2 - координаты второй точки.
		 * 
		 * @return угол между двумя точками в градусах.
		 */
		public static function getAngleDeg(x1:Number, y1:Number, x2:Number, y2:Number, norm:Boolean = true):Number
		{
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			var angle:Number = Math.atan2(dy, dx) / Math.PI * 180;
			
			if (norm)
			{
				if (angle < 0)
				{
					angle = 360 + angle;
				}
				else if (angle >= 360)
				{
					angle = angle - 360;
				}
			}
			
			return angle;
		}
		
		public static function toPercent(current:Number, total:Number):Number{
			return current / total;
		}
		
		public static function fromPercent(percent:Number, total:Number):Number{
			return total/100*percent;
		}
		
		/**
		 * Сумма чисел
		 * 
		 * @param args - массив чисел
		 *
		 * @return возвращает сумму сех элементов массива
		 */
		public static function summ(args:Array):Number
		{
			var s:Number = 0;
			
			for(var i:int=0; i<args.length; i++)
				s += args[i];
			
			return s;
		}
		
		public static function aver(args:Array, count:int = -1):Number
		{
			var s:Number = 0;
			var n:int = args.length;
			var aver:Number;
			
			
			for(var i:int=0; i<n; i++)
				s += args[i];
			
			aver = s / n;
			
			if(count == -1)
				return aver;
			
			var round:int = Math.pow(10, count);
			
			return Math.round(aver * round) / round;
		}

		public static function min(args: Array): Number
		{
			var min: Number = args[0];
			var count: int = args.length;

			for (var i: int = 1; i < count; i++)
			{
				if (min > args[i])
				{
					min = args[i];
				}
			}
			return min;
		}

		public static function max(args: Array): Number
		{
			var max: Number = args[0];
			var count: int = args.length;

			for (var i: int = 1; i < count; i++)
			{
				if (max < args[i])
				{
					max = args[i];
				}
			}
			return max;
		}
	}
}