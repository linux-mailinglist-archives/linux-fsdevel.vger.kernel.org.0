Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A932C2AD4E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgKJL2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:15 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11940 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbgKJL2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007686; x=1636543686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8NoeNl3Tt1JCx8RCbgz8L4axYDCtVntSuJmZVeke6U8=;
  b=Bu5RM2iMagQPJynknSYcAIo5kmb0jaVGonl9ZusHcJ41kjd+/SRGqkYy
   zuMM2pO74l1Xpfy7lW3sq98T5Y3zMtvX2jEZmWryT5q4x5cthdydhXKlj
   A72meH38yNl8cm+nbM04Te/2dBEFZIpyAISHUneHbzkcqZCjH82tWJW94
   Ri7Cr1KUIJkTdL4SaDKGD83t2pLjYxp1WWDF55o6nYol3cjZMCmtwGDgm
   o97ypGWX0TsYdoSlfi3+1RBvKgMRAKyDA8GgLT0p00fpMBKhpmS5ni3Qm
   rvd8XbjKTB8tHgfAgnzy6IfAw/1oidMen34nMKZvE0W5ymum4XCg7WgVu
   g==;
IronPort-SDR: mgBRpTl31GmQPUtCVCtM0feR7WQupWIsrgALLN0dsJsj5wm/FlFUp16CeZT4bDnl139XKff8Xr
 uf0rQsWHJ3kQljgL0A8NqPA66RoG2caukfMDFAOJT7FTwKoroStd4zM4OjEExVx2pTq7ftvpJq
 lZKou9qcC2XG8N8CXew42/uizxBR+oyt3hZ9IY3sH9zlQywNtA9QURqEikRd1B5mOPKLXatH/h
 kk9cTZ53GrRyfP4SfQVWf4w6GWO7hSCnUaghUGd2NzXX8uqzr0jkaUum/It2kHQhirRdl7CLlh
 fs4=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376411"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:06 +0800
IronPort-SDR: KIGBsKzPCuMDD6Fadu7IlJJ56/68Bucj5/tLMqD7YFhiGV70IPEyCUumcs/mdbuW+QsxBzqef3
 vha1ldAdelEgBBohJJhyVtDizL1HE8znp0p/1qOurXk7VKiiOnAvndDnNTUBTqJwynQlcn4+eP
 zXh05ZdD4/+E33tZIeFTddKWaMIHGTZ3uFGSxyJlQGTTy3/bEAVDvlTqbf6UOWDVuqYsoHg+fq
 3kSXF5mgg4GR03YvG6a61KLkOpeL8OCyXYaKGnx7Z70nhHRMckKw7wbdI98v1MNNDCv6xl2v/J
 ybQNEz/Fh+XQfa7CKSkzFUd4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:07 -0800
IronPort-SDR: 8bfWCJKgm7ywL4SpSw2b7WVFlH18SBGc1bZ5XNTIz7ciYqQ7TzyaaGiWTB/NmgDB0pTdrSVrHH
 7H1pfVMsT8J8cxCT7yJeHY4yGh9PAgrK+4GpIsWxgOZRGmCF20R3aOFz70rkbIa/eRiGgRKRMW
 ORCccDMk2gYxHnd8QGfky6Cdmzd35VcuTm/RVA/WkJ1j2P6n1Tf89iJrmQUrV4UtTtUIBdl9bw
 MSfEeVQKfTZGQx9kCw39JzB6Ovd1+zPZCr1isalMYeeN7L9ETON3qGzVp21UNMSITEFh3XjIKJ
 t68=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:05 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Date:   Tue, 10 Nov 2020 20:26:05 +0900
Message-Id: <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/iomap/direct-io.c  | 41 +++++++++++++++++++++++++++++++++++------
 include/linux/iomap.h |  1 +
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..f04572a55a09 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -200,6 +200,34 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
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
@@ -278,6 +306,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
+		/*
+		 * Set the operation flags early so that bio_iov_iter_get_pages
+		 * can set up the page vector appropriately for a ZONE_APPEND
+		 * operation.
+		 */
+		bio->bi_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
+
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
 		if (unlikely(ret)) {
 			/*
@@ -292,14 +327,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
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
index 4d1d3c3469e9..1bccd1880d0d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -54,6 +54,7 @@ struct vm_fault;
 #define IOMAP_F_SHARED		0x04
 #define IOMAP_F_MERGED		0x08
 #define IOMAP_F_BUFFER_HEAD	0x10
+#define IOMAP_F_ZONE_APPEND	0x20
 
 /*
  * Flags set by the core iomap code during operations:
-- 
2.27.0

