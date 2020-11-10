Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE52AD4F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgKJL2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:39 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11959 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbgKJL2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007698; x=1636543698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=szoiIRf5AkbzT+2ZmJTgqCaLd0pybpHzchAtHCKhcaU=;
  b=ltGd9qa0GxmKeHNYQXeOQBsbDqpSEc7jr3o1WcvVtdTNw008nvvABO1d
   L2Q2xgbfJrxnn/LQcUdqMeALUmI83DJyDswjFSvlrm7BAWEhOwo4gJcV3
   YfSiFk7UN8nE2ku/I2I5htF2voOUGuoroLRNElFAWgc4WuRbj0syHNJI0
   42opoF5ULinnxhbd92MVs5J4EDwBnSUdZuHmDyXTY60CzT9ei0JX8JER+
   XlnmNFx4xa+YuTBNT24gRuk48LejTD5LnWjaOMROGtMtesQ/hqyaeNdfv
   /X5IXqTgHGcEP8WyrqSD3nyttZy8aXRzHKxmjKTsQWBaGGuK8iW/2Bjkv
   Q==;
IronPort-SDR: OosxW4e9PilAIhUn4fxfLdn9m1EgSmFAsGmaCMTBQCc9lo4JTyQwj0QtG2iyHS1G5bjuEXbgjB
 YtpgQ/tNg5wkWPyV2FPhMaD3FYRziNrhDPRb6bpuW9wYQlSq9XKWj7VyN5yqPg3xdVe6THKlx0
 mCU57K+Q2htW2GFxp0/DHkbNUXMyS3IJfld4H59YMvJUG9W/uxIcS1CgqEAgM82THvxBpx83Gl
 /EoiVdcyurorA1kW74Sw7y2tlKQ76lPmQY6lVYxB/oPBQX9m14gSzbcS0uz+fCijK16wBHu5ZY
 sMs=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376426"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:18 +0800
IronPort-SDR: 8RHSm/rj00zHnxhVneHVnbmsa9Jzed/Zn0kwMFS8NfNhC1RXJq3v0QJdKD48Ckh4GX9zAXZmpD
 hrylgeplBk5rKk1w60ZUBJQ4aZoMHF6GKmIQlDBYUpKHXNMuwGAiu0YTV/VahQespZXvU6qADN
 2Ns/qWUd8DpJ4N/FxokCwjAZeYGm6BxzKNvZaS0RAEENFtJNLPtPZMgyJ08JsYYFVMn/lpOo7s
 l37bGuo+OYDFXsl4mrpfRQ9EvqR1JdcIIdE+PaBBBn2xqWg6m+/dOoLstWkI3HgReil6PdVeEL
 e8/qpHXnMbbVaEvYS12Ktlvp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:19 -0800
IronPort-SDR: rysyaEfiyX7o090rjXn/yy5arl0m6HjAiczBOnPnunANhoiNOv3NB6CUMaGlkIgwQVoX1YlhAa
 6NRZ92Td2jlhR+i/FgXRJQGP1cStYhWJ1N2cchAYlK6R3tsC9I/iHzQ0ilklVkw6tbA2uxV/w/
 95X7NgcEP7DEJEwxld7qWZZkJtXZc530cvEYOeSPd2zrw3RFIRPM5Ilx08XQmE4p5y/ii2L1wE
 mmksp5SdvmHf85Aq+DxYs7yIeLmemZvy5l3+VfN+XOwWnJ7XLH2MfUHhGhLn7ScfiLAt1xeov/
 CvA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:17 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v10 08/41] btrfs: disallow NODATACOW in ZONED mode
Date:   Tue, 10 Nov 2020 20:26:11 +0900
Message-Id: <a7debcd84dafac8b0d0f67da6b4e410ea346bffb.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NODATACOW implies overwriting the file data on a device, which is
impossible in sequential required zones. Disable NODATACOW globally with
mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ioctl.c | 13 +++++++++++++
 fs/btrfs/zoned.c |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ab408a23ba32..d13b522e7bb2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -193,6 +193,15 @@ static int check_fsflags(unsigned int old_flags, unsigned int flags)
 	return 0;
 }
 
+static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
+				    unsigned int flags)
+{
+	if (btrfs_is_zoned(fs_info) && (flags & FS_NOCOW_FL))
+		return -EPERM;
+
+	return 0;
+}
+
 static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
@@ -230,6 +239,10 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	if (ret)
 		goto out_unlock;
 
+	ret = check_fsflags_compatible(fs_info, fsflags);
+	if (ret)
+		goto out_unlock;
+
 	binode_flags = binode->flags;
 	if (fsflags & FS_SYNC_FL)
 		binode_flags |= BTRFS_INODE_SYNC;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d6b8165e2c91..bd153932606e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -290,5 +290,10 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 		return -EINVAL;
 	}
 
+	if (btrfs_test_opt(info, NODATACOW)) {
+		btrfs_err(info, "zoned: NODATACOW not supported");
+		return -EINVAL;
+	}
+
 	return 0;
 }
-- 
2.27.0

