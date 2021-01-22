Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D73A2FFCBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbhAVG3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:29:07 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51117 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbhAVG11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296846; x=1642832846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ek7JIhSO4mv1skx19zGKgLOh9ix/IxT0bw2T3bkcUKw=;
  b=U3bhN/2TjhJvfj0LOB/kLpUbqUH4UXuecnlLEbjODHgXpxKcFD/+l7kD
   u+92184y/sHGue7pOsnxGOHYgm23B3jeN6U6rcXCsnzx8R1KXSmReQm8O
   7+IIt7hCFj/P7wQuQZGjxma9l1jM2pHvfm5m1LvLS45SL/6LZPY0AitMF
   e9cnq0RmEnMBj8l9MGvBs9bFSbWQ/ExL7IUbLD0qIB8xMdwFni2k1OSl8
   A3t4Gxps9DC/33GjdQgIMbJr92cYvwDfNCfYGP2GLlgFUhRbKdTVGMCPT
   STi3c88UabyhhBuZMZgqnuYOOoTSglrsRpMoCmOJkZ9FHagpxJ9FTofEK
   g==;
IronPort-SDR: KlPbBqT12+xF3JO9LPjSPwuhdUwtLDE9Nd+7OyJBrDfBZwnAuzCdd0WPExePAvgeF44353WdYb
 xAiqgTwI5CH7Oxb9fIGBjwOxGbYsTG7zSDh652m4hq540vtzUzNFPfT3yXvxtppt22Vs930GEG
 RZ4QNu/33QIjfGOd2Vwt/FYNceFkwZDEu0xPfO2MdV+at6KdQTcvKu7swafggoaXkapFhCVk9H
 e6RilT2KMwLZd2fONcRqqpk/10rZCB5yrfq2VpU9cT91LYfWad9nM8ON1J5IqunojeucV1zGRt
 j/A=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392050"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:12 +0800
IronPort-SDR: T+A7lej0XOxJxTTf4k/qIYy3QA3p25BJe51qukWMXOUtYNhbMSaYZLM61KEm7ghe6muC/rq4LM
 3va0Hd15f+Do8dr+gLhLi+ChXkhF0qGzji+KMMb/p9GWouO5PzKLu+mnc8c/5CSRFjEt04/ENz
 w3jOri17k6Iq0EJ9GIG/653lx+U1iiqMUAw28+bAIqkRT4J1jmyYN4BuRRztr4+UKNCcGl2M0W
 Krq7XvrfBtYNy40OBPwAjYf07KrMWoSiR9vPvPrf606CXQop7lTHRFF2cyIwer8Jobda0wWoFY
 C2yntb03cQ00kvY3/onTwsqs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:44 -0800
IronPort-SDR: IB76tcEVF/LHW3MQIkLxyS4Ci0TfQXCJY3H1ZbuQjKDVfN2fC8t2CFZN31ZW6OPaXLNOO3l2v3
 Y5lmc9eafiBXMTA2VxwIUpAiQ+bKRX0RgqtVaLrijoSXzW6wR0xynpoDx3IQzU/ec3ieOVSXgE
 bFLbxLrW0arS+6ge+ddbIsELYR12SnHVFdaoGWB7/JdlYux8fYGDZjB+3ugWNxLC/mYGfYOP/a
 KgAXkxnh/gIlj7bIsTewqroYKtRlyzY/lC+RWpmXIjYMbHSTsgW1vytlTU8upWqK3b2/+xJXmR
 ZnI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:11 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 31/42] btrfs: wait existing extents before truncating
Date:   Fri, 22 Jan 2021 15:21:31 +0900
Message-Id: <9abfa1e527228bdc44ef9f285cf0daf221b9a715.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index a5503af5369b..06d15d77f170 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5169,6 +5169,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
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

