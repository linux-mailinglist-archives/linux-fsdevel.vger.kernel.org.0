Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA27223C3AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHECtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 22:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHECtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:49:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EC3C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 19:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5DypN0ijHBHZ/kAe3LdCZQtmJcp7UEsHJipKJHyPuuQ=; b=kKh9f2l/S0/nSj/UvVZxlyJJtj
        y1dcDO6LAfTSCckksXAC7RNnkefLKfR5SAiTC+BeGSg7n722Aoav10+giskT2J205FGYFMuHn3gW4
        EJ0B/taRpqUge0VNvNtc2ojYnFBaM/8UjjWGszx83j3/GYkdBBlHVodz2PIDWS3lN3qCUHO2cgcWc
        qyXT1lgzuF28bKN8IzIg58AQFs9jCuS8TAfGpmSdP3x8K/KE3loJw4UBbJ9XnybT0BmoiatAuOw1P
        nVZUZmacJAKplH6RKk9VPWjEencKD2Fvqg584u8rTgjlcm7r/QsUQxDWxkTwZa7OUJvKo8UxwQYQW
        UWEu6F/w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k39UG-0007Ux-TU; Wed, 05 Aug 2020 02:49:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH] jfs: delete duplicated words + other fixes
Date:   Tue,  4 Aug 2020 19:49:01 -0700
Message-Id: <20200805024901.12181-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Delete repeated words in fs/jfs/.
{for, allocation, if, the}
Insert "is" in one place to correct the grammar.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net
---
 fs/jfs/jfs_dmap.c   |    2 +-
 fs/jfs/jfs_extent.c |    2 +-
 fs/jfs/jfs_extent.h |    2 +-
 fs/jfs/jfs_logmgr.h |    2 +-
 fs/jfs/jfs_txnmgr.c |    2 +-
 fs/jfs/jfs_xtree.c  |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20200804.orig/fs/jfs/jfs_dmap.c
+++ linux-next-20200804/fs/jfs/jfs_dmap.c
@@ -668,7 +668,7 @@ unlock:
  *		this does not succeed, we finally try to allocate anywhere
  *		within the aggregate.
  *
- *		we also try to allocate anywhere within the aggregate for
+ *		we also try to allocate anywhere within the aggregate
  *		for allocation requests larger than the allocation group
  *		size or requests that specify no hint value.
  *
--- linux-next-20200804.orig/fs/jfs/jfs_extent.c
+++ linux-next-20200804/fs/jfs/jfs_extent.c
@@ -575,7 +575,7 @@ extBalloc(struct inode *ip, s64 hint, s6
  *	blkno	 - starting block number of the extents current allocation.
  *	nblks	 - number of blocks within the extents current allocation.
  *	newnblks - pointer to a s64 value.  on entry, this value is the
- *		   the new desired extent size (number of blocks).  on
+ *		   new desired extent size (number of blocks).  on
  *		   successful exit, this value is set to the extent's actual
  *		   new size (new number of blocks).
  *	newblkno - the starting block number of the extents new allocation.
--- linux-next-20200804.orig/fs/jfs/jfs_extent.h
+++ linux-next-20200804/fs/jfs/jfs_extent.h
@@ -5,7 +5,7 @@
 #ifndef	_H_JFS_EXTENT
 #define _H_JFS_EXTENT
 
-/*  get block allocation allocation hint as location of disk inode */
+/*  get block allocation hint as location of disk inode */
 #define	INOHINT(ip)	\
 	(addressPXD(&(JFS_IP(ip)->ixpxd)) + lengthPXD(&(JFS_IP(ip)->ixpxd)) - 1)
 
--- linux-next-20200804.orig/fs/jfs/jfs_logmgr.h
+++ linux-next-20200804/fs/jfs/jfs_logmgr.h
@@ -132,7 +132,7 @@ struct logpage {
  * (this comment should be rewritten !)
  * jfs uses only "after" log records (only a single writer is allowed
  * in a page, pages are written to temporary paging space if
- * if they must be written to disk before commit, and i/o is
+ * they must be written to disk before commit, and i/o is
  * scheduled for modified pages to their home location after
  * the log records containing the after values and the commit
  * record is written to the log on disk, undo discards the copy
--- linux-next-20200804.orig/fs/jfs/jfs_txnmgr.c
+++ linux-next-20200804/fs/jfs/jfs_txnmgr.c
@@ -1474,7 +1474,7 @@ static int diLog(struct jfs_log * log, s
 		 * For the LOG_NOREDOINOEXT record, we need
 		 * to pass the IAG number and inode extent
 		 * index (within that IAG) from which the
-		 * the extent being released.  These have been
+		 * extent is being released.  These have been
 		 * passed to us in the iplist[1] and iplist[2].
 		 */
 		lrd->log.noredoinoext.iagnum =
--- linux-next-20200804.orig/fs/jfs/jfs_xtree.c
+++ linux-next-20200804/fs/jfs/jfs_xtree.c
@@ -3684,7 +3684,7 @@ s64 xtTruncate(tid_t tid, struct inode *
  *
  * function:
  *	Perform truncate to zero length for deleted file, leaving the
- *	the xtree and working map untouched.  This allows the file to
+ *	xtree and working map untouched.  This allows the file to
  *	be accessed via open file handles, while the delete of the file
  *	is committed to disk.
  *
