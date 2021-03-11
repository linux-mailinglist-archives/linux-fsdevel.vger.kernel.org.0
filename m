Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8D6336A9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 04:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhCKDWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 22:22:40 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56552 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhCKDWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 22:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615432952; x=1646968952;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0IP8A6eP34vOGzLXYcdoCXufmhCLVFXoXYee5053vtk=;
  b=LNHlUeHUr4w9EQAy4kiQrhrcZR9IGXqM8hUKFeCgUlBtZbJQ/dWRiczV
   XGgFWCVMxzOtF70d6VP/Tv4TJCeFAOWxdSyci8bmUJkUD3gO80l14rddr
   k0h/U52sWqUkt1EE6hS5N12kX97XW/OptwzcSbzYwb1HbBHmwrvwsce0P
   JXSBEVnplXrF1Jtr2RzliPHQSRI6Wml0pl+PZ9mpTIQP+sT+A/oczEPr3
   ECohU63cKlTBf71S5TGahUsXNOuWRYOMDQDEANQRNv5HDeS2QDIfIPBYU
   +Lvya6y/7d+EXnsd6NdXkdKjNBQPToatmjtdlxt5UeCpvAP+KuxQYkmjb
   g==;
IronPort-SDR: XpdIc0vLNU+ydtCSba3EgqluynA4Nr/LX3K2mbu9EFTt4AI47PWk0aKnuvF/VDu+m+xX74CgCy
 Nr3NV0TGkyytsQxRYoGe7l2y0Emp/VYdXVdZp/OKjl34AiJhlPmTvOqC2vj4pE5vPv8y3RoNql
 Zut5lplLZA8v7DaGmwN2Ni9hhvUNd0eZyFOiJWlbUxjrjupxCoTqS7oK2CHVmkyv1yD45pe5Xz
 CQ5+oJqeEFMNgByLV2sr9Waohqw+VG0ccYkT4HAKz+vwihxLe9CkFXpH9+OJu2/Ydw5XZTr8Q0
 FD8=
X-IronPort-AV: E=Sophos;i="5.81,238,1610380800"; 
   d="scan'208";a="163036201"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 11:22:31 +0800
IronPort-SDR: 1nWsVF32sStDUeQPivZ+Rwcx2smPBqsnVkmp4ncRRdsIcTr+b+oBlghmbqXUnZIK8mkbbciWHr
 gAmwpNWLT2leMr8UYJLDY3Vnk3U1YsYdM2LXhV+Cj9K1m8Km6f0jLbeaM0QNHMj2rcaKp6j05G
 fRJAxjX9VjrxFswmXbtonXplet13YVIgTSa8UmYH5fL++QPWCq9DYXVrKqHBBdz3r1k+yQJrHs
 ywgAYuKozaoNMQN+N2f4OcK/saWQifFOVhYyXeeVkWOwOfpXJiMMlMZ+AD86k4X5h/ayg+ctnd
 8WTIWfFpQvHIEQYsRAWb7si+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 19:03:27 -0800
IronPort-SDR: jYyXaUwZDr3EzdMtGwePDQ9iCQBXzhkJjEdXLhL/KcAYsfhHuvWHAmMMKPVV7zwK7pXuXw1CPj
 4D2oNmiOE9WnoDVkt5oOjVs9etVTNLD0t4uHiEuJX7kJXfRvTfmCouJa06GINE1pjFqdCSQpoo
 FcA4nfjNxaTNIlEwk3CFtyk8GVczGOGMsEl2jXbd/cAbGvAburcEXMuQu8youBUhGgQs51JQqw
 JJJ7TJJVL1J0flNKIZ6q4Hpkwccex7IRvat2pmuX57mVPYUbdUT9ftaa0T+k9bM+OqSAHyDYY3
 5aw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Mar 2021 19:22:30 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonefs: Fix O_APPEND async write handling
Date:   Thu, 11 Mar 2021 12:22:30 +0900
Message-Id: <20210311032230.159925-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zonefs updates the size of a sequential zone file inode only on
completion of direct writes. When executing asynchronous append writes
(with a file open with O_APPEND or using RWF_APPEND), the use of the
current inode size in generic_write_checks() to set an iocb offset thus
leads to unaligned write if an application issues an append write
operation with another write already being executed.

