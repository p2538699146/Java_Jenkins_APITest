package yi.master.test.common;

import java.io.Serializable;

public class Person implements Serializable
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	String name;
    
    int age;
    
//    transient int age;    //此属性不可序列化
    
    double height;
    
    public Person(int age, String name, double height)
    {
        this.age = age;
        this.name = name;
        this.height = height;
    }
    
    public String toString()
    {
    return this.name + "," +this.age + "," + this.height;
    }
    
}
