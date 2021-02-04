Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3CD30F0C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhBDK32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:29:28 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54276 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbhBDK1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434470; x=1643970470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XjcYtZuIM51dojVGj7xLOWZbBmFag0eUIaREfn2zNt4=;
  b=cASTctruQfuGrXC2LU/93pj0gOwx3EIUTsWCvf7WF6hLvpL4g1FdB5UI
   Po/l2JrO2HPrshFsWI+AXNsZG+dWAAkIpVooDYvNyMcXrHBdKVov/O2qG
   LqKAzyMgC9OChqHU9RRwCRZp4w1xP/diVTtkKGUkXMrMgo6l3r0+3VH85
   Un+joPFseIvfLS2y9JHYpSRT3pRey9JW+sEvie6HrZfyGaRmurlu4O7Km
   uX5EMwLRIupGhjIJn5wE+/zUse6l010Tm4fq9Gv2ssQhjwyl4+sUYE4Hz
   6BwdBVaw04zeWZEcknwCY1n8QH7mFQPiM3uwnTnaBoRIIxE8LWeWYKvSG
   A==;
IronPort-SDR: 2LiSH5CppNGzAmSPCCFNBdYDfAMRvHGS4ymEUjXQUj3ZOveM1XotSqfOppfaEVyAEUKvNm0uY5
 soAxCgzDV/m7eSsIz6TftfkYrW3YmCn0R91WgvTVJ2VnNmkvqPnlgk5rYZ7LyjfYRBblC9C7np
 G4wQjsVoIhis3MQtLxPCWfSYNj4ar5XvXCoBETwojjyK+UvvnSV544tx3dIdX9Nuy6ersdFZUz
 3/iTvB/6epPVg5xvsQRvXpedFSPpS19ny1hTozDTkNXqqU3zDQCdX9yBB2ZDkIQGhLq6yYr8eL
 6Y0=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108038"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:33 +0800
IronPort-SDR: tosL7rpVTbI3xHo+qmpuRALxHzhNKeNzhhww1LpH0zO6DhkYsiaKi/RqF62L/oKluXVvs01mx0
 AIMaF2t5thMFunm4KnRVqjE+7hLJacqcHt+4qJ5bUU9pZr5QgcbaL5ufu8x7EKM9XLVoyfFniK
 8EDfsY66obVJ5OTNFwg8xYfZknDt911xwnSAoCCLHgi9kqbe95jOJok9YB0Gw0eL1WvHjvxZAd
 Y68ghRhKFYmxn2lV+Bv4w+/xxjA49xp216wKGn76hLPT2L4P3H1bisIZDs13kHmj19Wqg32nyd
 AFTxXDW7Rfpb/QEcNlccUWv5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:36 -0800
IronPort-SDR: V7BFVJEeUMiNDpBxcFXAgsLQIyjvnExEdB3SX/N1t0vKi/2X6t5SwuLQl92s5/Oy70BXkRs9pY
 OnqjL+kEx1mGSYButNn2JJbNec9CZP3mP3b8neqw06gNSuoH+S5LP5x+Ysy/K1tprso3QbeRgK
 r/SyVepHzaaNveawov+Cn4+xeGFIkCzQ6OZc1wTBVaD3rira8yjFvDiG6IqqYuvu2LjylpL5gO
 R+4lKK6AEt/VVYY0Ri5T0rSN4DhU0+ZAlaCfjHXUfk6Md9110HqaFZN2C5CS2QSXUYrH1mA7nd
 0JE=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:32 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 27/42] btrfs: zoned: enable zone append writing for direct IO
Date:   Thu,  4 Feb 2021 19:22:06 +0900
Message-Id: <8cb66ba0b58724b0235e207a6d5971a7b8a900a9.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Likewise to buffered IO, enable zone append writing for direct IO when its
used on a zoned block device.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6dbab9293425..dd6fe8afd0e0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7738,6 +7738,9 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
 	iomap->length = len;
 
+	if (write && btrfs_use_zone_append(BTRFS_I(inode), em))
+		iomap->flags |= IOMAP_F_ZONE_APPEND;
+
 	free_extent_map(em);
 
 	return 0;
@@ -7964,6 +7967,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	if (err)
 		dip->dio_bio->bi_status = err;
 
+	btrfs_record_physical_zoned(dip->inode, dip->logical_offset, bio);
+
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
 }
@@ -8124,6 +8129,19 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		bio->bi_end_io = btrfs_end_dio_bio;
 		btrfs_io_bio(bio)->logical = file_offset;
 
+		WARN_ON_ONCE(write && btrfs_is_zoned(fs_info) &&
+			     fs_info->max_zone_append_size &&
+			     bio_op(bio) != REQ_OP_ZONE_APPEND);
+
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			status = extract_ordered_extent(BTRFS_I(inode), bio,
+							file_offset);
+			if (status) {
+				bio_put(bio);
+				goto out_err;
+			}
+		}
+
 		ASSERT(submit_len >= clone_len);
 		submit_len -= clone_len;
 
-- 
2.30.0

