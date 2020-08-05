Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A953023C3A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 04:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgHECsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 22:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHECsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:48:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA80C06174A;
        Tue,  4 Aug 2020 19:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=WAQQ1Eowx4V82r2Qp2tbmfcB9Cjqkc3KDQfMdhLLOUY=; b=DenYh5E88vIxUC/ceFOInNllBG
        I0FgkdTEDW+o+d/7atIENwXR9Eqvyp48arimamyOwLwFw36HpF0bcwOUlGJi3HXefJHo5UNcwbaht
        jEm+axkYQE8NPhU7QehI08f9nEKo9scKk+YPhcz1lbxyipoABXrHdmy5ywpQrP5BVyyUJvfl+ojan
        354CCLZKtebMKggRfNAuDqC4ff98zngR8RY9EKg1uwbBJneUvtutz17X0RoxpbFLap1uchbOzPQNj
        s7IpzSdGaXJ7bHqrl/3h6N/cBDPHW9OT3pFV2BjAoVPh4FpZrRqXUn2BBj6Bo8gL5NujEl4g2ek59
        aBYQNhtA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k39Ts-0007Sd-GT; Wed, 05 Aug 2020 02:48:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: delete duplicated words + other fixes
Date:   Tue,  4 Aug 2020 19:48:34 -0700
Message-Id: <20200805024834.12078-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Delete repeated words in fs/btrfs/.
{to, the, a, and old}
and change "into 2 part" to "into 2 parts".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
---
 fs/btrfs/block-group.c      |    2 +-
 fs/btrfs/ctree.c            |    2 +-
 fs/btrfs/disk-io.c          |    2 +-
 fs/btrfs/extent_io.c        |    2 +-
 fs/btrfs/free-space-cache.c |    2 +-
 fs/btrfs/qgroup.c           |    2 +-
 fs/btrfs/tree-log.c         |    4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

--- linux-next-20200804.orig/fs/btrfs/block-group.c
+++ linux-next-20200804/fs/btrfs/block-group.c
@@ -2783,7 +2783,7 @@ int btrfs_write_dirty_block_groups(struc
 			 * finished yet (no block group item in the extent tree
 			 * yet, etc). If this is the case, wait for all free
 			 * space endio workers to finish and retry. This is a
-			 * a very rare case so no need for a more efficient and
+			 * very rare case so no need for a more efficient and
 			 * complex approach.
 			 */
 			if (ret == -ENOENT) {
--- linux-next-20200804.orig/fs/btrfs/ctree.c
+++ linux-next-20200804/fs/btrfs/ctree.c
@@ -5111,7 +5111,7 @@ again:
 			slot--;
 		/*
 		 * check this node pointer against the min_trans parameters.
-		 * If it is too old, old, skip to the next one.
+		 * If it is too old, skip to the next one.
 		 */
 		while (slot < nritems) {
 			u64 gen;
--- linux-next-20200804.orig/fs/btrfs/disk-io.c
+++ linux-next-20200804/fs/btrfs/disk-io.c
@@ -2929,7 +2929,7 @@ int __cold open_ctree(struct super_block
 	}
 
 	/*
-	 * Verify the type first, if that or the the checksum value are
+	 * Verify the type first, if that or the checksum value are
 	 * corrupted, we'll find out
 	 */
 	csum_type = btrfs_super_csum_type(disk_super);
--- linux-next-20200804.orig/fs/btrfs/extent_io.c
+++ linux-next-20200804/fs/btrfs/extent_io.c
@@ -3241,7 +3241,7 @@ static int __do_readpage(struct page *pa
 
 		/*
 		 * If we have a file range that points to a compressed extent
-		 * and it's followed by a consecutive file range that points to
+		 * and it's followed by a consecutive file range that points
 		 * to the same compressed extent (possibly with a different
 		 * offset and/or length, so it either points to the whole extent
 		 * or only part of it), we must make sure we do not submit a
--- linux-next-20200804.orig/fs/btrfs/free-space-cache.c
+++ linux-next-20200804/fs/btrfs/free-space-cache.c
@@ -1353,7 +1353,7 @@ static int __btrfs_write_out_cache(struc
 
 	/*
 	 * at this point the pages are under IO and we're happy,
-	 * The caller is responsible for waiting on them and updating the
+	 * The caller is responsible for waiting on them and updating
 	 * the cache and the inode
 	 */
 	io_ctl->entries = entries;
--- linux-next-20200804.orig/fs/btrfs/qgroup.c
+++ linux-next-20200804/fs/btrfs/qgroup.c
@@ -2315,7 +2315,7 @@ static int qgroup_update_refcnt(struct b
  * Update qgroup rfer/excl counters.
  * Rfer update is easy, codes can explain themselves.
  *
- * Excl update is tricky, the update is split into 2 part.
+ * Excl update is tricky, the update is split into 2 parts.
  * Part 1: Possible exclusive <-> sharing detect:
  *	|	A	|	!A	|
  *  -------------------------------------
--- linux-next-20200804.orig/fs/btrfs/tree-log.c
+++ linux-next-20200804/fs/btrfs/tree-log.c
@@ -4881,7 +4881,7 @@ static int log_conflicting_inodes(struct
 		 * Check the inode's logged_trans only instead of
 		 * btrfs_inode_in_log(). This is because the last_log_commit of
 		 * the inode is not updated when we only log that it exists and
-		 * and it has the full sync bit set (see btrfs_log_inode()).
+		 * it has the full sync bit set (see btrfs_log_inode()).
 		 */
 		if (BTRFS_I(inode)->logged_trans == trans->transid) {
 			spin_unlock(&BTRFS_I(inode)->lock);
@@ -6378,7 +6378,7 @@ void btrfs_record_snapshot_destroy(struc
  *            committed by the caller, and BTRFS_DONT_NEED_TRANS_COMMIT
  *            otherwise.
  * When false: returns BTRFS_DONT_NEED_LOG_SYNC if the caller does not need to
- *             to sync the log, BTRFS_NEED_LOG_SYNC if it needs to sync the log,
+ *             sync the log, BTRFS_NEED_LOG_SYNC if it needs to sync the log,
  *             or BTRFS_NEED_TRANS_COMMIT if the transaction needs to be
  *             committed (without attempting to sync the log).
  */
