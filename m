Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBB223C3A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgHECs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 22:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHECs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:48:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C78C06174A;
        Tue,  4 Aug 2020 19:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=45+4tsZh43voqjT3pyHG/7x1QXao2XdBpQJpfMWnUws=; b=gtSqY2NBABTLkNBfCxPB95KMUT
        sQe54gmhDEkq26K3Nai9vrsCgXEpFzZODeQdJoTX2n7kLGibiYhLrulxCDIdidU1yAD0o+5R8Lp8f
        DR3l/ktJdpMJ+aJEG/awzgolaYr+v4bO5CJdNaueEVKXm6l8G16/HtdzGxsZQuTKqhfi+4zSLD6lM
        f6XP+ISw3Hgj3nq1vxIRDQbinYvEQIg/x108fyHihZX9HhhW7GByCZW9g19GgcA6h8YIPnnFlFrwg
        UTtotBA4bAkeo3q68UZYuLxGCXSJ+V/WkPriHtr0ouf//PBb4RVCbMpF5cs+8nfe7RxEUNnD1wF6+
        NS6RHTcA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k39U5-0007TM-W2; Wed, 05 Aug 2020 02:48:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: delete duplicated words + other fixes
Date:   Tue,  4 Aug 2020 19:48:50 -0700
Message-Id: <20200805024850.12129-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Delete repeated words in fs/ext4/.
{the, this, of, we, after}

Also change spelling of "xttr" in inline.c to "xattr" in 2 places.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
---
 fs/ext4/extents.c  |    2 +-
 fs/ext4/indirect.c |    2 +-
 fs/ext4/inline.c   |    4 ++--
 fs/ext4/inode.c    |    2 +-
 fs/ext4/mballoc.c  |    4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

--- linux-next-20200804.orig/fs/ext4/extents.c
+++ linux-next-20200804/fs/ext4/extents.c
@@ -4029,7 +4029,7 @@ static int get_implied_cluster_alloc(str
  * down_read(&EXT4_I(inode)->i_data_sem) if not allocating file system block
  * (ie, create is zero). Otherwise down_write(&EXT4_I(inode)->i_data_sem)
  *
- * return > 0, number of of blocks already mapped/allocated
+ * return > 0, number of blocks already mapped/allocated
  *          if create == 0 and these are pre-allocated blocks
  *          	buffer head is unmapped
  *          otherwise blocks are mapped
--- linux-next-20200804.orig/fs/ext4/indirect.c
+++ linux-next-20200804/fs/ext4/indirect.c
@@ -1035,7 +1035,7 @@ static void ext4_free_branches(handle_t
 			brelse(bh);
 
 			/*
-			 * Everything below this this pointer has been
+			 * Everything below this pointer has been
 			 * released.  Now let this top-of-subtree go.
 			 *
 			 * We want the freeing of this indirect block to be
--- linux-next-20200804.orig/fs/ext4/inline.c
+++ linux-next-20200804/fs/ext4/inline.c
@@ -276,7 +276,7 @@ static int ext4_create_inline_data(handl
 		len = 0;
 	}
 
-	/* Insert the the xttr entry. */
+	/* Insert the xattr entry. */
 	i.value = value;
 	i.value_len = len;
 
@@ -354,7 +354,7 @@ static int ext4_update_inline_data(handl
 	if (error)
 		goto out;
 
-	/* Update the xttr entry. */
+	/* Update the xattr entry. */
 	i.value = value;
 	i.value_len = len;
 
--- linux-next-20200804.orig/fs/ext4/inode.c
+++ linux-next-20200804/fs/ext4/inode.c
@@ -2786,7 +2786,7 @@ retry:
 		 * ext4_journal_stop() can wait for transaction commit
 		 * to finish which may depend on writeback of pages to
 		 * complete or on page lock to be released.  In that
-		 * case, we have to wait until after after we have
+		 * case, we have to wait until after we have
 		 * submitted all the IO, released page locks we hold,
 		 * and dropped io_end reference (for extent conversion
 		 * to be able to complete) before stopping the handle.
--- linux-next-20200804.orig/fs/ext4/mballoc.c
+++ linux-next-20200804/fs/ext4/mballoc.c
@@ -124,7 +124,7 @@
  * /sys/fs/ext4/<partition>/mb_group_prealloc. The value is represented in
  * terms of number of blocks. If we have mounted the file system with -O
  * stripe=<value> option the group prealloc request is normalized to the
- * the smallest multiple of the stripe value (sbi->s_stripe) which is
+ * smallest multiple of the stripe value (sbi->s_stripe) which is
  * greater than the default mb_group_prealloc.
  *
  * The regular allocator (using the buddy cache) supports a few tunables.
@@ -2026,7 +2026,7 @@ void ext4_mb_complex_scan_group(struct e
 			/*
 			 * IF we have corrupt bitmap, we won't find any
 			 * free blocks even though group info says we
-			 * we have free blocks
+			 * have free blocks
 			 */
 			ext4_grp_locked_error(sb, e4b->bd_group, 0, 0,
 					"%d free clusters as per "
