Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5C3034E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbhAZF33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:29 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33036 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732134AbhAZCiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628690; x=1643164690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IkN5GoeRkESPBFBXYtV8ezLFrKmoz8xW5id1nnpCmBc=;
  b=Y9PP5Kg1QdJZuUUXn87TIUdFuz85vNHLHODuNaWkQFrjiHHVBI+o7s2A
   QYo4tLOLpBzPCVpIs7O3OYFjH7Nc8ySQdTpbiIamO4uf7H0hpVW4aeRd/
   29YDm18/fOmI+9vbjciDahRVkZmMZUrdOY+yQGap73qCnJ0InwEIhFXM4
   6vJRn6e2iHenOcKa3MsMl2ufqY5hx5WXUGazPLXsT9o4LrxUNAPUTtaRV
   OP9Rb64axu9EWO7dkhrOKGtY0wS2v3tnAFJzYD1fZrPpqVd7y2gMZD2SG
   9v3HMRP4yL2BJLeHjkLR5o3LL+2ODitb1CaCwQdrtb0NKxhRtOsvxA9Z1
   w==;
IronPort-SDR: 7klANJk52sUAj/cf3wOTaMd2V1FQh79ZwY0L5QtYpjJQWlJKCUm5/+L8e2hPPB4uppnlWB19ke
 wX3Iu23j/A9Qd7cGNR/w97yhm4vkDvSUNR60nFNLVd+vAVA4mEfN409kWIvYZ5QG/kOJe7R7qY
 Vfn7WT5c6kuUf+dEsTM/qWfdCnN7DM2FnN6DyZddsPphB+mTKQ+PbesdvgNkm6qn7tFkYxrM6z
 Q5YAccgWhPPSAzsvFvK7AX5kCVheiPNcpxtCSmvXAGw3WXjZlpnFHWe65Ui70lL1zFf8dPKstI
 Oo4=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483557"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:40 +0800
IronPort-SDR: jExnuyg8UvRQlhTwcGhyxWLkAmA81aZWa5BJi5gqE+dd996BIBthpQEK7sayC9XtYoZgEyBeYA
 Pd1JtZTNHnsrSu6Zd63rcAVwhEdHP+keQMM3aTfMmofTEuUSKuZx1tCT+8BqdrQJEtccSWNz1O
 IL5NWTOSz/U+yTQUqgj3zpBHbOrIXAriTNKMbxDmK/pfWtZt+eE09RknfiiCyPKvv5ar9iAiRl
 WDmXodpQ6X7UihuoV05QxUYrICp5p4IKaCu23FZZOwUMcR7SZCoxCdL2F7jkpT2SVvPgVwCdyS
 GOsrCEFip9c0OeUnXpnIjgn8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:06 -0800
IronPort-SDR: xORTNpDQKqloZPqpsyeEgcsOH3RQSHaz/8K08ftwQrjDPteQgXjpcYBKgICbRCnUMXjR8zb+EE
 W8k9eBUeMrSc+y/nfLhsz+D6gub5sxDqYnDe7iEjdfu0LYvCqB5VUkqeOE+f2Fr8xXE/TYUmZg
 5ehE9coM8a/nkWIEnAGGR8eb0QtFX3BenpvUXJY+FLXAR6KjGJNJ/jkY6P1fu3NzYZA6UOMSV1
 PdZTmx5uP19Ftbzh2WeD+sDqYRhjacE83mF7OEjTciOLBoc6lxM/kR45hrk02iaM5fKJ6G4J7q
 938=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:38 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 24/42] btrfs: extend btrfs_rmap_block for specifying a device
Date:   Tue, 26 Jan 2021 11:25:02 +0900
Message-Id: <cc11870fa46fd284b777508e6860f559458215d7.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs_rmap_block currently reverse-maps the physical addresses on all
devices to the corresponding logical addresses.

This commit extends the function to match to a specified device. The old
functionality of querying all devices is left intact by specifying NULL as
target device.

