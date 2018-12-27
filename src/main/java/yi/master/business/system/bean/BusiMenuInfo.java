package yi.master.business.system.bean;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

import org.apache.struts2.json.annotations.JSON;

import yi.master.annotation.FieldNameMapper;
import yi.master.business.user.bean.User;

/**
 *     业务菜单信息
 * @author xuwangcheng
 * @version 2018.12.27
 */
public class BusiMenuInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer menuId;
	private String menuName;
	private String menuUrl;
	private String iconName;
	private Integer nodeLevel;
	private Integer seq;
	private Timestamp createTime;
	private User createUser;
	private String mark;
	private BusiMenuInfo parentNode;
	private Set<BusiMenuInfo> childs = new HashSet<BusiMenuInfo>();

	private String parentNodeName;
	private Integer parentNodeId;
	
	public BusiMenuInfo() {
		super();
	}

	public BusiMenuInfo(Integer menuId) {
		super();
		this.menuId = menuId;
	}
	
	public BusiMenuInfo(Integer menuId, String menuName, String menuUrl, String iconName, Integer nodeLevel,
			Integer seq, Timestamp createTime, User createUser, String mark, BusiMenuInfo parentNode,
			Set<BusiMenuInfo> childs) {
		super();
		this.menuId = menuId;
		this.menuName = menuName;
		this.menuUrl = menuUrl;
		this.iconName = iconName;
		this.nodeLevel = nodeLevel;
		this.seq = seq;
		this.createTime = createTime;
		this.createUser = createUser;
		this.mark = mark;
		this.parentNode = parentNode;
		this.childs = childs;
	}

	
	public void setParentNodeName(String parentNodeName) {
		this.parentNodeName = parentNodeName;
	}
	
	public String getParentNodeName() {
		if (this.parentNode != null) {
			return this.parentNode.getMenuName();
		}
		return "";
	}
	
	public void setParentNodeId(Integer parentNodeId) {
		this.parentNodeId = parentNodeId;
	}
	
	public Integer getParentNodeId() {
		if (this.parentNode != null) {
			return this.parentNode.getMenuId();
		}
		return null;
	}
	
	public Integer getParentNodeId2() {
		return this.parentNodeId;
	}
	
	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuUrl() {
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public String getIconName() {
		return iconName;
	}

	public void setIconName(String iconName) {
		this.iconName = iconName;
	}

	public Integer getNodeLevel() {
		return nodeLevel;
	}

	public void setNodeLevel(Integer nodeLevel) {
		this.nodeLevel = nodeLevel;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	
	@JSON(format="yyyy-MM-dd HH:mm:ss")
	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public User getCreateUser() {
		return createUser;
	}

	public void setCreateUser(User createUser) {
		this.createUser = createUser;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}
	
	@JSON(serialize=false)
	public BusiMenuInfo getParentNode() {
		return parentNode;
	}

	public void setParentNode(BusiMenuInfo parentNode) {
		this.parentNode = parentNode;
	}
	
	@JSON(serialize=false)
	public Set<BusiMenuInfo> getChilds() {
		return childs;
	}

	public void setChilds(Set<BusiMenuInfo> childs) {
		this.childs = childs;
	}
}
