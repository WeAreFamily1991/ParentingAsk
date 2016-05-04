/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "ConvertToCommonEmoticonsHelper.h"
#import "Emoji.h"

static NSString * kStr_01 =@"/::~"  ;
static NSString * kStr_02 =@"/::$"  ;
static NSString * kStr_03 =@"/::X"  ;
static NSString * kStr_04 =@"/::'(" ;
static NSString * kStr_05 =@"/::O"  ;
static NSString * kStr_06 =@"/:--b" ;
static NSString * kStr_07 =@"/::T";
static NSString * kStr_08 =@"/:,@-D";
static NSString * kStr_09 =@"/::g";
static NSString * kStr_10 =@"/:|-)";
static NSString * kStr_11 =@"/::!";
static NSString * kStr_12 =@"/::,@";
static NSString * kStr_13 =@"/:,@f";
static NSString * kStr_14 =@"/::-S";
static NSString * kStr_15 =@"/:?";
static NSString * kStr_16 =@"/:,@x";
static NSString * kStr_17 =@"/:,@@";
static NSString * kStr_18 =@"/::8";
static NSString * kStr_19 =@"/:,@!";
static NSString * kStr_20 =@"/:xx";
static NSString * kStr_21 =@"/:bye";
static NSString * kStr_22 =@"/:wipe";
static NSString * kStr_23 =@"/:dig";
static NSString * kStr_24 =@"/:&-(";
static NSString * kStr_25 =@"/:<@";
static NSString * kStr_26 =@"/:@>";
static NSString * kStr_27 =@"/::-O";
static NSString * kStr_28 =@"/:>-|";
static NSString * kStr_29 =@"/:P-(";
static NSString * kStr_30 =@"/::'|";
static NSString * kStr_31 =@"/:@x";
static NSString * kStr_32 =@"/:8*";
static NSString * kStr_33 =@"/:pd";
static NSString * kStr_34 =@"/:<W>";
static NSString * kStr_35 =@"/:beer";
static NSString * kStr_36 =@"/:basketb";
static NSString * kStr_37 =@"/:oo";
static NSString * kStr_38 =@"/:coffee";
static NSString * kStr_39 =@"/:eat";
static NSString * kStr_40 =@"/:pig";
static NSString * kStr_41 =@"/:fade";
static NSString * kStr_42 =@"/:cake";
static NSString * kStr_43 =@"/:li";
static NSString * kStr_44 =@"/:bome";
static NSString * kStr_45 =@"/:kn";
static NSString * kStr_46 =@"/:footb";
static NSString * kStr_47 =@"/:ladybug";
static NSString * kStr_48 =@"/:shit";
static NSString * kStr_49 =@"/:gift";
static NSString * kStr_50 =@"/:hug";
static NSString * kStr_51 =@"/:share";
static NSString * kStr_52 =@"/:cake";
static NSString * kStr_53 =@"/:v";
static NSString * kStr_54 =@"/:@)";
static NSString * kStr_55 =@"/:jj";
static NSString * kStr_56 =@"/:@@";
static NSString * kStr_57 =@"/:bad";
static NSString * kStr_58 =@"/:lvu";
static NSString * kStr_59 =@"/:no";
static NSString * kStr_60 =@"/:ok";
static NSString * kStr_61 =@"/:love";
static NSString * kStr_62 =@"/:<L>";
static NSString * kStr_63 =@"/:jump";
static NSString * kStr_64 =@"/:shake";
static NSString * kStr_65 =@"/:<O>";
static NSString * kStr_66 =@"/:circle";
static NSString * kStr_67 =@"/:kotow";
static NSString * kStr_68 =@"/:turn";
static NSString * kStr_69 =@"/:skip";
static NSString * kStr_70 =@"/:oY";

static NSString * kStr_71 =@"";
static NSString * kStr_72 =@"";
static NSString * kStr_73 =@"";
static NSString * kStr_74 =@"";
static NSString * kStr_75 =@"";
static NSString * kStr_76 =@"";
static NSString * kStr_77 =@"";
static NSString * kStr_78 =@"";
static NSString * kStr_79 =@"";
static NSString * kStr_80 =@"";
static NSString * kStr_81 =@"";
static NSString * kStr_82 =@"";
static NSString * kStr_83 =@"";
static NSString * kStr_84 =@"";
static NSString * kStr_85 =@"";
static NSString * kStr_86 =@"";
static NSString * kStr_87 =@"";
static NSString * kStr_88 =@"";
static NSString * kStr_89 =@"";
static NSString * kStr_90 =@"";
static NSString * kStr_91 =@"";
static NSString * kStr_92 =@"";
static NSString * kStr_93 =@"";
static NSString * kStr_94 =@"";
static NSString * kStr_95 =@"";
static NSString * kStr_96 =@"";
static NSString * kStr_97 =@"";
static NSString * kStr_98 =@"";
static NSString * kStr_99 =@"";
static NSString * kStr_100 =@"";
static NSString * kStr_101 =@"";
static NSString * kStr_102 =@"";
static NSString * kStr_103 =@"";
static NSString * kStr_104 =@"";
static NSString * kStr_105 =@"";
static NSString * kStr_106 =@"";
static NSString * kStr_107 =@"";
static NSString * kStr_108 =@"";
static NSString * kStr_109 =@"";
static NSString * kStr_110 =@"";


static NSString * kStr_111 =@"";
static NSString * kStr_112 =@"";
static NSString * kStr_113 =@"";
static NSString * kStr_114 =@"";
static NSString * kStr_115 =@"";
static NSString * kStr_116 =@"";
static NSString * kStr_117 =@"";
static NSString * kStr_118 =@"";
static NSString * kStr_119 =@"";
static NSString * kStr_120 =@"";

static NSString * kStr_121 =@"";
static NSString * kStr_122 =@"";
static NSString * kStr_123 =@"";
static NSString * kStr_124 =@"";
static NSString * kStr_125 =@"";
static NSString * kStr_126 =@"";
static NSString * kStr_127 =@"";
static NSString * kStr_128 =@"";
static NSString * kStr_129 =@"";
static NSString * kStr_130 =@"";


