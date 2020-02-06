Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94252154239
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgBFKo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:57 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbgBFKoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985894; x=1612521894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+3EfF9kWwSaym96gaaWEwyNN9Tptl6ELHEmXCoomO0k=;
  b=NV2wkB+cA/PJV3PJYHnRn/YN5/Lr8afe+YIAZ/CtYHHauy6hOPlEYmft
   CorU/AwFxgABRha2DZzqzZBqXprc8UxDwFdhBiHbm0qC2YVObf+RLvIeE
   bZ4CFPUA4QfJxA2abWfcVXNdYPNDOvbcNQ/e5PcdOc1Pgo8CZXAzTjOF5
   adv6/xTOMDQ9y8XXa+MJNtCUJDVuyJzOFe1fLBDM6WUfssVDohH7sI6h4
   8AaCXi4rH9K53lGNXrOioOonTcuNGNerdVXB8Z2mGSG8GUcTyeOqvc+S8
   Nt5CXKTOHC2Xj0H3SF3X+aKuBCupsoOiHL6jronfIblmY07RH7ZuCRgBf
   g==;
IronPort-SDR: 0crSytSvN0LOaSAqyDG5uCuEQ+zhf7scVodutt1DVh5D5X148H1H83vOm6X6o3/oLy0cQjtP+6
 OKGOb4rgjvNv+KD4O1PGRk/NxpelDZd2ptBh8m9W4qqd0Ol3huyoBrTQ+xyjSkqA6ycrJIEIvU
 9JPu7m+29W0utzZNkJ9eh1RT4ipSqDY8CglbRAesCsoVBPpyokXm/uknSqcPytRTYlWC6tqqhc
 VlsqlXnlSSPQRHhbOVBX7ciMaD4ocoVS585indFBa673bl2UCwcPPrmHN1qtdCo6h7D8V/2HrV
 pfw=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209572"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:54 +0800
IronPort-SDR: xyxaHQbT3V37oUMaoCM8ZzmeMlAeqIBb61PeHleX1bdTXOgbOZJS+Um9T6/nJceVxQzuQhMNbe
 Mp3QUALL2PoSFIoRCkJG9f+ad8aCAhsYU9zT5SXMhzLR+YCOtj/GNu56a8jqyGzMMzkpnHgqY8
 F4AF5zXhh+Oyaiofxv3mkcYAuY0H0fJE/c73FEM9HoXP4PtH6mg4MHDz6+az9ELfiIuyiYwEzJ
 hdlGu3yqiKMC4O78FLIEtwCB8JkRTyPlwRHyCSjbZsmov7X6q6voYePlnC3I7CpEoHLBZQU8L0
 S6sU2ec+vMgtuft+vxEBdw8W
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:54 -0800
IronPort-SDR: VJIsXF3ricQoWhMnr+kIkpCN9h5jm+wbSrA98roCU6BN9ogyYhsa945CWsFJpfy0Cj6w/mKwXC
 K3Iqn6ayVTulty0ymJva/QRfhuu2w8tP6KVf2yaeJqlfNETKkzy6qnidBVSic2KsPaIEuBVJpr
 llVQTndZos92YlEOzfQwRGA6a5taD3gHJ/vvllwp3gG1BuXZ4nFIc8yuU9QnKNTHHeVgqFdCyn
 j61nw2j29R3emzaYNQa8h5IeesqC4ufAruR1t0CGDG5MMTFad/dqaaJZiy/UprDsKtu1mz8TsU
 wCA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:52 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 19/20] btrfs: skip LOOP_NO_EMPTY_SIZE if not clustered allocation
Date:   Thu,  6 Feb 2020 19:42:13 +0900
Message-Id: <20200206104214.400857-20-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

LOOP_NO_EMPTY_SIZE is solely dedicated for clustered allocation. So,
we can skip this stage and go to LOOP_GIVEUP stage to indicate we gave
up the allocation. This commit also moves the scope of the "clustered"
variable.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 123b1a4e797a..2631ce2e123c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3373,6 +3373,7 @@ enum btrfs_loop_type {
 	LOOP_CACHING_WAIT,
 	LOOP_ALLOC_CHUNK,
 	LOOP_NO_EMPTY_SIZE,
+	LOOP_GIVEUP,
 };
 
 static inline void
@@ -3789,7 +3790,6 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 					bool full_search)
 {
 	struct btrfs_root *root = fs_info->extent_root;
-	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
 	int ret;
 
 	if ((ffe_ctl->loop == LOOP_CACHING_NOWAIT) &&
@@ -3863,6 +3863,14 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 		}
 
 		if (ffe_ctl->loop == LOOP_NO_EMPTY_SIZE) {
+			struct clustered_alloc_info *clustered =
+				ffe_ctl->alloc_info;
+
+			if (ffe_ctl->policy != BTRFS_EXTENT_ALLOC_CLUSTERED) {
+				ffe_ctl->loop = LOOP_GIVEUP;
+				return -ENOSPC;
+			}
+
 			/*
 			 * Don't loop again if we already have no empty_size and
 			 * no empty_cluster.
-- 
2.25.0

