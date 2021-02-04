Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932C430F0C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhBDK3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:29:49 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54283 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbhBDK14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434476; x=1643970476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKjAQeqUaFKvcmg8zhBIMC/N6B8G4XTwHHH2DlqohAg=;
  b=OMBhgh1fu0UJuzLU9uR2jpwM3FIf6rWIDatYwScb0XULohSPBAiWn7jw
   fBHvkpGBLbouucsCesY+BQdIOBz0trrM62yfNTL4UQYISanPxw9/wQZtk
   zm252mVkApPmqPjZziAJ8qF9CGu7ATwHy0x7YmSIScW7hWJGj36Z1+g2L
   TBV1Gio7a3iq+4zzFP5OxR3fdF7MViwoBxQ/dv6kbgfxHFOpvx+SjYZoa
   /NO5fkwApFX03I/Pe3wdfppAUrea5bf2bKevLszzTCrvPVyExvmMymJaJ
   GY7+qgnUGPGN6+GAP0FOu2dokNCXrOGgzvpqGgEXyedopMwBCWzAII7tn
   A==;
IronPort-SDR: OKaY+Yc8qPFLO3Xrmv8he82mT6jK3upFBS5OSUXFlS9k0DNpVGGh7r+YcyxvbViSgAlPaMVCHG
 0XcDSV19OQLcHRADrQXPjlNAUBsMp5UF5R2zuHZnkt5UuhzgEERGXkny7R1oxD/WQnbQ0if8u8
 cUrXwyorxmasZQ+WlmyOFR8huRPka7ucT7GVDf0cdoRSe8En7fTM8BClw0XTUgxT/zsAMBzQhm
 x66STvzbdIO9mLNeiQEnEXDUPoazy1bhF9Ot7v39NMsYn5FO7HzWEeh2gjpxyTgGoSUcJojh9m
 Ypk=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108040"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:34 +0800
IronPort-SDR: HtfmwcVqXCfNHBiVoymzKZWTDpH/U3K+tMSrbcCYGW7hmIHvYPxLaeNNEO10VzfESRXdb/OmVc
 OeIo3496E3pzBUARKyK0HL1sgC+agWSIeXYZCX6o4xCXlpVeHkWILzE9oc9ScLHs6JCE8MXJXL
 acTZJY2kOmVphaCD1q1wUzOs+lHP3UyGfWo40eqp61WlyeCDnVmbzrGIHp6uF3l+rDHnX5iG8w
 hiHh4bav9NZJwJAy7ehpS2pu2YQMuQeK9NzAYp5NUrtFDAadTs7UQ/HEPw6qAi7HcyhvVK4Drf
 VXw1S3cgYFr2Q6WojzO8/7Aw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:37 -0800
IronPort-SDR: MSscIHIwGc+gS2/H9Y+Mu/tXFs++ixbhsEi5YY0wJsi34kLDpuRER4Gx6OgtNHlsT18mNu0e/i
 PWCQoP+D+7dVf+lqEvVSx+txdc9rNTTnA+bwFklqNtbDVrPuICGFFdTTl0mR0/r2vpNGT+WzM6
 gFnGxECZVm1RV/1XN25pnhJAMWfRISC2n/PMcbNttPuDVl1He4mLkcyuVBMKRniaPytMuvBNvf
 q1wyWsBqnZgx+S3b79er/Q/mE1JEO4XozUxBjLMzFUPQ6HqE7vzMCt1C3YZJ3g0t8Km4rZ/WJq
 6mU=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:33 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 28/42] btrfs: zoned: introduce dedicated data write path for zoned filesystems
Date:   Thu,  4 Feb 2021 19:22:07 +0900
Message-Id: <8dc2fc3e477bbbfdb9ba23ead804497b2752d05f.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If more than one IO is issued for one file extent, these IO can be written
to separate regions on a device. Since we cannot map one file extent to
such a separate area on a zoned filesystem, we need to follow the "one IO
== one ordered extent" rule.

The normal buffered, uncompressed and not pre-allocated write path (used by
cow_file_range()) sometimes does not follow this rule. It can write a part
of an ordered extent when specified a region to write e.g., when its
called from fdatasync().

Introduce a dedicated (uncompressed buffered) data write path for zoned
filesystems, that will CoW the region and write it at once.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dd6fe8afd0e0..c4779cde83c6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1394,6 +1394,29 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	return 0;
 }
 
+static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
+				       struct page *locked_page, u64 start,
+				       u64 end, int *page_started,
+				       unsigned long *nr_written)
+{
+	int ret;
+
+	ret = cow_file_range(inode, locked_page, start, end, page_started,
+			     nr_written, 0);
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
@@ -1871,17 +1894,24 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 {
 	int ret;
 	int force_cow = need_force_cow(inode, start, end);
+	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
 
 	if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
+		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 1, nr_written);
 	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
+		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 0, nr_written);
 	} else if (!inode_can_compress(inode) ||
 		   !inode_need_compress(inode, start, end)) {
-		ret = cow_file_range(inode, locked_page, start, end,
-				     page_started, nr_written, 1);
+		if (zoned)
+			ret = run_delalloc_zoned(inode, locked_page, start, end,
+						 page_started, nr_written);
+		else
+			ret = cow_file_range(inode, locked_page, start, end,
+					     page_started, nr_written, 1);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
 		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
-- 
2.30.0