static NSString * kStr_131 =@"";
static NSString * kStr_132 =@"";
static NSString * kStr_133 =@"";
static NSString * kStr_134 =@"";
static NSString * kStr_135 =@"";
static NSString * kStr_136 =@"";
static NSString * kStr_137 =@"";
static NSString * kStr_138 =@"";
static NSString * kStr_139 =@"";
static NSString * kStr_140 =@"";

static NSString * kStr_141 =@"";
static NSString * kStr_142 =@"";
static NSString * kStr_143 =@"";
static NSString * kStr_144 =@"";
static NSString * kStr_145 =@"";
static NSString * kStr_146 =@"";
static NSString * kStr_147 =@"";
static NSString * kStr_148 =@"";
static NSString * kStr_149 =@"";
static NSString * kStr_150 =@"";


static NSString * kStr_151 =@"";
static NSString * kStr_152 =@"";
static NSString * kStr_153 =@"";
static NSString * kStr_154 =@"";
static NSString * kStr_155 =@"";
static NSString * kStr_156 =@"";
static NSString * kStr_157 =@"";
static NSString * kStr_158 =@"";
static NSString * kStr_159 =@"";
static NSString * kStr_160 =@"";

static NSString * kStr_161 =@"";
static NSString * kStr_162 =@"";
static NSString * kStr_163 =@"";
static NSString * kStr_164 =@"";
static NSString * kStr_165 =@"";
static NSString * kStr_166 =@"";
static NSString * kStr_167 =@"";
static NSString * kStr_168 =@"";
static NSString * kStr_169 =@"";
static NSString * kStr_170 =@"";


static NSString * kStr_171 =@"";
static NSString * kStr_172 =@"";
static NSString * kStr_173 =@"";
static NSString * kStr_174 =@"";
static NSString * kStr_175 =@"";
static NSString * kStr_176 =@"";
static NSString * kStr_177 =@"";
static NSString * kStr_178 =@"";
static NSString * kStr_179 =@"";
static NSString * kStr_180 =@"";

static NSString * kStr_181 =@"";
static NSString * kStr_182 =@"";
static NSString * kStr_183 =@"";
static NSString * kStr_184 =@"";
static NSString * kStr_185 =@"";
static NSString * kStr_186 =@"";
static NSString * kStr_187 =@"";
static NSString * kStr_188 =@"";
static NSString * kStr_189 =@"";
static NSString * kStr_190 =@"";


static NSString * kStr_191 =@"";
static NSString * kStr_192 =@"";
static NSString * kStr_193 =@"";
static NSString * kStr_194 =@"";
static NSString * kStr_195 =@"";
static NSString * kStr_196 =@"";
static NSString * kStr_197 =@"";
static NSString * kStr_198 =@"";
static NSString * kStr_199 =@"";
static NSString * kStr_200 =@"";

static NSString * kStr_201 =@"";
static NSString * kStr_202 =@"";
static NSString * kStr_203 =@"";
static NSString * kStr_204 =@"";
static NSString * kStr_205 =@"";
static NSString * kStr_206 =@"";
static NSString * kStr_207 =@"";
static NSString * kStr_208 =@"";
static NSString * kStr_209 =@"";
static NSString * kStr_210 =@"";


static NSString * kStr_211 =@"";
static NSString * kStr_212 =@"";
static NSString * kStr_213 =@"";
static NSString * kStr_214 =@"";
static NSString * kStr_215 =@"";
static NSString * kStr_216 =@"";
static NSString * kStr_217 =@"";
static NSString * kStr_218 =@"";
static NSString * kStr_219 =@"";
static NSString * kStr_220 =@"";

static NSString * kStr_221 =@"";
static NSString * kStr_222 =@"";
static NSString * kStr_223 =@"";
static NSString * kStr_224 =@"";
static NSString * kStr_225 =@"";
static NSString * kStr_226 =@"";
static NSString * kStr_227 =@"";
static NSString * kStr_228 =@"";
static NSString * kStr_229 =@"";
static NSString * kStr_230 =@"";


static NSString * kStr_231 =@"";
static NSString * kStr_232 =@"";
static NSString * kStr_233 =@"";
static NSString * kStr_234 =@"";
static NSString * kStr_235 =@"";
static NSString * kStr_236 =@"";
static NSString * kStr_237 =@"";
static NSString * kStr_238 =@"";
static NSString * kStr_239 =@"";
static NSString * kStr_240 =@"";

static NSString * kStr_241 =@"";
static NSString * kStr_242 =@"";
static NSString * kStr_243 =@"";
static NSString * kStr_244 =@"";
static NSString * kStr_245 =@"";
static NSString * kStr_246 =@"";
static NSString * kStr_247 =@"";
static NSString * kStr_248 =@"";
static NSString * kStr_249 =@"";
static NSString * kStr_250 =@"";

static NSString * kStr_251 =@"";
static NSString * kStr_252 =@"";
static NSString * kStr_253 =@"";
static NSString * kStr_254 =@"";
static NSString * kStr_255 =@"";
static NSString * kStr_256 =@"";
static NSString * kStr_257 =@"";
static NSString * kStr_258 =@"";
static NSString * kStr_259 =@"";
static NSString * kStr_260 =@"";

static NSString * kStr_261 =@"";
static NSString * kStr_262 =@"";
static NSString * kStr_263 =@"";
static NSString * kStr_264 =@"";
static NSString * kStr_265 =@"";
static NSString * kStr_266 =@"";
static NSString * kStr_267 =@"";
static NSString * kStr_268 =@"";
static NSString * kStr_269 =@"";
static NSString * kStr_270 =@"";


static NSString * kStr_271 =@"";
static NSString * kStr_272 =@"";
static NSString * kStr_273 =@"";
static NSString * kStr_274 =@"";
static NSString * kStr_275 =@"";
static NSString * kStr_276 =@"";
static NSString * kStr_277 =@"";
static NSString * kStr_278 =@"";
static NSString * kStr_279 =@"";
static NSString * kStr_280 =@"";

