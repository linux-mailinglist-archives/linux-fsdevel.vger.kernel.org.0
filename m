Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484092A0700
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgJ3Nx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21997 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgJ3NxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604066004; x=1635602004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rQA0qxXR27Qp9vBL16jvoizpw+AqEtwDF+vNmnqv+ho=;
  b=ECmNkgtuznU3glF5ZVTy6s9JmeITloWWoidPwxgjWNWzccLfe/MMx3oZ
   dNUKzwvQmHev/Qxn+bj1EfUrlmenT4w8dIO/qVCux2Brlio6xiHb5nOkY
   M12qIIaRNbKwgdjD4RP2jJuKrVlAkoWP7vk+628gERq2B6MbKVc4HPq2G
   K8tn/6abbrITpOXANJ0MPU9SL1ayYcgdcGaetPjeMnE97/DTKdRtkSmK9
   J7y4xUwoPt4qcy7VIMu2QV1/4gCM4SFqnexdwOdXn/NKtdA4hxniADj8C
   uu88HKGd4EH8bP9Rv3mQZqv9zO4oYFdwJ/q6qLSiHJaRHjchRTZUPHxSK
   w==;
IronPort-SDR: QS9LVCh1JSC0fpyQevO6DeSLfFR0WB1gor8WXVf7NMvsqqW47OtCP7hFC/KBBLSFS+hdTfm/CO
 clFVDXOyvsOSc94gvR1BLgu0M66zv41KrpCByBGysnVPcky4WoE6Zv/P9NpWClwIT2+Vm1IdBM
 3fuWXPZgx6uh712+t8BjXisUAbpWNC/jvIey/WBysH5V4ox7Jo1CfvDsoS5KBM4Xj1UZ4yqwHd
 Irj1lv0I/wEiHACcmhawsNOwlJLUyiFATVnol8YHO7/1rfCsQIuE4rIRMI1uFysFTmz3dI4Ab+
 sO4=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806650"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:53:11 +0800
IronPort-SDR: GKRtR2P8V8UbfKIQe12pL7aNtWP7ZGIffqKLMMsMBMzoq+HBAnUaaol0Bdo2K5mUdrWsuFEevo
 hykIpuUZqAkx0JDWkv8/pcaJ0Eshbibg42Wjf33MYBdxA7B/QKSUsMutDBg+Wj+GZ+n5q5Msut
 da7lzcno/HC8F6r1Yl2ubjhwEonCHfoeNu2Uou1FCCtPHckulaHg40L9bYPD4xswBqcN+oVkil
 F3YE+DuJEi2KVUdZAiEkR7iwi/MDJYoSAH17hfBHrLMNW5DP/v6Xr4tLvXi6+MYtssP3RtdCQK
 MKvPTmhy0vvzkw/5KamoLrQd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:25 -0700
IronPort-SDR: dgMlRiVEOGDuYEOI8v5Ci41Uc/xcQhUWEnGM/IuorO/jbhB/O3R2w99u0ErnFEEys5aDhLzwer
 WvMencArzMWotSuoK9/MV5xKulj2834m3QxWb6Rmat2A/Vqln9pARbfDZ0aXjB14tMqMNPY7VY
 9qdRldpCzvevY84FTTJ6fpZ7L57GkzoPUdMI4SZZtAMXwWqi31/ymKonI8bIcXMemwLEfWJTDR
 HLKNdQ3issmQC3pBzkBFdw7hlCjy1bD6y2nqMwdUEk61La4qedrsBarTyL+OWRPgR1wA468gQS
 73U=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:53:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v9 41/41] btrfs: enable to mount ZONED incompat flag
Date:   Fri, 30 Oct 2020 22:51:48 +0900
Message-Id: <477669128f8e874f07c2c636e651833b6620d4c4.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This final patch adds the ZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount ZONED flagged file
system.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 026d34c8f2ee..c15f73c21f69 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -302,7 +302,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_ZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.27.0

