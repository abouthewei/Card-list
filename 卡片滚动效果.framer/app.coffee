# 基础参数
rows = 8
gutter = 16
rowHeight = []
rowWidth = Screen.width - gutter*2
heightA = 0
cellminY = []

for n in [0...rows]
	rowHeight[n] = Utils.round(Utils.randomNumber(240,240),0)  
	#print "rowHeight：[" + n + "]:" + rowHeight[n]
	
	heightA = heightA + rowHeight[n] + 16

# 创建滚动列表
scroll = new ScrollComponent
	size: Screen.size
	speedY: 0.5*0.72
	scrollHorizontal: false

# 创建卡片容器
cells = new Layer
	width: Screen.width
	height: heightA
	backgroundColor: null
	#parent: scroll.content	
# 创建卡片
for index in [0...rows]

	cell = new Layer
		width: rowWidth
		height: rowHeight[index]
		x: Align.center
		y: 0
		parent: cells
		scale: 1
		backgroundColor: "#00AAFF"
		hueRotate: index * 10
		borderRadius: 8
		shadowY: 4
		shadowBlur: 16
		shadowColor: "rgba(0,0,0,.5)"
		
	cell.progress = 0
	
	if index == 0
		cells.children[index].y = 0 
	for m in [0...index]
		cells.children[index].y = cells.children[m].y + rowHeight[m] + gutter
	# 记录卡片minY值
	cellminY[index] = cells.children[index].minY
	
	

#  滚动列表填充&设置
contentA = new Layer
	width: Screen.width
	height: heightA * 1.5
	parent: scroll.content
	backgroundColor: null
scroll.content.backgroundColor = null

# 滚动进度
progress = 0
 
# 滚动事件 
scroll.onMove ->
	
	progress = scroll.content.y * -1
	#print "滑动距离:" + Utils.round(scroll.content.y,0)
	
	for i in [0...rows] 
		#print "滑动距离:" + Utils.round(scroll.content.y,0) + " 距离：[" + i + "]:" + (cellminY[i] * (1-Utils.modulate(progress, [0,cells.children[i].minY], [0,1], true)))
		
		num = (rows-1)-i
		# 卡片进度转换
		cells.children[i].progress = Utils.modulate(progress, [rowHeight[i]*(i+1),rowHeight[i]*i], [0,1])	
		# 卡片透明度
		cells.children[num].opacity = Utils.modulate(cells.children[num].progress, [-0.35,1], [0,1], true) 
		# 卡片尺寸
		cells.children[num].scale = Utils.modulate(cells.children[num].progress, [0,1], [0.94, 1], true)
		# 卡片Y值赋值
		cells.children[i].y = (cellminY[i] * (1-Utils.modulate(progress, [0,cellminY[i]], [0,1], true)))
		
				
			
			