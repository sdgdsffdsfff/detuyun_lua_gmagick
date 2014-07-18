--�˾�
--�ü�
--����ͼ
--��ת
--IDC����
local M = {}
function M.new(imagevar,local_file_cachedir,local_file_cachepath,fun)
	
	local arg = {}
	arg.local_file_out_folder = local_file_cachedir
	arg.local_file_out_path = local_file_cachepath	
	arg.imagevar = imagevar	
	
	local gm = {}
	gm.arg = {}
	
	gm.run = function ()
		
		
		
		local orginfile = arg.imagevar.var.orginfile
		local abs_file  = arg.local_file_out_path
		
		--����Ŀ¼
		local mkdir_command ="mkdir  -p  "..arg.local_file_out_folder.." >/dev/null 2>&1 "
		os.execute(mkdir_command)
		
		local commandtool = "/usr/local/bin/gm "
		
		
		gm.resize()
		gm.crop()
		gm.border()
		gm.font()
		
		local thumb_convert_command = ""
		--���
		local argcommand = gm.gmextraarg()
		thumb_convert_command = thumb_convert_command .. argcommand

		--����ͼ
		if thumb_convert_command  ~= "" then
			local convertcommandstr = commandtool.." convert +profile '*' -strip  "..thumb_convert_command.." "..orginfile.."  "..abs_file

			os.execute(convertcommandstr)
			
			if fun.file_exists(abs_file) == true then
				orginfile = abs_file  --��Ŀ��ͼ��Ϊ��ǰԭͼ
			end
		end
		
	

	end
	
	
	gm.gmextraarg = function ()
		local convert_command_arg = ""
				
		--�Զ�����  -auto-orient		
		if fun.isemptyorzero(arg.imagevar.img.autoorient) == false  then
			convert_command_arg = convert_command_arg.." -auto-orient "
		end
		
		--����
		if fun.isemptyorzero(arg.imagevar.img.quality) == false and tonumber(arg.imagevar.img.quality) ~= nil then
			convert_command_arg = convert_command_arg.." -quality "..arg.imagevar.img.quality;
		end
		
		-- ˮƽ��תͼ��
		if fun.isemptyorzero(arg.imagevar.img.flop) == false then
			convert_command_arg = convert_command_arg.." -flop "
		end
		
		-- ��ֱ��תͼ��
		if fun.isemptyorzero(arg.imagevar.img.flip) == false then
			convert_command_arg = convert_command_arg.." -flip "
		end
		
		--�ڰ���
		if fun.isemptyorzero(arg.imagevar.img.monochrome) == false then
			convert_command_arg = convert_command_arg.." -monochrome "
		end
		
		--̿��Ч��
		if fun.isemptyorzero(arg.imagevar.img.charcoal) == false then
			convert_command_arg = convert_command_arg.." -charcoal 2"
		end
		
		--ɢ��ë����Ч��
		if fun.isemptyorzero(arg.imagevar.img.spread) == false then
			convert_command_arg = convert_command_arg.." -spread 30 "
		end
		
		--����
		if fun.isemptyorzero(arg.imagevar.img.swirl) == false then
			convert_command_arg = convert_command_arg.." -swirl 67 "
		end
		--����
		if fun.isemptyorzero(arg.imagevar.img.raise) == false then
			convert_command_arg = convert_command_arg.." -raise 5x5 "
		end			
		
		--��ת
		if fun.isemptyorzero(arg.imagevar.img.rotate) == false and tonumber(arg.imagevar.img.rotate) ~= nil  then
			convert_command_arg = convert_command_arg.." -rotate "..arg.imagevar.img.rotate
		end
		--��
		if fun.isemptyorzero(arg.imagevar.img.sharp) == false and arg.imagevar.img.sharp == "on" then
			convert_command_arg = convert_command_arg.." -unsharp 1.5x1.0+0.8+0.03  "
		end
		
			
		if fun.isemptyorzero(gm.arg.background) == false then
			convert_command_arg = convert_command_arg.." -background "..gm.arg.background
		end
		
		if fun.isemptyorzero(gm.arg.resize) == false then
			convert_command_arg = convert_command_arg.." -resize "..gm.arg.resize
		end
		
		if fun.isemptyorzero(gm.arg.gravity) == false then
			convert_command_arg = convert_command_arg.." -gravity "..gm.arg.gravity
		end
		
		if fun.isemptyorzero(gm.arg.crop) == false then
			convert_command_arg = convert_command_arg.." -crop "..gm.arg.crop
		end
		
		if fun.isemptyorzero(gm.arg.extent) == false then
			convert_command_arg = convert_command_arg.." -extent "..gm.arg.extent
		end
		
		
		--Բ��
		if fun.isemptyorzero(arg.imagevar.img.cycle  ) == false and tonumber(arg.imagevar.img.cycle ) ~= nil  then
			convert_command_arg = convert_command_arg.." -cycle   "..arg.imagevar.img.cycle  
		end
		
		--�߿�
		if fun.isemptyorzero(gm.arg.borderwidth) == false then
			convert_command_arg = convert_command_arg.." -border  "..gm.arg.borderwidth.."x"..gm.arg.borderwidth
		end
		if fun.isemptyorzero(gm.arg.bordercolor) == false then
			convert_command_arg = convert_command_arg.." -bordercolor  \""..gm.arg.bordercolor.."\""
		end
		
		--����ˮӡ
		if fun.isemptyorzero(gm.arg.font_obj_str) == false then
			convert_command_arg = convert_command_arg.."  "..gm.arg.font_obj_str
		end
		
		
		return convert_command_arg
	end
	
	
	
	--����
	gm.resize = function ()
		
		local thumbwidth = arg.imagevar.img.thumbwidth
		local thumbheight = arg.imagevar.img.thumbheight
		
		
		--�����߶������ڡ��򷵻�nil
		if  tonumber(thumbheight) == nil  and tonumber(thumbwidth) == nil then
			return nil
		end
		
		--�����߲�Ϊ���֣��� ��������0
		if  thumbheight ~=nil and tonumber(thumbheight) == nil  then
			thumbheight = 0
		end
		if  thumbwidth ~=nil and tonumber(thumbwidth) == nil  then
			thumbwidth = 0
		end
		
		
		
		--���С��1�����ǰٷֱ�
		if fun.isemptyorzero(thumbwidth) == false  and tonumber(thumbwidth) < 1  then
			thumbwidth = thumbwidth * arg.imagevar.var.imagewidth
		end
		if fun.isemptyorzero(thumbheight) == false  and tonumber(thumbheight) < 1  then
			thumbheight = thumbheight * arg.imagevar.var.imageheight
		end
		
		--������
		if arg.imagevar.var.imagewidth  and  fun.isemptyorzero(thumbwidth) == false and tonumber(arg.imagevar.var.imagewidth) < tonumber(thumbwidth) then
			thumbwidth= tonumber(arg.imagevar.var.imagewidth)
		end
		if arg.imagevar.var.imageheight and fun.isemptyorzero(thumbheight) == false and tonumber(arg.imagevar.var.imageheight) < tonumber(thumbheight) then
			thumbheight = tonumber(arg.imagevar.var.imageheight)
		end
		
		
		--����ģʽ
		local imageviewmodel  = arg.imagevar.img.thumbimageviewmodel
		if fun.isemptyorzero(imageviewmodel) == true then
			imageviewmodel = "4"
		end
		
		--��� thumbwidth == nil .���޶���
		if  fun.isemptyorzero(thumbwidth) == true and fun.isemptyorzero(thumbheight) == false  then
			gm.arg.resize = "x"..thumbheight.."^"
			--��� thumbheight == nil .���޶���
		elseif  fun.isemptyorzero(thumbheight) == true and fun.isemptyorzero(thumbwidth) == false then
			gm.arg.resize = thumbwidth.."x"
			--���thumbwidth��thumbheightͬʱ����
		elseif fun.isemptyorzero(thumbwidth) == false and  fun.isemptyorzero(thumbheight) == false  then			
			gm.arg.resize = thumbwidth.."x"..thumbheight
		end
		
		
		--���Դ���
		if tostring(imageviewmodel) == "1" and fun.isemptyorzero(thumbwidth) == false  then
			gm.arg.resize = thumbwidth.."x"
		elseif tostring(imageviewmodel) == "2"   and fun.isemptyorzero(thumbheight) == false then
			gm.arg.resize = "x"..thumbheight.."^"
		elseif tostring(imageviewmodel) == "3"  and fun.isemptyorzero(thumbwidth) == false  and fun.isemptyorzero(thumbheight) == false then
			gm.arg.resize = thumbwidth.."x"..thumbheight.."^"
			gm.arg.gravity = "Center"
			gm.arg.crop = thumbwidth.."x"..thumbheight.."+0+0"
		elseif tostring(imageviewmodel) == "4"  and fun.isemptyorzero(thumbwidth) == false  and fun.isemptyorzero(thumbheight) == false then
			gm.arg.resize = thumbwidth.."x"..thumbheight
		end
		
	end
	
	
	
	--�ü�
	gm.crop = function ()
		
		if fun.isemptyorzero(arg.imagevar.img.crop) == true then
			return nil
		end
		
		
		local crop_obj = {}
		local key_name_arr = fun.split(arg.imagevar.img.crop,",")
		for index,value in pairs(key_name_arr) do
			if value ~= "" then
				local pair_name_arr = fun.split(value,"_")
				for pairindex,pairvalue in pairs(pair_name_arr) do
					if pairvalue == "w" then
						crop_obj.width    = pair_name_arr[pairindex + 1]  or ""
					elseif pairvalue == "h" then
						crop_obj.height   = pair_name_arr[pairindex + 1]  or ""
					elseif pairvalue == "c" then
						crop_obj.crop     = pair_name_arr[pairindex + 1]  or ""
					elseif pairvalue == "g" then --face faces
						crop_obj.gravity  = pair_name_arr[pairindex + 1]  or ""
					elseif pairvalue == "x" then
						crop_obj.x  = pair_name_arr[pairindex + 1]  or ""
					elseif pairvalue == "y" then
						crop_obj.y  = pair_name_arr[pairindex + 1]  or ""
					end
				end
			end
		end
		
		
		--�ü�ģʽ
		if fun.isemptyorzero(crop_obj.crop) == true then
			crop_obj.crop = "crop"
		end
		
		local thumbwidth = crop_obj.width
		local thumbheight = crop_obj.height
		
		--�����߶������ڡ��򷵻�nil
		if  tonumber(thumbheight) == nil  and tonumber(thumbwidth) == nil then
			return nil
		end
		
		--���С��1�����ǰٷֱ�
		if fun.isemptyorzero(thumbwidth) == false and tonumber(thumbwidth) < 1  then
			thumbwidth = thumbwidth * arg.imagevar.var.imagewidth
		end
		if fun.isemptyorzero(thumbheight) == false and tonumber(thumbheight) < 1  then
			thumbheight = thumbheight * arg.imagevar.var.imageheight
		end
		
		
		
		--crop��X��Yλ��
		if crop_obj.x == nil or tonumber(crop_obj.x) == nil then
			crop_obj.x =  0
		end
		if crop_obj.y == nil or tonumber(crop_obj.y) == nil then
			crop_obj.y =  0
		end
		if tonumber(crop_obj.x) >= 0 then
			crop_obj.x = "+"..crop_obj.x			
		end
		if tonumber(crop_obj.y) >= 0 then
			crop_obj.y = "+"..crop_obj.y			
		end
		
		--λ��
		gm.arg.gravity = crop_obj.gravity
		if gm.arg.gravity == nil then
			gm.arg.gravity =  "center"
		end
		
		--��ȶ����ڵ����
		if  tonumber(thumbheight) ~= nil  and tonumber(thumbwidth) ~= nil then
			
			-- scale ���̶��� fill lfill fit limit pad lpad crop thumb
			if crop_obj.crop == "scale" then  -- �̶���С
				gm.arg.resize = thumbwidth.."x"..thumbheight.."!"
			elseif  crop_obj.crop == "fit" then
				gm.arg.resize = thumbwidth.."x"..thumbheight..""
			elseif  crop_obj.crop == "fill" then
				gm.arg.resize = thumbwidth.."x"..thumbheight.."^"
			elseif  crop_obj.crop == "limit" then
				gm.arg.resize = thumbwidth.."x"..thumbheight.."^"
			elseif  crop_obj.crop == "pad" then
				gm.arg.resize = thumbwidth.."x"..thumbheight..""
				gm.arg.background = "white"
				gm.arg.extent =  thumbwidth.."x"..thumbheight..""
				gm.arg.gravity = "center"
			elseif  crop_obj.crop == "crop" then				
				gm.arg.crop = thumbwidth.."x"..thumbheight..crop_obj.x..crop_obj.y				
			end
		end
		
	end
	
	
	
	--�߿�
	gm.border = function ()
		if fun.isemptyorzero(arg.imagevar.img.border) == true then
			return nil
		end
		
		
		local border_obj = {}
		local key_name_arr = fun.split(arg.imagevar.img.border,",")
		for index,value in pairs(key_name_arr) do
			if value ~= "" then
				local pair_name_arr = fun.split(value,"_")
				for pairindex,pairvalue in pairs(pair_name_arr) do
					if pairvalue == "w" then
						border_obj.width    = pair_name_arr[pairindex + 1]  or ""
					elseif pairvalue == "c" then
						border_obj.color   = pair_name_arr[pairindex + 1]  or ""					
					end
				end
			end
		end
		
		if border_obj.width ~= nil and tonumber(border_obj.width) ~= nil and border_obj.color  ~= nil then
			gm.arg.borderwidth = border_obj.width 
			gm.arg.bordercolor = border_obj.color
		end
		
	end
	
	--����
	gm.font = function ()
		if fun.isemptyorzero(arg.imagevar.img.font) == true then
			return nil
		end
		
		
		-- c_green,f_����,t_����,x_10,y_20
		local font_obj = {}
		local key_name_arr = fun.split(arg.imagevar.img.font,",")
		for index,value in pairs(key_name_arr) do
			if value ~= "" then
				local pair_name_arr = fun.split(value,"_")
				for pairindex,pairvalue in pairs(pair_name_arr) do
					if pairvalue == "c" then
						font_obj.fill    = pair_name_arr[pairindex + 1]  or ""
					elseif pairvalue == "s" then
						font_obj.size    = pair_name_arr[pairindex + 1]  or ""
					elseif pairvalue == "f" then
						font_obj.font   = pair_name_arr[pairindex + 1]  or ""
						font_obj.font = fun.urldecode(font_obj.font)		
					elseif pairvalue == "t" then						
						font_obj.text   = pair_name_arr[pairindex + 1]  or ""	
						font_obj.text = fun.urldecode(font_obj.text)	
					elseif pairvalue == "x" then
						font_obj.x   = pair_name_arr[pairindex + 1]  or ""		
					elseif pairvalue == "y" then
						font_obj.y   = pair_name_arr[pairindex + 1]  or ""	
					elseif pairvalue == "g" then
						font_obj.gravity   = pair_name_arr[pairindex + 1]  or ""					
					end
				end
			end
		end

		--����ļ�������
		if font_obj.text == nil then
			return nil
		end
		
		
		--gm convert -size 320x200 xc:white -font Arial -fill blue -encoding	Unicode -draw "text 100,100 ' \321\202\320\265\321\201\321\202'"		foo.png
		
		local font_obj_str = " "
		
		if font_obj.font ~= nil then
			font_obj_str = font_obj_str.." -font "..font_obj.font
		else
			font_obj_str = font_obj_str.." -font  Arial"
		end			
		if font_obj.fill ~= nil then
			font_obj.fill = string.gsub(font_obj.fill,"0x","#")
			font_obj_str = font_obj_str.." -fill '"..font_obj.fill.."'"
		else
			font_obj_str = font_obj_str.." -fill red"
		end
		
		if font_obj.size ~= nil then
			font_obj_str = font_obj_str.." -pointsize "..font_obj.size
		else
			font_obj_str = font_obj_str.." -pointsize 18"
		end
		
		font_obj_str = font_obj_str.." -encoding Unicode "
		
		if font_obj.gravity ~= nil then
			font_obj_str = font_obj_str.." -gravity "..font_obj.gravity
		end						
		if font_obj.text ~= nil and font_obj.x ~= nil and font_obj.y ~= nil  then		
			font_obj_str = font_obj_str.." -draw 'text "..font_obj.x..","..font_obj.y.." \""..font_obj.text.."\"'"
		end			

		gm.arg.font_obj_str = font_obj_str		
	end
	
	
	
	
	return gm
	
end
return M
