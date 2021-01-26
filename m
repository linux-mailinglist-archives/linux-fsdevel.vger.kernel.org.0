Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF0230495C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbhAZF3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:09 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33033 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbhAZCfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628530; x=1643164530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bGkX3hb0zkxfFujhJMgPf7DfHa82gfSPmHQHl4Wnv7U=;
  b=F+qmPKfDxYzdAGz7/xgp1dlkR+FE2yh/iKrwtLQ+dOd65Z0kvStAjwFf
   d1gExwa6Ytgtuk1UWlQ/AhlBzT8aS0kfLpHqo74vpEpKn3vmDFd17Xwle
   FRaUQddarM1r0sKCG7Vw1asAo15Eu5yJf5AGlMl3MemjeEeYpCjNwShcP
   kghS4qItaUv9Owo40BFBe9fXfTfNDPbMR5QHSTZBaAJ/VnSaQI6EyrKnU
   5PhUB4Zj6gjga5jyjpyraZemfb52WYUw8oZ90N2lgVvy+Z4yyYdTBJsTN
   eKUFH1w+N6kjHHEehT3XuVoT8LzS4/wkm5CqktZZ4YRsmkWE+g+y+PRVX
   A==;
IronPort-SDR: bWFRV7igUvzG26PQujB1PLliWkfLBALw+3O/XKFD5LeOq37l8pgOo0Ymwg/GxdKqpfUjSabEze
 pCbtpJXomb6MRiofzNSjsLnor+Sm0no4Jfyp1NOxGMV0lzxR54gtFiVRODVi34nhPGBoXNZGhq
 IUyEgJmtn5qT4weR/KCyvSijIKkNP66RG0ulfSQtkgfDU157k67xBsqA5PGBs7VE+5olxD6bx8
 /vp2rqB6lb2L6D8qJ+5dGi393cF0bkYRowyAAe0QA3Ey2BHrQryU9zPCCskw+hcZQAy29gl5YY
 EEQ=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483546"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:33 +0800
IronPort-SDR: HNXHPrSkw98bKwfD4URNRnX3NU9Owo+dn3pTVlbTh6NaEVPFuE+GRg+00/MDQSexHA5u74g+zi
 zsGG+qC7F4jmb+Up6Xpm+CE3zksBTOPzAp9inBX0Q/70XBqSP+ov1XJ5iVfh2zx6ivJDBsvdHZ
 iJD61XQjHQy+eWH5PDIbxTvHrn/Nzd35ZNOjso34oh3XyPMWzNAmpOSoKOSm+hc0o2bRqOXM9S
 lvSyDmcl7DAdnYq70aKeE7ahAgqZcrRii49j+6jkGk40hQm3NoUWnzVh+PgqoeojikglUEgmQl
 fkjWx9XzC368D0U9zn3gfKKh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:59 -0800
IronPort-SDR: EcGX66tlTnzY8TVo9z4elhRvKGv3DMEki59QYNEt0x4v/n1Adex32+S7yeQxyK9sAlwWtQ3tEH
 qjfclTqtujzMiwZL7+p15V43wAXxXgCu80Qk7koAxF+q7OReHiV9i/rBLpzABLlBlvu+gjKT/a
 A86Pe1us005+Q8B3walJigw0Xmp/DnT2Br33zKIC0aJz95wOJHCjxh1qoUe//BsbjJG8MErcMh
 ilVm6fFZa9lsvrD8RR3fpQzQ7L02RiN0wkQExGxzzRDHtondP7kKF6uTkEoHoPYvdRKWA7Tm3T
 fnw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:31 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 20/42] btrfs: use bio_add_zone_append_page for zoned btrfs
Date:   Tue, 26 Jan 2021 11:24:58 +0900
Message-Id: <51b1f298d964cbe07c3714c3361fdbf596dbf52e.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
index df434f9ba774..ad19757d685d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3083,6 +3083,7 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
 {
 	sector_t sector = disk_bytenr >> SECTOR_SHIFT;
 	bool contig;
+	int ret;
 
 	if (prev_bio_flags != bio_flags)
 		return false;
@@ -3097,7 +3098,12 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
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

