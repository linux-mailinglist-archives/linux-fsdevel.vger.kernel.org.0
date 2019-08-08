Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE785E76
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbfHHJbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732427AbfHHJbw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256711; x=1596792711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LXvW7fbiuo+RMdBcEe7muZ2DHPLietQkEmIKlsq8yds=;
  b=Ig5Q2bb3FPai1tIpj4egB1s+fq+W0rM6wwHWuy/+XK91ueuURUNGCRAM
   n0VdqQ3fLbbvMU71jEiePObRU8VFzpY5P4g7SGaBhBjekHCjS2DnLSQdF
   9I/O7H88hXl7+B8QwehuttOIzT2k2aTiJmH6JHg8hMgixcog2k7bG5Dqa
   nzbApf/3+LUFmlKsJzU56KrjCfFNf5tge29IGCc7WY6oTeUsxOIw3rOCF
   95IwRUUTjvZX3qPWicVz+YD/Iae2haJyeRsrybAPZGp9BzxHGfQeFcKVY
   0TZCb3GCxiD7kEf0LwHDvQR/qFky61h0kP+dOWqeO9hu8bAVl6iF3Z9qF
   A==;
IronPort-SDR: HUb4VPBKX2x9XeZscenAzUW6ggFPvdvbJUduxDRk3ND6liQzn+08d7gJOgZXNKOAhz22GM48RN
 adj8k3mqJN8gCHtN03ZaUZ1MnaTqWm+DUzdn2N+7uVqpnrebqQurApbqh07M6y/oocx416HcRw
 t8JuYdc3DrSuVjUynGkUpLM1nw9STWJdpHxJ/mbKwTyOjJ06AuUxoGucAgmFpXGE3YuuS4N6K2
 t0ThxNVen4to19vZdlHh9oI05RvMRVa6AIo7k1We4bpgheQCmNb8lQ1l/gIYQqdhkljfmPEi5r
 JuM=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363402"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:51 +0800
IronPort-SDR: kl7bfjdxNCpSge5A7JLkMvmyU1WrMn5r5aajvZZLCctQRhpRaiL3FL17pNOIDzZecCSEd6Doal
 xYnEPa95RTAomBgNw+EW+E4Wlqqx+M++h/YvbYSEIcq5OaV94ATPz1nv5eK47zoi663OFuPYel
 B3wTJ+ptgn935VEjEllZFVo0Q6gPUOg6bgc506bVms+07NRwJyuaJXBtSFjY+mCR/0F6nJcC4i
 zhplt5d2ubDGLtzrzBWgfeijs0EID/nmm2BNtCgygrUyRDZjOObKa0HXsVqUdHsVKYr2loqLWB
 4lVoG/WDUzVapJL2v1AhLsum
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:35 -0700
IronPort-SDR: IWv7hftPv5sUwka1c28g3x5y/uT0Lm9LQCGDkVy42iCBNXEzUDV13T4Fp7fqhtqcWYhWuabzb8
 ybsKtcO8GPazdQ6ongrjZjttxkeT5tPKj64QJxPt4T3Vu/gMKkJWhryA2SLPAaY1tP/kJOaVY+
 Algr78bCpFmYEgev7LVEHjypMC/jw/mTlgKCg1eoft1P9ytrdiViR5xlFQ/UhrHcQKXLxWVAnb
 RqHvsCQ/Q1W+N81UNX0T0+Cok+AfaBaqti8EZ1Y0XWTLzgKrItEIF3zmn+PsQVsYQ4bQbIuQKs
 Mtg=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:50 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 20/27] btrfs: wait existing extents before truncating
Date:   Thu,  8 Aug 2019 18:30:31 +0900
Message-Id: <20190808093038.4163421-21-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When truncating a file, file buffers which have already been allocated but
not yet written may be truncated.  Truncating these buffers could cause
breakage of a sequential write pattern in a block group if the truncated
blocks are for example followed by blocks allocated to another file. To
avoid this problem, always wait for write out of all unwritten buffers
before proceeding with the truncate execution.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d7be97c6a069..95f4ce8ac8d0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5236,6 +5236,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_end_write_no_snapshotting(root);
 		btrfs_end_transaction(trans);
 	} else {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+		if (btrfs_fs_incompat(fs_info, HMZONED)) {
+			ret = btrfs_wait_ordered_range(
+				inode,
+				ALIGN(newsize, fs_info->sectorsize),
+				(u64)-1);
+			if (ret)
+				return ret;
+		}
 
 		/*
 		 * We're truncating a file that used to have good data down to
-- 
2.22.0