static NSString * kStr_281 =@"";
static NSString * kStr_282 =@"";
static NSString * kStr_283 =@"";
static NSString * kStr_284 =@"";
static NSString * kStr_285 =@"";
static NSString * kStr_286 =@"";
static NSString * kStr_287 =@"";
static NSString * kStr_288 =@"";
static NSString * kStr_289 =@"";
static NSString * kStr_290 =@"";


static NSString * kStr_291 =@"";
static NSString * kStr_292 =@"";
static NSString * kStr_293 =@"";
static NSString * kStr_294 =@"";
static NSString * kStr_295 =@"";
static NSString * kStr_296 =@"";
static NSString * kStr_297 =@"";
static NSString * kStr_298 =@"";
static NSString * kStr_299 =@"";
static NSString * kStr_300 =@"";

static NSString * kCHN_01 =@"[/撇嘴]"  ;
static NSString * kCHN_02 =@"[/害羞]"  ;
static NSString * kCHN_03 =@"[/闭嘴]"  ;
static NSString * kCHN_04 =@"[/大哭]" ;
static NSString * kCHN_05 =@"[/惊讶]"  ;
static NSString * kCHN_06 =@"[/冷汗]" ;
static NSString * kCHN_07 =@"[/吐]";
static NSString * kCHN_08 =@"[/愉快]";
static NSString * kCHN_09 =@"[/饥饿]";
static NSString * kCHN_10 =@"[/困]";
static NSString * kCHN_11 =@"[/惊恐]";
static NSString * kCHN_12 =@"[/悠闲]";
static NSString * kCHN_13 =@"[/奋斗]";
static NSString * kCHN_14 =@"[/咒骂]";
static NSString * kCHN_15 =@"[/疑问]";
static NSString * kCHN_16 =@"[/嘘]";
static NSString * kCHN_17 =@"[/晕]";
static NSString * kCHN_18 =@"[/疯了]";
static NSString * kCHN_19 =@"[/衰]";
static NSString * kCHN_20 =@"[/敲打]";
static NSString * kCHN_21 =@"[/再见]";
static NSString * kCHN_22 =@"[/擦汗]";
static NSString * kCHN_23 =@"[/抠鼻]";
static NSString * kCHN_24 =@"[/糗大了]";
static NSString * kCHN_25 =@"[/左哼哼]";
static NSString * kCHN_26 =@"[/右哼哼]";
static NSString * kCHN_27 =@"[/哈欠]";
static NSString * kCHN_28 =@"[/鄙视]";
static NSString * kCHN_29 =@"[/委屈]";
static NSString * kCHN_30 =@"[/快哭了]";
static NSString * kCHN_31 =@"[/吓坏了]";
static NSString * kCHN_32 =@"[/可怜]";
static NSString * kCHN_33 =@"[/菜刀]";
static NSString * kCHN_34 =@"[/西瓜]";
static NSString * kCHN_35 =@"[/啤酒]";
static NSString * kCHN_36 =@"[/篮球]";
static NSString * kCHN_37 =@"[/乒乓]";
static NSString * kCHN_38 =@"[/咖啡]";
static NSString * kCHN_39 =@"[/饭]";
static NSString * kCHN_40 =@"[/猪头]";
static NSString * kCHN_41 =@"[/凋谢]";
static NSString * kCHN_42 =@"[/蛋糕]";
static NSString * kCHN_43 =@"[/闪电]";
static NSString * kCHN_44 =@"[/炸弹]";
static NSString * kCHN_45 =@"[/刀]";
static NSString * kCHN_46 =@"[/足球]";
static NSString * kCHN_47 =@"[/瓢虫]";
static NSString * kCHN_48 =@"[/便便]";
static NSString * kCHN_49 =@"[/礼物]";
static NSString * kCHN_50 =@"[/拥抱]";
static NSString * kCHN_51 =@"[/握手]";
static NSString * kCHN_52 =@"[/蛋糕]";
static NSString * kCHN_53 =@"[/胜利]";
static NSString * kCHN_54 =@"[/抱拳]";
static NSString * kCHN_55 =@"[/勾引]";
static NSString * kCHN_56 =@"[/拳头]";
static NSString * kCHN_57 =@"[/差劲]";
static NSString * kCHN_58 =@"[/爱你]";
static NSString * kCHN_59 =@"[/NO]";
static NSString * kCHN_60 =@"[/OK]";
static NSString * kCHN_61 =@"[/爱情]";
static NSString * kCHN_62 =@"[/飞吻]";
static NSString * kCHN_63 =@"[/跳跳]";
static NSString * kCHN_64 =@"[/发抖]";
static NSString * kCHN_65 =@"[/怄火]";
static NSString * kCHN_66 =@"[/转圈]";
static NSString * kCHN_67 =@"[/磕头]";
static NSString * kCHN_68 =@"[/回头]";
static NSString * kCHN_69 =@"[/跳绳]";
static NSString * kCHN_70 =@"[/投降]";

