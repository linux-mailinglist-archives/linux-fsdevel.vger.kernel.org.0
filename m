Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B082FFCA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbhAVG0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:26:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51138 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbhAVG0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296774; x=1642832774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0hlh/nk+eI9NxaEmuQbJ4vSowBJ1lLOdbFOWcJflPo0=;
  b=Piq57/W2tpGa96aXJCDRyBcdeFB6qhAUrECfLlQVbOHZxBtZng0kGi7p
   ERLzROCK1jilkFll+BLjQtJrMS8nT4DJ4+osaUGtx6J6XJwAuVWyJ931U
   q5ljgUjHhWz5szu/ALiFRBXkHp+pVwXnBVFADeOdXzYSb/I6y4BguyCFP
   K34Km8H9FHnVmjusMawTcMosbS9UZ31AjL/temuoxsDrU0jxbkpAhz/ic
   7hUDO1WhoxloXhMQZTySXUTLGlvg0U8/OyXbWbtHQQbdjkJycqqeD/+V2
   kZyTJXuMg4oPqLaGXGKOYDUDLaVZ/5uzWWUEz/udxsNvl0eXXYpHrWgLg
   g==;
IronPort-SDR: +0h1RoJZ+u3K+sJA7BVL49GoAoWArg0zOcVvGpOeiFhONeBMNba8tRtIARfpTejVr20zvdJoo+
 AbLDFKcKA5AUEkwB/vq6Gprm/hFKKsQ3D26GAJUDiBu6kUiVdAW0iAXOqKzGdDDyjNA7dogsDf
 zr4wtI87pBoBgZ5hTCgU1/5aUuc3eH53253jFRiDN71V/7w3Fyp8GSCgp8FXil4ZY8l74QCeL4
 nloMwGfgPqe9n06ATeSPbvHyEzHd4b6AajR6iKCYFjlV5n1umyMfOjyJaYwggKcTBKFgLzL9lm
 UZc=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392006"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:54 +0800
IronPort-SDR: ZLrS/a4byBIF7rEDJQOad3pgQ3ZLt6osW0JWDXyZCuD3XtZxhvIG+oZsX013GHvTg8TTUtapuF
 8Lhmp9WgFjhgOEQYhjaowzO9Zlr9i3fG/ASLAFJrNGHO6r8A8Qg5Yq4mc9WmDVuambqanRsqEO
 7f+n8vUpTlk2RcNSQQm/hKBd6Ab9gPYaGcsPixLc+Ut63atqSln+cFdiSFRTCmTFsFA28wBdkE
 45QDSp72VhIcCuGrqDVc3bDWCEqFFrN6RnMmCRTGPp7/SbY2wvMnCDouj3vc1YCwmEPLUi4RkU
 1bnsd6/f+06PEILRBciNiZag
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:25 -0800
IronPort-SDR: XqkitWtHKW9XAvBgXkYZvqXGhGkD0plzspqL2zkJ1x1nBXCRnR+si9gdMV2aR1KyXX/h+cw/wS
 SW9Q61E13OJTw8fuQLWw8PiRw6ktXOuc+aKk90ekVnBrrpfXB6z/eGjaSMZn1+STrAC1SsfMSR
 y8gGylqaSdUC7PjjQ9xDIjD3eblpPInDY5iAZ0G6R4TO50oOO1vHOwIgj2Ku8jh7y7RTVa4I7x
 fd5K3pVJxSmsiYy4DVRYg5VMLaTAnXCGnB1j5Ax22/gBPPyjtWKnkaX/8L8mWdDK4HbrKtn5n4
 OpU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:52 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 20/42] btrfs: use bio_add_zone_append_page for zoned btrfs
Date:   Fri, 22 Jan 2021 15:21:20 +0900
Message-Id: <5079f58020ef53a905ffdf8f7ec25b103d88f0bb.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index df7665cdbb2c..9c8faaf260ee 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3082,6 +3082,7 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
 {
 	sector_t sector = disk_bytenr >> SECTOR_SHIFT;
 	bool contig;
+	int ret;
 
 	if (prev_bio_flags != bio_flags)
 		return false;
@@ -3096,7 +3097,12 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
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
+		em = btrfs_get_chunk_map(fs_info, disk_bytenr, io_size);
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

