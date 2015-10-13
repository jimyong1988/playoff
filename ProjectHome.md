根据传入的球队和比赛比分，自动显示淘汰赛对阵，目前只能自动适应正好2的n次方个球队的情况，有特殊需要的可以自行研究代码。

开发环境：Adobe Flash Builder 4

开发语言：ActionScript 3.0

# 内部用到的URL和默认设置为： #

球队页面url： "/qiudui/teams?id=";

比赛页面url： "/match?id=";

# 设置方法为（可以只设置其中任意多个）： #

直接把参数加在flash的尾部，如:playoff.swf?teamurl=球队页面url&matchdataurl=比赛页面url

# 数据格式说明： #

通过flash的flashVars参数来传递数据到flash：

teams:球队列表，根据球队数目生成比赛对阵，格式为"队名,id:队名,id:..."

matches:比赛列表，排列顺序为第一轮从左到右，从上到下，然后第二轮，直到决赛、第三名赛，格式为"id,比分1,比分2:id,比分1,比分2:..."

nofinal:是否隐藏决赛和第三名赛，true为隐藏

nolink:是否不可点击打开球队和比赛的链接，true为不可打开

matchurl:打开比赛的链接前缀

自动按照所给值显示

例：


&lt;object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000 "   codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/   swflash.cab#version=10,0,0,0" width="550" height="300" id="playoff" align="center"&gt;




&lt;param name="allowScriptAccess" value="sameDomain" /&gt;




&lt;param name="movie" value="/images/flash/playoff.swf" /&gt;




&lt;param name="quality" value="high" /&gt;




&lt;param name="bgcolor" value="#ffffff" /&gt;




&lt;param name="flashVars" value="teams=白金台会所康友足球队,1285:劲浪体育,1022:元老汇,257:福彩中心,1:大象,299:,272:盛世英煌,533:长安民生物流,66:觅图设计,241:新势力,1120:奔四,58:A30,305:杰林电子,84:亚华世家,564:威王洁具,1187:JM,274&matches=2350,3,8:2351,3,1:2352,4,3:2353,0,1:2354,4,1:2355,7,5:2356,3,4:2357,1,2:2358,1,5:2359,1,2:2360,0,3:2361,2,1:2364,3,1:2363,0,3:2362,1,2:2365,3,0&nofinal=true&nolink=false" /&gt;




&lt;embed src="/images/flash/playoff.swf" quality="high" bgcolor="#ffffff"     flashVars="teams=白金台会所康友足球队,1285:劲浪体育,1022:元老汇,257:福彩中心,1:大象,299:,272:盛世英煌,533:长安民生物流,66:觅图设计,241:新势力,1120:奔四,58:A30,305:杰林电子,84:亚华世家,564:威王洁具,1187:JM,274&matches=2350,3,8:2351,3,1:2352,4,3:2353,0,1:2354,4,1:2355,7,5:2356,3,4:2357,1,2:2358,1,5:2359,1,2:2360,0,3:2361,2,1:2364,3,1:2363,0,3:2362,1,2:2365,3,0&nofinal=true&nolink=false"width="550" height="300" name="mymovie" align="center" allowScriptAccess="sameDomain"  type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /&gt;




&lt;/object&gt;

