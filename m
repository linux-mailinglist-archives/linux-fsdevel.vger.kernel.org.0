Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86541124C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLDI1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:34 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfLDI1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448073; x=1606984073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hn8rXOZX1OA2+3TWZvhoWhKBiZE4/a1ND96omx9fCo4=;
  b=OqJ/beRH2GUUOXoK0nCiFzSza1XQLJDSmbCROuqbamq2bFvXiOhVkHVe
   JpFc1hiZliYPV5tjAoKEo9RrFsJn8jZeONDEk47pbFy0EqYJBjvKvEyp4
   eZNrdVZYyBxwobErBjEzazP36fQYV3UqmeJm+KhWRS0+fzfpbBAVRDpij
   kzR0+CKUTugl9lWoKI6YHfFSfEFqU4j5FHeKQLxyT+cRfmnilUZMKuEpL
   q7SdsEQKTfpeX+9FiepxVFaoFPR+b4jcqgpJa9oI9hkfOncLnsPVCytis
   j5rR1/buDmp9QacDjdDnD9sqn8pxRT7+wESz9mckKWht3RJ5oTWITj0Sj
   w==;
IronPort-SDR: F3jT1aipMiawpLNvtIqj8LS+aO4Hzrj71aHwGAGkvILDO0wpIvG4HP+zPLdCw8mrHi1htEGIJ1
 CNU98JdF0ydQakt1Ngr97oV/2u5lFAMIzTDnMYxbAuOP3+obFLD4eDy/zbJmtcnOhs7P0ArYkx
 3RDAJT2vY4QMTe4N+vob4f+5Y37PFwQfiOwl/l6TbHrViAqetx0fofydNvi5IFddhA2XXm/5q3
 OH5i2k818NC6RIhxCreGiABzGApAjZ/7zZzFVNqyBevd6IRcj/rfcobkLPbPAP3RrpnFNwOUdl
 ubE=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031729"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:27:52 +0800
IronPort-SDR: miXKoQvodiPDbxEoQXl1vI87/WPOgGhrVqcRm813M4rNwKoiK9G/s6k+n8okVO7MclKSXnZU24
 e+dLo76CN+8zoVjbPsJlCfApjkrB5vwqvKu8ssLKr5sZOVyHkVzaNuerfUeXheMU5PTSbbcrIh
 LjIeFStv2zysVzypC1/Dg9J28tT+B2GAxop54GDKC8jDCZISJlVBvlrFLWYnOtAX88pbjeUp9D
 NjTbNpWmXHg+2xJstWmw4irVWTrihRI6HcIz4wS9PLRB6XtBabHNffXFyTwQ8jIwhIqMwB6gxH
 /vgz87ocMxnknJf5+RG4jP9Y
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:20 -0800
IronPort-SDR: 6ieqC4pkVOYlOL0vdg6DXwi3m6rbjSBWcjNFoGq1NeNmKh+OupyUrIi387bLnfpIehr5af6Uhb
 Orb4SyOm/y9mGVmUubxC6Jp74Ql9YJTavus8v2dquVYoMBoOq8cU5iIBX3trl1Kc7Ipws8+7f2
 yMRRvFHGKxdf/ThFVmWCN1aSGrQ/Bq8hmgqcAxXy9wU/sBUPgXyMcY3LdJCoIKYAGqfOayzlWX
 peFsL8a2lOu71JRUvho5g3GcTSjjKLBmfmbiC/bhuqsCunI7/bK8qzuos4UmAzItqL8Mc4LItr
 GHE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:31 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 02/15] btrfs-progs: introduce raid parameters variables
Date:   Wed,  4 Dec 2019 17:25:00 +0900
Message-Id: <20191204082513.857320-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Userland btrfs_alloc_chunk() and its kernel side counterpart
__btrfs_alloc_chunk() is so diverged that it's difficult to use the kernel
code as is.

This commit introduces some RAID parameter variables and read them from
btrfs_raid_array as the same as in kernel land.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 volumes.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/volumes.c b/volumes.c
index 143164f02ac0..8bfffa5586eb 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1014,6 +1014,18 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int max_stripes = 0;
 	int min_stripes = 1;
 	int sub_stripes = 1;
+	int dev_stripes __attribute__((unused));
+				/* stripes per dev */
+	int devs_max;		/* max devs to use */
+	int devs_min __attribute__((unused));
+				/* min devs needed */
+	int devs_increment __attribute__((unused));
+				/* ndevs has to be a multiple of this */
+	int ncopies __attribute__((unused));
+				/* how many copies to data has */
+	int nparity __attribute__((unused));
+				/* number of stripes worth of bytes to
+				   store parity information */
 	int looped = 0;
 	int ret;
 	int index;
@@ -1025,6 +1037,18 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
+	index = btrfs_bg_flags_to_raid_index(type);
+
+	sub_stripes = btrfs_raid_array[index].sub_stripes;
+	dev_stripes = btrfs_raid_array[index].dev_stripes;
+	devs_max = btrfs_raid_array[index].devs_max;
+	if (!devs_max)
+		devs_max = BTRFS_MAX_DEVS(info);
+	devs_min = btrfs_raid_array[index].devs_min;
+	devs_increment = btrfs_raid_array[index].devs_increment;
+	ncopies = btrfs_raid_array[index].ncopies;
+	nparity = btrfs_raid_array[index].nparity;
+
 	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
 			calc_size = SZ_8M;
@@ -1085,7 +1109,6 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (num_stripes < 4)
 			return -ENOSPC;
 		num_stripes &= ~(u32)1;
-		sub_stripes = 2;
 		min_stripes = 4;
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID5)) {
-- 
2.24.0

