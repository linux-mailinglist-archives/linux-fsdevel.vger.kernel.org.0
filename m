Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A3222DE08
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 12:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGZKuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 06:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZKuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:50:20 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB57BC0619D2;
        Sun, 26 Jul 2020 03:50:19 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 639FC6F630;
        Sun, 26 Jul 2020 10:50:16 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, corbet@lwn.net, dsterba@suse.com,
        mchehab+huawei@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] fs: Replace HTTP links with HTTPS ones
Date:   Sun, 26 Jul 2020 12:50:10 +0200
Message-Id: <20200726105010.16247-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5 with unmaintained stuff according to:
 perl scripts/get_maintainer.pl --nogit{,-fallback} --nol

 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 fs/hfsplus/btree.c      | 2 +-
 fs/hfsplus/unicode.c    | 2 +-
 fs/isofs/Kconfig        | 6 +++---
 fs/nls/mac-celtic.c     | 2 +-
 fs/nls/mac-centeuro.c   | 2 +-
 fs/nls/mac-croatian.c   | 2 +-
 fs/nls/mac-cyrillic.c   | 2 +-
 fs/nls/mac-gaelic.c     | 2 +-
 fs/nls/mac-greek.c      | 2 +-
 fs/nls/mac-iceland.c    | 2 +-
 fs/nls/mac-inuit.c      | 2 +-
 fs/nls/mac-roman.c      | 2 +-
 fs/nls/mac-romanian.c   | 2 +-
 fs/nls/mac-turkish.c    | 2 +-
 fs/nls/nls_iso8859-14.c | 2 +-
 fs/qnx6/Kconfig         | 2 +-
 16 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 66774f4cb4fd..5168a86fc29b 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -18,7 +18,7 @@
 
 /*
  * Initial source code of clump size calculation is gotten
- * from http://opensource.apple.com/tarballs/diskdev_cmds/
+ * from https://opensource.apple.com/tarballs/diskdev_cmds/
  */
 #define CLUMP_ENTRIES	15
 
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index c8d1b2be7854..31d0fc7c01f1 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -304,7 +304,7 @@ static u16 *hfsplus_decompose_nonhangul(wchar_t uc, int *size)
  * Annex #15: Unicode Normalization Forms, version 3.2.0.
  *
  * Copyright (C) 1991-2018 Unicode, Inc.  All rights reserved.  Distributed
