Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A32161776
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgBQQNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=n3OHHKHQGHUcansjehJKA6e6cfXC7iQMHoNdNp59CMg=; b=bYrIFGs8GrTjw4I8PIA47Wqa3i
        orFDB1PWN0qzOUKmTiNGKZthhhYaKvlY9vBOffJZbvw4YwYzQqomUT7jMvkEunfgAoWlG7vsrErH+
        yjhxDUU0BvCgGmd3HLYVVc98wr47Mc2tTt1DfGwyqg9K64MAhyGn9g6ee9rtv9/K5KD36Zg2RnDwg
        1kHkB6Zvusy84duZfkCVksCYxkWDydlxGozS5v8BsRkrC6J03jT+oAgOlbpj0X+GVdXivsHXmBxhB
        n7N2sjZoAVnl1V8JOU42uNSH/KiUzTsflOG3HqyIPv5S02Y27Swkw9oiALpJnbZq+WDBQOPdNwmsB
        xDPiPOiw==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006uR-6R; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0Z-000fZN-Nk; Mon, 17 Feb 2020 17:12:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>
Subject: [PATCH 06/44] docs: filesystems: convert befs.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:52 +0100
Message-Id: <3e29ea6df6cd569021cfa953ccb8ed7dfc146f3d.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Adjust document and section titles;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{befs.txt => befs.rst}        | 59 +++++++++++--------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 36 insertions(+), 24 deletions(-)
 rename Documentation/filesystems/{befs.txt => befs.rst} (83%)

diff --git a/Documentation/filesystems/befs.txt b/Documentation/filesystems/befs.rst
similarity index 83%
rename from Documentation/filesystems/befs.txt
rename to Documentation/filesystems/befs.rst
index da45e6c842b8..79f9740d76ff 100644
--- a/Documentation/filesystems/befs.txt
+++ b/Documentation/filesystems/befs.rst
@@ -1,48 +1,54 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
 BeOS filesystem for Linux
+=========================
 
 Document last updated: Dec 6, 2001
 
-WARNING
+Warning
 =======
 Make sure you understand that this is alpha software.  This means that the
-implementation is neither complete nor well-tested. 
+implementation is neither complete nor well-tested.
 
 I DISCLAIM ALL RESPONSIBILITY FOR ANY POSSIBLE BAD EFFECTS OF THIS CODE!
 
-LICENSE
-=====
-This software is covered by the GNU General Public License. 
+License
+=======
+This software is covered by the GNU General Public License.
 See the file COPYING for the complete text of the license.
 Or the GNU website: <http://www.gnu.org/licenses/licenses.html>
 
-AUTHOR
-=====
+Author
+======
 The largest part of the code written by Will Dyson <will_dyson@pobox.com>
 He has been working on the code since Aug 13, 2001. See the changelog for
 details.
 
 Original Author: Makoto Kato <m_kato@ga2.so-net.ne.jp>
+
 His original code can still be found at:
 <http://hp.vector.co.jp/authors/VA008030/bfs/>
+
 Does anyone know of a more current email address for Makoto? He doesn't
 respond to the address given above...
 
 This filesystem doesn't have a maintainer.
 
-WHAT IS THIS DRIVER?
-==================
-This module implements the native filesystem of BeOS http://www.beincorporated.com/ 
+What is this Driver?
+====================
+This module implements the native filesystem of BeOS http://www.beincorporated.com/
 for the linux 2.4.1 and later kernels. Currently it is a read-only
 implementation.
 
 Which is it, BFS or BEFS?
-================
-Be, Inc said, "BeOS Filesystem is officially called BFS, not BeFS". 
+=========================
+Be, Inc said, "BeOS Filesystem is officially called BFS, not BeFS".
 But Unixware Boot Filesystem is called bfs, too. And they are already in
 the kernel. Because of this naming conflict, on Linux the BeOS
 filesystem is called befs.
 
-HOW TO INSTALL
+How to Install
 ==============
 step 1.  Install the BeFS  patch into the source code tree of linux.
 
@@ -54,16 +60,16 @@ is called patch-befs-xxx, you would do the following:
 	patch -p1 < /path/to/patch-befs-xxx
 
 if the patching step fails (i.e. there are rejected hunks), you can try to
-figure it out yourself (it shouldn't be hard), or mail the maintainer 
+figure it out yourself (it shouldn't be hard), or mail the maintainer
 (Will Dyson <will_dyson@pobox.com>) for help.
 
 step 2.  Configuration & make kernel
 
 The linux kernel has many compile-time options. Most of them are beyond the
 scope of this document. I suggest the Kernel-HOWTO document as a good general
-reference on this topic. http://www.linuxdocs.org/HOWTOs/Kernel-HOWTO-4.html 
+reference on this topic. http://www.linuxdocs.org/HOWTOs/Kernel-HOWTO-4.html
 
-However, to use the BeFS module, you must enable it at configure time.
+However, to use the BeFS module, you must enable it at configure time::
 
 	cd /foo/bar/linux
 	make menuconfig (or xconfig)
@@ -82,35 +88,40 @@ step 3.  Install
 See the kernel howto <http://www.linux.com/howto/Kernel-HOWTO.html> for
 instructions on this critical step.
 
-USING BFS
+Using BFS
 =========
 To use the BeOS filesystem, use filesystem type 'befs'.
 
-ex)
+ex::
+
     mount -t befs /dev/fd0 /beos
 
-MOUNT OPTIONS
+Mount Options
 =============
+
+=============  ===========================================================
 uid=nnn        All files in the partition will be owned by user id nnn.
 gid=nnn	       All files in the partition will be in group nnn.
 iocharset=xxx  Use xxx as the name of the NLS translation table.
 debug          The driver will output debugging information to the syslog.
+=============  ===========================================================
 
-HOW TO GET LASTEST VERSION
+How to Get Lastest Version
 ==========================
 
 The latest version is currently available at:
 <http://befs-driver.sourceforge.net/>
 
-ANY KNOWN BUGS?
-===========
+Any Known Bugs?
+===============
 As of Jan 20, 2002:
-	
+
 	None
 
-SPECIAL THANKS
+Special Thanks
 ==============
 Dominic Giampalo ... Writing "Practical file system design with Be filesystem"
+
 Hiroyuki Yamada  ... Testing LinuxPPC.
 
 
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index c9480138d47e..98de437f5500 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -52,6 +52,7 @@ Documentation for filesystem implementations.
    afs
    autofs
    autofs-mount-control
+   befs
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

