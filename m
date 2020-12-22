Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716752E04DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLVDv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:51:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46436 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgLVDv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609115; x=1640145115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L306P33jOLf6svdQjsNWRjnB1A6g8bi2oLYv7PhCk8Q=;
  b=aVT5Kx96tHE1qNQjCy4bxts3nw4AChhBDjpB5wD+0TqwKe5qr1EPFKqO
   ad783+vTj8gsrk84BfnjYxtwTk7Y0vZqi+j7LHrzJgltzEfXEaVxyEeTX
   2AF3ppdO6agksF2zGgMYulrq4o70PM4PxwfrtzmGdzjpIMK0X1jusvV0w
   J57Lr50iBzPfrbfysPFe+H59usCW7YcE0Ri5wXZ2Au25nf8W2aAddO9Fi
   rUU5UFzsV6OHrTrvAcnx4BF9D3a+pUFQSnGIsxVvPrW82Kn4bdGzBY/oM
   ByYEL4JN/N3kEFgV9wiJ98l9n6kWv2JLqQ3ptlK361pC8gfz+cL3YI/MK
   A==;
IronPort-SDR: LKVUfH7qy3sEpraGrWTv8g4AUCob/RKfpxWdVQepOkUoyng8PQewHWmNUsWGuOfDAfBZUfigWm
 rdZoZbEh1Htk4bVhyrr4Lpqok1VI/+Hy+IfV0i7SRXWFGXPQYiEsie0mp1VYmnmoLKgbJTg07R
 HtK5mDBUIUaA7/AuDI+ilfv/Udqi5padyrXt61tePuoHsM6yfecvbsRAGo597bA7EiI9E0wO8/
 le7pYELt9CYB+4Ia72+HQvuMjVzryhpvH/K+gfV+EzjZlzfsIGkwBozmRqMFr7jGr+dAz/wSXq
 HDo=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193712"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:25 +0800
IronPort-SDR: 97t3EwjmAaalN21XLHz8d1DgYPVYT9gnY9DM+keoTrlIro+Z1+tSmm+HDfDeHWrUsO310Iu5PZ
 /kZzF+LdYlCjKtluixs7dGR3Uz1ptN7INmJZ3zfAuhIRC8bh9cXilGUjmQPzag/f87Y9J5ouGQ
 qF7pe/3wuCZUl3P0qZnXqlf6k9LVhgVFdc3Ig3uMAUFtwHsGtZt524jZCAXtXHDd/jMDKYnbOA
 ytMS6UozYpMEXi60mLhvxJlgkdJIqfj8cqZkE95pknrsOSuoZn17isBz0ru8CkhimVYwrMOEQF
 JdYKqCdCAOjicPlv9+UpbfGQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:36 -0800
IronPort-SDR: WSzmHQsQjSWX+v/mV/UfsEFuvhb0X5ZTMurEBU7R5AB2njfaOsaebNAP4JE8W3MIUw3P20OjoQ
 0Gjmp7i/pEgU8TtL3ST0T5XVn4BhTrgLYswLTI/BIxo2InOMwfh+1nUTuwsacqkl4CDQsOysTf
 mRqMi4/X9Z7tsi9//unIMT/90WIpOUUhwz1LqAimf13hBa7sVABAtJzXqemTrCUj/sxuOX14wj
 RspEfGjhPiRX5zGb1AZ7cxDIHPTroy4LS7E9jWOLwMcvJDlS4Dq3Mlm2wR2hPa4SdD3M4BkPeX
 qqc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 01/40] block: add bio_add_zone_append_page
Date:   Tue, 22 Dec 2020 12:48:54 +0900
Message-Id: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1608515994.git.naohiro.aota@wdc.com>
References: <cover.1608515994.git.naohiro.aota@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 35 +++++++++++++++++++++++++++++++++++
 include/linux/bio.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..a6e482c8f43f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -851,6 +851,41 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio,
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
+	struct request_queue *q;
+	bool same_page = false;
+
+	if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_ZONE_APPEND))
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