- * under the Terms of Use in http://www.unicode.org/copyright.html.
+ * under the Terms of Use in https://www.unicode.org/copyright.html.
  */
 static int hfsplus_try_decompose_hangul(wchar_t uc, u16 *result)
 {
diff --git a/fs/isofs/Kconfig b/fs/isofs/Kconfig
index 08ffd37b9bb8..bef876506652 100644
--- a/fs/isofs/Kconfig
+++ b/fs/isofs/Kconfig
@@ -9,7 +9,7 @@ config ISO9660_FS
 	  driver.  If you have a CD-ROM drive and want to do more with it than
 	  just listen to audio CDs and watch its LEDs, say Y (and read
 	  <file:Documentation/filesystems/isofs.rst> and the CD-ROM-HOWTO,
-	  available from <http://www.tldp.org/docs.html#howto>), thereby
+	  available from <https://www.tldp.org/docs.html#howto>), thereby
 	  enlarging your kernel by about 27 KB; otherwise say N.
 
 	  To compile this file system support as a module, choose M here: the
@@ -24,7 +24,7 @@ config JOLIET
 	  which allows for long filenames in unicode format (unicode is the
 	  new 16 bit character code, successor to ASCII, which encodes the
 	  characters of almost all languages of the world; see
-	  <http://www.unicode.org/> for more information).  Say Y here if you
+	  <https://www.unicode.org/> for more information).  Say Y here if you
 	  want to be able to read Joliet CD-ROMs under Linux.
 
 config ZISOFS
@@ -35,6 +35,6 @@ config ZISOFS
 	  This is a Linux-specific extension to RockRidge which lets you store
 	  data in compressed form on a CD-ROM and have it transparently
 	  decompressed when the CD-ROM is accessed.  See
-	  <http://www.kernel.org/pub/linux/utils/fs/zisofs/> for the tools
+	  <https://www.kernel.org/pub/linux/utils/fs/zisofs/> for the tools
 	  necessary to create such a filesystem.  Say Y here if you want to be
 	  able to read such compressed CD-ROMs.
diff --git a/fs/nls/mac-celtic.c b/fs/nls/mac-celtic.c
index 266c2d7d50bd..180df6d9978c 100644
--- a/fs/nls/mac-celtic.c
+++ b/fs/nls/mac-celtic.c
@@ -11,7 +11,7 @@
  * COPYRIGHT AND PERMISSION NOTICE
  *
  * Copyright 1991-2012 Unicode, Inc.  All rights reserved.  Distributed under
- * the Terms of Use in http://www.unicode.org/copyright.html.
+ * the Terms of Use in https://www.unicode.org/copyright.html.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of the Unicode data files and any associated documentation (the "Data
diff --git a/fs/nls/mac-centeuro.c b/fs/nls/mac-centeuro.c
index 9789c6057551..f793435ab858 100644
--- a/fs/nls/mac-centeuro.c
+++ b/fs/nls/mac-centeuro.c
@@ -11,7 +11,7 @@
  * COPYRIGHT AND PERMISSION NOTICE
  *
  * Copyright 1991-2012 Unicode, Inc.  All rights reserved.  Distributed under
- * the Terms of Use in http://www.unicode.org/copyright.html.
+ * the Terms of Use in https://www.unicode.org/copyright.html.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of the Unicode data files and any associated documentation (the "Data
diff --git a/fs/nls/mac-croatian.c b/fs/nls/mac-croatian.c
index bb19e7a07d43..e513861b61fe 100644
--- a/fs/nls/mac-croatian.c
+++ b/fs/nls/mac-croatian.c
@@ -11,7 +11,7 @@
  * COPYRIGHT AND PERMISSION NOTICE
  *
  * Copyright 1991-2012 Unicode, Inc.  All rights reserved.  Distributed under
- * the Terms of Use in http://www.unicode.org/copyright.html.
+ * the Terms of Use in https://www.unicode.org/copyright.html.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of the Unicode data files and any associated documentation (the "Data
diff --git a/fs/nls/mac-cyrillic.c b/fs/nls/mac-cyrillic.c
index 2a7dea36acba..bb96694d797d 100644
--- a/fs/nls/mac-cyrillic.c
+++ b/fs/nls/mac-cyrillic.c
@@ -11,7 +11,7 @@
  * COPYRIGHT AND PERMISSION NOTICE
  *
  * Copyright 1991-2012 Unicode, Inc.  All rights reserved.  Distributed under
- * the Terms of Use in http://www.unicode.org/copyright.html.
+ * the Terms of Use in https://www.unicode.org/copyright.html.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of the Unicode data files and any associated documentation (the "Data
diff --git a/fs/nls/mac-gaelic.c b/fs/nls/mac-gaelic.c
index 77b001653588..997de9de6788 100644
--- a/fs/nls/mac-gaelic.c
+++ b/fs/nls/mac-gaelic.c
@@ -11,7 +11,7 @@
  * COPYRIGHT AND PERMISSION NOTICE
  *
  * Copyright 1991-2012 Unicode, Inc.  All rights reserved.  Distributed under
- * the Terms of Use in http://www.unicode.org/copyright.html.
+ * the Terms of Use in https://www.unicode.org/copyright.html.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of the Unicode data files and any associated documentation (the "Data
diff --git a/fs/nls/mac-greek.c b/fs/nls/mac-greek.c
index 1eccf499e2eb..514063fb54b3 100644
--- a/fs/nls/mac-greek.c
+++ b/fs/nls/mac-greek.c
@@ -11,7 +11,7 @@
  * COPYRIGHT AND PERMISSION NOTICE
  *
  * Copyright 1991-2012 Unicode, Inc.  All rights reserved.  Distributed under
- * the Terms of Use in http://www.unicode.org/copyright.html.
+ * the Terms of Use in https://www.unicode.org/copyright.html.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of the Unicode data files and any associated documentation (the "Data
diff --git a/fs/nls/mac-iceland.c b/fs/nls/mac-iceland.c
index cbd0875c6d69..1dc42186fac0 100644
--- a/fs/nls/mac-iceland.c
+++ b/fs/nls/mac-iceland.c
@@ -11,7 +11,7 @@
  * COPYRIGHT AND PERMISSION NOTICE
  *
  * Copyright 1991-2012 Unicode, Inc.  All rights reserved.  Distributed under
- * the Terms of Use in http://www.unicode.org/copyright.html.
+ * the Terms of Use in https://www.unicode.org/copyright.html.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of the Unicode data files and any associated documentation (the "Data
diff --git a/fs/nls/mac-inuit.c b/fs/nls/mac-inuit.c
index fba8357aaf03..6b6b71d9744e 100644
--- a/fs/nls/mac-inuit.c
+++ b/fs/nls/mac-inuit.c
@@ -11,7 +11,7 @@
  * COPYRIGHT AND PERMISSION NOTICE
  *
  * Copyright 1991-2012 Unicode, Inc.  All rights reserved.  Distributed under
- * the Terms of Use in http://www.unicode.org/copyright.html.
+ * the Terms of Use in https://www.unicode.org/copyright.html.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of the Unicode data files and any associated documentation (the "Data
diff --git a/fs/nls/mac-roman.c b/fs/nls/mac-roman.c
index b6a98a5208cd..b725bc18d0d5 100644
--- a/fs/nls/mac-roman.c
+++ b/fs/nls/mac-roman.c
@@ -11,7 +11,7 @@
  * COPYRIGHT AND PERMISSION NOTICE
  *
  * Copyright 1991-2012 Unicode, Inc.  All rights reserved.  Distributed under
- * the Terms of Use in http://www.unicode.org/copyright.html.
+ * the Terms of Use in https://www.unicode.org/copyright.html.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of the Unicode data files and any associated documentation (the "Data
diff --git a/fs/nls/mac-romanian.c b/fs/nls/mac-romanian.c
index 25547f023638..82716495c8a0 100644
--- a/fs/nls/mac-romanian.c
+++ b/fs/nls/mac-romanian.c
@@ -11,7 +11,7 @@
  * COPYRIGHT AND PERMISSION NOTICE
  *
  * Copyright 1991-2012 Unicode, Inc.  All rights reserved.  Distributed under
- * the Terms of Use in http://www.unicode.org/copyright.html.
+ * the Terms of Use in https://www.unicode.org/copyright.html.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of the Unicode data files and any associated documentation (the "Data
diff --git a/fs/nls/mac-turkish.c b/fs/nls/mac-turkish.c
index b5454bc7b7fa..bbea22dd852e 100644
--- a/fs/nls/mac-turkish.c
+++ b/fs/nls/mac-turkish.c
@@ -11,7 +11,7 @@
  * COPYRIGHT AND PERMISSION NOTICE
  *
  * Copyright 1991-2012 Unicode, Inc.  All rights reserved.  Distributed under
- * the Terms of Use in http://www.unicode.org/copyright.html.
+ * the Terms of Use in https://www.unicode.org/copyright.html.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of the Unicode data files and any associated documentation (the "Data
diff --git a/fs/nls/nls_iso8859-14.c b/fs/nls/nls_iso8859-14.c
index 046370f0b6f0..694a20fe710f 100644
--- a/fs/nls/nls_iso8859-14.c
+++ b/fs/nls/nls_iso8859-14.c
@@ -5,7 +5,7 @@
  *
  * Generated automatically from the Unicode and charset table
  * provided by the Unicode Organisation at
- * http://www.unicode.org/
+ * https://www.unicode.org/
  * The Unicode to charset table has only exact mappings.
  *
  * Rhys Jones, Swansea University Computer Society
diff --git a/fs/qnx6/Kconfig b/fs/qnx6/Kconfig
index 6a9d6bce1586..ff081dd0b074 100644
--- a/fs/qnx6/Kconfig
+++ b/fs/qnx6/Kconfig
@@ -5,7 +5,7 @@ config QNX6FS_FS
 	help
 	  This is the file system used by the real-time operating systems
 	  QNX 6 (also called QNX RTP).
-	  Further information is available at <http://www.qnx.com/>.
+	  Further information is available at <https://www.qnx.com/>.
 	  Say Y if you intend to mount QNX hard disks or floppies formatted
           with a mkqnx6fs.
 	  However, keep in mind that this currently is a readonly driver!
-- 
2.27.0

