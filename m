Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68AA304961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbhAZF2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:28:51 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38278 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbhAZCdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628412; x=1643164412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8o51zJXgKCL1eBAT72xASng1Vg7d57lWE5i4quEbbGI=;
  b=msnz6RI1OeBfVTP8ZagVl18MoZXsPqkOOtKaS00xwjSP2V0WwcTvUMCK
   Ih9GHHDym2D9mVOj0hyPl7eefKmSz+CztrjRcs3O/+3TC41Z8HdqjV9No
   +KncZ7FCVC98qX89CL4VGrUcaYWYSurEtno/jAAMBvx3nd7uSwLt9z1rs
   Y3nvDHeMt3tJyy2cuxptjI2eCAdzgxuf81nZhIkBUx0huk7YIH3lbjm1Z
   nORAol/RwpBGIY3472z3ROv16ob6r+5w+SUkNbfgjt3MP6HmYBvJH1a81
   ELv3ESOMUJ7d4i1EdwuYlD65eNDLZQQPxvsGg3bdTkNCqlT/BW+cDzZod
   g==;
IronPort-SDR: UTHpgILdlQPlzDeFIAqBjb0OCgAkNx41TufGKHKoSNwgsHg1FdA/iF4zfkcn35bwJb6uTFuTao
 XZ6TT/F30C3cz+oSuRcq3Z5T78P2+S6OGSHt+l7uFwnFy0oG6hAqZ/RTGlRpY1xNPl8vTvsPrW
 VlotcdO/6BBwl5k70FStxAmEB+LX6ftsmYlBU41F14EAZJe/zR1eoDYUxd1cHEWqG4Zub3UgE4
 oVODNSdNEkeCha0PV7+SCsALWUD/GjvYgqT2D9o1+rgWfz/5OMs1oeruZyDZREL7UbuCcJYDFp
 r2A=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483539"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:26 +0800
IronPort-SDR: RG2XqoY/bGDBfIVlS2h4DV04Jxa9VwUeFJPOmuOBuFRyvZaE0L3ybCCS1JlNp8SyIiCGR2gmmv
 PchdEMTk6HIyyfeStAM/HRozKR5idbpTDyRheBMnTOD5TPjn91uZY5/V+mJvhkk+cYHPBSKy9y
 JAHRYTbGW2pEGIxGZj5T9T4cXavp6eGCQVHRDoNJhMk+Drhy0Y05AeiJBEOPYGfouocgPp94Y8
 0hkr6/mJu/RX8M2OZMaS1glVkkYqhxR3/wUpOQrH/HBWwBpUo2HoRQ1KhNbgWybqDNbTkQDhSq
 nEU3EVexIMiIAOg7bYYYXq+v
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:53 -0800
IronPort-SDR: PTmbE2p0B7nDKxOYXNgSyF5DkLIrfICpLBu4ErRTMyZdYvdi+mP5Z4/1ovhzzmK+N4/6ewK7+w
 AlDN7fdMutIodRLUkxFPtggRgtgMZCqQWuhnAAURkL8eHZIpYfVrppNeAqVZSAyR4FnfTu18uM
 noHTxpVmAk/LwkYsezZxcquR64fZ0y0deTjeT+bxaqv1YmuAeH720LJ+cxrvapBcImXpj38j4x
 8/S4/X9BidSSy5jK0k3KpxiXTS7mJq3x64JRkYEAdvdEA7P+szAqzuswFDYV893d3ILCAdoHJE
 nQk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 16/42] btrfs: advance allocation pointer after tree log node
Date:   Tue, 26 Jan 2021 11:24:54 +0900
Message-Id: <69b443b9aa59b80de9442a0f5f81c685fd326b15.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
index 19c00118917a..c4ccfcb98aed 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2619,8 +2619,22 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
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

