
--��ʼ������
local M = {}
M.imagevarobj = require("image.imagevar")
M.imagevarobj.init()
M.imagevar = M.imagevarobj.image
--ͼƬ����
	--M.imagevar����������
	--local_file_cachedir����Ŀ¼
	--local_file_cachepath�����ļ�
	--fun ���ܺ�����
local ImageConfig = {}
local gmagick = require("image.gmagick").new(M.imagevar,img.config.local_file_cachedir,img.config.local_file_cachepath,fun)
gmagick.run()