static NSString * kCHN_71 =@"😊";
static NSString * kCHN_72 =@"😍";
static NSString * kCHN_73 =@"😘";
static NSString * kCHN_74 =@"😳";
static NSString * kCHN_75 =@"😡";
static NSString * kCHN_76 =@"😓";
static NSString * kCHN_77 =@"😲";
static NSString * kCHN_78 =@"😭";
static NSString * kCHN_79 =@"😁";
static NSString * kCHN_80 =@"😱";
static NSString * kCHN_81 =@"😖";
static NSString * kCHN_82 =@"😉";
static NSString * kCHN_83 =@"😏";
static NSString * kCHN_84 =@"😜";
static NSString * kCHN_85 =@"😰";
static NSString * kCHN_86 =@"😢";
static NSString * kCHN_87 =@"😚";
static NSString * kCHN_88 =@"😄";
static NSString * kCHN_89 =@"😪";
static NSString * kCHN_90 =@"😫";
static NSString * kCHN_91 =@"😔";
static NSString * kCHN_92 =@"😠";
static NSString * kCHN_93 =@"😌";
static NSString * kCHN_94 =@"😝";
static NSString * kCHN_95 =@"😂";
static NSString * kCHN_96 =@"😥";
static NSString * kCHN_97 =@"😃";
static NSString * kCHN_98 =@"😨";
static NSString * kCHN_99 =@"😒";
static NSString * kCHN_100 =@"😷";
static NSString * kCHN_101 =@"😞";
static NSString * kCHN_102 =@"👿";
static NSString * kCHN_103 =@"👽";
static NSString * kCHN_104 =@"👀";
static NSString * kCHN_105 =@"👃🏼";
static NSString * kCHN_106 =@"👄";
static NSString * kCHN_107 =@"👂🏼";
static NSString * kCHN_108 =@"❤️";
static NSString * kCHN_109 =@"💔";
static NSString * kCHN_110 =@"💘";

static NSString * kCHN_111 =@"💗";
static NSString * kCHN_112 =@"💜";
static NSString * kCHN_113 =@"💛";
static NSString * kCHN_114 =@"💚";
static NSString * kCHN_115 =@"💙";
static NSString * kCHN_116 =@"💩";
static NSString * kCHN_117 =@"👍🏼";
static NSString * kCHN_118 =@"👎🏼";
static NSString * kCHN_119 =@"👊🏼";
static NSString * kCHN_120 =@"✌🏼";

static NSString * kCHN_121 =@"👌🏼";
static NSString * kCHN_122 =@"💪🏼";
static NSString * kCHN_123 =@"👆🏼";
static NSString * kCHN_124 =@"👇🏼";
static NSString * kCHN_125 =@"👈🏼";
static NSString * kCHN_126 =@"👉🏼";
static NSString * kCHN_127 =@"✊🏼";
static NSString * kCHN_128 =@"👐🏼";
static NSString * kCHN_129 =@"🙏🏼";
static NSString * kCHN_130 =@"🙌🏼";


static NSString * kCHN_131 =@"👏🏼";
static NSString * kCHN_132 =@"👧🏼";
static NSString * kCHN_133 =@"👦🏼";
static NSString * kCHN_134 =@"👩🏼";
static NSString * kCHN_135 =@"👨🏼";
static NSString * kCHN_136 =@"👶🏼";
static NSString * kCHN_137 =@"👵🏼";
static NSString * kCHN_138 =@"👴🏼";
static NSString * kCHN_139 =@"👳🏼";
static NSString * kCHN_140 =@"👲🏼";

static NSString * kCHN_141 =@"👱🏼";
static NSString * kCHN_142 =@"👸🏼";
static NSString * kCHN_143 =@"👷🏼";
static NSString * kCHN_144 =@"💂🏼";
static NSString * kCHN_145 =@"👮🏼";
static NSString * kCHN_146 =@"🙆🏼";
static NSString * kCHN_147 =@"🙅🏼";
static NSString * kCHN_148 =@"💇🏼";
static NSString * kCHN_149 =@"💆🏼";
static NSString * kCHN_150 =@"💁🏼";


static NSString * kCHN_151 =@"👯";
static NSString * kCHN_152 =@"👫";
static NSString * kCHN_153 =@"🎎";
static NSString * kCHN_154 =@"🚶";
static NSString * kCHN_155 =@"🏃";
static NSString * kCHN_156 =@"💃";
static NSString * kCHN_157 =@"💑";
static NSString * kCHN_158 =@"💏";
static NSString * kCHN_159 =@"👼🏼";
static NSString * kCHN_160 =@"💀";

static NSString * kCHN_161 =@"🐱";
static NSString * kCHN_162 =@"🐶";
static NSString * kCHN_163 =@"🐭";
static NSString * kCHN_164 =@"🐹";
static NSString * kCHN_165 =@"🐰";
static NSString * kCHN_166 =@"🐺";
static NSString * kCHN_167 =@"🐸";
static NSString * kCHN_168 =@"🐯";
static NSString * kCHN_169 =@"🐨";
static NSString * kCHN_170 =@"🐻";


static NSString * kCHN_171 =@"🐷";
static NSString * kCHN_172 =@"🐮";
static NSString * kCHN_173 =@"🐗";
static NSString * kCHN_174 =@"🐵";
static NSString * kCHN_175 =@"🐴";
static NSString * kCHN_176 =@"🐍";
static NSString * kCHN_177 =@"🐦";
static NSString * kCHN_178 =@"🐔";
static NSString * kCHN_179 =@"🐧";
static NSString * kCHN_180 =@"🐛";

static NSString * kCHN_181 =@"🐙";
static NSString * kCHN_182 =@"🐠";
static NSString * kCHN_183 =@"🐳";
static NSString * kCHN_184 =@"🐬";
static NSString * kCHN_185 =@"☀️";
static NSString * kCHN_186 =@"☔️";
static NSString * kCHN_187 =@"🌙";
static NSString * kCHN_188 =@"✨";
static NSString * kCHN_189 =@"⭐️";
static NSString * kCHN_190 =@"⚡️";

static NSString * kCHN_191 =@"☁️";
static NSString * kCHN_192 =@"⛄️";
static NSString * kCHN_193 =@"🌊";
static NSString * kCHN_194 =@"❗️";
static NSString * kCHN_195 =@"❓";
static NSString * kCHN_196 =@"💤";
static NSString * kCHN_197 =@"💦";
static NSString * kCHN_198 =@"🎵";
static NSString * kCHN_199 =@"🔥";
static NSString * kCHN_200 =@"🌹";

