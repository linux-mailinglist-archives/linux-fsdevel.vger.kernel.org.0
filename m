Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5FB3112458
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfLDITc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:32 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32750 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDITa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447571; x=1606983571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PbWaR4sjrNTc1oHZ4k8YsfgtzKO5GNAOEB8mw/dXAwI=;
  b=Degszd2Bkp4BZ6O7Qox8rOgkwUgr7qQYLNZh5AE+fBhCYDW+V0TWmy2y
   +P9xIt3+ZBV0FPePEalnshheEUdY6mTA5q6Z9cmt5jPKMfr/HScPwkya0
   hcLBGJsNV2QAn3KFas2Ue0BH1CX2BJe7gNMU/n4NgN2T0XQmFlGIzzXfw
   KJoS31kkuNZfM1Z3niV+xkrbCcS0Ttk0JoSxXHotKdSkCr60GSGR53bfU
   nfRggRFksdK25Yn24WtUgsIMhIMjx9rv0H25y11El7ugc+G64Iq7hB0bw
   09RWLF4eQ83nVn3kyJsY0duJvCshaF4//uIbYGVG4SWV6U1MIb1iYAXQS
   A==;
IronPort-SDR: eLxry8xYfrlujwJVpMtZkYA5SwYmxXHyONdEIumYMhECXiB2QmgVeR6pgAYJPbR/eTpZzdMhjA
 29SAO+YPUvTwsumd3SVd5rtRute7LU6y7dMMuMoJ1ltwlFQNAR3RWx8yenyTt0hSHxzssGS+OM
 47eSzYtIsDWJ2ybTZZVffk3oGivAvnHVUVglykmyyeKphbQiUQc2S0Xi7C5bkhG+REEwXWOtcR
 aQUiWG0o5DC7ykuyiZVBH1oFz0XJo3ijSaDZL3y6vaOrCrIQu5yejGWW8Kz6qM+qbojLp6Kkbh
 NFw=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355028"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:30 +0800
IronPort-SDR: jn7aLJwloHOBsfB23eOvu1++hf7emf9T1IAY6wnK40oGtlzhUs7YaO0Mvho/+jXD7tvayIpcDj
 N4ThqIW2ocJCDVaPpcagTuo/K2/uZVUKaIs6o5FFMZ4S5H+VISGPSNbHVpZn2kJvHquyF3zAei
 LhMtF9LuKl+nQNNbiGOCvBTPKuQHnEgB7mohs7HhaDJbN0MjwozuhLIxRZJsQHwrgn8AyccK+K
 vd10dzll0n4y+NQ9OnrDAsaADf3WnOl/W+q8Ivqxt7Vlu0CNDDo0qMl2m9FkxzfrRbNKMWqwl3
 jhp3IicvXCfgWNZKmOoiFu4Q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:13:55 -0800
IronPort-SDR: UmW8DpnUa4qNLOBDv8n/rvJJqLcpdTYH+fe0E8wrZbXQY0ALCe6gxNA7+uSPEmxrsNL74fNpkF
 ezMzTK6FZgpHrnD+5EtIjlr9HjMWtAFeRBiiCXkF37aQ4XjivBNwsIrMaStXCo4MzIEsKJhCuc
 V6wc2G88ZOgzi6fHL/EzoKBFvmKule9As/TPDvbhACPvBP0KP7mfF11FC89xh0QqGtpk/3zISd
 eJTj4hMjTll+cMJa46RR94uP/eKI53U//zz2wQW/uQUMzV4o6jVeUzirAeO3dtGtosMAajfFcA
 bWo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:28 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 04/28] btrfs: disallow RAID5/6 in HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:11 +0900
Message-Id: <20191204081735.852438-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 9a04240910f6..b74581133a72 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -241,6 +241,13 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
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
2.24.0

