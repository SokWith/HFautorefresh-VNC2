#!/bin/bash
# Author : Bing
# Script follows here:

# Define a function to clear chromium browser cache
clear_cache() {
  rm -rf ~/.cache/chromium
}

# Define a function to load a web page using chromium browser
load_page() {
  # The first argument is the web page url
  url=$1
  # Open the url in a new tab of chromium browser
  chromium --new-tab $url --window-position=0,0 --window-size=700,500

}

# Define a function to move the mouse and click the left button using xdotool
move_and_click() {
  # The first argument is the x coordinate
  x=$1
  # The second argument is the y coordinate
  y=$2
  # Move the mouse to the given coordinates
  xdotool mousemove $x $y
  # Click the left button
  xdotool click 1
}

# Define a function to type some characters and press enter using xdotool
type_and_enter() {
  # The first argument is the characters to type
  chars=$1
  # Type the characters
  xdotool type "$chars"
  # Press enter
  xdotool key Return
}

# Define a function to kill all chromium browser windows
kill_chromium() {
  # Find the process id of chromium browser
  pid=$(pgrep chromium)
  # Kill the process
  kill $pid
}

# Define a function to wait for some seconds
wait_for() {
  # The first argument is the number of seconds to wait
  seconds=$1
  # Sleep for the given seconds
  sleep $seconds
}

screenshot_to_base64() {
  # 检查是否提供了保存路径作为参数
  if [ -z "$1" ]; then
    echo "请提供一个保存截图的路径。"
    return 1
  fi

  # 使用xdotool获取当前活动窗口的截图，并将其转换为base64编码
  local current_time=$(date +%s) # 获取当前绝对时间
  local filename="${current_time}.txt" # 创建文件名
  local save_path="$1/$filename" # 完整的保存路径

  # 截屏并保存为base64编码
  xdotool key "Print" # 模拟按下“Print”键进行截屏
  sleep 1 # 等待截屏命令执行
  xclip -selection clipboard -t image/png -o | base64 > "$save_path"

  echo "截图已保存为base64编码文本文件：$save_path"
}

# 使用示例：
# screenshot_to_base64 "/path/to/save/directory"


# Define an infinite loop
while true
do
  # Clear chromium browser cache
  clear_cache
  # Load the first web page
  #load_page "https://www.bing.com/turing/captcha/challenge"
   /home/user/Desktop/myshell/openchall.sh &
  # Wait for 15 seconds
  wait_for 15
  # Move the mouse and click the left button
  move_and_click 80 210
  # Wait for 5 seconds
  wait_for 5
  # 使用示例：
  screenshot_to_base64 "/home/user/Desktop"
  # Load the second web page
  load_page "https://www.bing.com/search?q=Bing+AI&showconv=1&FORM=hpcodx"
  # Wait for 5 seconds
  wait_for 5
  # Move the mouse and click the left button
  move_and_click 400 490
  # Type AI and press enter
  type_and_enter "AI"
  # Wait for 5 seconds
  wait_for 5
  # 使用示例：
  screenshot_to_base64 "/home/user/Desktop"
  # Kill all chromium browser windows
  kill_chromium
  # Wait for 50 minutes
  wait_for 3000
  # Go back to the beginning of the loop
done


