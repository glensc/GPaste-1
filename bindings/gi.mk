# This file is part of GPaste.
#
# Copyright 2012-2014 Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
#
# GPaste is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# GPaste is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GPaste.  If not, see <http://www.gnu.org/licenses/>.

-include $(INTROSPECTION_MAKEFILE)

INTROSPECTION_SCANNER_ARGS = --c-include=gpaste.h --c-include=gpaste-client.h --c-include=gpaste-daemon.h
INTROSPECTION_COMPILER_ARGS = $(NULL)
INTROSPECTION_GIRS = $(NULL)

libgpaste_gir_file = bindings/gi/GPaste-1.0.gir

all_la_files = \
	$(builddir)/$(libgpaste_applet_la_file) \
	$(builddir)/$(libgpaste_client_la_file) \
	$(builddir)/$(libgpaste_core_la_file) \
	$(builddir)/$(libgpaste_daemon_la_file) \
	$(builddir)/$(libgpaste_gnome_shell_client_la_file) \
	$(builddir)/$(libgpaste_keybinder_la_file) \
	$(builddir)/$(libgpaste_settings_la_file) \
	$(builddir)/$(libgpaste_settings_ui_la_file) \
	$(NULL)

all_la_sources = \
	$(libgpaste_client_libgpaste_client_la_SOURCES) \
	$(libgpaste_applet_libgpaste_applet_la_SOURCES) \
	$(libgpaste_core_libgpaste_core_la_SOURCES) \
	$(libgpaste_daemon_libgpaste_daemon_la_SOURCES) \
	$(libgpaste_gnome_shell_client_libgpaste_gnome_shell_client_la_SOURCES) \
	$(libgpaste_keybinder_libgpaste_keybinder_la_SOURCES) \
	$(libgpaste_settings_libgpaste_settings_la_SOURCES) \
	$(libgpaste_settings_ui_libgpaste_settings_ui_la_SOURCES) \
	$(NULL)

$(libgpaste_gir_file): $(all_la_files)
bindings_gi_GPaste_1_0_gir_FILES = \
	$(all_la_sources) \
	$(NULL)
bindings_gi_GPaste_1_0_gir_CFLAGS = \
	$(AM_CFLAGS) \
	$(NULL)
bindings_gi_GPaste_1_0_gir_LIBS = $(all_la_files)
bindings_gi_GPaste_1_0_gir_EXPORT_PACKAGES = \
	libgpaste-applet \
	libgpaste-client \
	libgpaste-core \
	libgpaste-daemon \
	libgpaste-gnome-shell-client \
	libgpaste-keybinder \
	libgpaste-settings \
	libgpaste-settings-ui \
	$(NULL)
bindings_gi_GPaste_1_0_gir_SCANNERFLAGS = --warn-all
bindings_gi_GPaste_1_0_gir_INCLUDES = \
	GdkPixbuf-2.0 \
	Gio-2.0 \
	GObject-2.0 \
	Gtk-3.0 \
	$(NULL)

if HAVE_INTROSPECTION
INTROSPECTION_GIRS += \
	$(libgpaste_gir_file) \
	$(NULL)
endif

girdir = $(datadir)/gir-1.0
gir_DATA = $(INTROSPECTION_GIRS)

typelibdir = $(libdir)/girepository-1.0
typelib_DATA = $(INTROSPECTION_GIRS:.gir=.typelib)

CLEANFILES += \
	$(gir_DATA) \
	$(typelib_DATA) \
	$(NULL)
