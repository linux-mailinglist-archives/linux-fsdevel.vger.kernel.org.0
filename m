Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13662A06DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgJ3Nwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21982 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgJ3Nwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065951; x=1635601951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uaSV3YtpzAhOAnLQn61gpLWM4TCZLYKZQdx2GDB4tHg=;
  b=pMTcef9sTst4aRdxIGtLgrV4pNc+bP9Yzw8i2t1qV2KDIAywQPSxAuC2
   toWq72ms4hP5r5aCw2gu69HUbIvZ+0+cj5JoP6iagfQOoHpaZUbfbSlX5
   J9gbeIXOHiHuvr7TPLahtFXeCFJjWbboTKjisCCvkm5IWoABeEoeGNNzF
   SgS1/bBeoosLChRWWYb9+ik4rEiGzQCW4HeLPk4UvMIXUzdSVS7PPgwIt
   k4aNtJEEeTZJO2bRVIGEZuUiHvyX17Kx4skfNpNzzDMAi1jTWZZgdybei
   bUGH+XcuukMfLYi61Hn9uAleczUtbw42esW60SrsNiYF2WXed2uXkp8n4
   w==;
IronPort-SDR: Okrxw6vkZ4ggt+UgXHNY1xFcEregljOuM6yhW0JDDJdvwPbOCSkXGwYx8ac1yzrvAUqFeYYhZA
 tNxwkeEQctJiTLyNaQMxSoCTtYsDGTpJ7l/Jo2qJ2HECfbGvjIzVy42KYlRAUM3iXJgExZGI/r
 QmlPO/LecSBsuJ1g7bcWEJB6RGq9QtvAPWYit/Lz1Dn7PskMCgyZ4vhtxClca5qfo4OGNyLujS
 Js2qec7TVT4kOX30eHSFi/G3wcMosb5WJ48Itf+i0OCA7w3Rfk2P/NmmHFFFc3q/qjBWZfGRfj
 +VI=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806588"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:31 +0800
IronPort-SDR: dCMzNitI6SnFH7EIkwsR+yTVu3at03M2Pk3RP7r/95NCI2NSdiBqghILyIrxEqSHZLPNpxT+VX
 oapdHF+acMmGQ5CmetG8Nd/fEIPSo5KtdgtpzwvTi/tB+razghNcAZ5lHkKc7aCvRzNUZTVSR1
 +kSCB6K6LZl+1F1T4E+e3iGxDE8Ujcv5daA2KZ4YO4y1E22d8noZubOrCa01p7JOveq5Ac4zJ9
 JonBkB0MVwhCc5PoTVFfO6N3jwyu3PghBQg0UgLYA3F2uzft1XF5O80P4zHiomhesQMOp54s+d
 yDHK0tCQK+qmQNzDRC3RWSsz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:45 -0700
IronPort-SDR: hL+PYsl9JeeuuGJad61KqQBo6YChaogmPBLO5L101UKeDljx0JhC3m3TwxWqZFR38TlWDSIS1r
 BPODA7/TOky4atYnb0mrzYWTCZX1eL8Piqn3PfHYPA53yxUy23mxgCo6qYYOKBhfKrEBfNcE9/
 AeXrBTNOCoaivrOkYjFuPTD2uGDjcW1LplLYs3k6B2gNlzH/yczgAL5Hn+rEwqV3pGgAlVycRV
 XgxEC7wTfTt9z5R06ir4mQS8Fmz1maHNLGRCmssqziqWd4Oa0ajCAX170NX6INAhoj9vtf+5ER
 t34=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:30 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v9 08/41] btrfs: disallow NODATACOW in ZONED mode
Date:   Fri, 30 Oct 2020 22:51:15 +0900
Message-Id: <4129ba21e887cff5dc707b34920fb825ca1c61a4.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NODATACOW implies overwriting the file data on a device, which is
impossible in sequential required zones. Disable NODATACOW globally with
mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ioctl.c | 16 ++++++++++++++++
 fs/btrfs/zoned.c |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ab408a23ba32..e1036a9ce881 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -193,6 +193,18 @@ static int check_fsflags(unsigned int old_flags, unsigned int flags)
 	return 0;
 }
 
+static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
+				    unsigned int flags)
+{
+	bool zoned = btrfs_is_zoned(fs_info);
+
+	if (zoned && (flags & FS_NOCOW_FL))
+		return -EPERM;
+
+	return 0;
+}
+
+
 static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
@@ -230,6 +242,10 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
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
index 3885fa327049..1939b3ee6c10 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -281,5 +281,11 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 		return -EOPNOTSUPP;
 	}
 
+	if (btrfs_test_opt(info, NODATACOW)) {
+		btrfs_err(info,
+		  "cannot enable nodatacow with ZONED mode");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
-- 
2.27.0

