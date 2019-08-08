Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30A085E56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbfHHJbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59650 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732163AbfHHJbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256684; x=1596792684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5J1GW4kx+20xPsSwku37opj8v1sPkJx3qocgeUce9oE=;
  b=RYPBx6j7lOIfFWNz7Sa9ZKSWuCarr9DNWyd+XD+cx0dwylV+UjqGotEM
   b63umS6O57C+25rDBpKvt18z/d4VbWJCy3HYabUxGX2sW5n5PuD5NVimP
   JiBsdanX18cm2lAzog8z6PsyiN+KidKfJ9KG72da8pFhxDOBnIw9USfpe
   n0BK6PXfJg6xEDAtVFulNqaAK0Sryw8wFPO+so6+HNplBAwIZeDnlhXYB
   9Nl47U+2O0QV/nhUL6tW4ImjWOtSofGoQ5ERaa/fTveI1koClq66GiUIT
   50SliEm/00WJpo1dmV0pPIJKbciu6wnIwfxXiwQAo/VqMHu9Of79R/Y+D
   A==;
IronPort-SDR: xXRa2LIMAiz8AD1osZkAT2kuv334/AQ5wmAaA7qGbb2v9mPbcqY6g1QYdPg7XpDkDuaBVaeZHH
 AY/BxHHPleZh9BKitYVM1NzFJoFpomQAMJYoCX0OqvccRFrnHYoKtK7WyW2uEVOsp3iuEYRhSJ
 nwV5XT/z6gFLiOFEl3E2oh8dmySJwF7frmEbZodnFRAxUVcQ8Qs7uetYlXoUr19z2Qn+Q4uk1M
 6k4BOHdGDPElLdhuP889y1nphPr5NBm1hdMjcwkPQPyCOsgTCJoaS6AC1kO4WTy4pW7hxcrBPY
 oCQ=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363330"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:24 +0800
IronPort-SDR: T88MzdyPpUmcuOfp4qnqyRZAo6PN3UoHvNxPxVaHtWN2VeAmm7GqgGHKABmVI2uNv3N9DY5Dme
 L1Tvhj4qYimbPI9qaZthsDgs2uodrUBv/ju8X8ChSxz4btoyCwiTlFNEHuOReEZjftESYDD3q0
 WV338KpqqH2FtKp7dXCx7sB46XpgSFMGlIbAEBOzhBPDfJUFvCSt9lXj1X0iAMbIt6mQf4bLhc
 qaRQGvLPAPFXZVRv9tmFYbCPpmPBv2uYe7Uq3kLcNHfqX1PyAOWm4IRvO4fdTcsBw263tBAUuQ
 jePoavRIuAIzdLOZLYJebcNZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:08 -0700
IronPort-SDR: 8NgDJN/dZvem/XqMVj+sISf6Ya/j2S7n23aT8h1E/SxVcxH52fRqMQ3ooviyl47CUifJxw/jqu
 Aoiimh5MFArvXLAJQNpAXnUn3SJtEQiSf3kS0C5eVWYiobtLYsc1l8giIbXuvo+/G42cQUKE2b
 noSZew6AkUqKGumq+0s+9etOz/M3ksOQjSNGNfEaCw1TSAXI0GjrAIw1ne9DF6DcvoFCcjNec6
 O9lSg3GJ/TEBH7BpKisTrq7eWB9lgUrc4SKtM8i8wUJyrdCknsrv5oU5ddsO+k8N3f6HxVF6/T
 TPY=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:23 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 06/27] btrfs: disallow NODATACOW in HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:17 +0900
Message-Id: <20190808093038.4163421-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
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
index 99a03ab3b5de..0770b1f58bd9 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -250,5 +250,11 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
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
2.22.0

