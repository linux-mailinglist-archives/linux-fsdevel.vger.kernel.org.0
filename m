Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCB23C3AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 04:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHECte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 22:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHECtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:49:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3CCC06174A;
        Tue,  4 Aug 2020 19:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=CSearbpv8lpytwRyxAxVfHTq08ceNhBEmFsoZJbUn6A=; b=jrizglumKXOO/GgL+5pNdR4Fhd
        /3IzV/EkxjQPFAy2yJnxqSNvnZdoGtRBGA64UFp8bU51Inpmt4pyDkFVRVgLSE0n8tKkbALlftjSR
        SLdRkoYSUr9021QfQ80EBujA5nAkTYJ3MUzF51//r1bf9sj6YdTdlhsVEnly79DIwVqz/lf4UuY7T
        knqczdvwo0aWMEXNSkqVOJhSVDjwYD6QcpkwoMQaPQfhZWeTRbOaKFJ/GxSws0u76s4NwQOoE/oT5
        zyiT0ksEredd84oG7S80jKGWbq8mrjSS4Ylt78EMEWaV4lnQuxLsZ19uYwZA2dvkjI27OE/lDxDsq
        CzxOjWRw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k39Uf-0007Vi-5L; Wed, 05 Aug 2020 02:49:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jan Kara <jack@suse.com>,
        Jeff Mahoney <jeffm@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH] reiserfs: delete duplicated words
Date:   Tue,  4 Aug 2020 19:49:25 -0700
Message-Id: <20200805024925.12281-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Delete repeated words in fs/reiserfs/.
{from, not, we, are}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>
Cc: Jeff Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: reiserfs-devel@vger.kernel.org
---
 fs/reiserfs/dir.c       |    8 ++++----
 fs/reiserfs/fix_node.c  |    4 ++--
 fs/reiserfs/journal.c   |    2 +-
 fs/reiserfs/xattr_acl.c |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

--- linux-next-20200804.orig/fs/reiserfs/dir.c
+++ linux-next-20200804/fs/reiserfs/dir.c
@@ -289,7 +289,7 @@ void make_empty_dir_item_v1(char *body,
 
 	/* direntry header of "." */
 	put_deh_offset(dot, DOT_OFFSET);
-	/* these two are from make_le_item_head, and are are LE */
+	/* these two are from make_le_item_head, and are LE */
 	dot->deh_dir_id = dirid;
 	dot->deh_objectid = objid;
 	dot->deh_state = 0;	/* Endian safe if 0 */
@@ -299,7 +299,7 @@ void make_empty_dir_item_v1(char *body,
 	/* direntry header of ".." */
 	put_deh_offset(dotdot, DOT_DOT_OFFSET);
 	/* key of ".." for the root directory */
-	/* these two are from the inode, and are are LE */
+	/* these two are from the inode, and are LE */
 	dotdot->deh_dir_id = par_dirid;
 	dotdot->deh_objectid = par_objid;
 	dotdot->deh_state = 0;	/* Endian safe if 0 */
@@ -323,7 +323,7 @@ void make_empty_dir_item(char *body, __l
 
 	/* direntry header of "." */
 	put_deh_offset(dot, DOT_OFFSET);
-	/* these two are from make_le_item_head, and are are LE */
+	/* these two are from make_le_item_head, and are LE */
 	dot->deh_dir_id = dirid;
 	dot->deh_objectid = objid;
 	dot->deh_state = 0;	/* Endian safe if 0 */
@@ -333,7 +333,7 @@ void make_empty_dir_item(char *body, __l
 	/* direntry header of ".." */
 	put_deh_offset(dotdot, DOT_DOT_OFFSET);
 	/* key of ".." for the root directory */
-	/* these two are from the inode, and are are LE */
+	/* these two are from the inode, and are LE */
 	dotdot->deh_dir_id = par_dirid;
 	dotdot->deh_objectid = par_objid;
 	dotdot->deh_state = 0;	/* Endian safe if 0 */
--- linux-next-20200804.orig/fs/reiserfs/fix_node.c
+++ linux-next-20200804/fs/reiserfs/fix_node.c
@@ -611,9 +611,9 @@ static int get_num_ver(int mode, struct
  *	blk_num	number of blocks that S[h] will be splitted into;
  *	s012	number of items that fall into splitted nodes.
  *	lbytes	number of bytes which flow to the left neighbor from the
- *              item that is not not shifted entirely
+ *              item that is not shifted entirely
  *	rbytes	number of bytes which flow to the right neighbor from the
- *              item that is not not shifted entirely
+ *              item that is not shifted entirely
  *	s1bytes	number of bytes which flow to the first  new node when
  *              S[0] splits (this number is contained in s012 array)
  */
--- linux-next-20200804.orig/fs/reiserfs/journal.c
+++ linux-next-20200804/fs/reiserfs/journal.c
@@ -32,7 +32,7 @@
  *                      to disk for all backgrounded commits that have been
  *                      around too long.
  *		     -- Note, if you call this as an immediate flush from
- *		        from within kupdate, it will ignore the immediate flag
+ *		        within kupdate, it will ignore the immediate flag
  */
 
 #include <linux/time.h>
--- linux-next-20200804.orig/fs/reiserfs/xattr_acl.c
+++ linux-next-20200804/fs/reiserfs/xattr_acl.c
@@ -373,7 +373,7 @@ int reiserfs_cache_default_acl(struct in
 
 		/* Other xattrs can be created during inode creation. We don't
 		 * want to claim too many blocks, so we check to see if we
-		 * we need to create the tree to the xattrs, and then we
+		 * need to create the tree to the xattrs, and then we
 		 * just want two files. */
 		nblocks = reiserfs_xattr_jcreate_nblocks(inode);
 		nblocks += JOURNAL_BLOCKS_PER_OBJECT(inode->i_sb);
