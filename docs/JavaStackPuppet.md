TODO: Install Java deployment/development environment
- [ ] Extract Tomcat stuff into separate manifests and classes.
- [x] Install Java
- [x] Install Tomcat
- [x] Install Tomcat Admin tools
- [x] Configure Tomcat admin web applications user name/passord/group.
- [x] Restart tomcat after user file changes.
- [x] Supply tomcat admin user password at runtime. Went with default hiera values.
- [x] Configure Tomcat startup options in /etc/defaults/tomcat7. JAVA_OPTS for various java -D properties, environment variables
- [x] Configure Tomcat for serving https. Create Java keystore and integrate into tomcat
- [x] Configure Tomcat ports in server.xml
- [ ] Decide on sensible strategy to expose web application directories on the host to the guest
- [x] Add tomcat service restart after tomcat-users.xml change
- [x] Create sensible parameter mechanism for keytool. Went with default hiera values.
- [x] Decide on what directory the keystore should be. Went with /etc/tomcat/.keystore for the default hiera value.
