package by.framework 
{
	
	public class Progress
	{
		private var _arrPercents:Array = [];
		
		public function Progress(counts:int)
		{
			for(var i:int=0; i<counts - 1; i++)
				_arrPercents.push(int(100 / counts)/100);
			
			_arrPercents.push(1 - AMath.summ(_arrPercents));
		}
		
		public function getTotalProgress(phase:int, percent:Number):Number
		{
			var lastPhases:Number = 0;
			
			for(var i:int=phase-1; i>=0; i--)
				if(i>=0)
					lastPhases += _arrPercents[i];
			
			return 100 * lastPhases + percent * _arrPercents[phase];
		}

	}
	
}
