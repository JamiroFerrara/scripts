ffmpeg -f gdigrab -i desktop -profile:v high -pix_fmt yuvj420p -level:v 4.1 -preset ultrafast -tune zerolatency -vcodec libx264 -pix_fmt yuv420p -r 30 -g 30 -acodec aac -strict -2 -f flv rtmp://213.168.249.164:999/show/stream