Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982942AD4E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgKJL2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:07 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11933 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgKJL2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007685; x=1636543685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BuRFMbf+ahickXV6NT593M5CLgBwFnCrpXMYcWjKFAM=;
  b=HHl1qV5DTGWW6CMwx+X+TqhjQRsKDyEnO1ecNUpGdWZs9C3MKa9dhQoo
   sVFt2QDDV9SG04jklXl9W7orvWDWle3kp2U6up/06ZCgtsbWZohQAuGij
   H0Lg+qEIYEg5cN3ewyAX4eil2hRLUECMmmQ5iVTCLWKgg8dQsZmtED4eO
   2COuMNARmgS1DdxFLXVmka4WuA83ev21+uz4ozdguUv2xYJGEowIxMG22
   G33aslcn49qDzk9kGgdbHyKWLNBEOCN2KqLYZAQPmnWztY+wPHN31rX+w
   RXx/Jjd4THdGLgnoG5qz/riSoBGHQMjnhpiqKond28sfuqGVkukM4i4z4
   g==;
IronPort-SDR: f1wjh3C4aRlXuh2ieCU6DBi2L6dbDqq27ZoUbt9pa+BcrPsX1it0rS8z6KCyaNzQpxDGn/CEr9
 fXeoMq1oDo4TrHO8Zvl5NE0LNIyYVGcvECrfJyZMCOsv7ir7e05L5hyaQl2GlOb15AZVyDtMga
 aYtL0ZuJju2Qg+LKFdfWBem1SezcISzeBruDtXuYqnGo9lZvJNIDoYMay+WTYsNwOj/xdziPcD
 1hSPAs3ulAFjWrO4SAhspuhYH3SvsOnb9Uvy3xPM7OqMiqgMuZj7WtoZ1QqaJJzGlggOq9s9zr
 LVc=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376409"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:05 +0800
IronPort-SDR: ae5CWyyuLvH0bNoQZn09RNCV5PfrhrdK7182PdqR5OGAS7Aa0BzQIARri/1vtYmoMAelmPh5GT
 wFvbbIioXV1OlqI0OKZSf8LCKIhxqLS6CJ94zDaiSZIKKDuviDH3UqYa3eDEf4GubCLT2G5yhZ
 n3SxsDJkMqG7Sry8nHPpyNl8chT3s6ldyaoTFx7nzFYYMQ7GPoVtcggK5jCeFF4Tjly6QE4cv4
 Jt1wrif+nccL57eZ2fSX5FZp1ciKBDERDjaIKRgUeL+6V0/UM2x5mPYy5PtN1XOIsQMA2VZGlW
 YhuPhIfjgmBn4fcCqfX7IXmc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:06 -0800
IronPort-SDR: tw16f9TXcwu7AadHvvBEUstkeljEO2GSMLkNdJjpJ0enwCGlG1rFFEHdz2fiKLCHHpuVc+pkk+
 qCkVMkHezCXMRQpuSVfiSejc1/W6rxAWHZLMMhyDfdN7qps11mM1So3WZzURbu9j9OdA6W5glw
 GWb8DzvIb0mIb60XjhwIY9CywY77TK8A4DvLj9ovg3oxAfMy3ojAoXDHVBH4b0bKHsSVZ3yuCt
 3s8ZL722HMXdKVTmNsUtLByHrpSWXxxK/dOOouIFQdSpMjmbxVvYaXc88uGDbAaFss+37yYYtt
 +BI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:04 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v10 01/41] block: add bio_add_zone_append_page
Date:   Tue, 10 Nov 2020 20:26:04 +0900
Message-Id: <01fbaba7b2f2404489b5779e1719ebf3d062aadc.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
 block/bio.c         | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/bio.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 58d765400226..c8943201c26c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -853,6 +853,44 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio,
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

