Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9077E30497C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbhAZF11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:27:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33033 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbhAZC1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628028; x=1643164028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eQqHLsjybb7lWCvG4dlunJ6qzMlBgQEQm6/04cQWSLs=;
  b=Z2imcZ/EOemTr+P6deOUZ4LE9Uol4lS9iaY3cHrOxukwz3Ig/rr+ecsy
   hkEZ8gvmVZy9/3w65LkPW01eVGgQ93mQeyZzZP15nYUw2ZO2Hi4wbDKkI
   TIbOeQjqcvBSB46GstEWgXjGFIybeghKQ2L2rMD5mZM0MLpA5+0UNM0H7
   8B9tnfWOzfDyM+KNxlHLGa0HHivlbxvULPM308qf0TvFHMuJg5Q7gVK9y
   16HLSe0gKD76Fp8Zme4z1tJKyt5jLqKXLSXThxVUBa7Lawv+abW9dqleT
   aV72cOprSgBzrR3bU7Dh1DI/Hb1bX5mBQsDsre8bcuEs/WVeTYr0+avGx
   w==;
IronPort-SDR: jeOkewXojZEEW/u7rYtZdrSK9D0aQgmfXhNj83by+y/6AfqSWVvr59c3H7aAE2Kn5VRf2Ix/P5
 c100UQQhOXJZT3CMjeZv4a4/Oq39gxNQYp9HUN/ajaVdiXh5N9ff1wVPidXVhfUhup64/QmQ0N
 gBKhgNL5eCNFendohLOOVrYHFrEjR6bWzLd4hfJXCRiDSd1sBZRvRM89CsIBGpj75p/FHr1Igj
 EdkYWBTbMZfgR4MBFXeRs4+S9fhX4fE52fEZeDrRmpO7WEnBCWG0qCbCDYF3Gf5PmO3fURNCo9
 2oM=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483496"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:01 +0800
IronPort-SDR: QbxyO2I9JObZrdu5fAH8iu7EpHMrmGnyaWtXSlT7sE+uXml80q1aRL1fjlBH7I+ID8Pv5OZEjM
 jmHOonu7i5YcHI3+nrdkwJlZdJl3HrNbdssmws8jfiWgrRnnynCIPOfc+LMIV7v6iTBDCHAY9E
 A3n73Ly+PenCEX99SlD1QlddpKqEv/XKvKQxFxANx322vmcil/BQ3IxcWhozs7B5Snn2yKvWR2
 lvmfJBse80rIsulzVeI0PiqbZVUjrzU+hyNWs0/BEAf0sQtUFP15mAqJwFmxj0VYrgH+GoHACR
 NRljZZ51oFhuFrV/7RXrBTg5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:27 -0800
IronPort-SDR: e8ZRGeefFLl9fyACTmPhDkolUe9PxYQU57HxV3qH3NXhG2lDb523uPXmj+k4s5rr28D+Rd1lrk
 Ej2SjcIji1k5NAz08HzmDK7A6Ya0wbK8ulP/Au1E4COtVG4rf2/2m8CRT31kznyUVbJyo2XS5/
 3ouNrm7vgRKmfwkK6+cR4Yaa9RyL1OeCMaqTYHB6k3TEjIDuO7OE7ZJSenGc9LMa2w8X/ynnGd
 K6UBf1NBeBDY3QkW5iACE1rUoybPapuBs3Eu+MtEcQwjTXxpaELlO16eMqtVoJAk9OanUrqFYO
 j7U=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:25:59 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v14 01/42] block: add bio_add_zone_append_page
Date:   Tue, 26 Jan 2021 11:24:39 +0900
Message-Id: <2a0a587139de5586a2c563e4d43060b9abcbf1ed.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which
is intended to be used by file systems that directly add pages to a bio
instead of using bio_iov_iter_get_pages().

Cc: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 33 +++++++++++++++++++++++++++++++++
 include/linux/bio.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..2f21d2958b60 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -851,6 +851,39 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 }
 EXPORT_SYMBOL(bio_add_pc_page);
 
+/**
+ * bio_add_zone_append_page - attempt to add page to zone-append bio
+ * @bio: destination bio
+ * @page: page to add
+ * @len: vec entry length
+ * @offset: vec entry offset
+ *
+ * Attempt to add a page to the bio_vec maplist of a bio that will be submitted
+ * for a zone-append request. This can fail for a number of reasons, such as the
+ * bio being full or the target block device is not a zoned block device or
+ * other limitations of the target block device. The target block device must
+ * allow bio's up to PAGE_SIZE, so it is always possible to add a single page
+ * to an empty bio.
+ *
+ * Returns: number of bytes added to the bio, or 0 in case of a failure.
+ */
+int bio_add_zone_append_page(struct bio *bio, struct page *page,
+			     unsigned int len, unsigned int offset)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	bool same_page = false;
+
+	if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_ZONE_APPEND))
+		return 0;
+
+	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
+		return 0;
+
+	return bio_add_hw_page(q, bio, page, len, offset,
+			       queue_max_zone_append_sectors(q), &same_page);
+}
+EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
+
 /**
  * __bio_try_merge_page - try appending data to an existing bvec.
  * @bio: destination bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1edda614f7ce..de62911473bb 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -455,6 +455,8 @@ void bio_chain(struct bio *, struct bio *);
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
+int bio_add_zone_append_page(struct bio *bio, struct page *page,
+			     unsigned int len, unsigned int offset);
 bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
-- 
2.27.0

