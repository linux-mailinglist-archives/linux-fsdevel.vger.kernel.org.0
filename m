Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D852411DCD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfLMEKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:10:51 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11856 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbfLMEKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210250; x=1607746250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HWodf9i+Q9JHuGM6H1pHriq9UD+L1er9YnSArjPPIF4=;
  b=Y3fhT8w+e49yb0Dr6OIbLshX8EI4zxfBfVhhvcThOcbb0jzRGRUh2svG
   hDTW/54/x1KJt1ZcoMgqPEOe3O6NDDs7HRqDemJns2xOuBmHxLaSuMQsa
   sT1Tqjy+aDtiimYFx4NRRp8a4gQ8t2Ks0NGENMFdSkRLO/G4QFYtn6pn0
   knap+vX6sArH+bLEHsBBow4o3Tn5wIaPaehOKYOuXePrfp2YDKoKhxsM0
   eiUAI/H0ZFVpAn8AeHhwaJbAvnGFQmmUhwjIMgedE/elndVS8IPZpj+NN
   63/7SfFzZRGTA6DFR5FaGnFeH2kwOOcI55FVOyMBz8OObtcyXADccoJKA
   Q==;
IronPort-SDR: gb7Tr4kVG5m8dM7202D2dodv5lGaBNPUzJhpVOFpayGTuNwxl+Gyp8lYFSVZgRVxIPAU9O4q4l
 x/8xzDuUtDT8vxgf1GFTVzInrXVeE0PXVvcgD66E3Xn+SsNrG5hm6km4yvQ35Lv8JrjVAk+xWD
 w3dC6FSAUNwhalgKCoj/D8g1Ya2pEX9OWDBfNmio2uc4WgEM2qHbR2XwAHR9l/IYpjRfbwGT0n
 CRYZircijlKK7qOVqlxFIV/mbzIVfDgyeuDi3/Jb/MjZKfkSsnO716WZ20MT88fTW5om+95Q5/
 iaA=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860111"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:10:50 +0800
IronPort-SDR: eLHA/R2vOu7LyJawsjyZa23zBhtBbEgInGaGUUNnHVPpGL4MSqRCREUkVMg2dlh+IS975YnBMk
 Cuj7EsmIJ/u3276bmKG8WVqVdqn3Ev8wqLJZmu26OAzc1CVwBH+7GFxt+HKprOu0lR0Kgw3IqD
 pRBx3mcxv0iv5U5nQXIY0QNChqj7bE4XA3FsJukHZg4oODzmVKNr1BaZbnX2OgjO3cKmuF7nde
 CnDagiOGbFr6k1KjRTkD6fnqzjk4P1lejP7dNZXCPx0+bYMxrHmR+Fbcrz3o2Qah4mNxDlHdZL
 NWPwHrR+obd0KZM4MTCJM4jw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:22 -0800
IronPort-SDR: iIuoN5WmZ5K7C7SIDgoFn1/BwPfKMd8ILEd+zvMYYEoNt2nru7B9LFCeQqBbJ10bYdqX5v+lQl
 zPNy7KXzj4BzqZBt7ZiyY72I2iQkjluyiMdgTRuoXMAhcXYDnXl0r4UmzneS8GoD6RMn/EnT1f
 w3Lp/BCKzXbBy9SEVMJtKmEg56wbyaraNVQBSCGuDQpqk5C5w27QdWR5zolbifM7Py2qHMrnR9
 ohQy2z4xhoyavfBi5IHU3uyD/R3K1pyNB0vklTGXwyaRX/lkkkPGGV7YKZCv7BS2G7ckMzvx3Q
 Bj4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:10:48 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 06/28] btrfs: disallow NODATACOW in HMZONED mode
Date:   Fri, 13 Dec 2019 13:08:53 +0900
Message-Id: <20191213040915.3502922-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NODATACOW implies overwriting the file data on a device, which is
impossible in sequential required zones. Disable NODATACOW globally with
mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 6 ++++++
 fs/btrfs/ioctl.c   | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index d62f11652973..21b8737dd289 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -266,5 +266,11 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
 		return -EOPNOTSUPP;
 	}
 
+	if (btrfs_test_opt(info, NODATACOW)) {
+		btrfs_err(info,
+		  "cannot enable nodatacow with HMZONED mode");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a1ee0b775e65..a67421eb8bd5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -94,6 +94,9 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
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
2.24.0