static NSString * kCHN_201 =@"🌺";
static NSString * kCHN_202 =@"🌻";
static NSString * kCHN_203 =@"🌷";
static NSString * kCHN_204 =@"🌸";
static NSString * kCHN_205 =@"💐";
static NSString * kCHN_206 =@"🍀";
static NSString * kCHN_207 =@"🌾";
static NSString * kCHN_208 =@"🍃";
static NSString * kCHN_209 =@"🍂";
static NSString * kCHN_210 =@"🍁";

static NSString * kCHN_211 =@"🌲";
static NSString * kCHN_212 =@"🌴";
static NSString * kCHN_213 =@"🌵";
static NSString * kCHN_214 =@"🎅";
static NSString * kCHN_215 =@"👻";
static NSString * kCHN_216 =@"🎃";
static NSString * kCHN_217 =@"🎄";
static NSString * kCHN_218 =@"🔔";
static NSString * kCHN_219 =@"🎉";
static NSString * kCHN_220 =@"🎈";

static NSString * kCHN_221 =@"💿";
static NSString * kCHN_222 =@"📷";
static NSString * kCHN_223 =@"🎥";
static NSString * kCHN_224 =@"💻";
static NSString * kCHN_225 =@"📺";
static NSString * kCHN_226 =@"🔓";
static NSString * kCHN_227 =@"🔒";
static NSString * kCHN_228 =@"🔑";
static NSString * kCHN_229 =@"💡";
static NSString * kCHN_230 =@"📫";

static NSString * kCHN_231 =@"🛁";
static NSString * kCHN_232 =@"💰";
static NSString * kCHN_233 =@"🔫";
static NSString * kCHN_234 =@"💊";
static NSString * kCHN_235 =@"💣";
static NSString * kCHN_236 =@"⚽️";
static NSString * kCHN_237 =@"🏈";
static NSString * kCHN_238 =@"🏀";
static NSString * kCHN_239 =@"🎾";
static NSString * kCHN_240 =@"🎿";

static NSString * kCHN_241 =@"🏄";
static NSString * kCHN_242 =@"🏊";
static NSString * kCHN_243 =@"🏆";
static NSString * kCHN_244 =@"👾";
static NSString * kCHN_245 =@"🎤";
static NSString * kCHN_246 =@"🎸";
static NSString * kCHN_247 =@"👙";
static NSString * kCHN_248 =@"👑";
static NSString * kCHN_249 =@"🌂";
static NSString * kCHN_250 =@"👜";


static NSString * kCHN_251 =@"💄";
static NSString * kCHN_252 =@"💅🏼";
static NSString * kCHN_253 =@"💍";
static NSString * kCHN_254 =@"🎁";
static NSString * kCHN_255 =@"💎";
static NSString * kCHN_256 =@"☕️";
static NSString * kCHN_257 =@"🎂";
static NSString * kCHN_258 =@"🍰";
static NSString * kCHN_259 =@"🍺";
static NSString * kCHN_260 =@"🍻";

static NSString * kCHN_261 =@"🍸";
static NSString * kCHN_262 =@"🍵";
static NSString * kCHN_263 =@"🍶";
static NSString * kCHN_264 =@"🍔";
static NSString * kCHN_265 =@"🍟";
static NSString * kCHN_266 =@"🍝";
static NSString * kCHN_267 =@"🍜";
static NSString * kCHN_268 =@"🍧";
static NSString * kCHN_269 =@"🍦";
static NSString * kCHN_270 =@"🍡";

static NSString * kCHN_271 =@"🍙";
static NSString * kCHN_272 =@"🍘";
static NSString * kCHN_273 =@"🍞";
static NSString * kCHN_274 =@"🍛";
static NSString * kCHN_275 =@"🍚";
static NSString * kCHN_276 =@"🍲";
static NSString * kCHN_277 =@"🍱";
static NSString * kCHN_278 =@"🍣";
static NSString * kCHN_279 =@"🍎";
static NSString * kCHN_280 =@"🍓";

static NSString * kCHN_281 =@"🍉";
static NSString * kCHN_282 =@"🍆";
static NSString * kCHN_283 =@"🍅";
static NSString * kCHN_284 =@"🍊";
static NSString * kCHN_285 =@"🚀";
static NSString * kCHN_286 =@"🚄";
static NSString * kCHN_287 =@"🚉";
static NSString * kCHN_288 =@"🚃";
static NSString * kCHN_289 =@"🚗";
static NSString * kCHN_290 =@"🚕";


static NSString * kCHN_291 =@"🚓";
static NSString * kCHN_292 =@"🚒";
static NSString * kCHN_293 =@"🚑";
static NSString * kCHN_294 =@"🚙";
static NSString * kCHN_295 =@"🚲";
static NSString * kCHN_296 =@"🏁";
static NSString * kCHN_297 =@"🚹";
static NSString * kCHN_298 =@"🚺";
static NSString * kCHN_299 =@"🅾";
static NSString * kCHN_300 =@"❌";

@implementation ConvertToCommonEmoticonsHelper

#pragma mark - emotics
+ (NSString *)convertToCommonEmoticons:(NSString *)text {
    int allEmoticsCount = (int)[Emoji allEmoji].count;
    NSMutableString *retText = [[NSMutableString alloc] initWithString:text];
    for(int i=0; i<allEmoticsCount; ++i) {
        NSRange range;
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😊"
                                 withString:@"[):]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😃"
                                 withString:@"[:D]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😉"
                                 withString:@"[;)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😮"
                                 withString:@"[:-o]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😋"
                                 withString:@"[:p]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😎"
                                 withString:@"[(H)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😡"
                                 withString:@"[:@]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😖"
                                 withString:@"[:s]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😳"
                                 withString:@"[:$]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😞"
                                 withString:@"[:(]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😭"
                                 withString:@"[:'(]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😐"
                                 withString:@"[:|]"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😇"
//                                 withString:@"[(a)]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😬"
                                 withString:@"[8o|]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😆"
                                 withString:@"[8-|]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😱"
                                 withString:@"[+o(]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🎅"
                                 withString:@"[<o)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😴"
                                 withString:@"[|-)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😕"
                                 withString:@"[*-)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😷"
                                 withString:@"[:-#]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😯"
                                 withString:@"[:-*]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😏"
                                 withString:@"[^o)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😑"
                                 withString:@"[8-)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💖"
                                 withString:@"[(|)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💔"
                                 withString:@"[(u)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌙"
                                 withString:@"[(S)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌟"
                                 withString:@"[(*)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌞"
                                 withString:@"[(#)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😂"
                                 withString:@"[(R)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"😚"
                                 withString:@"[(})]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"😍"
                                 withString:@"[({)]"
                                    options:NSLiteralSearch
                                      range:range];

        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💋"
                                 withString:@"[(k)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌹"
                                 withString:@"[(F)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👏"
                                 withString:@"[(W)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👍"
                                 withString:@"[(D)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👎"
                                 withString:@"/:weak"
                                    options:NSLiteralSearch
                                      range:range];
    }
    
    return retText;
}

