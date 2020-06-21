Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551B4202AD3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgFUNqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 09:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbgFUNqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:46:25 -0400
X-Greylist: delayed 613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 Jun 2020 06:46:24 PDT
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB25FC061794
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2020 06:46:24 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 62C72467E1;
        Sun, 21 Jun 2020 13:36:03 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        David Sterba <dsterba@suse.com>, Rob Herring <robh@kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: Documentation/filesystems
Date:   Sun, 21 Jun 2020 15:35:52 +0200
Message-Id: <20200621133552.46371-1-grandmaster@al2klimov.de>
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

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Documentation/filesystems/hfs.rst                    | 2 +-
 Documentation/filesystems/hpfs.rst                   | 2 +-
 Documentation/filesystems/nfs/rpc-server-gss.rst     | 6 +++---
 Documentation/filesystems/path-lookup.rst            | 6 +++---
 Documentation/filesystems/ramfs-rootfs-initramfs.rst | 8 ++++----
 Documentation/filesystems/ubifs-authentication.rst   | 4 ++--
 Documentation/filesystems/vfs.rst                    | 6 +++---
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/hfs.rst b/Documentation/filesystems/hfs.rst
index ab17a005e9b1..776015c80e3f 100644
--- a/Documentation/filesystems/hfs.rst
+++ b/Documentation/filesystems/hfs.rst
@@ -76,7 +76,7 @@ Creating HFS filesystems
 
 The hfsutils package from Robert Leslie contains a program called
 hformat that can be used to create HFS filesystem. See
-<http://www.mars.org/home/rob/proj/hfs/> for details.
+<https://www.mars.org/home/rob/proj/hfs/> for details.
 
 
 Credits
diff --git a/Documentation/filesystems/hpfs.rst b/Documentation/filesystems/hpfs.rst
index 0db152278572..7e0dd2f4373e 100644
--- a/Documentation/filesystems/hpfs.rst
+++ b/Documentation/filesystems/hpfs.rst
@@ -7,7 +7,7 @@ Read/Write HPFS 2.09
 1998-2004, Mikulas Patocka
 
 :email: mikulas@artax.karlin.mff.cuni.cz
-:homepage: http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
+:homepage: https://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
 
 Credits
 =======
diff --git a/Documentation/filesystems/nfs/rpc-server-gss.rst b/Documentation/filesystems/nfs/rpc-server-gss.rst
index 812754576845..abed4a2b1b82 100644
--- a/Documentation/filesystems/nfs/rpc-server-gss.rst
+++ b/Documentation/filesystems/nfs/rpc-server-gss.rst
@@ -10,12 +10,12 @@ purposes of authentication.)
 
 RPCGSS is specified in a few IETF documents:
 
- - RFC2203 v1: http://tools.ietf.org/rfc/rfc2203.txt
- - RFC5403 v2: http://tools.ietf.org/rfc/rfc5403.txt
+ - RFC2203 v1: https://tools.ietf.org/rfc/rfc2203.txt
+ - RFC5403 v2: https://tools.ietf.org/rfc/rfc5403.txt
 
 and there is a 3rd version  being proposed:
 
- - http://tools.ietf.org/id/draft-williams-rpcsecgssv3.txt
+ - https://tools.ietf.org/id/draft-williams-rpcsecgssv3.txt
    (At draft n. 02 at the time of writing)
 
 Background
diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index f46b05e9b96c..1c552b97eb35 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -69,7 +69,7 @@ pathname that is just slashes have a final component.  If it does
 exist, it could be "``.``" or "``..``" which are handled quite differently
 from other components.
 
-.. _POSIX: http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_12
+.. _POSIX: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_12
 
 If a pathname ends with a slash, such as "``/tmp/foo/``" it might be
 tempting to consider that to have an empty final component.  In many
@@ -376,7 +376,7 @@ table, and the mount point hash table.
 Bringing it together with ``struct nameidata``
 ----------------------------------------------
 
