Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07762AD50D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgKJL3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:12 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12024 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgKJL3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007750; x=1636543750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ymT8kV10Uka3PsUpR2UxtJE4fiKgqhZ9KbB4eo2cScc=;
  b=NQsGEQYu8m/VEzl8qIyV6G84xy9ISaWrqS86MQrPXk0rM/vWnCDgJUa0
   dBHNrKgXp94mArZnCN1KddXj9lr9a5TEAYPU1ReiXCkyBOtLGeSapIaG+
   bWYNxPw1LaN+e5sMxroF6RXajTR0GDqzsO5JrpuALDHNXsnox2tGdP+9c
   ugj4BVT/zWtQQVitFkkBcyyVI+9QvkTDia7OmRm9h+6uUs3g2HAO0kfvV
   3PHfhAleBLAd5deVNEOYkShIL/mIr87Xcsqo0mGGfYI7k6ONlXWWjNR8m
   Y+jqkLYDRLvb1Gsu5x9CSHWDaVbYW3uUTV/kZ+DfPh3kEt5FG7xxwZCN7
   w==;
IronPort-SDR: 1TvHuiJKDEh8Y6mh1o87kQERyyMzwvPJHgJXG6zCVg/ZTDwXdslw2le0luY3MzLco1RwGTQW/h
 pK0/CFxfl0D9/GzcGdz9LHovFFpY7r6svyavQBM06E5t+XRhYpzD68qizCap5FM1h/3WwtU243
 CcU0r5buDp4PCEdhuUK2hLCTlc7MQH5wvxxKyamx24YrTUVTHtwbpirmMuNH96eTaq2+IseXDr
 bYM7ks4Fu/WAezGAvAoFOgveoN4VBvctkyi3bNR36dgY58BY1nq06hzsK8eOm5eRG4ijfzEnf+
 nm0=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376630"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:52 +0800
IronPort-SDR: 4s3uOVPdiMfu/Tx5pakkngVkDEi3Jb40VgWBy9V2yFPvyelTDjnYJtAfja74buOPMMhTpJBhW9
 XQ1SQ5zs5aUpqF1KofdA+lcQhKvVo/NSI3YEsPlrJe0QinKueP92aEquU88Hiv3wKNnAOV6FE2
 QFGQKh7xvjoXM5VvbkGAXvNxw+TU/YAru9KOJzNqc3mo0NiSduWlWKEieCUficKvnWz109sFMs
 3+/rqm1uNiBfWcsZVN3a8+3yxuEaoOVCZDAwCAB7ct3VSo3zKQui0DX/FeLjlbT67TvEDV6/ad
 zE1cMiuX1SL0tRDhEMEcBhZM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:53 -0800
IronPort-SDR: VLNZ2HUDN4pvAE2uhCYoFMLgcZ8YEKiMKK0ugtH9ln1WNG410aMsp7vFhMOZXue/oXA0w355P7
 04iWboKDl46dTH2Hkr18tth54hsgtVaONRq0M5silZM4zbkTMhh1bO9KzJggK+m/0ev/aqY2nC
 gjscoV4sjZ4BSUvAgxD5Ueh9SW8ArJuOCvvQDLpg/zq65ASSy3mPjqeBHqDy/i8/g6iGaT6IjX
 K6OpkrwArU+SZIdvVnYfXJ0w6dQEW1qXLT9UK6L07gtC60fBj5AfaZLGvsc5CeNAlq6DtxLv6c
 wEI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:51 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 29/41] btrfs: wait existing extents before truncating
Date:   Tue, 10 Nov 2020 20:26:32 +0900
Message-Id: <47aba0c9cc8686ad4807de22c555f4d13db5dc9a.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When truncating a file, file buffers which have already been allocated but
not yet written may be truncated.  Truncating these buffers could cause
breakage of a sequential write pattern in a block group if the truncated
blocks are for example followed by blocks allocated to another file. To
avoid this problem, always wait for write out of all unwritten buffers
before proceeding with the truncate execution.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 991ef2bf018f..992aa963592d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4955,6 +4955,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+		if (btrfs_is_zoned(fs_info)) {
+			ret = btrfs_wait_ordered_range(
+				inode,
+				ALIGN(newsize, fs_info->sectorsize),
+				(u64)-1);
+			if (ret)
+				return ret;
+		}
 
 		/*
 		 * We're truncating a file that used to have good data down to
-- 
2.27.0

