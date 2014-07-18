local M = {}

M.image = {}
M.image.var = {}
M.image.img = {}

function M.init()
		
	--ͼƬԪ����
	M.image.var.orginfile  = "" --ԭͼ��ַ
	M.image.var.isrefresh  = "" -- �Ƿ�ǿ��ˢ��
	M.image.var.filecdate  = "" -- ͼƬ����ʱ��
	M.image.var.imagewidth = 0  -- ͼƬԭ��
	M.image.var.imageheight = 0 -- ͼƬԭ��

	----------------------------   ͼ����������� ----------------------
	--����ͼ����
	-- ?imageView/ģʽ(1,2,3,4)/w/��/h/��/q/����/sharp/��
	--<mode>=1	ͬʱָ����Ⱥ͸߶ȣ��ȱȲü�ԭͼ���в��ֲ�����Ϊx��С����ͼƬ
	--<mode>=2	ͬʱָ����Ⱥ͸߶ȣ�ԭͼ��СΪ������x��С������ͼ������ü�����
	--<mode>=2	��ָ����ȣ��߶ȵȱ���С
	--<mode>=2	��ָ���߶ȣ���ȵȱ���С
	M.image.img.thumbimageviewmodel = ""
	M.image.img.thumbwidth = ""
	M.image.img.thumbheight = ""


	----------------------------  ˮӡ���ô���������� ----------------------
	-- ?imageView/image/��ַ/dissolve//dx//dy//gravity//gravity
	--//dissolve/50/gravity/SouthEast/dx/20/dy/20
	--ˮӡ����
	M.image.img.waterimage =""
	M.image.img.watergravity = ""
	M.image.img.waterdissolve = ""
	M.image.img.waterdistancex = ""
	M.image.img.waterdistancey = ""
	

	-------------------------------�߼�ͼ������� ----------------------------------

	--����ԭͼEXIF��Ϣ�Զ����������ں����������������λ
	M.image.img.autoorient = ""

	--?imageView/crop �ü�
	-- w_100,h_150,c_scale �̶����
	-- w_100,h_150,c_fit ��ԭͼ�ı�����߽��вü�
	-- w_100,h_150,c_fillg_NorthWest	
	-- 	NorthWest    |     North      |     NorthEast	
	-- --------------+----------------+--------------	
	-- West          |     Center     |          East 			
	-- --------------+----------------+--------------			
	-- SouthWest     |     South      |     SouthEast
	
	-- w_100,h_150,c_limit
	-- w_100,h_150,c_pad,g_south_east
	-- w_100,h_150,c_crop,g_north_west | w_0.4
	-- x_355,y_410,w_300,h_200,c_crop
	-- w_90,h_90,c_thumb,g_face
	M.image.img.crop = ""

	--ͼƬ����
	M.image.img.quality = ""

	--��ת�Ƕ�
	M.image.img.rotate = ""

	--��
	M.image.img.sharp = ""

	--ͼƬ��ʽ��֧��web|jpg|png|gif
	M.image.img.type  = ""

	---�߿� w_4px,color_00390b
	M.image.img.border = ""
	
	--Բ�� �뾶
	M.image.img.cycle  = ""

	--�ڰ���
	M.image.img.monochrome = ""

	--��ֱ��תͼ��
	M.image.img.flip = ""

	--ˮƽ��תͼ��
	M.image.img.flop = ""
	
	--̿��Ч�� �γ�̿�ʻ���˵��Ǧ�ʻ���Ч���� -charcoal 2 
	M.image.img.charcoal = ""
	
	--ɢ��ë����Ч��  -spread 30
	M.image.img.spread = ""
	
	--������ͼƬ��������Ϊ���գ���ͼƬŤת���γ����е�Ч���� -swirl 67
	M.image.img.swirl = ""

	---͹��Ч���� raise 5x5����Ƭ�����ܻ�һ��5x5�ıߣ������Ҫһ������ȥ�ıߣ���-raise��Ϊ+raise�Ϳ����ˡ���ʵ͹�ߺͰ��߿��������𲢲��Ǻܴ�
	M.image.img.raise = ""
	
	--������ c_green,f_����,text_����,x_10,y_20
	-- convert -fill green -pointsize 40 -font ���� -draw 'text 10,50 "charry.org"' foo.png bar.png
	M.image.img.font = ""
	
	
	--�߼��˾�
	--gotham lomo vignette
	M.image.img.filter = ""	
	

end

function M.tostring()
	return M.serialize(M.image)
end

function M.serialize(obj)
	local lua = "img"
	for k, v in pairs(obj.img) do
		if v ~= "" then
			lua = lua .. "[" .. k .. "]=" .. v .. ","
		end
	end
	lua = lua .. "var"
	for k, v in pairs(obj.var) do
		if v ~= "" then
			lua = lua .. "[" .. k .. "]=" .. v .. ","
		end
	end
	return lua
	
end

return M
