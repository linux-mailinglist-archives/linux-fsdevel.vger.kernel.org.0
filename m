Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F7E2FFCC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbhAVG3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:29:31 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51031 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbhAVG1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296841; x=1642832841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/9weRuO7b6vz8tavqWUFrAlWchRN3uhfdP1UwvxTx0Y=;
  b=ecPmqBV5relJkcImdsjWZCg/goBMiVegm4U4GUrMwQHVaSBwJNrmhWlK
   ixe3YGn9N03RzhIQJ4ZyCgPpms7CWtfX9+zs8wwKjiXxl1z77zDw414/v
   aIMcNt3iCyaV8beppKuVKeTDDT4ZHQJRz1OFR0uaczUCPJsEz52MH6BmU
   u+evmZpYu3iO0sqO/2IqCc5DE3RFTolKRmWQv+xHgeUZK9C5ilqxzY4Fa
   f2nd/xP16Qt3Owiefn6H2wpE3sBxddzzNqIy+NEcJdUZ39WXebLUNZwE/
   WgsClDIF0Tzr/Ar3aT02g/F4tYMxROwUp481yePTTwPK3JA9V7tN6VrM8
   w==;
IronPort-SDR: /gj4F4wPTxwXExSFrtMTfwjq2TEKVfCoQiv+Evi5t08mAwUcHLACWJg+ZFOmRnIbhiY148K3MC
 DUR3dJEHaszgFwxTAs67DqrMcgYJB3PCQKTSvzKKPltFe7lqbBu1nxRT+iU84yEKrbH5Tx8KQS
 S4KeT4+XjX/qoR9Jh15nTQvxrax9IZVBlxkw90UKdfEop/8tyTK58AfhZg9vBx8JZSYUt8ysg/
 xqgJcxy+IF4R9EK+uR04+GClT/GVSw4+zPcld6YAzlTP6ZdxuOzOugCFRZWUPDQ8nQCoaiTJT9
 8cI=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392039"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:09 +0800
IronPort-SDR: AD/pzmzPImQ4cKeP6o45CHnHlEQebsxGwSNyeV/vZmMRXsZoohSMPGt/ng0FVd43BHh4kUYJTy
 qbX4Vw0mXqeAz3xgl/sTtNzlmvFHP/0yUQ1z1SA3WFRiyU1MbbEtedbOu9lYFbc3Aar4x6ewu5
 H16BsROZHUegBgpf3OGnuVND0s26rqVfnrr8KiimS9S+D9T90Rit8WMFT7kqQYq52Cw3Fy07Gm
 rq8szD+D5DMK/OPZkaer6ojeoHgi9NaxXC2sD9e/cDVaVIZaQEJPs7ntAGs7mqFpJKdaouw8+b
 kz9DIpxIdF6079T45SnT13Qe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:40 -0800
IronPort-SDR: 10uPCxzHrOW9JoYBreATosNqSqRXUz/NYbmtEShtHD7/ov1N9NO5HybTrxtVUm+sks8Dso4OUd
 CgpFyg4iO8wQyua+fgWms/ew2FAVPkpdrOVGbqR6k8GwCVqXMwvU2ZfWW19Q3j+SAdWL8gAqOn
 58Qg8S245+VYGz5m/6lelD6qj7o1KQhIRfEk9+PWyMGKeO/u47sYmRLyoYBlZaXOK8YUM9/4bV
 Ik8QEcaUuppz87sAFTo3U6Fots0ojNRynkIBsZbKZglKWs6R2NpUsGjBuAeSkAePACmaO/obse
 +mw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:07 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 29/42] btrfs: introduce dedicated data write path for ZONED mode
Date:   Fri, 22 Jan 2021 15:21:29 +0900
Message-Id: <a65217973c087fe8fb9cf82e1f54518ac3bc24d9.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index 26de8158fbe8..a5503af5369b 100644
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

