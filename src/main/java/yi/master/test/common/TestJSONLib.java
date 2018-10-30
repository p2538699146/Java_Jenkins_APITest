package yi.master.test.common;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TestJSONLib {
	private List<Date> time = new ArrayList<Date>();

	public List<Date> getTime() {
		return time;
	}

	public void setTime(List<Date> time) {
		this.time = time;
	}

	@Override
	public String toString() {
		return "TestJSONLib [time=" + time + "]";
	}
}
