Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67532AD4FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgKJL2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:43 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11994 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbgKJL2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007718; x=1636543718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sKARQgR5Wfxf3GLvD7ZCEBxfMjbSuqApaZ3xwA24Wl4=;
  b=Vqa6BcnyhQQhnv+tvBp+QujN2bFLVp7bjT22THYW3+4g2J1B4EVGqH60
   ozA2Aoh9Gu7Gx90ofeHR6ohpxhq/R75/P+T+LAFQlNwKrrjk7OggGlKQj
   vpMQFUbPwzeh6UuEtBPiHnJni0xQ02JaZZCvb9fLaQ4THXSOCU0PEibel
   +EgM6+IQZKJ5XD3n9YQo1pce4icX81BjAY670fCbs4C6+Ac1NfhClUQga
   HPuGZt5ZhXLOcKzZwQBJ3pnVfawKejtiUMcJ/oEkrF+hoXo+JQC3jg0wp
   YsCjdWUCI9medwpmcxDcKToTg0PoWsxCCRn5Lo5IaTLc/lw38wxGMUXhJ
   A==;
IronPort-SDR: 653FIuNEF7b2GRoWk0Yv9zKwbSM6FJbMhLkO6C/3aocyHmFVHMvBp55Thf6rnfYxBMoIG+JZd6
 V3iWHrOcTY+tNS7+Vq7ukbrk0DfpOLDP5p9dlwybF/HateE4XHFgdNQ20EX/c/bZxkhkVCyJck
 AnqbiZY12lj31Lox69uTuIc0BBGW0jmY1MuZLaX+f8jTPyXZ1odKQKkphV0QaAEsJkK9zT4UrB
 ftGux6TlKKpJWg/rHyQOv+QQ8iGLwTMnr+6PKMFU1L5ohjJ0WQMS9rVDRfUIemc/ka9ilwUC44
 eJQ=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376526"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:34 +0800
IronPort-SDR: /Y6d++q3pukPnZ3TrBGJz3rujdtRKtaw2jJ9tza4vaMynZfOUamwRADvj/EdaX0Q0Xj0Vmrd1e
 vdktxkfMOrCeVuBzhyje7yV+qPPsvnKFsKJupQO7IixQ4c8hd6l0l/J9tUJ4n84WVLsPMCUkKK
 yG5N23hYt512+7bmoJwxoI9r2xYteAzKPhSVtEczGxzMYAEuoAqKZ8F5wI6JQX4QWfCS3On4RX
 E3cmDHWaSYRMHiZ+/x3LoA3gsJoZCGqVDL8kn/stAC8WkqS/Es7PIrLd5+sNUmUMhqaqk0SJTf
 PGRI1a9nZUeLe2/VKfmwDbXh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:35 -0800
IronPort-SDR: rt4XZ/Dd8G0EdhJwMbIraOZCZrrkIPcjP+wPeSMK9Ab6y/U5W5NJTx1KmZkAsCVMYdQ2jAz1js
 LYVTpHR3EJ1cAwlL5TxFJSZOYRdyHwgFKXb8Dpv0ex7aBCV8tWPEzIk8Ed9kV3sNHZ65qqeDzI
 qbsqb7rVB4ihvTalYtf+6s/QpSD1RYt+hYCjXd1OtjVGU+QGAiVTR/QtBVNIyM3yTiimR1d/Wx
 4RMvNyjsCSX56IPEbz5yMF9bNmqoK+RfHYR8TBpBxb3NfHXmoOE9rOyzOyp5hBXN6gumo2WOsd
 AZs=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:33 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 18/41] btrfs: reset zones of unused block groups
Date:   Tue, 10 Nov 2020 20:26:21 +0900
Message-Id: <7b1cd3bcb175cfc8d38b118dbd5bab99a483ca2f.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For an ZONED volume, a block group maps to a zone of the device. For
deleted unused block groups, the zone of the block group can be reset to
rewind the zone write pointer at the start of the zone.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  8 ++++++--
 fs/btrfs/extent-tree.c | 17 ++++++++++++-----
 fs/btrfs/zoned.h       | 16 ++++++++++++++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 232885261c37..31511e59ca74 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1470,8 +1470,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		if (!async_trim_enabled && btrfs_test_opt(fs_info, DISCARD_ASYNC))
 			goto flip_async;
 
-		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
+		/*
+		 * DISCARD can flip during remount. In ZONED mode, we need
+		 * to reset sequential required zones.
+		 */
+		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC) ||
+				btrfs_is_zoned(fs_info);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ab0ce3ba2b89..11e6483372c3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1331,6 +1331,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
+			struct btrfs_device *dev = stripe->dev;
+			u64 physical = stripe->physical;
+			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
 
@@ -1338,14 +1341,18 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
+
 			req_q = bdev_get_queue(stripe->dev->bdev);
-			if (!blk_queue_discard(req_q))
+			/* Zone reset in ZONED mode */
+			if (btrfs_can_zone_reset(dev, physical, length))
+				ret = btrfs_reset_device_zone(dev, physical,
+							      length, &bytes);
+			else if (blk_queue_discard(req_q))
+				ret = btrfs_issue_discard(dev->bdev, physical,
+							  length, &bytes);
+			else
 				continue;
 
-			ret = btrfs_issue_discard(stripe->dev->bdev,
-						  stripe->physical,
-						  stripe->length,
-						  &bytes);
 			if (!ret) {
 				discarded_bytes += bytes;
 			} else if (ret != -EOPNOTSUPP) {
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index c86cde1978cd..6a07af0c7f6d 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -209,4 +209,20 @@ static inline u64 btrfs_align_offset_to_zone(struct btrfs_device *device,
 	return ALIGN(pos, device->zone_info->zone_size);
 }
 
+static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
+					u64 physical, u64 length)
+{
+	u64 zone_size;
+
+	if (!btrfs_dev_is_sequential(device, physical))
+		return false;
+
+	zone_size = device->zone_info->zone_size;
+	if (!IS_ALIGNED(physical, zone_size) ||
+	    !IS_ALIGNED(length, zone_size))
+		return false;
+
+	return true;
+}
+
 #endif
-- 
2.27.0

