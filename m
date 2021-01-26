Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076BC30497D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbhAZF1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:27:32 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33036 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731695AbhAZC1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628028; x=1643164028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2OGmGEY1byakHiROOdFFJ6CO7FmJZnKKJJ8Xq5Cei/Y=;
  b=Zb6U8SVOcQOSsgrFyizNk/93NzUburQTZLfA7prblJ59Wm1KDkcpJLYD
   1tvH9Keo5ifBpTiIrlisfBO6I558zwPQnCRMJnf154gew3fZGC8KljS9D
   UgyR9V+ky4/efPoH+yy5u6RgxMXHfMmtL3DcZeIJO/ugtZ73MggH+gOUJ
   hH4NPTB4SO9LEjYgAIgysboDgJRlIqRGtvUnt5N77prypjQS8V1dNMVCK
   dgC1WWa6Dkg42jG7oQy9G9gs4oKPY9p+pqL5thg6Nw8EmZSNpkju97zl2
   ZOMNm9sd5XefQuZG5A5PG6Wi+y9n5tJLdNIo+0yKyDQk2+HI2iHIZiQMv
   w==;
IronPort-SDR: 9uMIV+3lpmKaie2gs1V+OrxLxXnW3l7nxUEtqglKV6d5m+HdmR5n7g2gd3i8wtaUpVKtlWDW3L
 KYeOp02KTjbTnoMUin/rL+uQ7RV7e8A1bKl0EgB9MDg2KCBcKEFfBaoi9vn4nRmur8SWxMGTiC
 WxkaxQllboPoMsYa2PTYpG4LX3qqFQDVz+jD2pqVVY8R1Qd+Gm4SFQE/v0JoiwPuYj3X6IU9h+
 6Tzh9AUR8uaAizcL6gl+o/cWc3jebLhoFp4S2FRKs1ihhV3ckuKF3DZv5wZ13ShbwL026Z7DSz
 4HU=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483498"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:03 +0800
IronPort-SDR: voxKt2k8XTMLHziKkQpsDO3WCy5Ld2YeRJ/9BLVGKybsMh7UKnpyIuGKplT2BUb+o48mB5kuLT
 C6YT/r7JozYVdMahuqy//GExy+LSkIPO6u4NvOnxDD6iiRukqHtWV8+Vad1ECiitxxqOZckqD9
 oZ9ME129tlAdQmrr77pJKyKxHiwbq82wYiTXYZQuNw2LBOHZ4wiAxtSUyKn+NlN8+v9wega5P8
 1T8iK+t3KPrQNotW169bHJeU1mGE0lM8wiIERPGDSH2EjUoNyv9ft0I3QKPWQz1YEw5wHh+n+V
 XdcXiAVrcH8cIO5V3ibneWn4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:29 -0800
IronPort-SDR: HRuVdQSnQxgqAFRTinpTBZiGcpiMr1PDelXmGJ88FKWQEX1YVXet/tB/YpWsBpCwBE/LaiiGEM
 x2hNYiiVUj/0QOYjBLb3LDxQK5dKiriix0YyWxOPybUuy4lAle5tp2J8uF+IpM9qANKtFQha7r
 2YPVYjxtc6qCVl1+dxyJTc3tNHCAwLAgpNk+pKCL/xyx9BgnjuI2DUzSurnwRhBLL8rVppBl+e
 ffQ34zWrvomP0afXvHDxxw6ulD0Ks5ce1FQloMAeDKeLgFumEmyHKvamrijlWzk2FVLT6z+idB
 ilA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:01 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v14 02/42] iomap: support REQ_OP_ZONE_APPEND
Date:   Tue, 26 Jan 2021 11:24:40 +0900
Message-Id: <adb1935b96c63a34a92bbf3dc5e97d10724e34f0.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A ZONE_APPEND bio must follow hardware restrictions (e.g. not exceeding
max_zone_append_sectors) not to be split. bio_iov_iter_get_pages builds
such restricted bio using __bio_iov_append_get_pages if bio_op(bio) ==
REQ_OP_ZONE_APPEND.

To utilize it, we need to set the bio_op before calling
bio_iov_iter_get_pages(). This commit introduces IOMAP_F_ZONE_APPEND, so
that iomap user can set the flag to indicate they want REQ_OP_ZONE_APPEND
and restricted bio.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/iomap/direct-io.c  | 43 +++++++++++++++++++++++++++++++++++++------
 include/linux/iomap.h |  1 +
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..2273120d8ed7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -201,6 +201,34 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	iomap_dio_submit_bio(dio, iomap, bio, pos);
 }
 
+/*
+ * Figure out the bio's operation flags from the dio request, the
+ * mapping, and whether or not we want FUA.  Note that we can end up
+ * clearing the WRITE_FUA flag in the dio request.
+ */
+static inline unsigned int
+iomap_dio_bio_opflags(struct iomap_dio *dio, struct iomap *iomap, bool use_fua)
+{
+	unsigned int opflags = REQ_SYNC | REQ_IDLE;
+
+	if (!(dio->flags & IOMAP_DIO_WRITE)) {
+		WARN_ON_ONCE(iomap->flags & IOMAP_F_ZONE_APPEND);
+		return REQ_OP_READ;
+	}
+
+	if (iomap->flags & IOMAP_F_ZONE_APPEND)
+		opflags |= REQ_OP_ZONE_APPEND;
+	else
+		opflags |= REQ_OP_WRITE;
+
+	if (use_fua)
+		opflags |= REQ_FUA;
+	else
+		dio->flags &= ~IOMAP_DIO_WRITE_FUA;
+
+	return opflags;
+}
+
 static loff_t
 iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		struct iomap_dio *dio, struct iomap *iomap)
@@ -208,6 +236,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
 	unsigned int fs_block_size = i_blocksize(inode), pad;
 	unsigned int align = iov_iter_alignment(dio->submit.iter);
+	unsigned int bio_opf;
 	struct bio *bio;
 	bool need_zeroout = false;
 	bool use_fua = false;
@@ -263,6 +292,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 			iomap_dio_zero(dio, iomap, pos - pad, pad);
 	}
 
+	/*
+	 * Set the operation flags early so that bio_iov_iter_get_pages
+	 * can set up the page vector appropriately for a ZONE_APPEND
+	 * operation.
+	 */
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
+
 	do {
 		size_t n;
 		if (dio->error) {
@@ -278,6 +314,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
+		bio->bi_opf = bio_opf;
 
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
 		if (unlikely(ret)) {
@@ -293,14 +330,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		n = bio->bi_iter.bi_size;
 		if (dio->flags & IOMAP_DIO_WRITE) {
-			bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
-			if (use_fua)
-				bio->bi_opf |= REQ_FUA;
-			else
-				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
 			task_io_account_write(n);
 		} else {
-			bio->bi_opf = REQ_OP_READ;
 			if (dio->flags & IOMAP_DIO_DIRTY)
 				bio_set_pages_dirty(bio);
 		}
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5bd3cac4df9c..8ebb1fa6f3b7 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -55,6 +55,7 @@ struct vm_fault;
 #define IOMAP_F_SHARED		0x04
 #define IOMAP_F_MERGED		0x08
 #define IOMAP_F_BUFFER_HEAD	0x10
+#define IOMAP_F_ZONE_APPEND	0x20
 
 /*
  * Flags set by the core iomap code during operations:
-- 
2.27.0

