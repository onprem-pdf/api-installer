sudo bash -c '
set -e

echo "[cleanup] Stoppe Tomcat"
systemctl stop tomcat9 2>/dev/null || true
systemctl disable tomcat9 2>/dev/null || true

echo "[cleanup] Entferne systemd Service"
rm -f /etc/systemd/system/tomcat9.service
systemctl daemon-reload
systemctl reset-failed

echo "[cleanup] Entferne Tomcat"
rm -rf /opt/tomcat

echo "[cleanup] Entferne PDFGuard Daten"
rm -rf /var/lib/pdfguard

echo "[cleanup] Entferne Temp Dateien"
rm -rf /tmp/pdfguard-install
rm -f /tmp/apache-tomcat-*.tar.gz

echo "[cleanup] Entferne Tomcat User & Group"
userdel -r tomcat 2>/dev/null || true
groupdel tomcat 2>/dev/null || true

echo "[cleanup] Entferne Java"
apt purge -y openjdk-17-jre-headless || true
apt autoremove -y || true

echo "[cleanup] (inkl. Java)"
'
