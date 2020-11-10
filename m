Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5162AD50B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgKJL3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:10 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12022 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbgKJL3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007747; x=1636543747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sMvVHJ6TFdYGhKN5I5Yr/kCzLx1a7+nltou3ISSvzeA=;
  b=lqQhP9Q2wkK8NVs++Yzd6yLDLrQ0ZbNiXMUN5HX3p9fufREWoJTk3ayD
   7IG37FiHS/8/zVGxR7CLj2UzGkzMwS53IuXGYqf7rdRTRUIvvCmnfsZDp
   C406xR4CxtCMADCqv9oL+kgmxM95gNtMirbymdalzzDtQtG3R3OPKoO1A
   egjsXi9do4XB9Ib9pojy0BVLcYm3D/jJZra/fOnEJfR7e59lpLZj0rqvS
   SaRTu3iFFU9MnQWdpVkF0G62hU1k2F4XZwXeqc6rc+rStKyNf+kr4CLKC
   3XeHOX6SiZrgDixAGjSHmXMMghw6vBQXKS6Rmv1Nz6Nc6A8kTPp3lRw7L
   w==;
IronPort-SDR: QGVbxKe9tQnHxv3Cb+Gwetn2hifreaqm4ehDf8fbHoyWvaxJ7s2EbTIclSUZV7pwobHOKNRwc9
 LIjZ73XIRWRvdQ8uJ8yEbIS3SM/+YDZV9qS4ghCRWjjoau4naK5Hd8ejCgxPL8EK2lmkrcAk3Q
 rHnSTtqNnEnDztzbCGVktagtuRO/IV309tRSPNyb9z0T+U2vm6uk7lucsOUbp2ArJ4itdDi+1A
 LRWLyubNHywtTMZrK3zuQ7n3Dpu8rc1zRgUCViRcQ4PPVEhjY8pSP/AxxBraVgHIx3WqTPxl6Z
 vZo=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376599"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:47 +0800
IronPort-SDR: uzQiijWtlAP4tca3h6uq9tiptJ69wnGbyQUKSBa0WqE8yTA2OJhH9KkzYIZoVs76dTFWwIKZPe
 EKWdh794ydzA1Hxf/MYVQn+cMLB3fB4/XEi3N+Uj8yVlW0K6t0WVqRsJFF6GY8yUNWjAYlrE9B
 vb2TxbwSL/8ZG+UGRIk/l8feqLCUIqU4Hpjm1dKLyEz5K9rafhsV5LgDyYjGiBewHy32eVXD4H
 iAj+HlOgxReYTQ2YPwnOA3w/eSVLuZNaeQvJwkBKts/y33zD8xRl+jf90r6Sp4YPayk/nxWURC
 gHoV1G9pLQgN7JnivSWCvrrO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:48 -0800
IronPort-SDR: iV+DyAGixlRd/ix9HUOEDmQtqtm8NEf0ZGKsGJlKpvtzHW2PUQJQRbwMRPaqHwyOlAAxMRvNBQ
 TLug05e+9wYNvjJQfMw3uY1U8ZVATYHH8RiaOSxgogE62aZEUkuHDx1fcZb1LWfVNj0oSosq6H
 MC68Sfk5FwGi5ahq8IL7xJP125HyGj0BpyyWaJIYzvNeaKoSt78iWe0u6vv6yqcQmYtON5TYpZ
 gsfC82Y+tKFP7n5rRNKA//WE35kO1ZkxWVGVmSwo1vsRVod+W6LZwFZwK1uoGNJyO4vrDs1WAk
 jcU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:47 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 26/41] btrfs: enable zone append writing for direct IO
Date:   Tue, 10 Nov 2020 20:26:29 +0900
Message-Id: <38ffdd3dad3415079c350e284006d51aced384d6.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Likewise to buffered IO, enable zone append writing for direct IO when its
used on a zoned block device.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fe15441278de..445cb6ba4a59 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7542,6 +7542,9 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
 	iomap->length = len;
 
+	if (write && btrfs_is_zoned(fs_info) && fs_info->max_zone_append_size)
+		iomap->flags |= IOMAP_F_ZONE_APPEND;
+
 	free_extent_map(em);
 
 	return 0;
@@ -7779,6 +7782,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	if (err)
 		dip->dio_bio->bi_status = err;
 
+	btrfs_record_physical_zoned(dip->inode, dip->logical_offset, bio);
+
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
 }
@@ -7933,6 +7938,18 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		bio->bi_end_io = btrfs_end_dio_bio;
 		btrfs_io_bio(bio)->logical = file_offset;
 
+		WARN_ON_ONCE(write && btrfs_is_zoned(fs_info) &&
+			     fs_info->max_zone_append_size &&
+			     bio_op(bio) != REQ_OP_ZONE_APPEND);
+
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			ret = extract_ordered_extent(inode, bio, file_offset);
+			if (ret) {
+				bio_put(bio);
+				goto out_err;
+			}
+		}
+
 		ASSERT(submit_len >= clone_len);
 		submit_len -= clone_len;
 
-- 
2.27.0

