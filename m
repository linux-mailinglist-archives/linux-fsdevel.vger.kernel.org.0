Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB1A2F7364
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbhAOG7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:59:52 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41718 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbhAOG7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693990; x=1642229990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QsVu7GBkwVh+sJroTATbqitsmKDIxtzYpMvVRjLwIjg=;
  b=ESk2Z/2nH68yefeR1w17jJinpLbzCF7zKeTIwDARMWVNkbzo19Zqzshd
   leqfqcQKHzzTGj+km4Z4z89gKiQbGkFVNbAOVIbvwmag1ZuJ+n7JqobAS
   b85LOQMt2i5XPZtDimmDKncpswPOohjAJbL2ReLAbqPGxRDLmRa4kOSBz
   NeUcr/wFVoY0Dmmm2Ib2NJfSCxgLNYWIYH5tOf3nFu5IaH8lEsFQBqyI+
   FMzywM3aanUyftR/JXuiYN5vLQDqDBp90vtOxhCoC8zrGP+/gisbL6sky
   +duKe3YoYy414eucSqo7ytfhuviHk+DtFCF5TaM9DwEDsMRECYA/8uvu3
   w==;
IronPort-SDR: IgvWB/w/umFpGjc2a5G53apVdX0RzdhL4h8mwTeyfKszHhFMyZjlVV0T1DGzcoF9H8MPghxdq/
 zoSOpcF3ygtrn1y0wdGfLoYMLVXd3rm78J4U9x2bK/YmQvdK0qEebzES5uNX55hm25GQJglusH
 25mhXONZVWSedBRVRR0WUpvcfdjeeiasYeB2rD+jfdnsTODXWYqtU0d5ZVXvHTXbhXqyexIIOQ
 169ZlxkKBRkkTijSLDa55OIOAmQG9U5OquHTnnQJTiFS4rgpnLFwLzhW8KMSIB2C0eL3q4ic8X
 mRo=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928287"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:56:01 +0800
IronPort-SDR: rGr9WjJi/yAg+twUu3tbKpRCkcIkYx6diR1bRrgMU3Zi74fSn9xXNTWLefXN+ChABIGPc+lc1v
 SifAcxnugaT/zswNpKGB9d0LOU0MJrWraSMaOquKnilmcxXkbnnK6lz/FXaqE9M+jChqEZO9iC
 +//L2Vc1XJItMEP+jA4OkfxorpxnP9hT5wn2teWbbcakHsNwq1fB5Qz0x63d/yl4CMOjrP0/zv
 GUDZtIBEgkUUNj7IfAUXrRCpwoOkGZ7bUBOCdA93sv9GgiCq9cN0tzo1CiLINCAS27kdHNF64l
 m9qxX158lyIwZFUuf01Gac3w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:43 -0800
IronPort-SDR: 1qq5PG/HOhqxWetSMqqG3K34f5yBftHZefBnN6RqV5D0w97WdZ2qM3HdIFp45gv/6mHlsBelcW
 OSiVl0B7mMsiuupZ8mBUESvGYb7g5lu7ZMRyw03wpdkY1ToINfvdbSwbnXhR2KImCZZSkKHpKA
 57YXfrxp+Fqq1kVt9mru2jEdbQTOXZRz8Neirhm4YfkmCSD4C3uQun3p1K+Gr9/rylC9UlN3Tz
 96LUQ9l+VZwG9Kf5p1AbOWUPq6nUAbbl1Hwv0RNneR21Suk297XSjvyi3tGQqCpjgVsK+ATBEc
 NiU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:56:00 -0800
Received: (nullmailer pid 1916476 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 28/41] btrfs: introduce dedicated data write path for ZONED mode
Date:   Fri, 15 Jan 2021 15:53:32 +0900
Message-Id: <34fed65a5240be2d2eed7b0be01f1db56c1f88d9.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If more than one IO is issued for one file extent, these IO can be written
to separate regions on a device. Since we cannot map one file extent to
such a separate area, we need to follow the "one IO == one ordered extent"
rule.

The Normal buffered, uncompressed, not pre-allocated write path (used by
cow_file_range()) sometimes does not follow this rule. It can write a part
of an ordered extent when specified a region to write e.g., when its
called from fdatasync().

Introduces a dedicated (uncompressed buffered) data write path for ZONED
mode. This write path will CoW the region and write it at once.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4f0915346c9d..cf84fdfd6543 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1400,6 +1400,29 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	return 0;
 }
 
+static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
+				       struct page *locked_page, u64 start,
+				       u64 end, int *page_started,
+				       unsigned long *nr_written)
+{
+	int ret;
+
+	ret = cow_file_range(inode, locked_page, start, end,
+			     page_started, nr_written, 0);
+	if (ret)
+		return ret;
+
+	if (*page_started)
+		return 0;
+
+	__set_page_dirty_nobuffers(locked_page);
+	account_page_redirty(locked_page);
+	extent_write_locked_range(&inode->vfs_inode, start, end, WB_SYNC_ALL);
+	*page_started = 1;
+
+	return 0;
+}
+
 static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 					u64 bytenr, u64 num_bytes)
 {
@@ -1879,17 +1902,24 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 {
 	int ret;
 	int force_cow = need_force_cow(inode, start, end);
+	const bool do_compress = inode_can_compress(inode) &&
+		inode_need_compress(inode, start, end);
+	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
 
 	if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
+		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 1, nr_written);
 	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
+		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 0, nr_written);
-	} else if (!inode_can_compress(inode) ||
-		   !inode_need_compress(inode, start, end)) {
+	} else if (!do_compress && !zoned) {
 		ret = cow_file_range(inode, locked_page, start, end,
 				     page_started, nr_written, 1);
+	} else if (!do_compress && zoned) {
+		ret = run_delalloc_zoned(inode, locked_page, start, end,
+					 page_started, nr_written);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
 		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
-- 
2.27.0

