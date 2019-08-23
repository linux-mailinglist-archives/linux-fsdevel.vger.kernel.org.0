Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3AC9ACAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404224AbfHWKLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47768 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfHWKLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555082; x=1598091082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lBaKPS9JfZTL0UTIepFgeg5zZ0gxmI9ZSwd0/FUcXdc=;
  b=Aj2SfBRJ3zI+pLCKEm45bt5MD+RiyOAWfw5chODqwKifUmm6DB0Zu/I7
   +tgZyCAMcbzWc+hOhOwgAHAki+IZvV9S+v+DgiSsfXFxPi/1JP5Zrqal0
   jgZ216PtJOYFaJ9QI4Y2Um4evY9ssMcHna1Jr5YdF9TGZRq5D12a4OUZP
   kOGHrsyP4hIzqLnEooa6ALdxdw5jpmqsdzoD2Btt2tSNTNlvICCBQi8oA
   1lyJXY0ez7wbmgOYkQg7VKbW53/jm3z8XmpGyM55UL2B9NsUm0SiC2QlS
   gLQK7p7VTvL9EO0yz45Fx4sjbRNA6ObVYPhhTDdb2p0FKsH+7hTdEOqFT
   g==;
IronPort-SDR: X/g0bL/aEfGBH4IkPaWu381w1E1Hq8YPEM1/onRsc1jGuODlAR07gFSZab+qjyQ9ODX5Ku8TwY
 qu5v6F+GqjETTX855hcYGEbEaC8TiREI6jLk3hL0AQJThY6vxoC/RUsgwuxtWgcXc00eWYyJKB
 hstDh2WCrdSluof0RYRHTo8n2ZzMq7Y9D68TduUP0qa6zEqT0N1sfTHzq8fHQkbYUQI5HaCW3a
 uYhVOnL7c4Kat42kC4o/ecDZhfMK2dRIzY/UkEsfpnjKIQPnxBer33SUvZPuYo/pvjfRDlGKl6
 WaM=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096238"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:22 +0800
IronPort-SDR: fVzM5IIvWYBi1Vh6iGMKhycy6IxICe9gewOHrKqUiTvwPPxwDf656VFzbSK687U9e87JKMK7EW
 Cf1V2mxJ0CIC425+mA19wcIiF/Slxwr5CgwQJQZQdM4SomN0b8Bo55Aah2Audk4uPibnJdXmEe
 NM/GnnA+gCkc5YvzToY55cAMdK9fAPO7xbBpHLwDD8r70xbGSBcPLXaX3Co/0CaGt/M0BikfH9
 fQuo4pS7fBaF3y6Mw+9jhmnTCYyp3cid87RYIgMfSHReoS4awGzsf/RDKtiOBFWLVqVILfr5dz
 jvX73W6B2vUP9jJkm74Pyt9m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:40 -0700
IronPort-SDR: Ygp7DNslaZ+BBEfkbOEgVjSco8ojtZoOcRcDtwjuDDRWOm2VR+p39Ml8YBZVSBwkmKsa4d0g/1
 c2N1JKQmWjNPtcsoiQNkL5Jn04gUk+dtQxv4G41kGXuJILwK0oJKVEAYugQ4HS7p12r78hJscC
 J4VfoN2VEE7c7jS9XzVg+bFabddHPXhCGXWMwPeBHemkJocYxMMXhIzPc8W0LeoSf1tgLxa+Aw
 mfViRzqFCZtsUygRJa/JVX+SLtk5lGdVmUqSWYqKFqLOCBi++0P9Y3XOA3kHTwyBLyFcI+VGWF
 0JU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 06/27] btrfs: disallow NODATACOW in HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:15 +0900
Message-Id: <20190823101036.796932-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NODATACOW implies overwriting the file data on a device, which is
impossible in sequential required zones. Disable NODATACOW globally with
mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 6 ++++++
 fs/btrfs/ioctl.c   | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 8f0b17eba4b3..edddf52d2c5e 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -247,5 +247,11 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
 		return -EINVAL;
 	}
 
+	if (btrfs_test_opt(info, NODATACOW)) {
+		btrfs_err(info,
+		  "cannot enable nodatacow with HMZONED mode");
+		return -EINVAL;
+	}
+
 	return 0;
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d0743ec1231d..06783c489023 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -93,6 +93,9 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 static unsigned int btrfs_mask_fsflags_for_type(struct inode *inode,
 		unsigned int flags)
 {
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED))
+		flags &= ~FS_NOCOW_FL;
+
 	if (S_ISDIR(inode->i_mode))
 		return flags;
 	else if (S_ISREG(inode->i_mode))
-- 
2.23.0

