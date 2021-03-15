Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36DD33AA26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 04:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhCODte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Mar 2021 23:49:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29592 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCODtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615780181; x=1647316181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cStN5xHdd90RnJb80LffzjZNk61ERCaMbgoxSq44p2A=;
  b=pof3r1TZly8PlYA9Loze74WK0MFDV+GAP5arHWQO8Xq18urxEOO4LTiv
   6zqDr1s4q7n+LvlR3CydBuAxBxGQcUIp12wBiT7+0Ni+WfzJNo5Vsa5eY
   xqQds2W7YT/ApI3swIL/Wo8OvynIFoz8dUJ9rgrHS5DA1jPNXOBIIKqYV
   ZOV3/3O/2VcMZPnf++6pgKlG2AuBhNmDg1qnA2nYXn9jZP4Z6ymhLiLnT
   c8e6UCYJjTnbw3edXiQOT/wxn04vuXj5QEPVpnLXlkowRMNkCNPBSLHma
   Oyag9gD5NLMwTkFK+qYmVE0tbOOM9SaFu3ldvWHyb5X7r7xKF/1UlCQJd
   A==;
IronPort-SDR: mH5nLPKzvy946xvJ2vlaTPY5caO982JythbJ0Nkk1/gSPfwjVl+tgmL4PQ3zFJRJA+Bt37+jLt
 0dbF6vk6mk5UXJt/Fe15Kvry57SYiYrtnKDtAVJJ6d9BskrCKwPWEbTkiYgD7FhLxPUYytUAM6
 iEhfmetJLQpmuOKOvUaOW5R48G1T9vDngk+afMaVs4tWwPB3I/WptblX93VGYEOxIGS8jX8Nvx
 DihJeCUx/vxEmrEtRdHoUBOkMBMrr3Yt+fi6JQh3Ge4Qxw+JL/TaE0S6eGYKJMs9mQPglukHsi
 RDE=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="266509453"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 11:49:41 +0800
IronPort-SDR: ++uQP0r7oep9flKpcMITkjWPphp9yi8Z6/bZjKcXmdowo9WJHEHNkuLtWXeoYravSlFPxLRfZM
 x136TVNEAXfmf9IyU39jOpEGmoQMGdgfOXNyCdSjuDVT3JqaRJQKFjqcbFv0kMyxstLUTp8cF6
 fn68lrQeG+++Ykdl4hwiQwuLTTg6O1X972JpQZYvVg7cX80BDwUUHC5/0HA8ST7o4kgcRx/BF5
 BrV5t0e3WTHrL1tANpTae80gTpa8zkbL35k5NE/5J/xtK6zTyu42CqLUZUFW4JCEX+8D3suZyZ
 t7QP8prIg6B9skoOsqxDDLFG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 20:31:51 -0700
IronPort-SDR: IVs2SXDxcHgFmZf8ZDgQbCF1TJ7RQrK+Zfs71V/Ov/yOY3aOLvQXVgiP915WEohlgCLAfqTpmL
 vhIdM0MCcYHXIB3TYHDPlD1LPmM6LCsKx6fOTb3rleh7QjcIsid3GZMgGCLDXHYgmeuDFZQb7K
 TgybswHDJcrJvP3h2Q0Zxe77oiKb/xHlJM2TC/XyWsoHmOhCdTt+WNQ6NXednRQCBQ02Qo4IDT
 1hSpvkTghhedDyNi14JpDzHDMu3tk3J+3fW60PcA9kYtDHRV7sWt5Ok0LPW2rFVgzbkjy3s9/a
 Ddc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Mar 2021 20:49:21 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] zonefs: Fix O_APPEND async write handling
Date:   Mon, 15 Mar 2021 12:49:19 +0900
Message-Id: <20210315034919.87980-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315034919.87980-1-damien.lemoal@wdc.com>
References: <20210315034919.87980-1-damien.lemoal@wdc.com>
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
index a3d074f98660..81836a5b436e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -743,6 +743,68 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
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
@@ -760,8 +822,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	struct super_block *sb = inode->i_sb;
 	bool sync = is_sync_kiocb(iocb);
 	bool append = false;
-	size_t count;
-	ssize_t ret;
+	ssize_t ret, count;
 
 	/*
 	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT
@@ -779,13 +840,10 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -844,12 +902,10 @@ static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
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
2.30.2

