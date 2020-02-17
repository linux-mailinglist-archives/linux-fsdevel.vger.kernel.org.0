Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4D161758
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgBQQNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Js8wnfpNmhMVRnwBxcUOBrEuHusxb+2FUX7Oyqu9/OI=; b=D3JVj2sPvh+T4sUVEGBcoasUTU
        n5+OmMHN0qMUmbsxfAd0Zzn7Twvy3O69Mwdfk2yXeIiOypu6bkwNAT2X6q26n5JkmK1ogI4KMAys8
        04OIOHBLlPtzf5uZnEmmmxVdaoCV0fqK+3Tb2FBSNyfYirjrbayh0ssfHC4XTUGnqCap8vPFRqx4H
        GquTjfZfzlDhbuVf+RboREuB9aQfLiAe5emKUFUWakCo34hr8uugnqE/iHPGbiyzF1u2dlcRf1dUO
        iry+3/DZyeolTNW1aMt4dqH5hM4Gze+In5069mQ3uIEvEnhLBUHwJbLNwvVTXmDTW46r7f7Ll9ybZ
        ZgdrI8aA==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006ui-CL; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000faX-Dy; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 20/44] docs: filesystems: convert gfs2-uevents.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:06 +0100
Message-Id: <1d1c46b7e86bd0a18d9abbea0de0bc2be84e5e2b.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This document is almost in ReST format: all it needs is to have
the titles adjusted and add a SPDX header. In other words:

- Add a SPDX header;
- Add a document title;
- Adjust section titles;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{gfs2-uevents.txt => gfs2-uevents.rst}    | 20 +++++++++++++++----
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)
 rename Documentation/filesystems/{gfs2-uevents.txt => gfs2-uevents.rst} (94%)

diff --git a/Documentation/filesystems/gfs2-uevents.txt b/Documentation/filesystems/gfs2-uevents.rst
similarity index 94%
rename from Documentation/filesystems/gfs2-uevents.txt
rename to Documentation/filesystems/gfs2-uevents.rst
index 19a19ebebc34..f162a2c76c69 100644
--- a/Documentation/filesystems/gfs2-uevents.txt
+++ b/Documentation/filesystems/gfs2-uevents.rst
@@ -1,14 +1,18 @@
-                              uevents and GFS2
-                             ==================
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+uevents and GFS2
+================
 
 During the lifetime of a GFS2 mount, a number of uevents are generated.
 This document explains what the events are and what they are used
 for (by gfs_controld in gfs2-utils).
 
 A list of GFS2 uevents
------------------------
+======================
 
 1. ADD
+------
 
 The ADD event occurs at mount time. It will always be the first
 uevent generated by the newly created filesystem. If the mount
@@ -21,6 +25,7 @@ with no journal assigned), and read-only (with journal assigned) status
 of the filesystem respectively.
 
 2. ONLINE
+---------
 
 The ONLINE uevent is generated after a successful mount or remount. It
 has the same environment variables as the ADD uevent. The ONLINE
@@ -29,6 +34,7 @@ RDONLY are a relatively recent addition (2.6.32-rc+) and will not
 be generated by older kernels.
 
 3. CHANGE
+---------
 
 The CHANGE uevent is used in two places. One is when reporting the
 successful mount of the filesystem by the first node (FIRSTMOUNT=Done).
@@ -52,6 +58,7 @@ cluster. For this reason the ONLINE uevent was used when adding a new
 uevent for a successful mount or remount.
 
 4. OFFLINE
+----------
 
 The OFFLINE uevent is only generated due to filesystem errors and is used
 as part of the "withdraw" mechanism. Currently this doesn't give any
@@ -59,6 +66,7 @@ information about what the error is, which is something that needs to
 be fixed.
 
 5. REMOVE
+---------
 
 The REMOVE uevent is generated at the end of an unsuccessful mount
 or at the end of a umount of the filesystem. All REMOVE uevents will
@@ -68,9 +76,10 @@ kobject subsystem.
 
 
 Information common to all GFS2 uevents (uevent environment variables)
-----------------------------------------------------------------------
+=====================================================================
 
 1. LOCKTABLE=
+--------------
 
 The LOCKTABLE is a string, as supplied on the mount command
 line (locktable=) or via fstab. It is used as a filesystem label
@@ -78,6 +87,7 @@ as well as providing the information for a lock_dlm mount to be
 able to join the cluster.
 
 2. LOCKPROTO=
+-------------
 
 The LOCKPROTO is a string, and its value depends on what is set
 on the mount command line, or via fstab. It will be either
@@ -85,12 +95,14 @@ lock_nolock or lock_dlm. In the future other lock managers
 may be supported.
 
 3. JOURNALID=
+-------------
 
 If a journal is in use by the filesystem (journals are not
 assigned for spectator mounts) then this will give the
 numeric journal id in all GFS2 uevents.
 
 4. UUID=
+--------
 
 With recent versions of gfs2-utils, mkfs.gfs2 writes a UUID
 into the filesystem superblock. If it exists, this will
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f24befe78326..c16e517e37c5 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -66,6 +66,7 @@ Documentation for filesystem implementations.
    ext3
    f2fs
    gfs2
+   gfs2-uevents
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

