Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADC330F07A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhBDKYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:24:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54218 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbhBDKYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434240; x=1643970240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BMLhpfHfBzIq80REyLJtBw7YshDs+nIEmFK1hkUa1t8=;
  b=HPOGI6EQXySJ1hSeeASMbhDPw4NxDSSfSidcJspHj+7jjhQXEPS87Zfw
   sC7wcSrY0FOUUW7z02tJxELlUSfZ0alV4d/HNj88XVNUIwt/BxdywShvo
   9waXqfZDV96VbiLV7qatGly+xRJ34yOw9DiQCejEGV6EpqRnb+V92eMK+
   LltD9uqQ5d11tzIm9Q0Nf9GdmK7Bwdgsp71d5aJdKqsCcFggsGtpH2czf
   3CDnalI0XczCcSbqeXQKfFxPKclmWYDqVZQPbxK/QHR1aSlazCtJA3qLy
   1q+uAATtxcZsk0ezzqctY81HZ5mBhqsGPMcB+e+CoR1MH7ImVuLthOy1i
   w==;
IronPort-SDR: qj+9R4ntVQ2okrvAzc2utO2gDD0lalDyD7VaM399SOq7aR4Zd6cMsNSRhMUw9Ng9b4Cy3TQ/+w
 HnaWYJdY6/raVVaHGPJTYqSOO9J8mP4eBu66OXe/4nOKDHFBbVDVZCAquU6r/G3dE8iPLjAzZ6
 gwUxnZ3PYqX44Hn4ehD//o/6ndDq5iHQdWWKh27u2eOoiW3WpBAfNAo+Gt6HLlsd+OmuaU7HDH
 9TXNDr+kvFAWpQk+wN3F845NvYazcXaxaA3ARo5G6tLKl4TKduYq1VCjxggt86/xFN1EVmsJOv
 ti8=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107942"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:22:55 +0800
IronPort-SDR: And/SLZwm4WssPnlyQn4jN7Y/d/suMD5F2+wDJND3d90J3oNe/WUvp5f4p+aTXl9GWjmssOFj+
 pp3GnhGYMzu5YAP5uFtaEjy2QVjyV2sQ3SQvQle4KvKOO8dLYK4b8cXG3oDxSAh3U9wWhK9BwI
 j0aVV8vcdy8OnPcExaKDBGjpPqNjn39UxWoZonkEDBv+MTIb9MHC8BLgunmEQmNczYEGtGfP6A
 I3viqQSEkxHf2wPvMJt7PWTT80gFjKBLtt32XPaZKiPIOg1HyQfpAJXroEh0d9sdTtjWI2iWhx
 DUy4fuj6iZk7eRfRWRtJ6nNk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:04:58 -0800
IronPort-SDR: 9Jh2cmnEWePNq86qjtv7lNRtPSGAAZ8CDZFM+bADgWaXMgdPXPggcHK3kAK+aQCJ9hwhDdgzVm
 4nltHnmXFZRQd9CpkE4cySvr8JrJxdxOQJimMS0CXqTNhE5sCsu/aQmOzPY4Vwd2lyfiUJdPem
 90YwT+D+HTqUPMFpKbZb163FG5m4igG8uFylQWDVFQ95S3YcjNceesvmm+w7MSqoALvXgVl5wY
 JvSIqL8vx6mizqD1exD3PqstGQ7hN8sYBfSCpNqirdBGuxYvcQyuroXkIj+qF/oLv6QlLQTJUc
 ryw=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:22:54 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v15 01/42] block: add bio_add_zone_append_page
Date:   Thu,  4 Feb 2021 19:21:40 +0900
Message-Id: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1612433345.git.naohiro.aota@wdc.com>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which
is intended to be used by file systems that directly add pages to a bio
instead of using bio_iov_iter_get_pages().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
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
2.30.0

