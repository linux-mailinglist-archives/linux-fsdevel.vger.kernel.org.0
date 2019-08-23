Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB329ACC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404576AbfHWKLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404383AbfHWKLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555107; x=1598091107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4lhxbEjSXkBXDAScPSNFcUFtf8ehM0euARJ66fgeDFE=;
  b=WyBfIuqkYeOKN/mlfBPD/ZG6ARlKAmZ4E1WZvU/7bkj7cGe+C+f71Jo5
   bGZtW1cxswtF9atl/vJ6WxpbH/uUeZJI3zZD56g4a2WX6tChA8BeAR7Bg
   CFlWKTManTfXvXFYxZ5Q3A6hq0XyMOEpH5FYs2yWLnESKVDoEzRUvcUaZ
   IaDdnBzkgm+CoyUhfo6I9qP+bDwBZQ7cMa8/lAL9htybk+EZ15lgo/lFo
   +7vpkl7Hg1rEavBZCeyyDIDjw4DCGprFRQFHG8yMlA+nWHWn/q3npCalf
   38jy6n1IAKYSOyVIIVcSvKGr218GkAhlVIZcqB5/1/EQnq3Gv6DV9nwSP
   A==;
IronPort-SDR: hfVix9K9axNOACIvHwnHGh4g1JTdSqwTwdLbNlz20wdazH8Ga3wFXHBQ5BTksr3/w60Z2TRypL
 AP7oS6LDzGa+kURl6xAZ0Hp9UqGMs34W4m3BHYZg56OocAayH2NuIEQYOEMZKn19scdm+111o3
 oDuJmdThZ6iq+9ZdYCXDuVoRCTSGD/LjVucKnygYtvgXtS7UFwbZSxsRVIsG4wEtItURnxEMiN
 Y5VARGzZLxKeVYRY+AUvihjXJh04VOE0wDsosUeCp8ILb2GspeJ0XXcaem7qMIbczT6nQP7ehW
 gVA=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096263"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:47 +0800
IronPort-SDR: Zf9/TS3CAgnTm9UhfvGd3Oee7LoWaLExXc6j5m4xocV9oH7qGaovvofTByGllhpYNMSMS46Rqn
 wIIvx8B7DQT9L1zFGonTeYgcJBG9DQTELcPY1tU3TTxPoObmB6y5FxqxQN49UGmzz2Qjct61Lr
 1jQafXxBK6k2AL5c5tE2PQuv8LjWt69WDDOCskZV9yFibrZwR8vKxp+7fw15a+0wa63EilQ0gM
 JhEW2deCMBA6bOGxNabqf4p4gIMgcUFgYg7qTCDmacZD7BBKdVU8R10XL0ksxeNm2f+M5nt5rR
 gq6Wi2izj/geCC3s5/LA7Esq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:09:05 -0700
IronPort-SDR: FoR4xtdV+xPrfbPGuNf80/8NBoJN0NrU373iGoEIePdrba0goFVrV01R/weRrky7GOSuhbU8aw
 bvWN6pxGWm0FLvb37m0WjHYz8ydc5S0xyoKlzFAKwDTUmUFHKEMrJrS5RMjULSu6hbxfKax36q
 H/+wOTplB/Sf2iHpZo5k9kQ6BN0vT4RpiNNqqAAKNBs2MToXE6XOaRE/EQN/SceKKxhjVs7dtZ
 Hb4ZP8EcSKNkm/HkXJuiUOwyNd3nd+XGw9K/drcoB3Fu5+7QASEjR2fd37eajqgoJtvo0a4Dys
 odM=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:45 -0700
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
Subject: [PATCH v4 18/27] btrfs: support direct write IO in HMZONED
Date:   Fri, 23 Aug 2019 19:10:27 +0900
Message-Id: <20190823101036.796932-19-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As same as with other IO submission, we must unlock a block group for the
next allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 283ac11849b1..d7be97c6a069 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8519,6 +8519,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	struct btrfs_io_bio *io_bio;
 	bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
 	int ret = 0;
+	u64 disk_bytenr;
 
 	bio = btrfs_bio_clone(dio_bio);
 
@@ -8562,7 +8563,11 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 			dio_data->unsubmitted_oe_range_end;
 	}
 
+	disk_bytenr = dip->disk_bytenr;
 	ret = btrfs_submit_direct_hook(dip);
+	if (write)
+		btrfs_hmzoned_data_io_unlock_logical(
+			btrfs_sb(inode->i_sb), disk_bytenr);
 	if (!ret)
 		return;
 
-- 
2.23.0

