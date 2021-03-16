Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8633CA8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 02:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhCPBJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 21:09:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30425 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbhCPBJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615856942; x=1647392942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=97sPaW3qyvuDOyO3nuYtL75Oph/gLKaZ5/X37h9Beh4=;
  b=I/ei3PAh6GsgiY5LhubDRS0mk7Vl/25v8gYy5Et03WVRrvTmTTDggQbS
   uwrWOApdS7cslnJkSWWBzQjzUN+PW50nI7dH9e5HMpuQGztziGEPtsULS
   kT+l9DI4kLrtKyN9Ef5hTOkmai18xQf0F3sGjFJffJHHc6ndUgnvrgOhA
   /TIYhrH6hSQ0hguClDHA1vhvYGB2uQaxfLw2rScshO1L2nLPwAO9F1QJS
   5WQpyNlUNrH0OKuD2VZWQe4R3H2qRQDYYByFWsZniOXicUVHtnsQNTss4
   0BO6Mo3YlCKvV/vsf1UFCLM2Ge7iYJ6QJIi0VI6U1VT0P+jGiHsIQ+IJI
   w==;
IronPort-SDR: 1pRr+oJOIO7rpPp7bzf7F69Q294M3TWMw91enfFt6Y5PFtFoxxqnGWv1fSbZN45+u9S5fDE1Do
 eZhQAugtpZe6OmeIOgR8imixZdOZtr+Xq7OmDmHUyEsln1CDHMyMAfI6tZWnOAKDuxazgy4v90
 R8Tr8yEbMgc59FPT8Yi2qW+sjOEJABKfWLt/YA1y6g/r2QKMjxvERylKm/pPAuvQ6Fj5CwBgTs
 kjd+l1eSMgrZK7qSzwTLeAnQUdS1WGM79z+DzMCJqy6NQAU9iGVRLae3TAjjqO0snO2UIl7no4
 uts=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="272929392"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 09:09:02 +0800
IronPort-SDR: Qp1gf1WrtVzHUWNzo/sakt5CRQeSzuvyMdTbuTpevp670pA3TBh/2o5/lA5kDwE34AgPfs0a1p
 GBjnBelUhbrcDvGHy2ABnsh59MwLHBvNj6ZC44G7u7ar0XGT3zeggnExn+vq1o7mPZ+aMUC5Cw
 RZ4c2yrGt8O9reIlZiHzTe1e1ITgVYc1vrynoVASPGnAzVJaR5kVMQyu5UKj+yOwAAHGBEDx0e
 GY33P4xOfOLgxcqdqQHRjaqK/9yVqtAqW5jHvclG/dy+D3XIXxiWu9qlKEHLm3NswOD/TqAIxk
 F+44NOcttyhsZ9nrpNWOzAXy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 17:49:39 -0700
IronPort-SDR: vA8dgIL4M4MEipOlZqGzoz5L2cRtwHJJHOKWzd6md35ttI/thZ1UF/WUJq0XzfpX7iUVI0MEix
 F1XE8sQk6XiWENnPX54OyV7qb0jE3l38BE5B8YQwyJ7HYgkbYOXmJJt7XgStMtDK+eeDe4dFg1
 GxjQm2EorerWcNxQocrqPX0OTthQNPAlYjbHoVlz9E1M72AGxBFNZ1dXcZfLnhUQEsDZoKyLW9
 JEiUXQt0CW6pEMagXD87fX3r2qezUzppCYwxeERq6oQ4L90qiH72oJpmWolfKYPTjnzlOs+ZDH
 hg0=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Mar 2021 18:09:02 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/2] zonefs: Fix O_APPEND async write handling
Date:   Tue, 16 Mar 2021 10:08:59 +0900
Message-Id: <20210316010859.122006-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316010859.122006-1-damien.lemoal@wdc.com>
References: <20210316010859.122006-1-damien.lemoal@wdc.com>
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
 fs/zonefs/super.c | 78 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index a3d074f98660..3427c99abb4d 100644
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
@@ -779,12 +840,11 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 		inode_lock(inode);
 	}
 
-	ret = generic_write_checks(iocb, from);
-	if (ret <= 0)
+	count = zonefs_write_checks(iocb, from);
+	if (count <= 0) {
+		ret = count;
 		goto inode_unlock;
-
-	iov_iter_truncate(from, zi->i_max_size - iocb->ki_pos);
-	count = iov_iter_count(from);
+	}
 
 	if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {
 		ret = -EINVAL;
@@ -844,12 +904,10 @@ static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
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

