Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBD52E0514
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgLVDyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:54:41 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46437 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgLVDyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609281; x=1640145281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fey7rYYX2UHhwcJjDen2FDnpCBTzvjYdlVUCU43g4OQ=;
  b=YGeDR6yvhOXPOe/ALZYX1d73TkDzwSxjErigHz+N+a0sNzM3d1tPTaOB
   e/Mo/RyM1aDe3oEeKyhvP8o10t3bBpm3bCVKMDOyxAtWRx1HawohPneHU
   UZdvjjOLIC6DXHtvCrBEdRR1TA4N+8XXqYM+7d6wtH42c3W961bj4PeP9
   ziSvNLc/Uy8fXS4Hgpg5/XKO50DCToVCB0JD3sTNTJx61qkt8hSUBQ2ZE
   0UZdUf20yTl90+sufzLWO5ePF6Jm0oO1c7nhRhjO5S68LoxRo031kGDZN
   Ys11Zev7Ktca6/7DVj3Eko9YeGwtBlDbc4LZylNzRUL7KWEb/SBXeKXxc
   Q==;
IronPort-SDR: FlTh8bmtq+daRYuDWOjLmYnbp7nv3m0P9cG1Wny4R1r2lRsvr8j/b1uZM5kMTU9RFZZAc3QpkV
 YzuDgFKyFznRD1z85IvKVi3GYy63/uLBKOAiB0so6JoinqA8t+UQp7oIWPu1VnQ5deA6XXshFT
 lC6fyqm/e3V/LHiWkiIb7fiLW9NKOce7OHExPPq3kSA/3Dr9/vzIWC+M3qbDh8A8fc5R+eifR/
 TKA2IW+X5jZ1kr4Oa7mudwLQP1TkGrd1e6RdYbAV3PmRhOigbWhsUuynKh8rBi4qFBZddDFzvr
 2I8=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193825"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:06 +0800
IronPort-SDR: sDkx8Vu6Ls29BL2y+xrqz4qxgg3fv0o3S+X2Tb1dqi9qDJo8La2p/0AlomuE90QPyJ4g0ZUe3T
 UtF6L5K3QDYyy7ySRbgCo8vJuZNN7fkGeAGMdp/WVzttB1zkQ0Iz1scsUdBd0IP6+3QKmkJ2tW
 84T7adBtI/7Wcj1ImPmMHMCOQzYzsXKuLfwn4WvZcgvPh0LKRgt8lY6MrTmnpOzOX6O+YKQx6I
 W0zY3ZZ+mv49l9IdyekWVwSG6jqAPEAFSUIs7uQM1ygASvWPrXzSDrHsiCbnAHB+7hHHUtvITN
 A5dtpGIZOBIqb5CflUDE3Zus
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:17 -0800
IronPort-SDR: 2ZNDpBCxiz63nzS9hPojhT4jPmcvbVX539ffu+sla56BkCh2NkT2tnfx8+ORteedb0JnW6ec3e
 w22BNPasmUCbIqtFlogSfOChO0a7Y4FNUZmKXyp5uJa2TrxeioKIvx43mWUxfgGZq2OJDJiCM1
 l/ksmKEmU4e+KcuGizswLtvsB1EiKeJg42XctiT6yuu+6XNKURBZ1JXosrrrDBrZJeDtYZXT55
 HnzdJHLMXENT/cmBYSxSbjkuiHM8Qetkt2GIVLUP0MNLOOCgwSYAdnNq53Utg9oPHWars4YW++
 1o0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:05 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v11 26/40] btrfs: enable zone append writing for direct IO
Date:   Tue, 22 Dec 2020 12:49:19 +0900
Message-Id: <bea1e8c8229bbb0cb3ae3eb63f0f163c678a305b.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
 fs/btrfs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0ca5b6c9f0ef..5e96d9631038 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7706,6 +7706,9 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
 	iomap->length = len;
 
+	if (write && btrfs_use_zone_append(BTRFS_I(inode), em))
+		iomap->flags |= IOMAP_F_ZONE_APPEND;
+
 	free_extent_map(em);
 
 	return 0;
@@ -7934,6 +7937,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	if (err)
 		dip->dio_bio->bi_status = err;
 
+	btrfs_record_physical_zoned(dip->inode, dip->logical_offset, bio);
+
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
 }
@@ -8086,6 +8091,18 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		bio->bi_end_io = btrfs_end_dio_bio;
 		btrfs_io_bio(bio)->logical = file_offset;
 
+		WARN_ON_ONCE(write && btrfs_is_zoned(fs_info) &&
+			     fs_info->max_zone_append_size &&
+			     bio_op(bio) != REQ_OP_ZONE_APPEND);
+
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			ret = extract_ordered_extent(inode, bio, file_offset);
+			if (ret) {
+				bio_put(bio);
+				goto out_err;
+			}
+		}
+
 		ASSERT(submit_len >= clone_len);
 		submit_len -= clone_len;
 
-- 
2.27.0

