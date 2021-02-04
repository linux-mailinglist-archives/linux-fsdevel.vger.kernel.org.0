Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E5330F07C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhBDKYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:24:07 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54222 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbhBDKYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434242; x=1643970242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qyufLWUgSwmWrYzDYEPcSXEzB03Y/7J9Ar2bT3V275o=;
  b=X2Ha5Zv1npqTwQX0HwB6wr0Pl+Spkb6KbKj5wqPCj534FIztIGhfcSKp
   blaL0xyO1RilBXqK3/GTzua3ZwcDRcLvgEPpr5GN1vnO2kg4gAL73si1H
   8XQPJ+/0yp/RHYU3MHU7Vmk+qPRxcgtAtRlJCvmy2RNo1RTtmrGe/iSRK
   lgT5JfQRb07VSHX+78H8mUHDRnR1vlxgyMjYbzO64vHUB+/973Q5j5mJa
   lNQ+SiyZpteF3FZKnkBpbVDG2Gwd6snzClMe/enAuebLeqGhEt2vbuDXN
   VcSB3+D0CVrfJdwrXQ7YkaMtTVk8UAyjx99k8gEFrkJSKm9XI3cHRvb/7
   Q==;
IronPort-SDR: 4BgndRiGdTMuo/Unpwt4hCSe9rSa6g+EpLqTuKwj2xIuyNT1ijNaP+aGnvircgvcQpOgoDRvyj
 8ga/4fdQ/Arc7achOefbinijDLNPPdM2/qaFdlPE8nWoyeAFuIx4Sh543y2rBNCpO5ChWvSmpD
 +89Tj243bNfSikU8FcJjVuV/FUj8HmIqdc1M55xCETZpDDDV5KO/LcdHDBaMaXcOrX7SRKo3hf
 uf9L96pi/c5orKbXN5x2Oi4oPYDQCeFisfGUg64xU3DqLiAgXZY3ds4oCbKAtQ55U6dA5oWnaM
 yb8=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107946"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:22:57 +0800
IronPort-SDR: eq0a/anM/JA9VL7IXlCH3M+MmG9qNBQxuPrckT+i+BIspksMa6HnwHQDBC1MFJTifzk0fO96Qo
 cE+nR9EMXP9TJweAFNy404DdyjHj3kkap+s/lRASyoplEXiVL4z0UEUTz7+Ol0I+VS93Q+HYuh
 iloAV+Lpdz10HdCbHTdbWXZ7IXwiVs0vGtRUtSM7vZJhbQ/0R3uC0xRnPC699d+PgHQ/VhLTZc
 93FpSW3NnDPXgZpgYleP+N+1xiXwuPGciOxZ/RQ2VJQ9uunp/5BYezPPgIC2VLLlEEhOZN+xa1
 jCPdfb4mV1543qDDBQOrZPR4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:00 -0800
IronPort-SDR: YFzU51e54JdVUjo+h/QipFcHM9BLdh70P+M+0VGtP68bxgapY9kuxc+WHdsMojSSrosGX/zLdz
 Yul+78xm2Fsgl8udAVS47ZbC2uVaaAnOgkjadt074eVZgEuYAXzEdY+fElJGFlRLcmQJYxiBbC
 8s+z85+QhKpmkrqg/0AzwJ9RnT3V1900zaONaPEfD0KFjEbYOdoTdA3Q+1P0oN0/elsn7Axfke
 P/FpuudguX9/TFfkXADq48jXwPKYbrPZCILtQYveRzkOlsRr+D6dOChdGYsQfJEI+gviZ2aGYL
 4U0=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:22:56 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v15 02/42] iomap: support REQ_OP_ZONE_APPEND
Date:   Thu,  4 Feb 2021 19:21:41 +0900
Message-Id: <e824cfd3ccb9c24a331fe0bc996ce10b25fb748a.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
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
2.30.0

