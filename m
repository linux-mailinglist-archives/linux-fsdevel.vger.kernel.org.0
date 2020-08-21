Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D7B24DADE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgHUQ3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 12:29:46 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:59074 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728648AbgHUQZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:25:57 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 51712821EC;
        Fri, 21 Aug 2020 19:25:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598027139;
        bh=DVLMZjHII+6h7ZanHM0twnhITbQwT9Zy/q8JsKmxgFc=;
        h=From:To:CC:Subject:Date;
        b=ZeXwYQllCIlnL4AbW7uL+9nvE39a9kzFeA7b8koU33OC7Zs6rj1t+w4K8+X9/eeqe
         BRpkz9snV5JHIC9SOn8AXQqxXusEdoF32Q6mjRN70bdYMEvPCIWAbSl69YBPz3LtDr
         ZL3NoA1nIFE0BbYXDCETl338OGpwqWrT2BGn6gdc=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 21 Aug 2020 19:25:38 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 21 Aug 2020 19:25:38 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: [PATCH v2 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Thread-Topic: [PATCH v2 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Thread-Index: AdZ302F8VVG9og4hTA6+RhoU6EU4hg==
Date:   Fri, 21 Aug 2020 16:25:37 +0000
Message-ID: <74de75d537ac486e9fcfe7931181a9b9@paragon-software.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds fs/ntfs3 Kconfig, Makefile and Documentation file

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com=
>
---
 Documentation/filesystems/ntfs3.rst | 93 +++++++++++++++++++++++++++++
 fs/ntfs3/Kconfig                    | 23 +++++++
 fs/ntfs3/Makefile                   | 11 ++++
 3 files changed, 127 insertions(+)
 create mode 100644 Documentation/filesystems/ntfs3.rst
 create mode 100644 fs/ntfs3/Kconfig
 create mode 100644 fs/ntfs3/Makefile

diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystem=
s/ntfs3.rst
new file mode 100644
index 000000000000..4a510a6cdaee
--- /dev/null
+++ b/Documentation/filesystems/ntfs3.rst
@@ -0,0 +1,93 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D
+NTFS3
+=3D=3D=3D=3D=3D
+
+
+Summary and Features
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NTFS3 is fully functional NTFS Read-Write driver. The driver works with
+NTFS versions up to 3.1, normal/compressed/sparse files
+and journal replaying. File system type to use on mount is 'ntfs3'.
+
+- This driver implements NTFS read/write support for normal, sparsed and
+  compressed files.
+  NOTE: Operations with compressed files require increased memory consumpt=
ion;
+- Supports native journal replaying;
+- Supports extended attributes;
+- Supports NFS export of mounted NTFS volumes.
+
+Mount Options
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The list below describes mount options supported by NTFS3 driver in addtio=
n to
+generic ones.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+nls=3Dname		These options inform the driver how to interpret path
+			strings and translate them to Unicode and back. In case
+			none of these options are set, or if specified codepage
+			doesn't exist on the system, the default codepage will be
+			used (CONFIG_NLS_DEFAULT).
+			Examples:
+				'nls=3Dutf8'
+
+uid=3D
+gid=3D
+umask=3D			Controls the default permissions for files/directories created
+			after the NTFS volume is mounted.
+
+fmask=3D
+dmask=3D			Instead of specifying umask which applies both to
+			files and directories, fmask applies only to files and
+			dmask only to directories.
+
+nohidden		Files with the Windows-specific HIDDEN (FILE_ATTRIBUTE_HIDDEN)
+			attribute will not be shown under Linux.
+
+sys_immutable		Files with the Windows-specific SYSTEM
+			(FILE_ATTRIBUTE_SYSTEM) attribute will be marked as system
+			immutable files.
+
+discard			Enable support of the TRIM command for improved performance
+			on delete operations, which is recommended for use with the
+			solid-state drives (SSD).
+
+force			Forces the driver to mount partitions even if 'dirty' flag
+			(volume dirty) is set. Not recommended for use.
+
+sparse			Create new files as "sparse".
+
+showmeta		Use this parameter to show all meta-files (System Files) on
+			a mounted NTFS partition.
+			By default, all meta-files are hidden.
+
+no_acs_rules		"No access rules" mount option sets access rights for
+			files/folders to 777 and owner/group to root. This mount
+			option absorbs all other permissions:
+			- permissions change for files/folders will be reported
+				as successful, but they will remain 777;
+			- owner/group change will be reported as successful, but
+				they will stay as root
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+
+ToDo list
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Full journaling support (currently journal replaying is supported) over =
JBD.
+
+
+References
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+https://www.paragon-software.com/home/ntfs-linux-professional/
+	- Commercial version of the NTFS driver for Linux.
+
+almaz.alexandrovich@paragon-software.com
+	- Direct e-mail address for feedback and requests on the NTFS3 implementa=
tion.
+
+
diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
new file mode 100644
index 000000000000..92a9c68008c8
--- /dev/null
+++ b/fs/ntfs3/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NTFS3_FS
+	tristate "NTFS Read-Write file system support"
+	select NLS
+	help
+	  Windows OS native file system (NTFS) support up to NTFS version 3.1.
+
+	  Y or M enables the NTFS3 driver with full features enabled (read,
+	  write, journal replaying, sparse/compressed files support).
+	  File system type to use on mount is "ntfs3". Module name (M option)
+	  is also "ntfs3".
+
+	  Documentation: <file:Documentation/filesystems/ntfs3.rst>
+
+config NTFS3_64BIT_CLUSTER
+	bool "64 bits per NTFS clusters"
+	depends on NTFS3_FS && 64BIT
+	help
+	  Windows implementation of ntfs.sys uses 32 bits per clusters.
+	  If activated 64 bits per clusters you will be able to use 4k cluster
+	  for 16T+ volumes. Windows will not be able to mount such volumes.
+
+	  It is recommended to say N here.
diff --git a/fs/ntfs3/Makefile b/fs/ntfs3/Makefile
new file mode 100644
index 000000000000..4d4fe198b8b8
--- /dev/null
+++ b/fs/ntfs3/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the ntfs3 filesystem support.
+#
+
+obj-$(CONFIG_NTFS3_FS) +=3D ntfs3.o
+
+ntfs3-objs :=3D bitfunc.o bitmap.o inode.o fsntfs.o frecord.o \
+	    index.o attrlist.o record.o attrib.o run.o xattr.o\
+	    upcase.o super.o file.o dir.o namei.o lznt.o\
+	    fslog.o
--=20
2.25.2