+ (NSString *)convertToSystemEmoticons:(NSString *)text
{
    if (![text isKindOfClass:[NSString class]]) {
        return @"";
    }
    
    if ([text length] == 0) {
        return @"";
    }
    int allEmoticsCount = (int)[[Emoji allEmoji] count];
    NSMutableString *retText = [[NSMutableString alloc] initWithString:text];
    for(int i=0; i<allEmoticsCount; ++i) {
        NSRange range;
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[):]"
                                 withString:@"😊"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:D]"
                                 withString:@"😃"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[;)]"
                                 withString:@"😉"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:-o]"
                                 withString:@"😮"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:p]"
                                 withString:@"😋"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(H)]"
                                 withString:@"😎"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:@]"
                                 withString:@"😡"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:s]"
                                 withString:@"😖"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:$]"
                                 withString:@"😳"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:(]"
                                 withString:@"😞"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:'(]"
                                 withString:@"😭"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:|]"
                                 withString:@"😐"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[(a)]"
//                                 withString:@"😇"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[8o|]"
                                 withString:@"😬"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[8-|]"
                                 withString:@"😆"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[+o(]"
                                 withString:@"😱"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[<o)]"
                                 withString:@"🎅"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[|-)]"
                                 withString:@"😴"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[*-)]"
                                 withString:@"😕"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:-#]"
                                 withString:@"😷"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:-*]"
                                 withString:@"😯"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[^o)]"
                                 withString:@"😏"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[8-)]"
                                 withString:@"😑"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(|)]"
                                 withString:@"💖"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(u)]"
                                 withString:@"💔"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(S)]"
                                 withString:@"🌙"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(*)]"
                                 withString:@"🌟"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(#)]"
                                 withString:@"🌞"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(R)]"
                                 withString:@"😂"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"[(})]"
                                 withString:@"😚"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"[({)]"
                                 withString:@"😍"
                                    options:NSLiteralSearch
                                      range:range];

        
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(k)]"
                                 withString:@"💋"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(F)]"
                                 withString:@"🌹"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(W)]"
                                 withString:@"👏"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(D)]"
                                 withString:@"👍"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:weak"
                                 withString:@"👎"
                                    options:NSLiteralSearch
                                      range:range];
        
    }
    
    return retText;
}


//zou 2015-12-10 表情转换为微信表情(微信表情支持环信的emoji表情，该方法弃用)
+ (NSString *)convertToWebChatEmoticons:(NSString *)text
{
    int allEmoticsCount = (int)[Emoji allEmoji].count;
    NSMutableString *retText = [[NSMutableString alloc] initWithString:text];
    for(int i=0; i<allEmoticsCount; ++i) {
        NSRange range;
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😊"
                                 withString:@"/::)"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😃"
                                 withString:@"/::D"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😉"
                                 withString:@"/::P"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😮"
                                 withString:@"/::|"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😋"
                                 withString:@"/:,@P"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😎"
                                 withString:@"/:8-)"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😡"
                                 withString:@"/::@"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😖"
                                 withString:@"/::Q"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😳"
                                 withString:@"/::|"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😞"
                                 withString:@"/::-|"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😭"
                                 withString:@"/::<"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😐"
                                 withString:@"/::("
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😇"
//                                 withString:@"[(a)]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😬"
                                 withString:@"/:B-)"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😆"
                                 withString:@"/::>"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😱"
                                 withString:@"/:!!!"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🎅"
                                 withString:@"/::+"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😴"
                                 withString:@"/::Z"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😕"
                                 withString:@"/:,@o"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😷"
                                 withString:@""
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😯"
                                 withString:@"/::d"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😏"
                                 withString:@"/:X-)"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😑"
                                 withString:@"/::L"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💖"
                                 withString:@"/:heart"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💔"
                                 withString:@"/:break"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌙"
                                 withString:@"/:moon"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌟"
                                 withString:@"/:sun"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌞"
                                 withString:@"/:sun"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😂"
                                 withString:@""
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"😚"
                                 withString:@"/::*"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"😍"
                                 withString:@"/::B"
                                    options:NSLiteralSearch
                                      range:range];
        
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💋"
                                 withString:@"/:showlove"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌹"
                                 withString:@"/:rose"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👏"
                                 withString:@"/:handclap"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👍"
                                 withString:@"/:strong"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👎"
                                 withString:@"/:weak"
                                    options:NSLiteralSearch
                                      range:range];
    }
    return retText;
}

