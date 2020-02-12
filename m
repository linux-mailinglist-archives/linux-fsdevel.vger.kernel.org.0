Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8958715A1C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgBLHVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgBLHVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492085; x=1613028085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7kSGCvaay2SG1nIxMcRDLO5KnT8tOtaO/l1P1KJNuCY=;
  b=jgej6GfwZJwzlZN43sE5PtTkqIhkzijeUGIHmYwSOVbMZUDLIAH2J0DZ
   AS73VJKJG/CpYhNeDvZG/5qGrlef/QpoAxPCilV51YCwDQvbKZcDQKakR
   BwhfWBFFEkVtNhdne1il2yJCw+eVd1UyyTjIGrWAjmz8/kU+vpB2sDbej
   vOJFoO7HLmhvWpYRvGdebPv5QUrpvtyszStFxA/64jvnVT+w2xnMnqEax
   PiAio9/3bth3d22ksKDCmS4qRZoasMrIur3so/J4aeB2DeToUAo/M72Iz
   cPIHvdgTUthoOEGIW/jMAxeZNm7XI4B2Ok5usoXqiRof9XeCpoFt61Pbw
   Q==;
IronPort-SDR: u0nV+EjUa/vVH4tK7EdG5XagoCWUhbSnwiJjr8t9bIR+rLMqi0PJT90fTaVDw0B1em3F66jJw4
 usxRanZgXRWsH+DfqcIyt/CaBH48xkhSvnfKDvCsEtl1eM+0B/6gNvyoJrtLCeZcX7jdcMpMNC
 91lwbLdULVdRXYWyffd5yEw1EFj3UOvXpcWnixAKq9iH0QSquY6QKp1vhXM4/4BpANpWHlIPvL
 h74g80/YMlGjXy163CD1lllqAZPp91i92eoa0NOfY5GVyp7D+OUXYP9jpYF7hUPAKntMn4p2OB
 0qQ=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448925"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:25 +0800
IronPort-SDR: CtsvS/RgUg15OKI/y+yEoRPL/kv+AT+S4DPmz0hv8xlzDBt3tFL7uZL5m3fnBiz7YRYIuWiJTX
 HnaE9XnfGqTBimm4JpS347nZgqORpWLXu7lknuyGRFuSyH946Gppc2oUlA86wmSIn4V9vFREAW
 fVTRrEpN/iepc6IvG7nVOm2aDU1OIKElLt6xoTZ5fwxEMCRfrxXke6nhXbPq9fCxu/be2j66xg
 gUIJQCjJtFpYGUfP2/W7Y4gm2FxW1+Oi+w1P8LN6r2ayDcVfg2iLpDZ4xKj1lThyqFyF9nVFTd
 SddsTZd0c0cn6+o9fpyeVjKS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:09 -0800
IronPort-SDR: R6slTFA/MnQuZ+l6STq8NcXTpIjBlHDwwiFNiqj7qqLawoDFpBc0GbzPnPLxI8ug0Rx6wO7DNO
 vlk2lRdbeNeF4LLpmZyaXARROKQ/BynfdTBItaEkZNt1H49xX8KGs/2VD55qvGKE1b7n8yydoH
 SPbWV9ULhs36Fd5ACFz+kTIZefhSNk32v+5comUQcyniDys/+J70lKPC2LzkiOPPSIoUsJ4NXL
 1z4oBO+ErFg+plaJ0lxaXyUCHGlZcMZvj6ThI007J1nxlPKd0oTNGJxuz29GzpNnBa18JyW2NL
 Gi0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:18 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 12/21] btrfs: move hint_byte into find_free_extent_ctl
Date:   Wed, 12 Feb 2020 16:20:39 +0900
Message-Id: <20200212072048.629856-13-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit moves hint_byte into find_free_extent_ctl, so that we can
modify the hint_byte in the other functions. This will help us split
find_free_extent further. This commit also renames the function argument
"hint_byte" to "hint_byte_orig" to avoid misuse.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 247d68eb4735..b1f52eee24fe 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3494,6 +3494,9 @@ struct find_free_extent_ctl {
 	/* Found result */
 	u64 found_offset;
 
+	/* Hint byte to start looking for an empty space */
+	u64 hint_byte;
+
 	/* Allocation policy */
 	enum btrfs_extent_allocation_policy policy;
 };
@@ -3808,7 +3811,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
  */
 static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 				u64 ram_bytes, u64 num_bytes, u64 empty_size,
-				u64 hint_byte, struct btrfs_key *ins,
+				u64 hint_byte_orig, struct btrfs_key *ins,
 				u64 flags, int delalloc)
 {
 	int ret = 0;
@@ -3833,6 +3836,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.have_caching_bg = false;
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
+	ffe_ctl.hint_byte = hint_byte_orig;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
@@ -3875,14 +3879,14 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	if (last_ptr) {
 		spin_lock(&last_ptr->lock);
 		if (last_ptr->block_group)
-			hint_byte = last_ptr->window_start;
+			ffe_ctl.hint_byte = last_ptr->window_start;
 		if (last_ptr->fragmented) {
 			/*
 			 * We still set window_start so we can keep track of the
 			 * last place we found an allocation to try and save
 			 * some time.
 			 */
-			hint_byte = last_ptr->window_start;
+			ffe_ctl.hint_byte = last_ptr->window_start;
 			use_cluster = false;
 		}
 		spin_unlock(&last_ptr->lock);
@@ -3890,8 +3894,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 
 	ffe_ctl.search_start = max(ffe_ctl.search_start,
 				   first_logical_byte(fs_info, 0));
-	ffe_ctl.search_start = max(ffe_ctl.search_start, hint_byte);
-	if (ffe_ctl.search_start == hint_byte) {
+	ffe_ctl.search_start = max(ffe_ctl.search_start, ffe_ctl.hint_byte);
+	if (ffe_ctl.search_start == ffe_ctl.hint_byte) {
 		block_group = btrfs_lookup_block_group(fs_info,
 						       ffe_ctl.search_start);
 		/*
-- 
2.25.0

