Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4DB2F7340
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbhAOG6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:58:54 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41699 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbhAOG6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693932; x=1642229932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YRMay/Q+9oo58lzbzw+6AQwTsydC8WqDxk0+o9Qk468=;
  b=ZsSwbq9AjUoBGbN4c/bZv6FM492F4tIZV3KSxDEQyOBG4h64rZnqGe06
   Rub04AL6afq3g93u3uXJtIP3JxTTIINLbQuvecazlb0eG9h8dH9E/SEBT
   75DBzcVMJ2S+b5IiPSaErdNROScsQwExE5jJCqYLqa9WkgZ4+IrP4UfNV
   e/JoNb4Yh81qdUH4aE4g0S9fagTpmjYo53ko0Sqj8dncPmRVkDSyp83m7
   wVR8ROvkO36HR0+K/I8EUuRGE/MR6mOmRnVBxvY6WDJ9CHY/pxO7SWq2c
   I0KMMkTB7VNcfnDFvCuNuRFIyelxRSSecbXFUeHqU+JIk93OjdBUihhSq
   A==;
IronPort-SDR: QIq4BYQOQmRRhmlQq2enembW0DvLCashUWwQ9cNRefGZFyr4FpbEQm0X1QQt9N4k3aoZNcWnsz
 sp76hdQ6w1ONRthEe8p8w7/mbe99r61FtG6pBeBEBa4+gdT4Q1BKGZzlm7DIudKhFtcCAl9fy+
 LjvTrcY/0GelV5FeSDbaRAC75wxlW2/v3ab/qjugBs0twGEc4yVTqDVoPz+WSAOptyKhU2ohEC
 UqP0ar8mThZX54cbGHxbGDU1k88IGo4iFClDI/23LwNKXAy9fGgSM7/EwN/ocu7+GZS58Hl8WZ
 WQM=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928264"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:45 +0800
IronPort-SDR: z8ZcAnsF16vhVDH8rSBGE/sRYhLfM6Qt4+GRI/X7J1C8RP3hiK+MPGx3YESsTiJRvDRJYngCzQ
 P1WYP7kPWjdW2i1PSpY44cfqD0dB1OxIj+4aci+WT5KrLtwm94AUqzonSDi8Tz/LXN34vYeWPL
 DCU7JNMvgk+3XTfuI2LxIOrho6vtU5rTu+f83XBBKPJqwjZPSsZorHrahs2VsLgmX/KMvonty1
 JoXgVSw+T9Zz/5V47sj5bwLNvYE8pBCh3TOzXZzZQGkK88IsAdkkqfovP7TCMXb9/LnpKbYUwT
 mnKI1/L4MpZAmgLj9ozWoUpT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:27 -0800
IronPort-SDR: lDpMeESmZtn48nz0dCSJ59HgJAAx+niC7EFiav6LpE4nZp0aaWglohE8JHlvfy/oARvASgm0mN
 8eW0K4dT4uszMOU63tWTqJ45A8HSSLGFzzR3X9U7Qg1p850dTx65iLrqrvhGl9ni2R+xOCpbUj
 v8AH++gFsGW+9zRcbOcBitX4BF+VDt2vuIfiGomeTOhhKCUKXsWGRs33kfQ1hYAfCWbkkRF5rs
 iC/Fp/3CX8+K9Bpd6KODjAXOln/1+xY8NSjQV4C4KBEzW3pPOBSGryZVEgnor40RzFKw9qJymQ
 EpA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:44 -0800
Received: (nullmailer pid 1916460 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 20/41] btrfs: use bio_add_zone_append_page for zoned btrfs
Date:   Fri, 15 Jan 2021 15:53:24 +0900
Message-Id: <9cb19c5a674bede549a357b676627083bf71345d.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 96f43b9121d6..41fccfbaee15 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3083,6 +3083,7 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
 {
 	sector_t sector = logical >> SECTOR_SHIFT;
 	bool contig;
+	int ret;
 
 	if (prev_bio_flags != bio_flags)
 		return false;
@@ -3097,7 +3098,12 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
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
@@ -3128,7 +3134,9 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t io_size = min_t(size_t, size, PAGE_SIZE);
-	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct extent_io_tree *tree = &inode->io_tree;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	ASSERT(bio_ret);
 
@@ -3159,11 +3167,27 @@ static int submit_extent_page(unsigned int opf,
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