//微信表情转换为环信表情
+ (NSString *)convertHuanXinEmoticons:(NSString *)text
{
    int allEmoticsCount = (int)[Emoji allEmoji].count;
    NSMutableString *retText = [[NSMutableString alloc] initWithString:text];
    
    
    for(int i=0; i<allEmoticsCount; ++i) {
        NSRange range;
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::)"
                                 withString:@"😊"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::D"
                                 withString:@"😃"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::P"
                                 withString:@"😉"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::|"
                                 withString:@"😮"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:,@P"
                                 withString:@"😋"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:8-)"
                                 withString:@"😎"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::@"
                                 withString:@"😡"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::Q"
                                 withString:@"😖"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::|"
                                 withString:@"😳"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::-|"
                                 withString:@"😞"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::<"
                                 withString:@"😭"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::("
                                 withString:@"😐"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[(a)]"
//                                 withString:@"😇"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:B-)"
                                 withString:@"😬"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::>"
                                 withString:@"😆"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:!!!"
                                 withString:@"😱"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::+"
                                 withString:@"🎅"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::Z"
                                 withString:@"😴"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:,@o"
                                 withString:@"😕"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@""
                                 withString:@"😷"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::d"
                                 withString:@"😯"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:X-)"
                                 withString:@"😏"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/::L"
                                 withString:@"😑"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:heart"
                                 withString:@"💖"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:break"
                                 withString:@"💔"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:moon"
                                 withString:@"🌙"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:sun"
                                 withString:@"🌟"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:sun"
                                 withString:@"🌞"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@""
                                 withString:@"😂"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"/::*"
                                 withString:@"😚"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"/::B"
                                 withString:@"😍"
                                    options:NSLiteralSearch
                                      range:range];
        
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:showlove"
                                 withString:@"💋"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:rose"
                                 withString:@"🌹"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:handclap"
                                 withString:@"👏"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:strong"
                                 withString:@"👍"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"/:weak"
                                 withString:@"👎"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@""
