package by.framework {
	import flash.geom.Point;
	
	public class Organizer {

		public function Organizer() {
			// constructor code
		}
		
		public static function rangeX(range:Number, count:int, center:Number = 0):Array
		{
			var arr:Array = [];
			var step:Number = range / (count - 1);
			var begin:Number = center - range / 2;
			
			for(var i:int=0; i<count; i++)
			{
				arr.push(i * step + begin);
			}
			
			return arr;
		}
		
		public static function stepXY(count:int, stepX:int, stepY:int, max:int, center:Point = null):Vector.<Point>
		{
			if (!center)
			{
				center = new Point(0, 0);
			}
			var rows:int = Math.ceil(count / max);
			var beganY:Number = center.y - (rows - 1) * stepY / 2;
			var beganX:Number;
			var arr:Vector.<Point> = new Vector.<Point>();
			
			var arrI:Array = [];
			while(true)
			{
				if(count > max + 1)
				{
					count -= max;
					arrI.push(max);
				}
				else if(count == max + 1)
				{
					count -= int((max + 1) / 2);
					arrI.push(int((max + 1) / 2));
				}
				else
				{
					arrI.push(count);
					break;
				}
			}
			
			for(var i:int=0; i<arrI.length; i++)
			{
				var dY:Number = i * stepY + beganY;
				beganX = center.x - (arrI[i] - 1) * stepX / 2;
				for(var j:int=0; j<arrI[i]; j++){
					arr.push(new Point(j * stepX + beganX, dY));
				}
			}
			
			return arr;
		}
		
		public static function line(count:int, step:Point, center:Point = null):Vector.<Point>
		{
			if (!center)
			{
				center = new Point(0, 0);
			}
			var beganY:Number = center.y - (count - 1) * step.y / 2;
			var beganX:Number = center.x - (count - 1) * step.x / 2;
			
			var vPoints:Vector.<Point> = new Vector.<Point>();
						
			for(var i:int=0; i<count; i++)
			{
				vPoints.push(new Point(beganX + i * step.x, beganY + i * step.y));
			}
			
			return vPoints;
		}
	}
	
}
