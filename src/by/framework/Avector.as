package by.framework {
	
	public class Avector {
		
		public var x:Number;
		public var y:Number;
		public var dp:Number;
	
		// конструктор
		public function Avector(ax:Number = 0, ay:Number = 0) {
			x = ax;
			y = ay;
			dp = 0;
		}
		
		/**
		 * Задаем значения вектора по скорости и углу
		 * 
		 * @param speed - скорость движения объекта
		 * @param angle - угол, под которым движится объект
		 */
		public function asSpeed(speed:Number, angle:Number):void{
			x = speed*Math.cos(angle);
			y = speed*Math.sin(angle);
		}
		
		/**
		 * Задаем значения вектора явно
		 * 
		 * @param ax - значение x
		 * @param ay - значение y
		 */
		public function set(ax:int, ay:int):void{
			x = ax;
			y = ay;
		}
		
		/**
		 * Сравнивает указанный вектор с текущим с определенной погрешностью
		 * 
		 * @param v - вектор с которым производится сравнение
		 * @param diff - допустимая погрешность
		 * 
		 * @return возвращает true если векторы равны, или false если не равны
		 */
		public function equal(v:Avector, diff:Number = 0.00001):Boolean
		{
			return (AMath.equal(x, v.x, diff) && AMath.equal(y, v.y, diff));
		}
		
		/**
		 * Копирует параметры переданного вектора
		 * 
		 * @param v - вектор параметры которого будут скопированы
		 */
		public function copy(v:Avector):void
		{
			x = v.x;
			y = v.y;
		}
		
		/**
		 * Складывает значения указанного вектора с текущими
		 * 
		 * @param v - вектор значения которого будут сложены
		 */
		public function add(v:Avector):void
		{
			x += v.x;
			y += v.y;
		}
		
		/**
		 * Квадрат длины вектора
		 *
		 * @return возвращает квадрат длины вектора
		 */
		public function sqr():Number{
			return x*x + y*y;
		}
		
		/**
		 * Нормирование вектора
		 *
		 * Нормирование вектора — это сокращение его длины до 1.
		 * Такие вектора обычно называют единичными. Они часто используются для того,
		 * чтобы задавать направления.
		 */
		public function normalizing():void{
			var len_v:Number = Math.sqrt(x*x + y*y);
			
			if(len_v > 0){
				x /= len_v;
				y /= len_v;
			}
		}
		
		/**
		 * Скалярное умножение векторов
		 * 
		 * @param v - вектор для умножения
		 *
		 * @return возвращает скалярнаую величину (обычное число)
		 */
		public function scalar(v:Avector):Number
		{
			return v.x*x + v.y*y;
		}
		
		/**
		 * Проецирование векторов
		 * 
		 * @param v - вектор для проекции
		 */
		public function projection(v:Avector):Avector
		{
			var ax:Number;
			var ay:Number;
			
			if(sqr() == 1){
				ax = scalar(v) * x;
				ay = scalar(v) * y;
			}else{
				ax = ( scalar(v) / sqr() ) * x;
				ay = ( scalar(v) / sqr() ) * y;
			}
			
			return new Avector(ax, ay);
		}
		
		/**
		 * Правая нормаль вектора
		 * 
		 * Нормалью вектора является вектор,
		 * лежащий на перпендикулярной к исходному вектору прямой и имеющий ту же длину
		 *
		 * @return возвращает правую нормаль
		 */
		public function normalR(v:Avector):Avector
		{
			return new Avector(-y, x);
		}
		
		/**
		 * Левая нормаль вектора
		 * 
		 * Нормалью вектора является вектор,
		 * лежащий на перпендикулярной к исходному вектору прямой и имеющий ту же длину
		 *
		 * @return возвращает левую нормаль
		 */
		public function normalL(v:Avector):Avector
		{
			return new Avector(y, -x);
		}
		
		/**
		 * Cкалярное произведение c перпендикулярным вектором
		 * 
		 * @param v - вектор для произведения
		 *
		 * @return возвращает скалярнаую величину (обычное число)
		 */
		public function perproduct(v:Avector):Number
		{
			var a:Avector = normalR(this);
			
			return v.x*a.x + v.y*a.y;
		}
	}
	
}