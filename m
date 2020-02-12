Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684AE15A1D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgBLHVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:34 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgBLHVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492103; x=1613028103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vNFoHTIxdH12CSqZG6yYMmU0kNe+Rs0A08BY2/Z/5KM=;
  b=ajl5CXpHv08XqgXcwiFudpyRaib7tkrXIkNJTgwm/tIxe8xdL4hQPy3T
   m0UaUWfEbdWEU/ohReUzqpVxTZQQzWxI2t189erE/rjzKtiytz2XsG/oi
   prtxnAegJMa2ajYWS6oiE9UQPL5pwoSlQWAhcROCy+IzfPADxScSVSrLQ
   b8Hru24HOZuZTm36+awSIEJSAFUSMfiagJosB/nnpqdsnmF7cHMsRLGYl
   PWs7O+5SsvTSBmlt4QumvpEMhwwvTkb/EM9tUfckDg3N4HH8nwcjiSmXx
   zgJQo1cLUMqwmU9oHOwG1ifIrj3merjPo10MxYvmh2KMgjs6gAX09GaUh
   Q==;
IronPort-SDR: X+FQ1FZISH1o+6akB53+SxJCuU6hgcLlgQ5x1+mdIq9ea9EqihbnxJa+5fneV28Aoi/+3a1CVg
 pQBG+HhD1JXS8jCrNpKEnpCfGxoaFTyEZh4e4lLGkbJeyxii1UinCkLK/HsgUK2PPtvjuCmRYB
 qYqwte0nNupsQWonq/d7Y9uz/0TjUX5ex5KMAZx7JeAKTBET4CW4CWBVJI2ShGwJ2aYpOv7yZ0
 6LwJvCfWkCEqZzN/+VU/CuHTvsKBJjXqstdOKgQhuh9dXQNqsHmlSC2agIHvNNLHgalUN9q+GJ
 VrU=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448944"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:43 +0800
IronPort-SDR: JtZGZF5tuutD8MHMDf5NmI+t8pEwjEmWeDOdGnsN7HU2Z8JoL4GRdIZHMX6tp1zIDqyoFZKiUH
 ND3Vf7kOm4eyGNslU7TxOMTTkF/j82CDq/1xEXMyyc3ft0OMZPvTyl+YvNc2TzVZpwIzZn4QeL
 04wPsvtIvaZfeJXm/72r9vO7scK5vjxzvZ09ouXSIc+rE+PDEQODLqZKNFaLYmSbE20269TH6e
 sEMeBppYo+F4MD8KHvgvW+qj4UC4X43R9yw/2m9GklXTcd293khCG5w9pXkUJ/66T0jCNKwJ7s
 on9G+YrVe76BYla4+caFthZC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:21 -0800
IronPort-SDR: fGC2OHNwuI/RND1/w7zHQdd2BorQOJwBjwp07uBBUcEnKKPsKC4MU/T3cXF4G2C0ebUfG3VQgb
 IBS5m5fgm8pPEGq4OVpMTVk+9NJ3nPnxMOoRAi0EmxFJpdkuezHxdG2Sg8tmWJ76sXO30EtyJZ
 FestLaFCmnNlddHak7RP5c99Wi7ED0hPBQ8eWk9GbKsAJQNMekiePRWO2YgHJ88C/51xJaMd6b
 KsK6tL9Ui4u2CCryCe9CWw0gEDz58xIE9kAawF5gITM62pe7bhO5TGZfs9krKGnv7hdB7IUb9q
 M0A=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:30 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 18/21] btrfs: drop unnecessary arguments from find_free_extent_update_loop()
Date:   Wed, 12 Feb 2020 16:20:45 +0900
Message-Id: <20200212072048.629856-19-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
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
index f3fa7869389b..efc653e6be29 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3754,10 +3754,9 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
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
 	int ret;
@@ -4126,9 +4125,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	}
 	up_read(&space_info->groups_sem);
 
-	ret = find_free_extent_update_loop(fs_info, ffe_ctl.last_ptr, ins,
-					   &ffe_ctl, full_search,
-					   ffe_ctl.use_cluster);
+	ret = find_free_extent_update_loop(fs_info, ins, &ffe_ctl, full_search);
 	if (ret > 0)
 		goto search;
 
-- 
2.25.0

