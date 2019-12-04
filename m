Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2847511245B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfLDITe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:34 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32758 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfLDITd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447573; x=1606983573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QBsiVYR4rO2XcDZTvs+beR5Uiu6ji7PzJZEi+KlKlog=;
  b=i3VNVMm9cyx3S27SmztibvKRp7jxTw4qNCp9JyhTVmlwyNk38qrq0MPz
   rzf9A9qxDnYnJDZ66TywdBp1DmGaNRfsPbQySrHYnIMCpSrwkBJBJwTeS
   8wQZIqW3Z81mad67H8TC0rgw9SvLT5BHAzBNp4DEQNt9iEL6k2ukVc3QI
   /lsRzgQSds6JIpYGuKyRmHRpj+PuUeWm8jtmB7kht/yn4Rfx+kjAC2k2A
   VAEh5fCBlvIwWMgi2cu7TdwUWkKdD3M0wy+vjvaKcUT/8zJTWUWrN3gfy
   A2TSFw9ppfSZCAtF1dIkNstQ0an6YPWMLiVq3olyvrVpWTSmXQMCpsSyK
   g==;
IronPort-SDR: 2XmtujSn/4gT4e5oU6omv4doGj1hTbdVM1nnXLWjKjAGbY0tecCiLBeRVl4363j6gBHtiYWwu2
 xh+F1IMqhN3ftLFf3fPJ9hOKxij0ew/kGmVVoQsg2FPb3VLY5jT0QS1MN04XM0Mttzox18M2aG
 IxYWZlrzYGDnGOUYrUq2HvyuO8QYjqG6UPB4AF0B4G9+v5wKktoga9FdmFJfXFHLGyBpSc/B/9
 WjBCIKfFmPHiRLW3KF2CB5O66OmvLMHoQLSE5D+nWop+gR/KUPb5vVF/mccP+FMMIp9+CnhffD
 no4=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355039"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:33 +0800
IronPort-SDR: MptxuiiQck5oMz846xnv2SwvYbBPKSR0aT74PDDvf9DTRpLbrR1+C6JJ0MwBJ1p81Vvq5fbOp+
 jINcbzWRRYYmH/XsMZnGVgeg4vgFxODdNgWBrij2Pz+X50Yshswvraj5HQXmlNAb8clFjC+ee9
 m4CmvXFAJzur3TFyroFn/ZHXHpk0M1c0Jg1fwuMrg8wZqQzJkGHQoqxgTBy9xJHytEN1qEqiUe
 GQnrvgkAIGNJ+D67KPWqa6RJ09Eh8oz6x2YekrhOrzlm+6EdsyJICmqWLig8232dRN+Hkh18Zl
 rfuDyF9ki78oQ1vG7zKLceQr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:13:57 -0800
IronPort-SDR: G8hzCQYkwffnwcfqEl/RfYI7tDw8xnooM0EgbFD/Vvh/AwULZvVoO6SWJetJjHPWHuOgRdGz7q
 AW4+PahAWk/hJV4UjKYfLh8Z0929nxbPICQxNkQhu1Cc4WaTUc3A05ZFr44Ibju12TwaIQQBsC
 UI0ZZ+AOhthxKq2gwdE3Fmi2niiilZy2p6b+E9bWNVuKYwWj1kMfaxJuV2PCWGPID6jE2BSzt1
 ETe6f1WN4oZS6o+1+yYuml3I49HBU6vJt0J/O7RODqeugw1sjrjuqNRd8U8vZHksKXebA8iESA
 W50=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:30 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 05/28] btrfs: disallow space_cache in HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:12 +0900
Message-Id: <20191204081735.852438-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As updates to the space cache are in-place, the space cache cannot be
located over sequential zones and there is no guarantees that the device
will have enough conventional zones to store this cache. Resolve this
problem by disabling completely the space cache.  This does not introduces
any problems with sequential block groups: all the free space is located
after the allocation pointer and no free space before the pointer. There is
no need to have such cache.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 18 ++++++++++++++++++
 fs/btrfs/hmzoned.h |  5 +++++
 fs/btrfs/super.c   | 10 ++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index b74581133a72..1c015ed050fc 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -253,3 +253,21 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
 out:
 	return ret;
 }
+
+int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
+{
+	if (!btrfs_fs_incompat(info, HMZONED))
+		return 0;
+
+	/*
+	 * SPACE CACHE writing is not CoWed. Disable that to avoid
+	 * write errors in sequential zones.
+	 */
+	if (btrfs_test_opt(info, SPACE_CACHE)) {
+		btrfs_err(info,
+		  "cannot enable disk space caching with HMZONED mode");
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 8e17f64ff986..d9ebe11afdf5 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -29,6 +29,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
+int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -48,6 +49,10 @@ static inline int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
 	btrfs_err(fs_info, "Zoned block devices support is not enabled");
 	return -EOPNOTSUPP;
 }
+static inline int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 616f5abec267..d411574298f4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -442,8 +442,12 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	cache_gen = btrfs_super_cache_generation(info->super_copy);
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (cache_gen)
-		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	else if (cache_gen) {
+		if (btrfs_fs_incompat(info, HMZONED))
+			WARN_ON(1);
+		else
+			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
+	}
 
 	/*
 	 * Even the options are empty, we still need to do extra check
@@ -879,6 +883,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		ret = -EINVAL;
 
 	}
+	if (!ret)
+		ret = btrfs_check_mountopts_hmzoned(info);
 	if (!ret && btrfs_test_opt(info, SPACE_CACHE))
 		btrfs_info(info, "disk space caching is enabled");
 	if (!ret && btrfs_test_opt(info, FREE_SPACE_TREE))
-- 
2.24.0