//                                 withString:@"😳"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@""
//                                 withString:@"😱"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@""
//                                 withString:@"😉"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        static NSArray *strArray = nil;
        if (strArray == nil) {
            strArray = [NSArray arrayWithObjects:kStr_01,kStr_02,kStr_03,kStr_04,kStr_05,kStr_06,kStr_07,kStr_08,kStr_09,kStr_10, kStr_11,kStr_12,kStr_13,kStr_14,kStr_15,kStr_16,kStr_17,kStr_18,kStr_19, kStr_20,kStr_21,kStr_22,kStr_23,kStr_24,kStr_25,kStr_26,kStr_27,kStr_28,kStr_29,kStr_30,kStr_31,kStr_32,kStr_33,kStr_34,kStr_35,kStr_36,kStr_37,kStr_38,kStr_39,kStr_40,kStr_41,kStr_42,kStr_43,kStr_44,kStr_45,kStr_46,kStr_47,kStr_48,kStr_49,kStr_50,kStr_51,kStr_52,kStr_53,kStr_54,kStr_55,kStr_56,kStr_57,kStr_58,kStr_59,kStr_60,kStr_61,kStr_62,kStr_63,kStr_64,kStr_65,kStr_66,kStr_67,kStr_68,kStr_69,kStr_70,kStr_71,kStr_72,kStr_73,kStr_74,kStr_75,kStr_76,kStr_77,kStr_78,kStr_79,kStr_80,kStr_81,kStr_82,kStr_83,kStr_84,kStr_85,kStr_86,kStr_87,kStr_88,kStr_89,kStr_90,kStr_91,kStr_92,kStr_93,kStr_94,kStr_95,kStr_96,kStr_97,kStr_98,kStr_99,kStr_100,kStr_101,kStr_102,kStr_103,kStr_104,kStr_105,kStr_106,kStr_107,kStr_108,kStr_109,kStr_110,kStr_111,kStr_112,kStr_113,kStr_114,kStr_115,kStr_116,kStr_117,kStr_118,kStr_119,kStr_120,kStr_121,kStr_122,kStr_123,kStr_124,kStr_125,kStr_126,kStr_127,kStr_128,kStr_129,kStr_130,kStr_131,kStr_132,kStr_133,kStr_134,kStr_135,kStr_136,kStr_137,kStr_138,kStr_139,kStr_140,kStr_141,kStr_142,kStr_143,kStr_144,kStr_145,kStr_146,kStr_147,kStr_148,kStr_149,kStr_150,kStr_151,kStr_152,kStr_153,kStr_154,kStr_155,kStr_156,kStr_157,kStr_158,kStr_159,kStr_160,kStr_161,kStr_162,kStr_163,kStr_164,kStr_165,kStr_166,kStr_167,kStr_168,kStr_169,kStr_170,kStr_171,kStr_172,kStr_173,kStr_174,kStr_175,kStr_176,kStr_177,kStr_178,kStr_179,kStr_180,kStr_181,kStr_182,kStr_183,kStr_184,kStr_185,kStr_186,kStr_187,kStr_188,kStr_189,kStr_190,kStr_191,kStr_192,kStr_193,kStr_194,kStr_195,kStr_196,kStr_197,kStr_198,kStr_199,kStr_200,kStr_201,kStr_202,kStr_203,kStr_204,kStr_205,kStr_206,kStr_207,kStr_208,kStr_209,kStr_210,kStr_211,kStr_212,kStr_213,kStr_214,kStr_215,kStr_216,kStr_217,kStr_218,kStr_219,kStr_220,kStr_221,kStr_222,kStr_223,kStr_224,kStr_225,kStr_226,kStr_227,kStr_228,kStr_229,kStr_230,kStr_231,kStr_232,kStr_233,kStr_234,kStr_235,kStr_236,kStr_237,kStr_238,kStr_239,kStr_240,kStr_241,kStr_242,kStr_243,kStr_244,kStr_245,kStr_246,kStr_247,kStr_248,kStr_249,kStr_250,kStr_251,kStr_252,kStr_253,kStr_254,kStr_255,kStr_256,kStr_257,kStr_258,kStr_259,kStr_260,kStr_261,kStr_262,kStr_263,kStr_264,kStr_265,kStr_266,kStr_267,kStr_268,kStr_269,kStr_270,kStr_271,kStr_272,kStr_273,kStr_274,kStr_275,kStr_276,kStr_277,kStr_278,kStr_279,kStr_280,kStr_281,kStr_282,kStr_283,kStr_284,kStr_285,kStr_286,kStr_287,kStr_288,kStr_289,kStr_290,kStr_291,kStr_292,kStr_293,kStr_294,kStr_295,kStr_296,kStr_297,kStr_298,kStr_299,kStr_300,nil];
        }
        
        static NSArray *ChNArrray = nil;
        if (ChNArrray == nil) {
            ChNArrray = [NSArray arrayWithObjects:kCHN_01,kCHN_02,kCHN_03,kCHN_04,kCHN_05,kCHN_06,kCHN_07,kCHN_08,kCHN_09,kCHN_10, kCHN_11,kCHN_12,kCHN_13,kCHN_14,kCHN_15,kCHN_16,kCHN_17,kCHN_18,kCHN_19, kCHN_20,kCHN_21,kCHN_22,kCHN_23,kCHN_24,kCHN_25,kCHN_26,kCHN_27,kCHN_28,kCHN_29,kCHN_30,kCHN_31,kCHN_32,kCHN_33,kCHN_34,kCHN_35,kCHN_36,kCHN_37,kCHN_38,kCHN_39,kCHN_40,kCHN_41,kCHN_42,kCHN_43,kCHN_44,kCHN_45,kCHN_46,kCHN_47,kCHN_48,kCHN_49,kCHN_50,kCHN_51,kCHN_52,kCHN_53,kCHN_54,kCHN_55,kCHN_56,kCHN_57,kCHN_58,kCHN_59,kCHN_60,kCHN_61,kCHN_62,kCHN_63,kCHN_64,kCHN_65,kCHN_66,kCHN_67,kCHN_68,kCHN_69,kCHN_70,kCHN_71,kCHN_72,kCHN_73,kCHN_74,kCHN_75,kCHN_76,kCHN_77,kCHN_78,kCHN_79,kCHN_80,kCHN_81,kCHN_82,kCHN_83,kCHN_84,kCHN_85,kCHN_86,kCHN_87,kCHN_88,kCHN_89,kCHN_90,kCHN_91,kCHN_92,kCHN_93,kCHN_94,kCHN_95,kCHN_96,kCHN_97,kCHN_98,kCHN_99,kCHN_100,kCHN_101,kCHN_102,kCHN_103,kCHN_104,kCHN_105,kCHN_106,kCHN_107,kCHN_108,kCHN_109,kCHN_110,kCHN_111,kCHN_112,kCHN_113,kCHN_114,kCHN_115,kCHN_116,kCHN_117,kCHN_118,kCHN_119,kCHN_120,kCHN_121,kCHN_122,kCHN_123,kCHN_124,kCHN_125,kCHN_126,kCHN_127,kCHN_128,kCHN_129,kCHN_130,kCHN_131,kCHN_132,kCHN_133,kCHN_134,kCHN_135,kCHN_136,kCHN_137,kCHN_138,kCHN_139,kCHN_140,kCHN_141,kCHN_142,kCHN_143,kCHN_144,kCHN_145,kCHN_146,kCHN_147,kCHN_148,kCHN_149,kCHN_150,kCHN_151,kCHN_152,kCHN_153,kCHN_154,kCHN_155,kCHN_156,kCHN_157,kCHN_158,kCHN_159,kCHN_160,kCHN_161,kCHN_162,kCHN_163,kCHN_164,kCHN_165,kCHN_166,kCHN_167,kCHN_168,kCHN_169,kCHN_170,kCHN_171,kCHN_172,kCHN_173,kCHN_174,kCHN_175,kCHN_176,kCHN_177,kCHN_178,kCHN_179,kCHN_180,kCHN_181,kCHN_182,kCHN_183,kCHN_184,kCHN_185,kCHN_186,kCHN_187,kCHN_188,kCHN_189,kCHN_190,kCHN_191,kCHN_192,kCHN_193,kCHN_194,kCHN_195,kCHN_196,kCHN_197,kCHN_198,kCHN_199,kCHN_200,kCHN_201,kCHN_202,kCHN_203,kCHN_204,kCHN_205,kCHN_206,kCHN_207,kCHN_208,kCHN_209,kCHN_210,kCHN_211,kCHN_212,kCHN_213,kCHN_214,kCHN_215,kCHN_216,kCHN_217,kCHN_218,kCHN_219,kCHN_220,kCHN_221,kCHN_222,kCHN_223,kCHN_224,kCHN_225,kCHN_226,kCHN_227,kCHN_228,kCHN_229,kCHN_230,kCHN_231,kCHN_232,kCHN_233,kCHN_234,kCHN_235,kCHN_236,kCHN_237,kCHN_238,kCHN_239,kCHN_240,kCHN_241,kCHN_242,kCHN_243,kCHN_244,kCHN_245,kCHN_246,kCHN_247,kCHN_248,kCHN_249,kCHN_250,kCHN_251,kCHN_252,kCHN_253,kCHN_254,kCHN_255,kCHN_256,kCHN_257,kCHN_258,kCHN_259,kCHN_260,kCHN_261,kCHN_262,kCHN_263,kCHN_264,kCHN_265,kCHN_266,kCHN_267,kCHN_268,kCHN_269,kCHN_270,kCHN_271,kCHN_272,kCHN_273,kCHN_274,kCHN_275,kCHN_276,kCHN_277,kCHN_278,kCHN_279,kCHN_280,kCHN_281,kCHN_282,kCHN_283,kCHN_284,kCHN_285,kCHN_286,kCHN_287,kCHN_288,kCHN_289,kCHN_290,kCHN_291,kCHN_292,kCHN_293,kCHN_294,kCHN_295,kCHN_296,kCHN_297,kCHN_298,kCHN_299,kCHN_300,nil];
        }
        
        @try {
            [strArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([retText containsString:obj]) {
                    
                    NSRange range;
                    range.location = 0;
                    range.length = retText.length;
                    
                    [retText replaceOccurrencesOfString:obj withString:[ChNArrray objectAtIndex:idx] options:NSLiteralSearch range:range];
                    NSLog(@"index--%d",idx);
                }
                
            }];
        }
        @catch (NSException *exception) {
            NSLog(@"throw exception is  here!!");
        }
        @finally {
            nil;
        }
        
            }
    return retText;
}


@end