We pass block_device instead of btrfs_device to __btrfs_rmap_block. This
function is intended to reverse-map the result of bio, which only have
block_device.

This commit also exports the function for later use.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c            | 17 ++++++++++++-----
 fs/btrfs/block-group.h            |  8 +++-----
 fs/btrfs/tests/extent-map-tests.c |  2 +-
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9801df6cbfd8..7facc4439116 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1583,6 +1583,8 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
  *
  * @fs_info:       the filesystem
  * @chunk_start:   logical address of block group
+ * @bdev:	   physical device to resolve. Can be NULL to indicate any
+ *                 device.
  * @physical:	   physical address to map to logical addresses
  * @logical:	   return array of logical addresses which map to @physical
  * @naddrs:	   length of @logical
@@ -1592,9 +1594,9 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
  * Used primarily to exclude those portions of a block group that contain super
  * block copies.
  */
-EXPORT_FOR_TESTS
 int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
-		     u64 physical, u64 **logical, int *naddrs, int *stripe_len)
+		     struct block_device *bdev, u64 physical, u64 **logical,
+		     int *naddrs, int *stripe_len)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -1612,6 +1614,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	map = em->map_lookup;
 	data_stripe_length = em->orig_block_len;
 	io_stripe_size = map->stripe_len;
+	chunk_start = em->start;
 
 	/* For RAID5/6 adjust to a full IO stripe length */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -1626,14 +1629,18 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	for (i = 0; i < map->num_stripes; i++) {
 		bool already_inserted = false;
 		u64 stripe_nr;
+		u64 offset;
 		int j;
 
 		if (!in_range(physical, map->stripes[i].physical,
 			      data_stripe_length))
 			continue;
 
+		if (bdev && map->stripes[i].dev->bdev != bdev)
+			continue;
+
 		stripe_nr = physical - map->stripes[i].physical;
-		stripe_nr = div64_u64(stripe_nr, map->stripe_len);
+		stripe_nr = div64_u64_rem(stripe_nr, map->stripe_len, &offset);
 
 		if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 			stripe_nr = stripe_nr * map->num_stripes + i;
@@ -1647,7 +1654,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		 * instead of map->stripe_len
 		 */
 
-		bytenr = chunk_start + stripe_nr * io_stripe_size;
+		bytenr = chunk_start + stripe_nr * io_stripe_size + offset;
 
 		/* Ensure we don't add duplicate addresses */
 		for (j = 0; j < nr; j++) {
@@ -1689,7 +1696,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = btrfs_rmap_block(fs_info, cache->start,
+		ret = btrfs_rmap_block(fs_info, cache->start, NULL,
 				       bytenr, &logical, &nr, &stripe_len);
 		if (ret)
 			return ret;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 0f3c62c561bc..9df00ada09f9 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -277,6 +277,9 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
 void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
 				struct btrfs_caching_control *caching_ctl);
+int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
+		       struct block_device *bdev, u64 physical, u64 **logical,
+		       int *naddrs, int *stripe_len);
 
 static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
@@ -303,9 +306,4 @@ static inline int btrfs_block_group_done(struct btrfs_block_group *cache)
 void btrfs_freeze_block_group(struct btrfs_block_group *cache);
 void btrfs_unfreeze_block_group(struct btrfs_block_group *cache);
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
-		     u64 physical, u64 **logical, int *naddrs, int *stripe_len);
-#endif
-
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 57379e96ccc9..c0aefe6dee0b 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -507,7 +507,7 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 		goto out_free;
 	}
 
-	ret = btrfs_rmap_block(fs_info, em->start, btrfs_sb_offset(1),
+	ret = btrfs_rmap_block(fs_info, em->start, NULL, btrfs_sb_offset(1),
 			       &logical, &out_ndaddrs, &out_stripe_len);
 	if (ret || (out_ndaddrs == 0 && test->expected_mapped_addr)) {
 		test_err("didn't rmap anything but expected %d",
-- 
2.27.0

