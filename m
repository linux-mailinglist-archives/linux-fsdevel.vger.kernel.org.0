Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDCB2A071C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgJ3NyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:54:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21997 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgJ3NxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065980; x=1635601980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/cg2DzInArlfMYW+0mqyb64wEUNBbmYmeZFAkD9V3Lk=;
  b=lksMgdxQz9uCMCSDH10k8J8lwOYXA8A+neyr1xjO1s+l6PhTQDAzhiVJ
   tc54xqegHbyA+RBpA7/tXoyEhWejXi2N06fvHhcMzXQamCk7fKrrTJnXI
   ZcdzjzDP3k2kqRVVaNYE7lKzHTl92MUxa/4SfMHkCqAgF5rzQww2XiMyG
   RXw69AV1l5LdTVFnIdPJs4etDyDRRTX3exd8FF5o4mjNNsUHJ9t/IQDEv
   Z7z2hixbeEfnBtX8fUz/xyzVgaVAz9leEsJS2DQZMgdHll9Tvm4KrBKtn
   4HdW5BBNBnvtIeOfsHBxg9dC5A0WgIhJ3QPhE3JhbMbm0Y1SXMfz153m0
   Q==;
IronPort-SDR: kIjpCCyqp8pkbPsJ03gDW3w46htLTFN6SScqrjBrlVd0pjHltdX5SHt65Diqv+otgF58OF8vSB
 CqYY5Dx/NDeM3yz5i/vjlSU2Owjj9P1ETXSvBGrZNc6g8fw3RelXFtqCI+naJ1yCpXjL4mBg8h
 GJAU37qo3x1lQ+2T+4pShDToLZr3TFoJ8Ysro9xBckN0UvlExrNHmNKU1luogeOideI7G60xIX
 /kX7LiLk0+84QEg0xxlJ/WVK1anG+pH9/Pj8Mbqi0Xbc3offLWUvCgEVVOz6cN5NlOavw0kJ6w
 2ZU=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806618"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:47 +0800
IronPort-SDR: gtdhnsQgnpz3JABo1rlHhkZzFaIA8nLyGWCnorvblNnB7F7wFly1CIyj5TQm7U0kjN03P0q34N
 GKtb4E124+s9OWscw3rPoWBIgaGHVoWJz7Ja+YvC55B/PRoueWzYnz/6wEs3VRLO/LJU4OOa/u
 aSh9MfASvpEY2tl6skUjRTcKYk611xBOIYDqJBk1jHqXwdtGcmMfCecJDy5JeLuW1l5tG3a16N
 W+S6r6aVUd/2fk/SoX05OYxHko6tXduSa8oV+Cx+ciwq4RjXeAQcwQDsXGgn0z39A2sZrIKN+o
 UTG6lxo2xNELuVCjQ6wvH9qs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:01 -0700
IronPort-SDR: gc6grznEYiQ0EhePSrcSmMP6rq0bqeyklibjuKLDmIByYmbn1ECNyHYQzV8q7DHFGtKfywFNwU
 GG2ySYnmqIi9v6dcmHjAR/VqtMDojNHOmR1JvfjcUefH6COahKYLrctB5shg6nw8DccOy7cKfV
 mQCiL7mzITqfjuzz1svuWmhfUMCeu765tTQFAO1cZVFj2MI3j2OSfx2j8h8uIKM5K+/gbJHxGD
 uG170cGAqteQAj5P6Oh7UrK5e2rfkrBUcGOwzf/L19NQW7tzKDVvDrsOcpq3017yOi+IqaESN1
 cKE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:46 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 21/41] btrfs: use bio_add_zone_append_page for zoned btrfs
Date:   Fri, 30 Oct 2020 22:51:28 +0900
Message-Id: <ad4c16f2fff58ea4c6bd034e782b1c354521d696.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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
 fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 17285048fb5a..764257eb658f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3032,6 +3032,7 @@ bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
 {
 	sector_t sector = logical >> SECTOR_SHIFT;
 	bool contig;
+	int ret;
 
 	if (prev_bio_flags != bio_flags)
 		return false;
@@ -3046,7 +3047,19 @@ bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
 	if (btrfs_bio_fits_in_stripe(page, size, bio, bio_flags))
 		return false;
 
-	return bio_add_page(bio, page, size, pg_offset) == size;
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct bio orig_bio;
+
+		memset(&orig_bio, 0, sizeof(orig_bio));
+		bio_copy_dev(&orig_bio, bio);
+		bio_set_dev(bio, btrfs_io_bio(bio)->device->bdev);
+		ret = bio_add_zone_append_page(bio, page, size, pg_offset);
+		bio_copy_dev(bio, &orig_bio);
+	} else {
+		ret = bio_add_page(bio, page, size, pg_offset);
+	}
+
+	return ret == size;
 }
 
 /*
@@ -3077,7 +3090,9 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t page_size = min_t(size_t, size, PAGE_SIZE);
-	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct extent_io_tree *tree = &inode->io_tree;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	ASSERT(bio_ret);
 
@@ -3108,11 +3123,27 @@ static int submit_extent_page(unsigned int opf,
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
+		/* only support SINGLE profile for now */
+		ASSERT(map->num_stripes == 1);
+		btrfs_io_bio(bio)->device = map->stripes[0].dev;
+
+		free_extent_map(em);
+	}
 
 	*bio_ret = bio;
 
-- 
2.27.0

