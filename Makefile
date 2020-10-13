tools: runitor rclone

P=linux-amd64
V=v0.6.0

runitor:
	curl -sLo runitor https://github.com/bdd/runitor/releases/download/$V/runitor-$V-$P
	chmod +x runitor

rclone:
	curl -sLo rclone.zip https://downloads.rclone.org/rclone-current-$P.zip
	unzip -j rclone.zip */rclone && rm rclone.zip
	chmod +x rclone
