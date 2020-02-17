Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4718161757
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgBQQNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=j2+Du2BNy7wViueNGcfDnpMtphEaIAxheVzQhudV/hA=; b=GgaenXaugBWOmmES39OOJg6i2l
        15KBPt+VQrbbOYwJO3VZqJb3OnadUW4G9pecA8rArftRKhDWvnqnd7HtSu+OuKNgMnKjakoU0cZCW
        s4yj2Sv9EdWK3fHAl5eWbjb8k/YNZYOGNr1+BHSjpOxGk4p/jTk1N3ItTJ0PfIWK5e3cqxSFx3HP0
        7K4eT6MPjNRXScXuU9FSJSHJ27509wC+StbhfRy+Dt2LXFm6wYWMN+ClasOV4UQfOpEytwU5kvmdq
        waa0LG0vDC8arpbhjjbBIiWxmMEXEhDzIBIKxiNk9e/LKswoILNtmeZYnOa01ng35d7yU/quP4L+P
        ytU3b2Cw==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006uh-9f; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000faS-CM; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 19/44] docs: filesystems: convert gfs2.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:05 +0100
Message-Id: <6d7a296de025bcfed7a229da7f8cc1678944f304.1581955849.git.mchehab+huawei@kernel.org>
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
- Add table markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{gfs2.txt => gfs2.rst}        | 20 +++++++++++++------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)
 rename Documentation/filesystems/{gfs2.txt => gfs2.rst} (76%)

diff --git a/Documentation/filesystems/gfs2.txt b/Documentation/filesystems/gfs2.rst
similarity index 76%
rename from Documentation/filesystems/gfs2.txt
rename to Documentation/filesystems/gfs2.rst
index cc4f2306609e..8d1ab589ce18 100644
--- a/Documentation/filesystems/gfs2.txt
+++ b/Documentation/filesystems/gfs2.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
 Global File System
-------------------
+==================
 
 https://fedorahosted.org/cluster/wiki/HomePage
 
@@ -14,16 +17,18 @@ on one machine show up immediately on all other machines in the cluster.
 GFS uses interchangeable inter-node locking mechanisms, the currently
 supported mechanisms are:
 
-  lock_nolock -- allows gfs to be used as a local file system
+  lock_nolock
+    - allows gfs to be used as a local file system
 
-  lock_dlm -- uses a distributed lock manager (dlm) for inter-node locking
-  The dlm is found at linux/fs/dlm/
+  lock_dlm
+    - uses a distributed lock manager (dlm) for inter-node locking.
+      The dlm is found at linux/fs/dlm/
 
 Lock_dlm depends on user space cluster management systems found
 at the URL above.
 
 To use gfs as a local file system, no external clustering systems are
-needed, simply:
+needed, simply::
 
   $ mkfs -t gfs2 -p lock_nolock -j 1 /dev/block_device
   $ mount -t gfs2 /dev/block_device /dir
@@ -37,9 +42,12 @@ GFS2 is not on-disk compatible with previous versions of GFS, but it
 is pretty close.
 
 The following man pages can be found at the URL above:
+
+  ============		=============================================
   fsck.gfs2		to repair a filesystem
   gfs2_grow		to expand a filesystem online
   gfs2_jadd		to add journals to a filesystem online
   tunegfs2		to manipulate, examine and tune a filesystem
-  gfs2_convert	to convert a gfs filesystem to gfs2 in-place
+  gfs2_convert		to convert a gfs filesystem to gfs2 in-place
   mkfs.gfs2		to make a filesystem
+  ============		=============================================
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f69d20406be0..f24befe78326 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -65,6 +65,7 @@ Documentation for filesystem implementations.
    ext2
    ext3
    f2fs
+   gfs2
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

