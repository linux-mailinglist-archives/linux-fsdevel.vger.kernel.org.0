Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDD339504
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfFGS43 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 14:56:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732066AbfFGSyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/7dqPwrQ7gR2T9mrau0LVVW5XMBZ6q95lcp2shiZP6k=; b=RA5fNz93EZhfqLReZosTU9lxb4
        lHhw52TA6t8IJPL/yvJ6gX0tUgpN17RzyyN3UdbVP0bg6gt1qFH72XFFrakvYEpqvlaR8W5Prd0Y7
        aw3X8pVVDv4gFN1tXG7SVFPbxaU6sUS6EpE8tR0q+ZR3V5ugc21P17Xe5Y0zoHwGDYKiGwwNdXclw
        RPsvenX0AgTGP79QvJVViyWNAyotfjMQ6Qm7DZG7/7gmhFK+HkUfi2mFlidQQdYH2Y3DJeKQEw1Ib
        Qqb9R/btgqNvxJC9sepdA5Gn6O1rYo54/Ae3z/x+rlGePYif0PKJzZecFV7PS0qlhL2KRHQFmyNvO
        +Mr2mFfQ==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005sl-Mo; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007Fj-Mg; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 19/20] docs: fs: fix broken links to vfs.txt with was renamed to vfs.rst
Date:   Fri,  7 Jun 2019 15:54:35 -0300
Message-Id: <12e5f1741401204539320f7686d5a20e7463a0b1.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A recent documentation conversion renamed this file but forgot
to update the links.

Fixes: af96c1e304f7 ("docs: filesystems: vfs: Convert vfs.txt to RST")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/filesystems/porting | 10 +++++-----
 include/linux/dcache.h            |  4 ++--
 include/linux/fs.h                |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/porting b/Documentation/filesystems/porting
index 3bd1148d8bb6..2813a19389fe 100644
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -330,14 +330,14 @@ unreferenced dentries, and is now only called when the dentry refcount goes to
 [mandatory]
 
 	.d_compare() calling convention and locking rules are significantly
-changed. Read updated documentation in Documentation/filesystems/vfs.txt (and
+changed. Read updated documentation in Documentation/filesystems/vfs.rst (and
 look at examples of other filesystems) for guidance.
 
 ---
 [mandatory]
 
 	.d_hash() calling convention and locking rules are significantly
-changed. Read updated documentation in Documentation/filesystems/vfs.txt (and
+changed. Read updated documentation in Documentation/filesystems/vfs.rst (and
 look at examples of other filesystems) for guidance.
 
 ---
@@ -377,12 +377,12 @@ where possible.
 the filesystem provides it), which requires dropping out of rcu-walk mode. This
 may now be called in rcu-walk mode (nd->flags & LOOKUP_RCU). -ECHILD should be
 returned if the filesystem cannot handle rcu-walk. See
-Documentation/filesystems/vfs.txt for more details.
+Documentation/filesystems/vfs.rst for more details.
 
 	permission is an inode permission check that is called on many or all
 directory inodes on the way down a path walk (to check for exec permission). It
 must now be rcu-walk aware (mask & MAY_NOT_BLOCK).  See
-Documentation/filesystems/vfs.txt for more details.
+Documentation/filesystems/vfs.rst for more details.
  
 --
 [mandatory]
@@ -625,7 +625,7 @@ in your dentry operations instead.
 --
 [mandatory]
 	->clone_file_range() and ->dedupe_file_range have been replaced with
-	->remap_file_range().  See Documentation/filesystems/vfs.txt for more
+	->remap_file_range().  See Documentation/filesystems/vfs.rst for more
 	information.
 --
 [recommended]
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f14e587c5d5d..5e0eadf7de55 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -153,7 +153,7 @@ struct dentry_operations {
  * Locking rules for dentry_operations callbacks are to be found in
  * Documentation/filesystems/Locking. Keep it updated!
  *
- * FUrther descriptions are found in Documentation/filesystems/vfs.txt.
+ * FUrther descriptions are found in Documentation/filesystems/vfs.rst.
  * Keep it updated too!
  */
 
@@ -568,7 +568,7 @@ static inline struct dentry *d_backing_dentry(struct dentry *upper)
  * If dentry is on a union/overlay, then return the underlying, real dentry.
  * Otherwise return the dentry itself.
  *
- * See also: Documentation/filesystems/vfs.txt
+ * See also: Documentation/filesystems/vfs.rst
  */
 static inline struct dentry *d_real(struct dentry *dentry,
 				    const struct inode *inode)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..c564cf3f48d9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1769,7 +1769,7 @@ struct block_device_operations;
 /*
  * These flags control the behavior of the remap_file_range function pointer.
  * If it is called with len == 0 that means "remap to end of source file".
- * See Documentation/filesystems/vfs.txt for more details about this call.
+ * See Documentation/filesystems/vfs.rst for more details about this call.
  *
  * REMAP_FILE_DEDUP: only remap if contents identical (i.e. deduplicate)
  * REMAP_FILE_CAN_SHORTEN: caller can handle a shortened request
-- 
2.21.0

