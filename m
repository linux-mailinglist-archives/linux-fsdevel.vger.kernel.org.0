Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB742F7333
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbhAOG6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:58:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41718 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbhAOG63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693908; x=1642229908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPmcv5byno73bmwo8Jg2eY0YlMtgNL95TyRHUx647j8=;
  b=B1Pd3epHBRs2FRaOIEVCaPkNxvtfqj2n+pmh8WhQ6/fXVAL5+P2EvhW2
   Xz6KGt5EmOkw96BSe5WW5VV32GV1xClHbtjJZXit3Vq/xPdXrXcPP2e9w
   LomF8EsAP1sNnPfatZXKwn1A/Xjqx8JRdckQ25jqbuj7omFVSOuRtfaUM
   Y7+hqdugC606ZyKBJ6pXNYz5lMgnB5GLbR+tKPGNosyh9eRsVkOgFweCB
   7YgCFSldjseD2xeE73HMVepAo6oLGXzTDvY+utCZwWwhxFgQPpB543x8V
   usRVk1+6x/GGskHYVYS5vFREASC0PKRpLwHflpuA2w/H0nvf6KqoupdNA
   Q==;
IronPort-SDR: xy2NUtL3d5piUL3z2376uyFptQQXi74cNG5oRI16CCvcmlCsKrGYePeT/hKdFxCaC76qzMzhDg
 yIM1LmrmsbiBGM7P2vVa+C79u0hLZH3iZsJIL9W945Jpi+seNt001URJf+vTOri6gD8HIWBVrP
 C1/B0ty76WhZujptHQ45Z2Rr0VYeLZ+A3T6W70m3XX7aRn2TWCfnqFZz5vGzuQXr3bcQVUUHFB
 a5L4+BVMSdUtE0n+UryIXivPSprL9xZFXkNWVblBE3dkJtWdEVMYvHkxSdt2R0j7AXxPLv4qmV
 xME=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928251"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:37 +0800
IronPort-SDR: TysY5FnkNr1nj77/5537zj9WAk+WOsPlXv7TvPWWzakABZE8kK/Y6K5hMy8RQxKa/JL3HjODZp
 2ibLpbxVlz0Rt/i1POhDvCC1GPxhbmQWPjPF1dprY9fdvpIWqVCLs8yE22hNKlKCeRKXJDedyw
 RFQNYHRw+YkXfcWt8K7LCBL4fk2B//Dxx94Sa/swGtOewmQiGn+jITKII0ccz5NT01XLdfirv4
 m2Ak016KlmDz2RNz8kUb82w/+WIB2q0CveDT/1I7fOO7NEayiXKKSMyO27C/xQeNVgCjWohoZw
 bbpiqW/zoFHp/xOwUKtkK0SB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:19 -0800
IronPort-SDR: 2yTOBFjKiwMpw23uyGAQd65kAWgU7R4vxnyorwTWKKjRa5QgayCfgUIcOzLtmef2XSHVhMy4SG
 Gv1+Szs2rtDFvOmo540RNePhvpjITs6MkXVjcr75LWjvKCMvHLgc8+XZshK5+aWTst4WuhIfSW
 we5uH6RZHLd3juUzP6va+ms+jpDkO0G4o47maMjj4Q3JmmNrK5V+sn3hKbauNgdxO9mf54yYFq
 PfqcNwy1UwG5l9XMHj0SP9MhDZ+r5mXsjK3eOVfUDRMzTtTQDLUHc/pWYcjXJpkWlZJRIOG69/
 zHI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:36 -0800
Received: (nullmailer pid 1916452 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 16/41] btrfs: advance allocation pointer after tree log node
Date:   Fri, 15 Jan 2021 15:53:20 +0900
Message-Id: <00b835bd1973fe3f3b9a35eb6fba90abab939186.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the allocation info of tree log node is not recorded to the extent
tree, calculate_alloc_pointer() cannot detect the node, so the pointer can
be over a tree node.

Replaying the log call btrfs_remove_free_space() for each node in the log
tree. So, advance the pointer after the node.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 757c740de179..ed39388209b8 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2616,8 +2616,22 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 	int ret;
 	bool re_search = false;
 
-	if (btrfs_is_zoned(block_group->fs_info))
+	if (btrfs_is_zoned(block_group->fs_info)) {
+		/*
+		 * This can happen with conventional zones when replaying
+		 * log. Since the allocation info of tree-log nodes are
+		 * not recorded to the extent-tree, calculate_alloc_pointer()
+		 * failed to advance the allocation pointer after last
+		 * allocated tree log node blocks.
+		 *
+		 * This function is called from
+		 * btrfs_pin_extent_for_log_replay() when replaying the
+		 * log. Advance the pointer not to overwrite the tree-log nodes.
+		 */
+		if (block_group->alloc_offset < offset + bytes)
+			block_group->alloc_offset = offset + bytes;
 		return 0;
+	}
 
 	spin_lock(&ctl->tree_lock);
 
-- 
2.27.0

