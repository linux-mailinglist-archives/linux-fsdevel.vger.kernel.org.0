Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B08B11DCCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfLMEKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:10:39 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11856 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfLMEKj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210239; x=1607746239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dI1kCb/VRDJYiFLG8VGEf67pizlAWg6fFeBbRKlx4yk=;
  b=IYEn/y2CkkUIgkhYAbDhW52vm3leDg+2qpb9ZH6DCE8l45az6Ai8kTIY
   2IIj/lmjdE0r1YbC2z2wZPLfiQJDjPDwaRvkGe6b7sw74V387FBWOL/nt
   g4pzTKiMHzCO2HBGWkw2IsziI4HJiv4QExtueIjQ5xLsi5fwekT8KIi6P
   xd1p81MW4EkIOH6luB3OeRtZLrjUrAe3aXyi350CQ2bcUm4Gq67JT7srC
   IV8x0bJ3ap9RxBXP1MTxw9tKQEVT+jwLhOODQtIcfx2sPogL08jMnlOXW
   mj/++zea3LLJPDENy0cdBW8ISL2huVC5SBKB+22JAjwG4iGu2RJJThLom
   w==;
IronPort-SDR: pS8mMw0u2YkJTty1wHZxSzbedYIXMwF1A/She3YnXnOJ0Hc2YEt2A7zP51TVyQ/RZC+l6cvp2R
 xnZl2sWLkCbEP8X4zHXcUz36rz0aXldmpPfbG6SwTmHVLXJPqYOCNcSqx5v+rk/KUTkA3UTQEW
 RD0iVcrzfqMYuQvjxDUS6WgQH582l/8rhq7hGPQsEPykV1IQtHNUP0k6YXJWDbGBTyxdb0heI4
 x9/kqUNMHhMe0JaaEjMvwFHH5jN4337Rq/EeDdzSkukyr3z//U9PgFakJo1bEtGOY4CJvoHbqI
 QQ8=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860094"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:10:39 +0800
IronPort-SDR: 3Z5U70qhxM1EzcZV9BR/bMdTuW6kqx7Wq+IrlliFfQWaVXO2RBl1/ZNY6mCnFavYsS+tRwys82
 ubstJ6L9bTrHlJkCc83d+j2AYu4+ReXh7K4loK3K6DcbhhpYESKIMNRJwIef4CpurAUDr6afED
 +Uy36aYcQ5caTQenrGWdbSy5rpG1bApGzf+aM5saX/jYkzZs7vZ1jiK8/peDrF1Jt1lcnrb4cl
 vfTvWwxgAKiB2im5H5dFlH6aF7lkUPSgahsnxs+GKcYnErM3nDXJI94MUP06oqi6RPxZEpibh+
 0RcYYLUuMNyIknVPwS5GHJXh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:10 -0800
IronPort-SDR: ZKb2+lDDbtgITKCyiG3mP/q6Hd4HfybNKpKEW4KPC7MBXoQWilZv3fmybL775LTGyuafeToiEP
 aQjgA2I01AstjQjAURr+JoQQsi9M/zxP7DFoiOxrQd7nZsVhr9obaic6QAmzI9K/UwG+Mx/WTD
 d+0yU/kl/+kg+jGXgDnTf14ZTJ00Vzo2y/7COIZtqOinEFbfGxLeF8osn2os/Jr8tGsnwI29nM
 ooGColmaCXLtL0Iy5NDbW1UnQw85hTWD4A4L9yWF1yId5babMIzK5xyERBA2NFuTKWKK7sJUfy
 yew=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:10:37 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 01/28] btrfs: introduce HMZONED feature flag
Date:   Fri, 13 Dec 2019 13:08:48 +0900
Message-Id: <20191213040915.3502922-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces the HMZONED incompat flag. The flag indicates that
the volume management will satisfy the constraints imposed by host-managed
zoned block devices.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/sysfs.c           | 2 ++
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5ebbe8a5ee76..230c7ad90e22 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -260,6 +260,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_INCOMPAT(hmzoned, HMZONED);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
@@ -275,6 +276,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
+	BTRFS_FEAT_ATTR_PTR(hmzoned),
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7a8bc8b920f5..62c22bf1f702 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -271,6 +271,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 12)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.24.0

