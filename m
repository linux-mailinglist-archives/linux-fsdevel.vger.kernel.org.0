Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170A985E5B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfHHJb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:27 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59650 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732163AbfHHJb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256686; x=1596792686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bRZULrSJKwNy2EeClCcFfsPH/n5tsEyPC1ct2OsOnkE=;
  b=aEL1DiPlkOfQNaeLhCyeHvdydrleGCnJHAf6nrAMHGiReANvSGakk3xd
   OMXrNUCf7awF4xbimiijxIMzOHDtNxHZc/iqxRUZzP+beBQTUXGZ2G8H0
   ThhZpGd1YVvY/0pfnKar1HmGsuezY1s68kwDkCoGM5T4s2v/vL4MzIr6N
   Q6bFRFsr+zLxpbuton3ErEf71N01mQQu5gJyUDpscI/1xMsAYTjeS4d7I
   L/pgzcbZnivgDe3kttxwPgjK5GTzLlRF7jguDSELxa7uXumu9+aelt9g6
   yx6GdyGg8LqY70dih0fsxQIxWjr/BRMx1d4N6ACHIkYNSeG/jGH2NM5Nd
   Q==;
IronPort-SDR: 1ooL4MS+UAzNYav8mmEAWlC3Tt02CrcyJzVuy98AYBlf4fQvkPHESpxMWVDcQ2xhG6VF/lNe85
 AHVpn0pJVcitdhDYLuVSgMMLVH1r6iJ5nO/NQyxIAculw8QrWnb1uAzPbfgA7PHUsREmEbiP6l
 tkjbbzVxbwUa3Ok5qOJ02yJSZPaG64FMs6/8qgZjvGFH5QF823u1ZU/5LeOfsIN5xDklmSNE4H
 fyVXW7utyziITLi8Y9OuaY+K4W86lm9NT69P0ujrJMGCWY9ydMr8poW8tqQluZdAEK0jExS7Zs
 ZWM=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363340"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:26 +0800
IronPort-SDR: Lbzdfdag8tkQr0Im0Xcl6hpreKyuDB0loio7jfxCjzKMyIZtLTV21Z9MBzCBP+k3FP5lyOGypR
 UiU2xzIcWRZuM5YE2OJCdZHV60ZJmOQXQRwo7vctp9dXVfcIuKbDh3wgYNYt2NV39JWKiJKUP3
 DyhpdHIU6/U8/4iVSVAv5xw6XjDSZbyn7pW1yr2fFZ8d4SBLQg8brXcdFxs3FB7IQ5rINXMkkB
 gxvS7eyH4/lyY75UmD1PrKJ4rQFnRQwD1m9J0q7cpk1xcPcpKK+8GnTJEbufwZgrg7g1dpojDs
 Qps+CY3aY37bsTU1NIRzHKbu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:10 -0700
IronPort-SDR: E3QCgO11VIYuopcFd1kubSpixRfDmybMfUhy42DrDIMv+CglxcKYqlbQxZnlt/mWCUKHaH2AP1
 SUbV7sa8ZpSBeH6GP6lv7rHQ3KFvdqLiwpNZwf2QrOw01XwAPleNBBekVZL1eBECevkDYGvG8D
 v5K4AlaFUu0On2XfxwjtLXYqBR1txFTXBmjcOyCSt6A8xA46tsh8YJnVLdUo7Lk3KSXnw20vGP
 qZQ7mN8cvT7Bpv+isvNXtQxmGEFgOxG6RdhnR2CavIUwwCr5WoJEznSJPR7Qs0dRiEt8YWcSp6
 7P8=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:25 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 07/27] btrfs: disable tree-log in HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:18 +0900
Message-Id: <20190808093038.4163421-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extent buffers for tree-log tree are allocated scattered between other
metadata's extent buffers, and btrfs_sync_log() writes out only the
tree-log buffers. This behavior breaks sequential writing rule, which is
mandatory in sequential required zones.

Actually, we don't have much benefit using tree-logging with HMZONED mode,
until we can allocate tree-log buffer sequentially. So, disable tree-log
entirely in HMZONED mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 6 ++++++
 fs/btrfs/super.c   | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 0770b1f58bd9..e07e76af1e82 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -256,5 +256,11 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
 		return -EINVAL;
 	}
 
+	if (!btrfs_test_opt(info, NOTREELOG)) {
+		btrfs_err(info,
+		  "cannot enable tree log with HMZONED mode");
+		return -EINVAL;
+	}
+
 	return 0;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 496d8b74f9a2..396238e099bc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -447,6 +447,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
 	}
 
+	if (btrfs_fs_incompat(info, HMZONED))
+		btrfs_set_and_info(info, NOTREELOG,
+				   "disabling tree log with HMZONED mode");
+
 	/*
 	 * Even the options are empty, we still need to do extra check
 	 * against new flags
-- 
2.22.0

