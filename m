Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DAE2E04E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgLVDv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:51:57 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46437 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgLVDv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609116; x=1640145116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=miwcS2PUXlaNgE1YrtKyGZ/a7gdhwX7SYGwz74INDPs=;
  b=PRvSsfzezufPo2XlFs++x3zzZ04z9pCqxi/CCP/JNWqZ3lWY4W5CvQ32
   0yB47RI2AB+AMMVAjC4u4Rn+leGFma4PbwAxL8+IsSO5Cq35hdwnnNnOC
   ozBD26VxzO4o5lxbYv/NU1VVNO4H12Rfn1DIf9Jd8KGRp2GEVKGELcMdG
   QccSULCQ58e+sfDU0XK+V0Iu5qGF12EbCsx+WPT9+0Ip7NcGgf9h5Wmdv
   88XXcwN006ufRNNruXbe00ZJr5ys5D/EqkNNTpLgge4oC7Zii9MujUx7X
   5JgPjPnfAxHJuXR9GkgOBplzj/GWcJoOt+WyNwiGagp048J+oVkfZVEjU
   g==;
IronPort-SDR: F1DkdjJGfnzk2bqrIQthpWwu/xv93XALBN2aKil8PMpSfYotIz9d4HD+c/oPpP750AulbNmt+z
 qSn9zbVCtkHWfKpi6pgs87K9DZEGKMTgwFcv545qlQOqitVt5kiFcgljEA1UAwQMXsq4JgLw6Z
 1TjDpIEt7U1BqHbkpFL9v+iGheW+E8EN1qRLW43LngUhkEnOUVhiLzqPGsD7+hmzNVxUzAKjRi
 FEhqgr8RXtWejnkFYafYIgOpS3EDYbiLWGD9FF5l+onndHtjDKuggXvkdFtWxrgK7EPb1p8VwM
 pqc=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193715"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:27 +0800
IronPort-SDR: Ae5CLJfRc+7nUNfq0fXDF/z0tZn9FI5MPSPCQJXztnjxhvM2Lv4IqizYT4x09pj9IRg5D11Lxo
 xhBNivmUawylwHL/Y9A9ayr1ZtmkHMJbpEMMYNUjfT0vN2xY0n3hYLr6QYepMwXHrORPzPfikm
 eq30wFVf/4OKZrN6vv+0e7FbkPAccNqvIEz00ZmjGwsUuUxZ1I9txIxwSBFh5WSAj6F7Pgnkgr
 fsXIiFg+dU9ntTqL0U6KraiCOda196HLSrt1th3ypTIuBo+rAlfR4DV3dvkEoonXvn37PVfYqB
 xKJRKIzLTNzs0jW8QYTM5KmW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:38 -0800
IronPort-SDR: pMirtehJWeBM4zJgQNWy3hlmjVPYg7DIR+5P9a0AVU5bhi0Y4ouVndhkgYpMZqwNsSA2AETm6i
 CQ1U43nZmJwmL9BK3z5p7VpR6cd+AWdi3TIrjQT6f3ei4YVlXxutnKymuHsDgjqiN9CbdKNBZ9
 D9fhEScSUm78JgeYMmUkiuNfjVt9rn5sNfPWQC31TFBu4/Atw4/gZdFSmAIlqB8q9Dugg6HO1v
 Bg1skExivcWXkoPrduG0iSb6UIdvP1WESYsCbToCD8z5SHRImQXjPs9X1R6s3OIJMV0tVEdW2x
 13E=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:26 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 02/40] iomap: support REQ_OP_ZONE_APPEND
Date:   Tue, 22 Dec 2020 12:48:55 +0900
Message-Id: <33bbb544385b7710f29c03b06699755def39319a.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

