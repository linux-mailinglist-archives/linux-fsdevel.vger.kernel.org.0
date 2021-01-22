Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EBC2FFC85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbhAVGXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:23:38 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51039 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbhAVGXa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296609; x=1642832609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=miwcS2PUXlaNgE1YrtKyGZ/a7gdhwX7SYGwz74INDPs=;
  b=T0wF8BM30en6vKOrPoOv618KQi8aTFFHZCouCtQwiKKpoDb90pM67rCz
   hR67YbqzCDTMgbburVGBkbg1I7GwEuj202T/xyR7AW3SiLYNVg5iSt6Cl
   H/xW2Rv09zi+ZX0/cfOElnQrjpqEeMwEQsfgN4/hGjB45pR5sfjQjqAdt
   2Ez8WEx571zx2RvnVjwkaCuzaaXXtgb5Le1X+VQmB5pBNHjYplF1iqPak
   K11606+8ndEC1Ko5LVAy+LcfrPuVUKpQ9h+ftvlgdD0oOZtr7mM9/H0j/
   MV9t4C9+PEPiXAoJMrftd9mJuABzgGnBw7FgfXWSmUu0njqet0Tsl9+1M
   g==;
IronPort-SDR: fwC42muGmJChA8mvmU/xo1AcYUwrFS+5YKWyKfSZ+/3lvLyzWVsfymQGdifTeLdIAVD6JK9Bme
 P7RKVvUH/Y+nVVQCJt6p5xaMyy7cSaJx4E5BPwNY0fB7EbQdTCjt72tMUGf9Q0brdfX+LJv1z2
 E4j9wAsiwXkKkHYoBITWqPHYNCD0q/Z2gQYS4cUU+I7Z17iZ8FQrloFO46b7cbh3myY4insUTC
 4kVSuQtnAIK9IyrWBRE9cTtbjKWEnjA2QuMnqSpCXsi3gQBanfwIrgOkBPJ1jcXa6Xj21OpCsq
 Lw8=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391922"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:24 +0800
IronPort-SDR: /oCxIRLMwKzHN6LM1F9zTbrTPDcX5C9Zxp5gZREi0bSApsqxuBpdhjqBaMwoy3YT1E6bqZKevL
 gCBSZpxk4rgA1Ig/6eeBZ2wzkmvSK4tzDi+BZykfzsKrweFiKiAu3hpoXekCqyOhFCPIjYi1Ue
 /y1xH0k9JB3Ic/bQZle8C092JqRu65eq4KfQYVtBxM6DU7eWU/dK2NCY2gVQPSUdysEYf/OTw0
 ddOB3UzU2LJ8KE7Vg6RUCx4QQA61kdeL549GHxsngxHSnfcDsl9rY5bronqJnJHuuqbdAAbG/2
 bOMCVtv/8f6JZliGffWaLpaW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:04:56 -0800
IronPort-SDR: HVTPAkVEIdKbaPlnG0E3aWuDuclsvegqFUtTMbS7upRjpE7XrjdxTDjxGP3BGtiCAfnCJPT+Nq
 PpFDsV79mzQFHpBrQz+RhJVL7QkHmhB8uvcBx5rvJfMFCwy0r1sbxkO++roSQfIpL7AiP975P+
 xG1UoAzoeeSSwLVPwdrFrIrCCxD8wZ3UgYS3LT/aq9wr8SJ7PYba+TscTcY+8b6fkLdpJGun5F
 quKfWUYFa8ktvPggFfcY4hOjA9kLHentlkiUZQ9um91cW24dJLFSSNQ7y6CInGeH3xrI9oOFcH
 4Qk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 02/42] iomap: support REQ_OP_ZONE_APPEND
Date:   Fri, 22 Jan 2021 15:21:02 +0900
Message-Id: <cd649d35d422b897c9b3569263cd1ed6e4ab96af.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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

