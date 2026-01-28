Return-Path: <linux-fsdevel+bounces-75755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPJtI8E+emlB4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:52:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F6A64CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3383312BF14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE93101D0;
	Wed, 28 Jan 2026 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0TC8holf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7630F552;
	Wed, 28 Jan 2026 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616950; cv=none; b=g2yyVr35umlxunFX4D2s+I7D99/Wsi8k4j7JF6jCe4fMbALUItmOaikpr4c5bHxvK3KZ8bUh3BsVw85SePow6NsURH6D9Ax9hAzrCtlHIDR70p0j0ojPFNhRuQxPwGwpCUtXpp5996GnncKL7EeT3kIDGFiRXZI7f1lLar/p5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616950; c=relaxed/simple;
	bh=XCBgujNdB5kJiKUuz/M43ejJVGzTrAJ4iBEfI7HwsdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpLWxCV8F4x/NubtTPNYdtSHwDkLh8uxVYZGZhs5wMHIGQq4v6ERqBwXc35NJlq8v0NiAa1nBzrd7ezlbB2Gev2QRjGk7pQWKFTx6M0iuDPBwC7+Q4qHStbFRxfp5uyvH/GXhPjRZlc8xiRCWfU/cWHP53+ym6oVOkcVo6XYx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0TC8holf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gJQ2+CYgFaec9d/WacYhwwNQZxMMKB0dkPDrxLtVzb4=; b=0TC8holfGeATni66VcUHYMdkcd
	Ke3XtAKkGzOQ5JiKOBkbzBNGtwNjG/e0EdJ/G6FkNq6yRDSLBA6PxHoNq7DFVcahVZB4auroRfSWy
	6BYUV0/MxXne5ObO7H6b0Dpdn312C2HuIDcFGghiWQzRiswngxxX8lz+YQPZEG5Vi3Btpc+YJTQ7u
	hn37is5XmW7S16cp+f0KbntWaJ6les3i7YNf70leir+aCyOcVmbi+n1yK+nl33+f0bv3QmlvKijN6
	N08HB3loms7Npm9bM2nwOV6f+tR6GjcnpMAHtYXJNjg/6HwRnoYD/K3GiaDZ4Yob2yOzrSiUyqNY0
	/hpvlkqg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl8Cp-0000000GMz0-1gHZ;
	Wed, 28 Jan 2026 16:15:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 04/15] block: prepare generation / verification helpers for fs usage
Date: Wed, 28 Jan 2026 17:14:59 +0100
Message-ID: <20260128161517.666412-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128161517.666412-1-hch@lst.de>
References: <20260128161517.666412-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75755-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email,infradead.org:dkim,oracle.com:email]
X-Rspamd-Queue-Id: F07F6A64CB
X-Rspamd-Action: no action

Return the status from verify instead of directly stashing it in the bio,
and rename the helpers to use the usual bio_ prefix for things operating
on a bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio-integrity-auto.c |  4 ++--
 block/blk.h                |  6 ++++--
 block/t10-pi.c             | 12 ++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index b64c71a7fc82..ebd17f47e0f9 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -39,7 +39,7 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 		container_of(work, struct bio_integrity_data, work);
 	struct bio *bio = bid->bio;
 
-	blk_integrity_verify_iter(bio, &bid->saved_bio_iter);
+	bio->bi_status = bio_integrity_verify(bio, &bid->saved_bio_iter);
 	bio_integrity_finish(bid);
 	bio_endio(bio);
 }
@@ -100,7 +100,7 @@ void bio_integrity_prep(struct bio *bio, unsigned int action)
 
 	/* Auto-generate integrity metadata if this is a write */
 	if (bio_data_dir(bio) == WRITE && bip_should_check(&bid->bip))
-		blk_integrity_generate(bio);
+		bio_integrity_generate(bio);
 	else
 		bid->saved_bio_iter = bio->bi_iter;
 }
diff --git a/block/blk.h b/block/blk.h
index 886238cae5f1..d222ce4b6dfc 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -695,8 +695,10 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	      const struct blk_holder_ops *hops, struct file *bdev_file);
 int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
 
-void blk_integrity_generate(struct bio *bio);
-void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter);
+void bio_integrity_generate(struct bio *bio);
+blk_status_t bio_integrity_verify(struct bio *bio,
+		struct bvec_iter *saved_iter);
+
 void blk_integrity_prepare(struct request *rq);
 void blk_integrity_complete(struct request *rq, unsigned int nr_bytes);
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c4ed9702146..d27be6041fd3 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -372,7 +372,7 @@ static void ext_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 	}
 }
 
-void blk_integrity_generate(struct bio *bio)
+void bio_integrity_generate(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
@@ -404,7 +404,7 @@ void blk_integrity_generate(struct bio *bio)
 	}
 }
 
-void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
+blk_status_t bio_integrity_verify(struct bio *bio, struct bvec_iter *saved_iter)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
@@ -439,11 +439,11 @@ void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
 		}
 		kunmap_local(kaddr);
 
-		if (ret) {
-			bio->bi_status = ret;
-			return;
-		}
+		if (ret)
+			return ret;
 	}
+
+	return BLK_STS_OK;
 }
 
 void blk_integrity_prepare(struct request *rq)
-- 
2.47.3


