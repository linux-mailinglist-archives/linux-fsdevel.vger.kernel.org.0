Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1520F2F730E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 07:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbhAOG4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:56:38 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41681 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693796; x=1642229796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=miwcS2PUXlaNgE1YrtKyGZ/a7gdhwX7SYGwz74INDPs=;
  b=USkamyy8joykEO7qWqvFLHOwyRuqvXzXqXsZijlCN3L0E3d072LcOlMQ
   wJfudVr/WMK/JnR8BCg9RfYA9fUhbD+QN57xYztrNi4jrG2R9RTgeLRCT
   p/ey3LznSUaEmzqxtp50lmAp5aGV0h0bPDxr4JfPM36Mjl0gXH/hWXqZg
   aimMTo2wQxIUPt+sGWz3H89O5omtPPHw2/y5UKH9oY+oAw5W8KvpMmGFn
   KSfzDblSTRuPTqtOx/SvN3RY5Gf5xvN9K+ZhUPGzG4QnCn+D6VQ3poBJX
   lCIxYxWJ2NdxAlhcU5rZqrxBbDp3rnIV25UNLSk6RoVWPhJ2fpiq4+57Y
   Q==;
IronPort-SDR: exccyp09M0Q0+0H0wPsxfuxXchG+kEi6lMf2FuNeEamojowXx4G3n7Ix54Bj3iJRaXnfCY2OBE
 whVfoq8w/CFX3+jFWMiWvKhs8Df78mcAU9sLypR/xfnKTaJbd5hARPmDmhFD50fpHBF8xIYcbk
 UaWGPGraG+Ij0zLmXYYNn4qxZ1zdT98aK9Qs0El2o1VR9meOj5bZCPYNxEIj3N8rSBGXA+86iI
 SRrlkINWuaM9Dcp1VEydJ2Lv5RF1693fkVmvGKfwilFfjm/IuOoSeHFs/GbgZ5UOuIRdYEgEsp
 dGY=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928180"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:07 +0800
IronPort-SDR: N5ZvsC32N9irjXjhXytOaBEyS8esXgrTT77AIrOulDpvWsTkcXkdD9OZSNClctWuU2tSrPIgZV
 BKBWe9r3DutyMHKXQjfF9pL8fTJhvw/v3aC2SKcAVHFp+GL0sFRw9WRnxALcoSpRhLTC5nTf1W
 crdbBCBZPWyv6XyXJig7mww3wrLwSvzfk8PtuosA9b3q+MJrkGGHOX041mPaRO/VXckcfj5AjO
 XvzgFD3lM3DUw2t9CmLkaQr9G0Ob4bj03l5ZWrXMbJNhobHPhQJvltrs3ISZbWkWjURetm1Z+8
 s0V58NrXInO2LJXjrWakKcSx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:39:50 -0800
IronPort-SDR: ZJXgoxndNWnN4v85ydN6Dn3LuOwzDjbzArYp0bcmoMiBBORpVgc48YfgSmTXfILumo2UnE8Xok
 B4uDPzfEdAWU63hMTPGIMXZraGcJLxb9s0bwoAIGTwrdQvnEQufoelbm0lJTe7yv04KgqpTAFf
 6c67iZ8gJxEGv7rmw3+nl6KbD16M6GMSPWO57Ep15at/FNM1YQVu25YJZoLrGy2p/Mq5li59qv
 MsEN0IYW5kkH7dQH0QaWIAAtKyH9OE5HDX7mXB46IuQn/89I3I2paby5sYOZUOQJumbH6MjoIl
 FgI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:06 -0800
Received: (nullmailer pid 1916422 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 02/41] iomap: support REQ_OP_ZONE_APPEND
Date:   Fri, 15 Jan 2021 15:53:05 +0900
Message-Id: <2f2639925d82a137308c6566f1863cc6fb79c58d.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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

