Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D88154234
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgBFKow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:52 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgBFKov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985890; x=1612521890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i28cB62cpvEdkeEm6OC016E5KksXp57RuPy0QhYL2+8=;
  b=SHflm1tgqNe4/JdRATQMRnl0LzJ/H5XgEie8mm9TrQq+Niw+2HEHsgAY
   wB93hKy/F1mN0fXP9w/ykcJTVvc+49APc7fhOQXQRH4wZuCv2jwG8MhCi
   K8msWTfM/2Td2wW/Fkp5Q6YDgefvK769GwFpc0PMQ0tGV/uSrQdMowQtU
   uoarTD107c7zWqIKKRbrnh9EJjsqZgKZe7XpT8guO4xkUMN3Tb8qRlSgD
   nRxKJ+9BhHrkLgoR7pX6Mj6Ns1A8d4rr8gd66Nc8ODIlO+7HzjyRJ0zcT
   +Jln00eY/ov5xhxfLPAwgNWUDnAN5xgQiBSlSlHrD1becM8HqLZv1Cnsi
   g==;
IronPort-SDR: A4UCSZzsDXRkRjEeHzx0zXQQl1S/W0wqltqqcEc8r4A313QcXS3r9U2iEhW+LZb8cAnGjeEa1B
 rdpJsC8OBzw5UNpPQ7VPpspNP08F3TRrh4J+rmi+nikjmztjlX+ki09atkvxSGAqPRZqvLsDO+
 WFCDuapgUzPRQgb2kwR3dKdejS8BXudJ6WjeB2F3SXL20CZu8YPQadlvYutHLshuairlYiYsRs
 V5hShMjNCS6/4Rmh//mBCUdoMir0h2kX0IXCjQOInZhNem22D9QiKAkH8gA09mheBiy0JDV29F
 f/I=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209561"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:50 +0800
IronPort-SDR: kWjuX3hRQDdNZMtO3Cubkq7D3DWyg8lThTwubxirpONldyjUtsqElT++znOsa1+LubD6SUGtAN
 nBLo1B7uD6fXiVw8ypSBOVdn6Ve1nhYBkLwNd/yqQeQWxxLj8wnYghQCc6bqEwlUG37i3iqM1W
 9JJlGe+Q/bk9kLIh307y0RngnOdV1XwcDVvKb7ml10JroaMFeLE9os8UY7WC5ZDQ8uq9PdQkOJ
 D0R2lMgtcrQrXeL+skZKF8YowSes3eaP6Fwvpve0qpI/tNDx/J/edmAZvCEKhSjU9BXTF3gkl2
 udEnSBaCFTw69ZeQjgm8Wrsv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:50 -0800
IronPort-SDR: 6aASIFtmBDUFcFopDd3Hl4jrsUIrGNzSg1HrPHLFHeWWI+iJFCnQtu81ssNmARd7Dnwe55qTzS
 lppOhSQbkx1t2hzIbW4o0uwuoU1YqKe6wy0DXAFH2jeSseg8Bgu4fvAqxoj9U/tMZodaLWdZ2o
 5i4Ef2+5MQXknxLBpzMjCJcEPNStgcnC5eYGz96zModoR66E0/7XtGcDiD4MtNs/z8+nxebHAJ
 B+2go1acQyZX7R/yuMtRUUjMG3je+rydCmVxvyhJKw14B5FGpKlGLNTFLSnC5sWNAWZ0ZfxUbC
 VWw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:49 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 17/20] btrfs: drop unnecessary arguments from find_free_extent_update_loop()
Date:   Thu,  6 Feb 2020 19:42:11 +0900
Message-Id: <20200206104214.400857-18-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that, we don't use last_ptr and use_cluster in the function. Drop these
arguments from it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d70ef18de832..03d17639d975 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3769,10 +3769,9 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
  * Return <0 means we failed to locate any free extent.
  */
 static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
-					struct btrfs_free_cluster *last_ptr,
 					struct btrfs_key *ins,
 					struct find_free_extent_ctl *ffe_ctl,
-					bool full_search, bool use_cluster)
+					bool full_search)
 {
 	struct btrfs_root *root = fs_info->extent_root;
 	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
@@ -4146,9 +4145,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	}
 	up_read(&space_info->groups_sem);
 
-	ret = find_free_extent_update_loop(fs_info, clustered->last_ptr, ins,
-					   &ffe_ctl, full_search,
-					   clustered->use_cluster);
+	ret = find_free_extent_update_loop(fs_info, ins, &ffe_ctl, full_search);
 	if (ret > 0)
 		goto search;
 
-- 
2.25.0

