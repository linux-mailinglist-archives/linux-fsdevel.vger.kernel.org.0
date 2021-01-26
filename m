Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E5D304915
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbhAZF3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38256 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732165AbhAZCjA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628739; x=1643164739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nu7Q1or+YsEP3U542BppwgqnO6OSlLy2x7LKzUGLHv4=;
  b=A++wFXrL1VUOxe67kX2AqpapSN2z0ilWkejmH+tFXAjIqU0M0aWSW3u9
   lGTXEQ5zQuAGLvSkwor5h3/NdcGEGjOlsjo8rEVp44M48h1TzYYCQxTv0
   VVS+MgJp0+5xNgxmhs/lPk3cy9HW669YkQMoM99gPwN8DV3Ktne4xCMDQ
   LIgJCkBmx4Wi4lFN5izDQgAtS4v4zg5HOPXj0iLbR8Tl124sqLbrNZ9xi
   l5DsYpCOzuiQ0xfWC2uPJOeiI2ZvY8UtvKa26n+D9WStiJ1ihH4n74Mu6
   bArbZEt1XPMtrlCNveLDGTBpmKNQTzJyp8gYdikjnGgCf54FdMohJ86sf
   Q==;
IronPort-SDR: oK7TtG0IfuTDQhGynpSTuZ2R1/E0gOF1T4OJtw2w0xd9/hkeribU47q0dciACIQVK2bDIvSTUn
 HV9LGS9PucLikRKCLz1zBY21VHMtpeIQV1DYQHoS5ZzHV5mm5qpZPZiq44uPr5BRveKFdzDopN
 UhtNrbIns/Ous9+bB5CMlsCHwOOIw2yBgMxQDu/ES1vk2Zz0zHSBGW/twHJCFdqiH7ov4YJFFG
 YWyhdPFmpdRE6rjJRlmVHEbiNDWLbBuP2/k2ZjjgMXognJpAsaLUcmh5wJJTG1FAXNS1nyRsFk
 IAo=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483565"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:48 +0800
IronPort-SDR: vwOcthLbAJG14QF22xZpdBrZpEVKVMcz7g+mYMqZ3z6bj8r4yzrseY2tJDKJmJX0PnSWqO4GEI
 0bkWGY1Hup2gBVo69Jbhu67DGcsLV6ZDH+t6y6uJeMPNJh41kGrwxUhphqf/CxSMX6Wcnb58rG
 jIWVV4ZnVFqW+bDHpFZ/+RKwim9xPWujgXbUSgbHHoVNmjJLndrukkWritSGLOqjv2oL49TDXc
 bKoadOAtexKRShe7g8PqULIhW7sfpqM2L/plATi1JEsGn/Pd6M4JzihG8MqwhMAqUOZdBVjLTc
 C/GzrmXwuYYKEhxTXYARHFpI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:15 -0800
IronPort-SDR: BBpfXBnCy+2awBsfd3IuK6sHpxexOFb3rh5HCqXTEcXd7NqzY6JkNWPR55XHbn4M5Siz3L0evJ
 nCu8lB8d/cd0YQTIbpaACBrlAB10SaSnV0lgQI3jkv2fDwO/hFm/zQxBTaVWgQbZdGiGWJbaVA
 3Zxh5eCpXxZBcXEG9y2AyVz2J5hFWG86LH6YFft2hxOHD06OEhsoIdI6rlZZVL2sbAUmg7cB5Q
 PzcvqtXgXDFFjSREcZt795ExjdRav6Bj4JRizJOsZr1Q6RLF3ILdIvR1DY09VcPQoH90ngG2Pg
 BgI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:47 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 29/42] btrfs: introduce dedicated data write path for ZONED mode
Date:   Tue, 26 Jan 2021 11:25:07 +0900
Message-Id: <698bfc6446634e06a9399fa819d0f19aba3b4196.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
index a9bf78eaed42..6d43aaa1f537 100644
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

