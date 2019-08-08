Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A3D85E4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbfHHJbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59627 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbfHHJbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256674; x=1596792674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jfxhO32hn7zstCghu1KgmwZMJF8yqJ8z6sMLGzvyNSU=;
  b=Jl5X4rjjVdy5Exx7AyD6FvM6eso0Y53W7vMHgKbr+BbMa2cOwor90jcN
   NzkDT3MXYnDpYTqXzL1leL1WFeVNOD3v+gHs+9aWUApljAOs5Z9aicVu7
   5gHUeOqRnlO3SgPrCkBrwWt/4ANzLLJCCoCvXxsKyTdKXVquIMtWQ107S
   xakrXhHQjhG+elNwRpx4FfYHgcpww3Iv2N1PaE2YIPL45PamE4EuXRmC2
   xeNlBda2Kfg7c2RkYYsv6j3Pd37csEskbZ2OF4rEVIDaZK+BQPL8NYVkI
   6JkgZAKit0U3/2dw3LBJ7QueRQD/Bt9wqwSLbkEaoAGvJumMz4vueUmDl
   A==;
IronPort-SDR: UsHy/sTcOb8Dx0wjMtDLx+GlVQS5EEBi3Uqx+Vg1Xoo7jqbl1CtyZHNc1q5Vo0u1G02S8mY7D7
 mP+8E0JActzM7pqLRs6mDT09nFekapj3Ex4cosFbB+CXjLmQ0UxlEwHekQCAgoK5S3W6Hp0Tyc
 JTiVK7h9KTbYOIABK81hTCoTMaQNkwxhVIfOPeJWC9CHMW51jgwFDMxUHMmoLl5OqdfyI+KrYz
 UzJc+UOYBob+FZumN9n1I+A3kVV8A/VP7133Ymslpk74TNEcwT9P11Kws5RJarsydRzpBEDivf
 Ne8=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363286"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:14 +0800
IronPort-SDR: R6fyWVHP15c9F8Ou7jebzbiT7t6M77d8ws35T2gwfJV5wV7eNNWYKrheqRsvx48ZXNSh7nkFR2
 S9RCQ3BCJPStG8ch1a9Fd+FJAT0HLLwcQ0bHV6eGM458Zhe9qUhzpRg1w5QQQ7fBw33CSM/Dj7
 ScZpV6SKmg8/F2feMpKvATmlch8xuMC4Gi0lX2jq5BIk/XKvxyE37BioDwMy6vkgpVcAUdwzCt
 bsbXlS40+bsh/sI3bWaxUFFf0y3jcsjhfnOLHaI79czxazFGbCZs3Hg1B12tNs0SZOl6NtP0iX
 xhxkbbsNqIbj27Bwo5bEC+VY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:28:58 -0700
IronPort-SDR: AoBvL0sHRNMUHesl0ewMllz6ceCWPs8G/L9LvWRAenILKFR0SBc1895k7HvPzH+xCu7simG9T2
 CqMdqp7hT0zNwvv26mo9JKH8nEMR9oAvL7y22/X4IYqUJkyerwobRKBxO3Q/JLLdoLoGbJIz1c
 k6AwLhG04pmABXNw95V5142W+XHjpkqgA8YyJCCuZ/imkAnSp/DQT9vp276k3Sdxaafk44SEuo
 OWwLjfS9AnMiNMuT6YsMyS/34pYyJhI1Epd0FC+NV8rb0a+PyC+/OOJQogbwT+JyNJeRXODGg0
 4VU=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:13 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 01/27] btrfs: introduce HMZONED feature flag
Date:   Thu,  8 Aug 2019 18:30:12 +0900
Message-Id: <20190808093038.4163421-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces the HMZONED incompat flag. The flag indicates that
the volume management will satisfy the constraints imposed by host-managed
zoned block devices.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/sysfs.c           | 2 ++
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e6493b068294..ad708a9edd0b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -193,6 +193,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(raid56, RAID56);
 BTRFS_FEAT_ATTR_INCOMPAT(skinny_metadata, SKINNY_METADATA);
 BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
+BTRFS_FEAT_ATTR_INCOMPAT(hmzoned, HMZONED);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
@@ -207,6 +208,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(skinny_metadata),
 	BTRFS_FEAT_ATTR_PTR(no_holes),
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
+	BTRFS_FEAT_ATTR_PTR(hmzoned),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	NULL
 };
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index c195896d478f..2d5e8f801135 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -270,6 +270,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 11)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.22.0

