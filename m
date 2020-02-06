Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D6154213
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgBFKoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:19 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgBFKoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985858; x=1612521858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4YvSJWMUpLhL88HQSt0+R6vDbTg7IOYYN8UIF1uYmbI=;
  b=EI48oNlyNaO9g+XC/rBi/EKUOCjWI0gANnnb93/ZOljGz3BYNG6cU+ds
   3BRiZ3dFSEHbEzT3Z+CqWiF2SroIaNHvqRD4wUxZxf4moBMrgF8rKWhAX
   HZdk6/ga5qT+9/2VEqTjAU31ZH6r87RGKtwZ2sed18EqZjpiA7231i8AS
   Fu3J746K/UO+AsZl6XOdoQd6V2ZtIWjiyPMYQHqIWFoa61v7xI00E50n/
   ue6eNEwjy2BU3FqZyrwFxzXOE2tLTftNiemdAJLQag3mWCAOT50UJjLLy
   DCBx0uBMHRxAM+CM/Y3GCwrhrCLHy3+w1K6A2BJbeihWt+2/Mq1nOG6GU
   A==;
IronPort-SDR: /tFawrBFI/Oqm8EJBKMWltIuePIQ11fK5G+ni5cxO+w+TZGs5nnxLrTEC53iBFt1LykepF7aCX
 Lxng9IMz2kGmrv64EvXizaEWY+BaTVAN//SjVh4Bo3HS+Zx18yb0fvI8pCbhQCM53cnAc7uwYf
 2yxmhk56v/5EJT4OaeGcmE8XWuEtb76Hjub5BWyrguj2M70EwCKYeo7hKZrJoNmAst15d1sujE
 fBR3BUkhLspohWtS7wxJhv5fcvvSHi1Ys9A25Zg+MN6svGAOZqvnBmEvlNEPiRKERK8uqhCWYK
 C6s=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209477"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:18 +0800
IronPort-SDR: ls5yzpD5TnMWBDKqIYRfCtwctWvetHY7vYGNHfXVcnVYb+x/FeelMdF/wEsoVvj/FknM2qicQU
 Mqo6rWXeUtYw2LdBID2sJScPkN+8rrCDjHg6sAgDhTuJDvA8sPB+5DqL17vq1RLPS4KybK5e3s
 n+ttRcPjAI/Imwhwh3KeWHzOkpwKfiw9ucVg9M5JyeXz+jZfpzH7KFSkp5hYMcodPS9uymlJ9r
 /ScHxdf/S1CuSKg9JJnOxJWalGCYh2lLQ5aUMzUV+PCfb98Iny9+NRGYu7bdKrqyOFTGJJ4le2
 dt95/D6hEmjju/ZCes+jVjUw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:18 -0800
IronPort-SDR: 2cJ8Y+LwxVoRAC3PRg/cEUQqvkf77oM5gbLyXNHehv8LKJvIq8C2+VKtLVoAoCRcoNqy7l/HGA
 NsWXAnrT3s/AU6tx8fGEgzBwxRuyXN8cPQFjziBkB5qfEgUUmnp7wB//juyHylehy9SkXbV7Ju
 l0wkHoW8xbw3sBzKn0hnPL9kCHYxh4SOvJDq82ue1sj3DGS2sh0HbwaK/c1DPVLInKD8QBkGYn
 vrF9J1jRDmlYLPN3fs4KwXWMU2Q3Zusz+DLdYufC5oRUncXPjXGsj2c3iqH9uPgXX6ate1zmQ4
 064=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:16 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 01/20] btrfs: change type of full_search to bool
Date:   Thu,  6 Feb 2020 19:41:55 +0900
Message-Id: <20200206104214.400857-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While the "full_search" variable defined in find_free_extent() is bool, but
the full_search argument of find_free_extent_update_loop() is defined as
int. Let's trivially fix the argument type.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0163fdd59f8f..227d4d628b90 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3672,7 +3672,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 					struct btrfs_free_cluster *last_ptr,
 					struct btrfs_key *ins,
 					struct find_free_extent_ctl *ffe_ctl,
-					int full_search, bool use_cluster)
+					bool full_search, bool use_cluster)
 {
 	struct btrfs_root *root = fs_info->extent_root;
 	int ret;
-- 
2.25.0

