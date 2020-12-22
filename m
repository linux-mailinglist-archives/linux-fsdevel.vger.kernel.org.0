Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C632E0508
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgLVDyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:54:01 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46437 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgLVDyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609239; x=1640145239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyxGN/7XXpdp+zOrzDjHCRgwKrztQYGRgwIFUc9Qbtw=;
  b=l9m9tdIiHm4NmC6k2G/b/NDQ11XbxrJ0o0J52zTlMyPyAINg6lqJaRGM
   dMg7Auh4aEJu344dngMI4Bmk7tE47R2T5UkGVELSWS7uwH4w/IdZrlTc0
   YR01LGnjguxPyRTqr2grwxkGJij2scPrM8cfpHAVcYbfVbRuMSvKjviRE
   5HIfY5vnXMqTX2Ij4bVQHhrOWuvWoW/yTZtCtgvKlhJOw0E8SuH3jEKK7
   wrXm0ZNiFCiSQQHmnYqF7FybXOmOFKhtdFRS/G+lrexG3ywqpAE5lPTWo
   CzBD7U5H1xtESpw1NqC7zxCbG238atSRcjrT98UtWZ4cZxHP8H31w7xla
   w==;
IronPort-SDR: RmNXAZ3quUrri4597y5xZaCBneEp9C04sU2WYH4iUlvFghqBmPHRB+ZmqQWOvMLM/EQH7W5JqN
 iukiCI9tBV9ZOfonEEnyc6n575KQk5Yt2BeT9Dm/2CMuIHdO5FIP9xqFkS7BCPvQuXDhFocwVQ
 Md5d7UmIP/jEYfLQQz2wQh+Eo63YBRw6OPo7ntqCrvsfprnEbbg+v9kPoFHcxpn/yNyfi79SKT
 TTsWVerSlikwREy1kH7sXaIa6e0u2r06VTvQth8grSp5EHzaJOVs1AubDIKsbEmk20wiMfg5Nv
 u5w=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193794"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:56 +0800
IronPort-SDR: xAT/PD6aabFGF+i/JjeUIuEIMsZu8vwIIUeth6EWn9vIvsefW5przy4OnDtWH4v4zOwfUl4C8I
 0BG2cEbazDeZ8sMfLxferirRuyjo1Kbd4WP34nlGBr9EY5hrV8zc/neY9penZ2YcKTQEDav8ds
 2CtNVOpqMN817fZKvk2LOPJzcYigfshtjYEOsjEIs7YXpRmH8yWgWbGzp4XIrw43wCTPeifIQo
 H8TuhanbS5FWnm5EijQX5lwSG0+jO1YNALd/ev7XcboXLA5ZIiXa3NXGAgS13+rSLpBsy5fJIK
 4fjBGh1u1iYlBkyyS74qTDpG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:07 -0800
IronPort-SDR: z0JH8bnb4b0MijYt4if0aF0PaodPKuFv+rFHxCEpLEzU6BmJoyyi9lFFMLNjFzdaR+/G6W/4y0
 D10u21pFFHeSofdafAzdyFS/kLNGVGm9QgiKCTc/CH2tjuUhP2unHP3iCnNGAxkQ5PxOIVTYW3
 7eUOMCS294dSsQ4z9MrsBcX+SHoe+6QpeZC7XePfg3Cd5ZMnGcXp5jlk5mXNV+Lp0RqkqTw3q0
 +3vMc14ucbuzReESLTQopoiFYFrdj8uugSg+FvzPSuRc9ob1md06YV9etuq+w6uplFC8pbbDjH
 CGY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:55 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 20/40] btrfs: use bio_add_zone_append_page for zoned btrfs
Date:   Tue, 22 Dec 2020 12:49:13 +0900
Message-Id: <bf6e2912dfc3062a914fb4c1ea5e550ac514725e.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zoned device has its own hardware restrictions e.g. max_zone_append_size
when using REQ_OP_ZONE_APPEND. To follow the restrictions, use
bio_add_zone_append_page() instead of bio_add_page(). We need target device
to use bio_add_zone_append_page(), so this commit reads the chunk
information to memoize the target device to btrfs_io_bio(bio)->device.

Currently, zoned btrfs only supports SINGLE profile. In the feature,
btrfs_io_bio can hold extent_map and check the restrictions for all the
devices the bio will be mapped.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2f070a9e5b22..d59b13f7ddcf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3082,6 +3082,7 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
 {
 	sector_t sector = logical >> SECTOR_SHIFT;
 	bool contig;
+	int ret;
 
 	if (prev_bio_flags != bio_flags)
 		return false;
@@ -3096,7 +3097,12 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
 	if (btrfs_bio_fits_in_stripe(page, size, bio, bio_flags))
 		return false;
 
-	return bio_add_page(bio, page, size, pg_offset) == size;
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
+		ret = bio_add_zone_append_page(bio, page, size, pg_offset);
+	else
+		ret = bio_add_page(bio, page, size, pg_offset);
+
+	return ret == size;
 }
 
 /*
@@ -3127,7 +3133,9 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t io_size = min_t(size_t, size, PAGE_SIZE);
-	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct extent_io_tree *tree = &inode->io_tree;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	ASSERT(bio_ret);
 
@@ -3158,11 +3166,27 @@ static int submit_extent_page(unsigned int opf,
 	if (wbc) {
 		struct block_device *bdev;
 
-		bdev = BTRFS_I(page->mapping->host)->root->fs_info->fs_devices->latest_bdev;
+		bdev = fs_info->fs_devices->latest_bdev;
 		bio_set_dev(bio, bdev);
 		wbc_init_bio(wbc, bio);
 		wbc_account_cgroup_owner(wbc, page, io_size);
 	}
+	if (btrfs_is_zoned(fs_info) &&
+	    bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct extent_map *em;
+		struct map_lookup *map;
+
+		em = btrfs_get_chunk_map(fs_info, offset, io_size);
+		if (IS_ERR(em))
+			return PTR_ERR(em);
+
+		map = em->map_lookup;
+		/* We only support SINGLE profile for now */
+		ASSERT(map->num_stripes == 1);
+		btrfs_io_bio(bio)->device = map->stripes[0].dev;
+
+		free_extent_map(em);
+	}
 
 	*bio_ret = bio;
 
-- 
2.27.0

