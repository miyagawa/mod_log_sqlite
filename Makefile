##
##  Makefile -- Build procedure for sample log_sqlite Apache module
##  Autogenerated via ``apxs -n log_sqlite -g''.
##

#   the used tools
APXS=apxs
APACHECTL=apachectl
VER=0.02

#   additional user defines, includes and libraries
#DEF=-Dmy_define=my_value
INC=-I/usr/local/include
LIB=-L/usr/local/lib -lsqlite

#   the default target
all: mod_log_sqlite.so

#   compile the DSO file
mod_log_sqlite.so: mod_log_sqlite.c
	$(APXS) -c $(DEF) $(INC) $(LIB) mod_log_sqlite.c

#   install the DSO file into the Apache installation
#   and activate it in the Apache configuration
install: all
	$(APXS) -i -a -n 'log_sqlite' mod_log_sqlite.so

#   cleanup
clean:
	-rm -f mod_log_sqlite.o mod_log_sqlite.so

#   simple test
test: reload
	lynx -mime_header http://localhost/log_sqlite

#   reload the module by installing and restarting Apache
reload: install restart

#   the general Apache start/restart/stop procedures
start:
	$(APACHECTL) start
restart:
	$(APACHECTL) restart
stop:
	$(APACHECTL) stop


#   make the distribution
dist:
	perl -MExtUtils::Manifest=manicopy,maniread -e "manicopy(maniread(), 'mod_log_sqlite-$(VER)', 'best')"
	tar cvf mod_log_sqlite-$(VER).tar mod_log_sqlite-$(VER)
	gzip --best mod_log_sqlite-$(VER).tar
	rm -r mod_log_sqlite-$(VER)
