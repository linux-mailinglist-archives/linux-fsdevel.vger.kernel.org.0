Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F4F30F0AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhBDK1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:27:07 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54222 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbhBDK0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434401; x=1643970401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SuOeS6EIMznVG3tzHpqlZKGIM/1EU/293PfwKobgODo=;
  b=UDNzdUlGD9ws1EPu2qoZxqTqhJNBhYR+y2ItPtqWCPEIkCjkR0o5ssAq
   j3cz0cSthe9K6TEjHHzGobojcuzYWkudeHhJsrp07e/bTAArmIcGHirhk
   yZqer1bAozqq2HhMOmDRbeuMNiZ1WyDbqud4QUMYp6xVctfoEwwU3LzVM
   S+qRimFyz5IrjIy82N8FDBcDLPlaX6Hm5jdNz6ZPiqvxvr80p/BD/mfqt
   1XHhvGs+hjmKFV6cJjcYgfCTm7yHMJ03wGNvXvmEIWq89bxlpWmvZkBS3
   GT2QVPlmV3BalL2scc1UNpl206Bb7hIMqRc+NJPQ37kEpRX1MOqVuPSuq
   A==;
IronPort-SDR: COy/w+czQ4HOVAtgmmGV+hwkM2WDReBnmntP1qAzv1yrrKKnNX1a/jrZ594YtTdJrf6f9ACqoN
 9V2SiFVi/DkvUyNYykkTQy/JFZDGadRQY9lgIzRZ8qMVvegcgnkp1DXBz8kRN1prsZoSNxMQaN
 xTC5WeK2XIOQYcUrlk9pAPyOPrdXKJE7OBYdCHSABRaj+H8dtY3li+bx/5UvYVihKXkByqC8BX
 EeB0KJRQAxzEkIAOy6lexa8SkFy0umaMODAWAPEL+pmvatGS5nVfQo4gfTiBqNDd3ln/YmHoko
 Wgs=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108009"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:21 +0800
IronPort-SDR: v6NTrt8X/pemAJmWpWEELniQXkF2TI0dEa8W230y8mJQAHjgy8sM86jtyv9YfXVbnPDGhRlW8F
 /YgqbIobI8yk0fPcQjTB7Tclxb9+ttu+ISp+G5qiz424ss8pCDemb4qg3SYT2BNkLNS2koQBrw
 ydE4hgMVOAQ4ftlG4a+Kn7Q8YR13PUvUpDH/ZnsgRZGsvvNcqTL1S0g2AHJ9XKmiLkrfiAsw5e
 Nfnktk56YwGAmJMk5zRfRWUldorE0t1vyXx8PmXk2g8XZ6hUq+/TQ6REN9el5uMQECONs+uyWp
 cLvsk0Y9TjoOhbOFvpPB2F3F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:25 -0800
IronPort-SDR: BjqWjfsC8md6v5n8h1xwN6HsfWQwfmlaXYHeKv5Ol+y+AF+nI2zfIPgvzKHwCuA8N+/EgUnYzC
 KGZQdNevNBCD9dXy0+J8g6IE0rwEJshKI9/keAbJ92ScYszrW+E+N+KBFulK+Ufeju/Q5szgYV
 Sf4iwI9ahBruWIwKQNvxUFH73Q+OnJoKT8En732RhdQXNCQoJ+zh+GOOKefQoznE2gPs7oaW/D
 a0SQcPwXBzQoN+avIySb3Qqb6AJ1kqh+7caR6I0B+vm07y1cMoCp2pDHCSL4HA7jC5PH1vuUtL
 bIc=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:21 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 19/42] btrfs: zoned: use bio_add_zone_append_page
Date:   Thu,  4 Feb 2021 19:21:58 +0900
Message-Id: <7fa79d7bd946a7f2f054a9d9562e6bda647cabb7.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A zoned device has its own hardware restrictions e.g. max_zone_append_size
when using REQ_OP_ZONE_APPEND. To follow these restrictions, use
bio_add_zone_append_page() instead of bio_add_page(). We need target device
to use bio_add_zone_append_page(), so this commit reads the chunk
information to cache the target device to btrfs_io_bio(bio)->device.

Caching only the target device is sufficient here as zoned filesystems
only supports the single profile at the moment. Once more profiles will be
supported btrfs_io_bio can hold an extent_map to be able to check for the
restrictions of all devices the brtfs_bio will be mapped to.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5db7e6c69391..15503a435e98 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3109,6 +3109,7 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
 {
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
 	bool contig;
+	int ret;
 
 	if (prev_bio_flags != bio_flags)
 		return false;
@@ -3123,7 +3124,12 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
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
@@ -3154,7 +3160,9 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t io_size = min_t(size_t, size, PAGE_SIZE);
-	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct extent_io_tree *tree = &inode->io_tree;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	ASSERT(bio_ret);
 
@@ -3185,11 +3193,26 @@ static int submit_extent_page(unsigned int opf,
 	if (wbc) {
 		struct block_device *bdev;
 
-		bdev = BTRFS_I(page->mapping->host)->root->fs_info->fs_devices->latest_bdev;
+		bdev = fs_info->fs_devices->latest_bdev;
 		bio_set_dev(bio, bdev);
 		wbc_init_bio(wbc, bio);
 		wbc_account_cgroup_owner(wbc, page, io_size);
 	}
+	if (btrfs_is_zoned(fs_info) && bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct extent_map *em;
+		struct map_lookup *map;
+
+		em = btrfs_get_chunk_map(fs_info, disk_bytenr, io_size);
+		if (IS_ERR(em))
+			return PTR_ERR(em);
+
+		map = em->map_lookup;
+		/* We only support single profile for now */
+		ASSERT(map->num_stripes == 1);
+		btrfs_io_bio(bio)->device = map->stripes[0].dev;
+
+		free_extent_map(em);
+	}
 
 	*bio_ret = bio;
 
-- 
2.30.0