Fix this problem by introducing zonefs_write_checks() as a modified
version of generic_write_checks() using the file inode wp_offset for an
append write iocb offset. Also introduce zonefs_write_check_limits() to
replace generic_write_check_limits() call. This zonefs special helper
makes sure that the maximum file limit used is the maximum size of the
file being accessed.

Since zonefs_write_checks() already truncates the iov_iter, the calls
to iov_iter_truncate() in zonefs_file_dio_write() and
zonefs_file_buffered_write() are removed.

Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/zonefs/super.c | 76 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index b6ff4a21abac..11aa990b3a4c 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -727,6 +727,68 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 
+/*
+ * Do not exceed the LFS limits nor the file zone size. If pos is under the
+ * limit it becomes a short access. If it exceeds the limit, return -EFBIG.
+ */
+static loff_t zonefs_write_check_limits(struct file *file, loff_t pos,
+					loff_t count)
+{
+	struct inode *inode = file_inode(file);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	loff_t limit = rlimit(RLIMIT_FSIZE);
+	loff_t max_size = zi->i_max_size;
+
+	if (limit != RLIM_INFINITY) {
+		if (pos >= limit) {
+			send_sig(SIGXFSZ, current, 0);
+			return -EFBIG;
+		}
+		count = min(count, limit - pos);
+	}
+
+	if (!(file->f_flags & O_LARGEFILE))
+		max_size = min_t(loff_t, MAX_NON_LFS, max_size);
+
+	if (unlikely(pos >= max_size))
+		return -EFBIG;
+
+	return min(count, max_size - pos);
+}
+
+static ssize_t zonefs_write_checks(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	loff_t count;
+
+	if (IS_SWAPFILE(inode))
+		return -ETXTBSY;
+
+	if (!iov_iter_count(from))
+		return 0;
+
+	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
+		return -EINVAL;
+
+	if (iocb->ki_flags & IOCB_APPEND) {
+		if (zi->i_ztype != ZONEFS_ZTYPE_SEQ)
+			return -EINVAL;
+		mutex_lock(&zi->i_truncate_mutex);
+		iocb->ki_pos = zi->i_wpoffset;
+		mutex_unlock(&zi->i_truncate_mutex);
+	}
+
+	count = zonefs_write_check_limits(file, iocb->ki_pos,
+					  iov_iter_count(from));
+	if (count < 0)
+		return count;
+
+	iov_iter_truncate(from, count);
+	return iov_iter_count(from);
+}
+
 /*
  * Handle direct writes. For sequential zone files, this is the only possible
  * write path. For these files, check that the user is issuing writes
@@ -744,8 +806,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	struct super_block *sb = inode->i_sb;
 	bool sync = is_sync_kiocb(iocb);
 	bool append = false;
-	size_t count;
-	ssize_t ret;
+	ssize_t ret, count;
 
 	/*
 	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT
@@ -763,13 +824,10 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 		inode_lock(inode);
 	}
 
-	ret = generic_write_checks(iocb, from);
-	if (ret <= 0)
+	count = zonefs_write_checks(iocb, from);
+	if (count <= 0)
 		goto inode_unlock;
 
-	iov_iter_truncate(from, zi->i_max_size - iocb->ki_pos);
-	count = iov_iter_count(from);
-
 	if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {
 		ret = -EINVAL;
 		goto inode_unlock;
@@ -828,12 +886,10 @@ static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
 		inode_lock(inode);
 	}
 
-	ret = generic_write_checks(iocb, from);
+	ret = zonefs_write_checks(iocb, from);
 	if (ret <= 0)
 		goto inode_unlock;
 
-	iov_iter_truncate(from, zi->i_max_size - iocb->ki_pos);
-
 	ret = iomap_file_buffered_write(iocb, from, &zonefs_iomap_ops);
 	if (ret > 0)
 		iocb->ki_pos += ret;
-- 
2.29.2

