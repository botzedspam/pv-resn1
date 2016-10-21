local function do_keyboard_endchat()
    local keyboard = {}
    keyboard.inline_keyboard = {
    	{
    		{text = '🔚', callback_data = '/end'}
	    }
    }
    return keyboard
end
local action = function(msg,blocks, ln)
local msg_id = msg.message_id
local user_id = msg.chat.id
local hash = 'pm:user'
local chat_info = db:hget(hash,user_id)
if blocks[1] == 'start' then
if chat_info == 'block' then 
 api.sendMessage(msg.chat.id, '*متاسفیم!*\n_شما بلاک هستید :(_', true) 
else
 db:hset(hash, user_id, 'true')
 api.sendMessage(msg.chat.id, '*- چت شروع شد*\n_پیام خود را بفرستید_', true) 
 end
 end
if blocks[1] == 'end' then
if chat_info == 'block' or chat_info == 'false' then 
return nil 
else
 db:hset(hash, user_id, 'false')
api.sendMessage(msg.chat.id, '*- چت پایان یافت* \nبرای شروع دوباره `start/ را بزنید`', true) 
end
end
if msg.chat.type == 'private' and chat_info == 'true' then
if blocks[1] == 'end' or blocks[1] == 'chat' then return nil end
api.forwardMessage('-165268776', msg.chat.id, msg_id) 
api.sendKeyboard(msg.chat.id, '`- پیام شما ارسال شد !`\n_بزودی پاسخگو هستیم_'  ,do_keyboard_endchat(), true)
end
if blocks[1] == 'block' then
if msg.reply and msg.reply.forward_from and msg.chat.type == 'group' and msg.chat.id == -165268776 and not blocks[2] then
msg = msg.reply
local user_id = msg.forward_from.id
 db:hset(hash, user_id, 'block')
api.sendMessage(msg.chat.id, '_کاربر '..user_id..' بلاک شد_', true) 
api.sendMessage(user_id, '`- متاسفیم`\n_شما بلاک شدید_\n\n*چت پایان یافت.*', true) 
else
 if msg.chat.type == 'group' and msg.chat.id == -165268776 then
 if msg.reply then return nil end
local user_id = blocks[2]
 db:hset(hash, user_id, 'block')
api.sendMessage(msg.chat.id, '_کاربر '..user_id..' بلاک شد_', true) 
api.sendMessage(user_id, '`- متاسفیم`\n_شما بلاک هستید_', true) 
end 
end
end
if blocks[1] == 'unblock' then
if msg.reply and msg.reply.forward_from and msg.chat.type == 'group' and msg.chat.id == - 165268776nd not blocks[2] then
msg = msg.reply
local user_id = msg.forward_from.id
 db:hset(hash, user_id, 'false')
api.sendMessage(msg.chat.id, '_کاربر '..user_id..' آنبلاک شد_', true) 
api.sendMessage(user_id, '_شما آنبلاک شدید_', true) 
else
 if msg.chat.type == 'group' and msg.chat.id == -165268776 then
  if msg.reply then return nil end
local user_id = blocks[2]
 db:hset(hash, user_id, 'false')
api.sendMessage(msg.chat.id, '_کاربر '..user_id..' آنبلاک شد_', true) 
api.sendMessage(user_id, '_شما آنبلاک شدید_', true) 
end 
end
end
    if msg.reply and msg.reply.forward_from and msg.chat.type == 'group' and msg.chat.id == -165268776 then
   msg = msg.reply_to_message
    local receiver = msg.forward_from.id
    local input = blocks[1]
      api.sendMessage(receiver, '- پیام ارسال شده توسط پشتیبانی : \n\n'..input, false)
end
end
return {
  action = action,
triggers = {
    '^/(unblock) (%d+)$',
    '^/(block) (%d+)$',
    '^/(unblock)$',
    '^/(block)$',
    '^/(start)$',
    '^/(end)$',
	'^###cb:/(start)',
	'^###cb:/(end)',
    '^(.*)$',
    }
}

-- @Sudo_TM
