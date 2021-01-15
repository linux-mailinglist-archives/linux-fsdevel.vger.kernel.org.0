Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0662F730C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 07:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbhAOG4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:56:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41680 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693794; x=1642229794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cV8mSpl3hDmF7Y62HKxGpA/uecu7FnYx08eRGKjzOw4=;
  b=EURnZ/q06J+yug2rdmjLwwk4Jly1CrrDe89uZWrY6iCGvO4KIW4GpgNw
   zAsrKNGfcHJm+HNz2bbRf6R5i9Vtlajh7sk/Fx/0rCqXyOL8rM3JXcCfP
   qv1FRuiWC8whlIuiqXnSykawBvecA/CMQcB1ZFiqzwAh7L6wX/Pqy2+dt
   Dmi1NkmyFxqZD2bLQ/onPo87IQ704maiRHLu23+e8iygOhU7AIFjzntJF
   2qJrenxYFjM/NeYBVV6p7wSnj6c46da76NYSSmKXD547PzkBkYplowgOw
   6wiYY6zzl82iRkJ5pomlHIsuLwYJPOp3jKNC/2jqaiIDYyZPjf7ZGr94D
   g==;
IronPort-SDR: yjgb1u5GcH0UgA1vYqLjozjSkoFj88jg5w8cBUydfYwjO+tw28QaTXH/djTopFhcVuj5JjPWUa
 1ALQY4p2jKRJgpxiGNeNgHWwnRvxEyVX0WDHf1h5xMvMjw4FKZ4uFKn3oyy4liEjNTa5VJc7Cc
 8jiiYK2804slobbm3jijjfZOjTq5LpVid2P4c79xZJiuznKopTQLNt7XMG25x8wPM5Ms9Q/xfa
 ep6pzR0eFn1Gwpdae++cwooGtCry9hhBBFEwvYdHolgC2pbcNHa9sZ+sTq9TRQSS2FDvXJPs9n
 ++o=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928176"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:05 +0800
IronPort-SDR: 7yBUaecGf/C81xgTmTxNhQkgDky1syjYUgkcN+85G0uxDXPNOxJotIA6VURl8Krleo5MwLYcYW
 TRNsVY7GCs2WeAYDTZquLu46CuL6WRLj53Mlme1nvfAP82EkFoWf053H1K8dV4YoHp4W4PCfsZ
 d6XAQJxqYenvFTxVpndVuQtCZ/UrtW6kI/PLzdmVFqmQ2C171HPgkKzygCPe15ozdS86buCtj9
 IgYDTm7KbwoAhIgwT1Dno7lXMhrMJxwXunUVtSvLckHqxCEUDGKvVdMRglmpKV58Me2xaxC/fv
 z7ICkDvmYgKWGA0lvI0elAVL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:39:48 -0800
IronPort-SDR: HVJkhQNys2w27pzx3tAlqxjh7ISrAj4XQU5gAludki91qmgPgWb9nXtLFgpQoyRHiVeLL8sVhy
 edqXr82femRF2bGxn8KPZSFx0EmDqNIHY3ARrDe+uFZMNMQeEjn8ff+kxLqVvJz1jPBz9OvQx1
 wKQTq+ylwVA7maIDIMVPVhNrPB4flex/ulrAkb6pAHxotYLPwL2AeAKFrgo+NFbLsrnftVgS20
 Tds3hxpAO4rS3TZqDlX6BrsHE5+9wLo3EoeN1FThUvjjd6I60rs9NDF7yAUIYGgJ4HRNsaRtnW
 xok=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:04 -0800
Received: (nullmailer pid 1916420 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:01 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 01/41] block: add bio_add_zone_append_page
Date:   Fri, 15 Jan 2021 15:53:04 +0900
Message-Id: <8d02dae71ff7ec934bc3155850e2e2b030b7dbbe.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 33 +++++++++++++++++++++++++++++++++
 include/linux/bio.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..a5c534bfe999 100644
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

