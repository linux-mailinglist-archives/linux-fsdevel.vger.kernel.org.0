Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F736180A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 05:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhDPDGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 23:06:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63371 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbhDPDGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 23:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618542340; x=1650078340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uVfh8D4+sBBq64E108Yvid21+UPvhkglPh0NjleQvb4=;
  b=cThEWTTds6021zuFqFhubo7E8SPoXUnhO+Padd4+Yh8/KN5/lgy0oDYg
   pJILsXn9FTc60mJ8DPdzi/QP9DjdOngo1QoPTtX0KFQyXOFwpxIoTTnxr
   HryykFIewOWozTMb3lVedMnBbrecEGNaMW2rIIudaijf19sgZK3ohUW4x
   6bN6DJU6rByUtAk3yvOv6sfJBebBaXQsMvEj9Im1jTDnIG7sUuW8Inx2d
   2qcNvhdFqCfWBYeaIho9NzwBAori/whJXBcpD8U8ydJMbpY7MPzJ18Kqj
   gNJ7C+y7Q5AuS8B3pehr+YQa4Ekh2UKnk8JJoywNSawnzjzrxz3HCzJag
   Q==;
IronPort-SDR: Wjd0C07/CyaIOAtTIRGTCXKKfLlLsF+PtYnIkpg7JP0T1sqP2a6JP1IS+xpCQM2bzZ76HW9ZTb
 my0i22KrIx/fz9yOU9rqXVJKINZQ1riztKi3nTydkiJ/D4nbIbii9hufetEIjaZU46f5AFT6Sy
 xCC3F/QPl1vhzNSYRGkcaXj8PEbSI5BS+7fAj7o+bSZ2bBLHsEnevhC0bUQmS4UCAUe+ZMGs3N
 BSHZFs2bYJYpoP8zXAOXYQTlXtuygXIZl9JbajVdqH8jf6cpYTcQJGRcOV70gWJdJAU65IEIZj
 h4c=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="169567899"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 11:05:40 +0800
IronPort-SDR: N+JLvR0N5aYsv7emEsPhN/tT0NVNgPJXcdSt0E/2pqaQSxIRvosiojEcT4wsXreg7GhNlGIuNn
 maxJ/SaKb8G03efUnWVERc3DJtdFC1Kmcf9YG+SNyuBKLvv9AR7Em3nrF5XZOu0WXz2BdxPKXF
 6MlOxoZOeju++9BiwlhDA8CJAAfusx0RQCCF0fXUWbt7JYc0dMNLr1j3JyPCUxqiI3nNDdY197
 tE8O9A4oGznyoshkejuYLBYSZeUFvY0NNsQ/ciR5CuTzBfztJFRpCKYXnjnkHTovmG7N4XoSJG
 DId+xOXwdD9L035ADnw0oVgo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 19:44:59 -0700
IronPort-SDR: u5Gc1810z5GreDYJpvaZDBd+bkB81RNJhYok8IDgPhe6JYgYj4b/4/fYIpyX1cNfJVEHlvUAnA
 MvOAeuVc8FBQZXEYMRwsr7AEl4o9EH4ZWc0IZfF4PcbzBOhhh0kx5kXMSJLHk9aqaOUbscvFQO
 cnR+SMMtVcof5L8EjlIR/eC/8XN0d4vx2Lzk9Lhsnt21cd/URva91ybcVwFbQqbeHdz6R/7aav
 OkHZyDzHZ5SnIdccJAHt+KUB7t7KMxH5k97pMJAwdRTYfFo0Amj59jJpiDg1hrSqHsfS+f5qTA
 0pc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 20:05:40 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/4] zonefs: fix synchronous write to sequential zone files
Date:   Fri, 16 Apr 2021 12:05:28 +0900
Message-Id: <20210416030528.757513-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416030528.757513-1-damien.lemoal@wdc.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Synchronous writes to sequential zone files cannot use zone append
operations if the underlying zoned device queue limit
max_zone_append_sectors is 0, indicating that the device does not
support this operation. In this case, fall back to using regular write
operations.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/zonefs/super.c  | 16 ++++++++++++----
 fs/zonefs/zonefs.h |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 049e36c69ed7..b97566b9dff7 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -689,14 +689,15 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
-	struct block_device *bdev = inode->i_sb->s_bdev;
-	unsigned int max;
+	struct super_block *sb = inode->i_sb;
+	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+	struct block_device *bdev = sb->s_bdev;
+	sector_t max = sbi->s_max_zone_append_sectors;
 	struct bio *bio;
 	ssize_t size;
 	int nr_pages;
 	ssize_t ret;
 
-	max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
 	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
 	iov_iter_truncate(from, max);
 
@@ -853,6 +854,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 
 	/* Enforce sequential writes (append only) in sequential zones */
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
+		struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+
 		mutex_lock(&zi->i_truncate_mutex);
 		if (iocb->ki_pos != zi->i_wpoffset) {
 			mutex_unlock(&zi->i_truncate_mutex);
@@ -860,7 +863,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 			goto inode_unlock;
 		}
 		mutex_unlock(&zi->i_truncate_mutex);
-		append = sync;
+		append = sync && sbi->s_max_zone_append_sectors;
 	}
 
 	if (append)
@@ -1683,6 +1686,11 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_mount_opts &= ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
 	}
 
+	sbi->s_max_zone_append_sectors =
+		queue_max_zone_append_sectors(bdev_get_queue(sb->s_bdev));
+	if (!sbi->s_max_zone_append_sectors)
+		zonefs_info(sb, "Zone append is not supported: falling back to using regular writes\n");
+
 	ret = zonefs_read_super(sb);
 	if (ret)
 		return ret;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 51141907097c..2b8c3b1a32ea 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -185,6 +185,8 @@ struct zonefs_sb_info {
 
 	unsigned int		s_max_open_zones;
 	atomic_t		s_open_zones;
+
+	sector_t		s_max_zone_append_sectors;
 };
 
 static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)
-- 
2.30.2

