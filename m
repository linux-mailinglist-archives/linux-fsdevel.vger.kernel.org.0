Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE822AD509
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgKJL3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:04 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11994 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbgKJL2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007719; x=1636543719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iUwnSUCNikli3pTqbc7EDAdDA7Oj0czvrjroerNYigk=;
  b=Ko9xrZsFSe17rbb0tUIFncbN+A5ZMxcxDWHOHxQ+qyasCQpXDFjat21M
   R70AU6rXsUlqM9qHPGd6b6ZFuciQ/p0I8WHuRu5iqbwjIN4dOMc5NVgiC
   sLNFgh397cnZkgBWW5BW5IBbMbmHDed7iSmLuLia2mE2SuDNWKMDFoSGK
   yhRtacvqXFNxtTLXGJFOIcWTZS+ct2AhbP/OEJzkmP04d9PQWD0FIpDo8
   +Sj4nDktov99TPR/+gfxoMJUVa+n8vLr2d+si+Dd0sHqINsTzhczqxYDH
   hKs68Q64T2jYz24JzdOyFNjtMVDJSX4PduIuwzLaAdSqU7VzCqOwyieKb
   w==;
IronPort-SDR: u5/t1IOI+6cSGRRpm2LdACkwaRQMxzDwISM3c2kobahXVUIy5twr4Y/CSVE4UvQXEyfsv7sF5q
 ui+8Ts+ge7LW13DH0Qyqn00pz8ObeXJcUUBghqwXkutrPhMe4VWPrwpMOhF4OAskVBcmZTP9sO
 YlVvqRztUZvHJQxFuscIZpiM5zraVu7icEaqGdrBaHl+FiaK+A8aWh3vEzHspQ/+uQ2jKAKDoX
 LtoRSDbopmIB6aOP/uyr9HB/XUsuMiAnN8iyOz1u1h3aE9+a4En4bdiHc9h5t5ITDWWv3AA5bd
 SXE=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376558"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:39 +0800
IronPort-SDR: 5d+q+rL8KDo2ijv2up4VXs1UMynpnUSyy7n/hb8v3Hl4zi8CneXvN5LES40cbvpUj80sOLMZp3
 qM8I9u7X+q8UuuLUK8yfxjOOyEXIYsJlEAXD+oQakTOhz98RBTD9jciQJOd854hHjcQN6RQzkb
 5Q9vfvQAG89y5mLUjpbhsabU/h7axrNgV/RSxTEfz3a7AFDSU7Ojyf0iLxXXQPIdbHBj/nOevs
 fekJY7LZi69U/nntkrAJ3JMECZ+hVFr+rwXGtGr/gcUQEf787DNmT6p23JNaM926qf1WFdxw7O
 wIpjbxKi4LGjLRPAqkR9LPHX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:40 -0800
IronPort-SDR: YI1yqGJnrjhcNjyEhqclTsFVk2GBt4Zj1e8tQcNGBsGwBpQLiGZYgtBLJDyhh9w4Vc2b3ewpUR
 WEf1PjUuywYLCA3BlUgEV14AbsiYBCDjJK7MI5Juc77IjiDoW3kCM/5tj+pgFkHxn5hZFErSJJ
 Hi/GBOxxqrAY6bEnt8N7Ww+H3kyj5NBGjsEpTxjL1lJSc9sOzYJffLxaAWlogJORBbeZrliJhb
 V1XQo6ebtBRrNM7rX1DMV5w7MjIefv7s6HFh7Q/mFkLX7gzzi4fDpwS/phv2pkNr5N3n9nj4iu
 2d0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:38 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 21/41] btrfs: use bio_add_zone_append_page for zoned btrfs
Date:   Tue, 10 Nov 2020 20:26:24 +0900
Message-Id: <190a0c66e8debf9017e91ceccf05320451b4529e.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
index 868ae0874a34..b9b366f4d942 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3033,6 +3033,7 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
 {
 	sector_t sector = logical >> SECTOR_SHIFT;
 	bool contig;
+	int ret;
 
 	if (prev_bio_flags != bio_flags)
 		return false;
@@ -3047,7 +3048,12 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
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
@@ -3078,7 +3084,9 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t page_size = min_t(size_t, size, PAGE_SIZE);
-	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct extent_io_tree *tree = &inode->io_tree;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	ASSERT(bio_ret);
 
@@ -3109,11 +3117,27 @@ static int submit_extent_page(unsigned int opf,
 	if (wbc) {
 		struct block_device *bdev;
 
-		bdev = BTRFS_I(page->mapping->host)->root->fs_info->fs_devices->latest_bdev;
+		bdev = fs_info->fs_devices->latest_bdev;
 		bio_set_dev(bio, bdev);
 		wbc_init_bio(wbc, bio);
 		wbc_account_cgroup_owner(wbc, page, page_size);
 	}
+	if (btrfs_is_zoned(fs_info) &&
+	    bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct extent_map *em;
+		struct map_lookup *map;
+
+		em = btrfs_get_chunk_map(fs_info, offset, page_size);
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

