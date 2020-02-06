Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C959B15422E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgBFKoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:46 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBFKop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985884; x=1612521884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ES3r/Y0ptjQAMXQVg2c4+1XZs2rCnxQ9Mt5HA9CYEvA=;
  b=XcYRRuBwaajFJMD21YRQOpUjQmzXO7Gs2TuVZNuXgN7Wbuekvv0n5rnB
   SQOf7g+0PY9+Svsa4+UX6rV0IV1kAcOno1AWskDxvxlAb7+eIETFrOm4C
   ZyvqKy5kgqNPJe7E4Rc7Sn36mUetM8+IlKGJxEOH+r+OaJ7xZ4xSrn6S1
   WbOt9REZP02ckosL8OWa/G4JDvaLHqfLFLJYmSkVX9M8c4di7PYq5N2a9
   5OG4azWz0TwxcOBMzeqyeVrHtUjdtOJsmfVCot/JDjcQNM0dV5IMaNMcs
   CLvNBXDdm8m6CqXWZX+3rlKGLWAjSww4aV1nZvVQUu6z/YkEpXq/rbYBa
   Q==;
IronPort-SDR: eXPug8kvUX6kSZZzNvCV/083JVktGjn+bPI2Gsyllcd0AWaHYXrGzIS1zEBwkmg/EuPs57M3UJ
 eK899SIGYZBNpk787ANRmygLFJzZ6LXcE52FKN+hDHxPnbriRzifTk6FIhZEPVloT/QXVQbSHp
 IbMN0S3zzPaPx7A7UfHlyu4d8urOStNZhxmVNVRcc9D2FAlTHlnMK6GtfrJrvNoKsrA7hc8v7S
 41xzlKoOxiCssvB5llWDScdvumS3GYbD0Dm+Zh05wzIdVUVe/Y+pTY/FLzapGEFxf0LSd+0jeN
 nAY=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209546"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:44 +0800
IronPort-SDR: CDS1K0P+JRryoNpGoJA15/FNrWUSvEKmglwOpri0gaGlpbmqmWQEalcu98p1v/As4ZyP3QjtUg
 DMAgnnCZkaywDabwAbhZVw2qakrNCXAVYIZoAQf0T4Y/EvvJ/EyTryQU4O1yBn+KpWZeqGm6P7
 tkSvfrQ6ukNHJcw3gGas+15yl1lQu4DY2j7nb5q7XBc+xIyJWY2PIMVJFQcmk8nVggh/kSSXrG
 hn6HEqUBgY4J2mS24VJjUsQazrgDKaQis7pf8kNvMx0px9Zht5pQrwIEFuBGxjoKSC4b48cLOy
 iDKSidKlH7wtjqAXuEr6Exto
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:44 -0800
IronPort-SDR: 0G/ajYKBNGY+JnDHP2N5cpnyXsmkt52PV39BzxSBSF1Kkyyin6bKc9IQbEGBR3yz98Z2DKuiEj
 6pzpSEXk3C/zWc3v3IuEz2h+V3lXcxs/1WTca1a23LCejwGn7XITcuydY210OXYv2xVaDxH7Ve
 r+JOD0n08IbtUjDsjZXSoQOLlLgds50PJgXVhHmkQxQIHa5p0JkBRbzZQrPnhyc4OfbQWEdVEQ
 3M8jHC9Lbrp41t60d978RDQ/JnqX291MW+Ar0YrbaOU+XiHeMTqZA0jT+pHasOzxHVC6H2rye3
 grY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:43 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 14/20] btrfs: drop unnecessary arguments from clustered allocation functions
Date:   Thu,  6 Feb 2020 19:42:08 +0900
Message-Id: <20200206104214.400857-15-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that, find_free_extent_clustered() and find_free_extent_unclustered()
can access "last_ptr" from the "clustered" variable. So, we can drop it
from the arguments.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d033d537a31d..0e1fe83e5d79 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3516,12 +3516,12 @@ struct clustered_alloc_info {
  * Return 0 means we have found a location and set ffe_ctl->found_offset.
  */
 static int find_free_extent_clustered(struct btrfs_block_group *bg,
-		struct btrfs_free_cluster *last_ptr,
 		struct find_free_extent_ctl *ffe_ctl,
 		struct btrfs_block_group **cluster_bg_ret)
 {
 	struct btrfs_block_group *cluster_bg;
 	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
+	struct btrfs_free_cluster *last_ptr = clustered->last_ptr;
 	u64 aligned_cluster;
 	u64 offset;
 	int ret;
@@ -3621,10 +3621,10 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
  * Return -EAGAIN to inform caller that we need to re-search this block group
  */
 static int find_free_extent_unclustered(struct btrfs_block_group *bg,
-		struct btrfs_free_cluster *last_ptr,
 		struct find_free_extent_ctl *ffe_ctl)
 {
 	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
+	struct btrfs_free_cluster *last_ptr = clustered->last_ptr;
 	u64 offset;
 
 	/*
@@ -3691,16 +3691,13 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
 	 * Ok we want to try and use the cluster allocator, so lets look there
 	 */
 	if (clustered->last_ptr && clustered->use_cluster) {
-		ret = find_free_extent_clustered(block_group,
-						 clustered->last_ptr, ffe_ctl,
-						 bg_ret);
+		ret = find_free_extent_clustered(block_group, ffe_ctl, bg_ret);
 		if (ret >= 0 || ret == -EAGAIN)
 			return ret;
 		/* ret == -ENOENT case falls through */
 	}
 
-	return find_free_extent_unclustered(block_group, clustered->last_ptr,
-					    ffe_ctl);
+	return find_free_extent_unclustered(block_group, ffe_ctl);
 }
 
 static int do_allocation(struct btrfs_block_group *block_group,
-- 
2.25.0

