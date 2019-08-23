Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 192AA9ACA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404179AbfHWKLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:19 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47768 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfHWKLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555078; x=1598091078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4gCxc5DIg70UY+tbNqleaiUt+WjvhXHfvAnkm9bxdLg=;
  b=m/9kKJ9WT9lv8gaYhZdaDC+rh4bF/FF0Xp+KyKu0r+/1GwvBjJqjYVSA
   IaxdJUFLDgDAxSN4A+FUe+TiKFlhe25LWIvgUMM3jla0oXs8TUZQg6q+j
   pMUihZP8kACLLviwU0SDrUOqtccFxTD6yg5+gfBb8YLd/FSQivUrVlKu7
   4B09uvZNVHAw9eQWichlsUjsz99JSx6rHhWuYRFZQ82b9UrxriqKNva2k
   h3JGvvIbeuviV6wTgPprl3/m5YYF1qKP2DhhK3iXUegImTxjAkvNKpDKU
   S8kiHZnIL9OCL+5M17X3heleuN/8qGcZKhS3ZhWq0jsZkD4nLhM/lZQU4
   A==;
IronPort-SDR: XnI+L8ZXDtVmtdeozyKEw/rEV/8Jz4nPpuxKuziou2Vzhs4FP0XKgvJb+1dJMJbXVxHx9aInq5
 6Xe9sMiUPuOc2VbBO99tjxHVvb8AkiXH4jcCyznfhaJKh1MLa/em4DzSPiAeR0LC/UAdOznEMb
 uSReSPgeaFUReGckRZJKdPfcAPzqerwdVtH18ntoSAUWIZjjhRCSFSu75mNXKdRWnGfD4LjeOy
 +AtTMHALHkqxiSzW3WOGb1EXM7a8A2fHADyiPq5HP+xeKj8Wf4amrmggk1nFagPki1+kH+YSYK
 88Q=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096235"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:18 +0800
IronPort-SDR: 7SR+ZERmZ90f65yXHRC8NbXYNnBo+VxOTQ4UztCmzOZlpuEN+P9+xEs2IWGiUn1mW1Q5G3a4KJ
 yXARMxiJpo/qXGxMZgzhOmBfG6/TcDZksOj0KzQBltqW45paHASLhBDVDxmo0FXIcQVzjTgMCo
 +e1UXTcW9vKBs1+6tjsiOMF33U/K7Fa8heHeJ8KN9InXSk0wzSllX+MURLD/00zoWtex58zIME
 6PkI3vnO09h2xwUHELJL+oaAbmiiVWR6rkv0Sz2fVgaF0nCYEkNBvb7f2vHf306H5zC4VRBWOO
 75XtW/UxKvp5M2d9xtRhzNXb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:36 -0700
IronPort-SDR: YH/N4wuDz3ZNlCSTMLlfpf9YD8Igbzjbb7p0F3cbE/FXzY4kP1bacMfULJHq8FrXhSm73ngoip
 Zlk6DaOA9Ye+5vP9DQSClBQw4T9EPqWAvKNmo+u1PNoiCWQ3d2cFKKZYDHalPrboMb/E6+hmxe
 i6Mx43Zid1qCXB2UL/TV4vyQAnKj1fz7DAnqI6aX6tIUfdwzOBd8KDeNFLweQ0a/SCIrVZZeqW
 YMXrADx4QhJv6obQFdcvtr2OrpPzQWGmzYg7ImISqLEkodvuK4rEsZ3NtRMiQRJUqGD8yBE6WQ
 /uA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:16 -0700
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
Subject: [PATCH v4 04/27] btrfs: disallow RAID5/6 in HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:13 +0900
Message-Id: <20190823101036.796932-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Supporting the RAID5/6 profile in HMZONED mode is not trivial. For example,
non-full stripe writes will cause overwriting parity blocks. When we do a
non-full stripe write, it writes to the parity block with the data at that
moment. Then, another write to the stripes will try to overwrite the parity
block with new parity value. However, sequential zones do not allow such
parity overwriting.

Furthermore, using RAID5/6 on SMR drives, which usually have a huge
capacity, incur large overhead of rebuild. Such overhead can lead to higher
to higher volume failure rate (e.g. additional drive failure during
rebuild) because of the increased rebuild time.

Thus, let's disable RAID5/6 profile in HMZONED mode for now.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index ca58eee08a70..84b7b561840d 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -219,6 +219,13 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	/* RAID56 is not allowed */
+	if (btrfs_fs_incompat(fs_info, RAID56)) {
+		btrfs_err(fs_info, "HMZONED mode does not support RAID56");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",
 		   fs_info->zone_size);
 out:
-- 
2.23.0

