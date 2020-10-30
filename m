Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE70A2A06CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgJ3NwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21969 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgJ3NwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065942; x=1635601942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ackO2U078tN9hfYqk2z+v2pR975Co+JjTSV3v7Aa2mk=;
  b=GAU34rI2G96fj19NKqdmyC53f/qye5F6PXur287OpTxPkMaA4uYioSWV
   xCVumwpaNbraXqZ1aNIPrXH6LjQJxvnW6cC7YUNOMro6xN7sCTlFDFQvO
   5Oye02kBvVIx8EoEJdo7My7XiplHoUBKgOFiezEalU0YouRa9WMWCRi1o
   1icyiy2EQ5KCdPBzFfUgfiVNikhV8crQjP2x4xu/c07mEzfp4G2yGLDWY
   BZ+1SJyI1W7g6S/3oz3P7gdWWf9wEng3FliCYp5sPXyqTP+LcMURS2ogO
   9QQQ7iGaIA2E2ss+fEzc3lZYQmWYZ0+FU+HNNfYltVWNQdM0ufzZIqKU4
   w==;
IronPort-SDR: TMRZ7m/tDq8oPWPzGgNux+0TpR/BWQkC6LBeDLEIeRYQBY2+N8HTHBD0gPLREeSLsYZ3NNAYuu
 +ddXrZKrQYMLQkrL6niGKWca8bedhfEjceTrp2ZUa3+pmwvJEafMpxD5U+RuSwmE8M9H/fVttM
 6ziafYUEOIe+AVy6MeWBtEzNuvqiHjYakTfa2dECdBzJPDqM77b6kNaAnvXdeBiJGH05pbOWAW
 0+J7yekPdVddZXj3xOFrHOY4q/6CshGg0Dq8huiZukZ1vZ6XMF9yhlVBfBpBU/X8QofK86jpPR
 304=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806570"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:21 +0800
IronPort-SDR: fMMweYDwB7dgqo3/fYFxnUQC4+t4W1iT4EUJWKruU4chME8ahLQznGjwJb6+ntBD+rvTJuhBZL
 8oGIHbvCIfVu2T+PulVShbNdtaPqjfnJKunkgP7YdXiXRNFE/ykRvoDRRX3XfR84XvXzsod8iu
 VRdCg+wJWsqSbeIkDJp/OnohOZfoXGfYP9/vA4WumCXJv74eARYCw55qhIIqKWEe8QjTgifcm6
 5rzNrROTN0SlQMWVA4EDcNpRiDcYn0ajLPIUjfkZarn77A8RpWzmxXFx0MxOPGgQzeo0X/iZri
 9Lt8NREqpDCKXFvCNb6A6tH+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:36 -0700
IronPort-SDR: Xt/hPeHC+IE9nSr8qRAGPZRJHsMsv2hI+eBwSz63plbmPEhespV3GyA9N4m0ExHBUp2AzUIz63
 1oqmN0U7O+OzXYl0piVeTwxiOjMRmZ328fCBkgWKLL1KgqU+e7NlqkJU1d5VqV5KXKuLVFfHk+
 UA71hnvMJXDh7CgGxVAnlRHARKulZEk4mcDlroIM9MwAUtYL019kXmP6P/dIqoDTGlTtX5y7OR
 BgYa35fSqeBr0LpGltoHngPL0IhHXtFQ9KWYiLszzt3AoIKAsklTfTJw6yOWZ2u3Qi8Vl1sKNo
 rY4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v9 01/41] block: add bio_add_zone_append_page
Date:   Fri, 30 Oct 2020 22:51:08 +0900
Message-Id: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1604065156.git.naohiro.aota@wdc.com>
References: <cover.1604065156.git.naohiro.aota@wdc.com>
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
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/bio.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 58d765400226..2dfe40be4d6b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -853,6 +853,42 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio,
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
+ */
+int bio_add_zone_append_page(struct bio *bio, struct page *page,
+			     unsigned int len, unsigned int offset)
+{
+	struct request_queue *q;
+	bool same_page = false;
+
+	if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_ZONE_APPEND))
+		return 0;
+
+	if (WARN_ON_ONCE(!bio->bi_disk))
+		return 0;
+
+	q = bio->bi_disk->queue;
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
index c6d765382926..7ef300cb4e9a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -442,6 +442,8 @@ void bio_chain(struct bio *, struct bio *);
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

