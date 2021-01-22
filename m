Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519E92FFC83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbhAVGXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:23:31 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51034 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhAVGX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296608; x=1642832608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tc4jvgtKmRYjRYt//weEvB2LvZuw7y0rhdeJ8hOnRVc=;
  b=CkfhkoJvot06S3dUr3SVNAP5HpwZIlD0fW5a29t7lAUxOY3DVvgNWANP
   jk/SRr+30i4ho2oVVQhgn4cV9r7L+aFM5rKK2wKr9tiiTwYkzcdCGHDeb
   t0qFI6NG439Fz8GlqqTaZJfhoffX+FyBuLqngpIlsjzkAaArfMMmmlGec
   vFfDNQ2A2b2C3fSL4V8100kN1WqBf2QrfXKUyA7Jz1KX/Cc7dS4Zjc8G5
   YAbfhlAjWzaTODVixZ0Xn4o0Nh2WPME3dNqwzpgJ0bb82fjl+BpzjHn8b
   1EdqpXbFW2gyPEREbdgGycEPLKqPnsqEhk7z6OF1fcL1krInxkvz9ltay
   g==;
IronPort-SDR: hBWY6fGwj1Jf5VQN4do7u03e2LZ5CZXx2zZE/CPYou6W4+0N5P7hkZJ3+/TsyTmL3Wwnv1whyv
 pAGR87JZSoDaebcwY0Bt5ZHDApDVIkIbFzHlvt0Pyh3oAwINOsdr5EBx77rojSujn4kDUejWEr
 hc8if9RpE/VfXsxgpmQnaIr+vvFealunx99ltuBY0L2dpK2LSX90XDFLnQX92joGwm13xQ/V41
 6A3+Dl7NQzXkjWQOp9UzU3mvwVHu6wgjbbYQ3E45y0NDXQKyc4CJw631TZUqZtQHSS5bCfhqdr
 uqw=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391919"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:22 +0800
IronPort-SDR: G+xLyz2mnXaEEeYqiStyfYok04I+9z5spgznJTD4UmBR+27aVsnRIFdNSdDNVdecYn9QHo3y/p
 Pr84HFRjTDsfDuNO4b0USjT0aEsir2xd7909UyFoUFnyecTDSWpzahy8JWy1fSMdrbyLw9EPKc
 X2j7rZrpFpBlYaMxKaRvWAZ5Urv6uDGE9RopJMserKPDxvLJ432++HmONMUA49vGcP/62jwKdl
 A2CQf1eThT6VYeTjA1GlC+M+F++Gsrsj8RuUftzAEybBY9o03k9SWKeQtChewoWx5alYa0ccpq
 Pt0WbMWtMcn/shVkCGPs80hz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:04:54 -0800
IronPort-SDR: 4htMumFIsnksP71uIavYO+wsQ9fHomNTfjCLv/A6bDjk+FFzAdeVlZEpCQTgbe0eDfvkgOy0MJ
 VV4V7lPidOb3AIUGsHki2oXHyGyag9VuQ5MnP1w6AfDcZXpWwrT7uXwtI+LfC3ur4kWAIKkZA/
 1l0ETLF68szzim3gBXOz4lP1zsKDTFqYUYHmqRgHrrN+FMUWqN0wfdq52GJ+P8OfIFvotkQlbA
 1Rzt4vbVkV6aTY3qadR7U7Tg6J/3I4ZwxqKTXyZbRVm9F6cyz2xfYYMpdDS4hyOAkO34/FMmwr
 tvY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:21 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 01/42] block: add bio_add_zone_append_page
Date:   Fri, 22 Jan 2021 15:21:01 +0900
Message-Id: <94eb00fce052ef7c64a45b067a86904d174e92fb.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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