-.. _First edition Unix: http://minnie.tuhs.org/cgi-bin/utree.pl?file=V1/u2.s
+.. _First edition Unix: https://minnie.tuhs.org/cgi-bin/utree.pl?file=V1/u2.s
 
 Throughout the process of walking a path, the current status is stored
 in a ``struct nameidata``, "namei" being the traditional name - dating
@@ -1265,7 +1265,7 @@ Symlinks are different it seems.  Both reading a symlink (with ``readlink()``)
 and looking up a symlink on the way to some other destination can
 update the atime on that symlink.
 
-.. _clearest statement: http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_08
+.. _clearest statement: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_08
 
 It is not clear why this is the case; POSIX has little to say on the
 subject.  The `clearest statement`_ is that, if a particular implementation
diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
index 3fddacc6bf14..4598b0d90b60 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -246,15 +246,15 @@ If you don't already understand what shared libraries, devices, and paths
 you need to get a minimal root filesystem up and running, here are some
 references:
 
-- http://www.tldp.org/HOWTO/Bootdisk-HOWTO/
-- http://www.tldp.org/HOWTO/From-PowerUp-To-Bash-Prompt-HOWTO.html
+- https://www.tldp.org/HOWTO/Bootdisk-HOWTO/
+- https://www.tldp.org/HOWTO/From-PowerUp-To-Bash-Prompt-HOWTO.html
 - http://www.linuxfromscratch.org/lfs/view/stable/
 
-The "klibc" package (http://www.kernel.org/pub/linux/libs/klibc) is
+The "klibc" package (https://www.kernel.org/pub/linux/libs/klibc) is
 designed to be a tiny C library to statically link early userspace
 code against, along with some related utilities.  It is BSD licensed.
 
-I use uClibc (http://www.uclibc.org) and busybox (http://www.busybox.net)
+I use uClibc (https://www.uclibc.org) and busybox (https://www.busybox.net)
 myself.  These are LGPL and GPL, respectively.  (A self-contained initramfs
 package is planned for the busybox 1.3 release.)
 
diff --git a/Documentation/filesystems/ubifs-authentication.rst b/Documentation/filesystems/ubifs-authentication.rst
index 16efd729bf7c..1f39c8cea702 100644
--- a/Documentation/filesystems/ubifs-authentication.rst
+++ b/Documentation/filesystems/ubifs-authentication.rst
@@ -433,9 +433,9 @@ will then have to be provided beforehand in the normal way.
 References
 ==========
 
-[CRYPTSETUP2]        http://www.saout.de/pipermail/dm-crypt/2017-November/005745.html
+[CRYPTSETUP2]        https://www.saout.de/pipermail/dm-crypt/2017-November/005745.html
 
-[DMC-CBC-ATTACK]     http://www.jakoblell.com/blog/2013/12/22/practical-malleability-attack-against-cbc-encrypted-luks-partitions/
+[DMC-CBC-ATTACK]     https://www.jakoblell.com/blog/2013/12/22/practical-malleability-attack-against-cbc-encrypted-luks-partitions/
 
 [DM-INTEGRITY]       https://www.kernel.org/doc/Documentation/device-mapper/dm-integrity.rst
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index ed17771c212b..16ca8792344b 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1431,13 +1431,13 @@ Resources
  version.)
 
 Creating Linux virtual filesystems. 2002
-    <http://lwn.net/Articles/13325/>
+    <https://lwn.net/Articles/13325/>
 
 The Linux Virtual File-system Layer by Neil Brown. 1999
     <http://www.cse.unsw.edu.au/~neilb/oss/linux-commentary/vfs.html>
 
 A tour of the Linux VFS by Michael K. Johnson. 1996
-    <http://www.tldp.org/LDP/khg/HyperNews/get/fs/vfstour.html>
+    <https://www.tldp.org/LDP/khg/HyperNews/get/fs/vfstour.html>
 
 A small trail through the Linux kernel by Andries Brouwer. 2001
-    <http://www.win.tue.nl/~aeb/linux/vfs/trail.html>
+    <https://www.win.tue.nl/~aeb/linux/vfs/trail.html>
-- 
2.27.0

