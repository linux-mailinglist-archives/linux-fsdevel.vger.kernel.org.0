Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A49161773
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgBQQNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TM/+7vTfsHEpAcMOa4KfCqPtaCRKLvnimk7V2AMAhG0=; b=V++KkF0d64mYaGGULeC86er3Wg
        5SP0kc5Dy192a6DY1BBdzNNGtl09YaMGZOKrpon2hWxcYyNL2Fe76jDMM73bVOh8ru5m43bqfaxC2
        YpoxHOc54y/Hj1Qn5ekcRjSlRg+X5V/dohW1TfMd0ROAdy0cpERv9EEcBVl9xUcWmM1q+LO5NbsG1
        CnqsnOIsLox7YvT09kaINO7gLBqUdsuLy9+uEh4OueS5v5VKp1y7APScXBgtLiwIc/C7me71emwFB
        JYfyeUQAaEPXsTlTfV0hubuh3g88NPXCKnpmPhPhtlfU/Ltmsynrj6uZn168bvqp3rXVqMO/ZGIsb
        YIg5VRxQ==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0b-0006uU-P4; Mon, 17 Feb 2020 16:12:33 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0Z-000fZc-Ra; Mon, 17 Feb 2020 17:12:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org
Subject: [PATCH 09/44] docs: filesystems: convert ceph.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:55 +0100
Message-Id: <df2f142b5ca5842e030d8209482dfd62dcbe020f.1581955849.git.mchehab+huawei@kernel.org>
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
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{ceph.txt => ceph.rst}        | 26 +++++++++++--------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 16 insertions(+), 11 deletions(-)
 rename Documentation/filesystems/{ceph.txt => ceph.rst} (91%)

diff --git a/Documentation/filesystems/ceph.txt b/Documentation/filesystems/ceph.rst
similarity index 91%
rename from Documentation/filesystems/ceph.txt
rename to Documentation/filesystems/ceph.rst
index b19b6a03f91c..b46a7218248f 100644
--- a/Documentation/filesystems/ceph.txt
+++ b/Documentation/filesystems/ceph.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
 Ceph Distributed File System
 ============================
 
@@ -15,6 +18,7 @@ Basic features include:
  * Easy deployment: most FS components are userspace daemons
 
 Also,
+
  * Flexible snapshots (on any directory)
  * Recursive accounting (nested files, directories, bytes)
 
@@ -63,7 +67,7 @@ no 'du' or similar recursive scan of the file system is required.
 Finally, Ceph also allows quotas to be set on any directory in the system.
 The quota can restrict the number of bytes or the number of files stored
 beneath that point in the directory hierarchy.  Quotas can be set using
-extended attributes 'ceph.quota.max_files' and 'ceph.quota.max_bytes', eg:
+extended attributes 'ceph.quota.max_files' and 'ceph.quota.max_bytes', eg::
 
  setfattr -n ceph.quota.max_bytes -v 100000000 /some/dir
  getfattr -n ceph.quota.max_bytes /some/dir
@@ -76,7 +80,7 @@ from writing as much data as it needs.
 Mount Syntax
 ============
 
-The basic mount syntax is:
+The basic mount syntax is::
 
  # mount -t ceph monip[:port][,monip2[:port]...]:/[subdir] mnt
 
@@ -84,7 +88,7 @@ You only need to specify a single monitor, as the client will get the
 full list when it connects.  (However, if the monitor you specify
 happens to be down, the mount won't succeed.)  The port can be left
 off if the monitor is using the default.  So if the monitor is at
-1.2.3.4,
+1.2.3.4::
 
  # mount -t ceph 1.2.3.4:/ /mnt/ceph
 
@@ -163,14 +167,14 @@ Mount Options
 	available modes are "no" and "clean". The default is "no".
 
 	* no: never attempt to reconnect when client detects that it has been
-	blacklisted. Operations will generally fail after being blacklisted.
+	  blacklisted. Operations will generally fail after being blacklisted.
 
 	* clean: client reconnects to the ceph cluster automatically when it
-	detects that it has been blacklisted. During reconnect, client drops
-	dirty data/metadata, invalidates page caches and writable file handles.
-	After reconnect, file locks become stale because the MDS loses track
-	of them. If an inode contains any stale file locks, read/write on the
-	inode is not allowed until applications release all stale file locks.
+	  detects that it has been blacklisted. During reconnect, client drops
+	  dirty data/metadata, invalidates page caches and writable file handles.
+	  After reconnect, file locks become stale because the MDS loses track
+	  of them. If an inode contains any stale file locks, read/write on the
+	  inode is not allowed until applications release all stale file locks.
 
 More Information
 ================
@@ -179,8 +183,8 @@ For more information on Ceph, see the home page at
 	https://ceph.com/
 
 The Linux kernel client source tree is available at
-	https://github.com/ceph/ceph-client.git
-	git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
+	- https://github.com/ceph/ceph-client.git
+	- git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
 
 and the source for the full system is at
 	https://github.com/ceph/ceph.git
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index dae862cf167e..ddd8f7b2bb25 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -55,6 +55,7 @@ Documentation for filesystem implementations.
    befs
    bfs
    btrfs
+   ceph
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

