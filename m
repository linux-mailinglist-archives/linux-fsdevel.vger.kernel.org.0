Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B82811DCD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbfLMEKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:10:48 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11856 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfLMEKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210246; x=1607746246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nRaA3JRYzcP6k4TuIo2+r6HiEqDsmoiNiX7kFHYjflM=;
  b=nzq6I9ePgZIQpx07M/eAACSO7Ftn/VpTfxRbnYUF3FfziaVPNv4QJYVn
   f+VnwUSL6Oq9nd5iEpbhtRrOqGxBCMYuSweOpn+ALRwipgskM5Hr0bsfC
   BBNcjbc/3eT1rKhwF6hQ/iVoWT0eZ9w/3RUtKqh28odINhSGYAjmYp2yG
   VVBnXjugqJSwTJYiG0lV8q8gEKa278VRu4JBwymLgD4W7lMQCqOJgC8KK
   PlRaY3QH5jQoR76CB7xS6lDsFMwj7wm9P/ZfuWCyrV3bPvf6XN+MMl5Cw
   FiHSwObjnVZK2JkX4mEgtQkDG6YFCqE0Im2vWJDRLIvm7V13jVs8gkFuq
   A==;
IronPort-SDR: UHsSSmVe467NpPPvy5vY/9VIlOgEHmwIZGy+/h10+bPyafHrjXWEryVf+D5EAVRIWlDmNV+nVU
 oyYArR0/Maki13gpd5uTCkzgUOazePkSPzA+me2MES5/D92KfVMqQJCsdL3SpXd/zFIlqZ3grB
 0mvM847u5qQWMthndGXSEa8A8CPtcRoCmfi4bQLSwUVFxh8/wUQobG/5WUPUnCKhJIhmZma3vH
 sroAY2xOToZ+wYWg9UAHQ3yZP0cioyD5VdC/B/4tRdY6sVuS7BwwtHGCzSoeKWezaLvfhMbJLZ
 TVM=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860105"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:10:46 +0800
IronPort-SDR: xNi0y9EisKfpA2mi+kfhd32uLWHjtAfL5E0P0MYA971+WdBPgnbSYi876R4aa57GWvtZmdyfX1
 NNgNWlSb2PcX4npfvk6sJ5gqIztETFABauh5M2m5mTxGcmhw1FHi1LP+l+eUCxRF0LOzroO7Rj
 5jGQ3v0CYy8JTDzj+0BZajMoRYWK56E3jSyuTbI8vxsCYhxPCV2wRMDe7uN+UMaObmcZoBUuWL
 JvvNl7OlLHG90hPn6nlpYrAgBVr17OKThnUHzJhGGNg7+HdILNglh3ukUfcSiErlEFIH7ztBX2
 DA1ZopbFlaWkzGVyK1L7i7Dx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:17 -0800
IronPort-SDR: r+5NYvY5cw/V/r0PJqKMkexmk3ysWt2anI4Ehrh3A5/Q0sAHusfBIAMXprbsH4iwocL8/gn+Qq
 CUD+67IBM1lTe4VUjwdk11naKe1RD952YS+bKbk1Rp6K5odac4MrXKt3cCACc+i5W2FM2+Bzaz
 gKjUa1xvMy1r/HzyAGRDW1/yJJfnMq+NP1wehlc/+2vFgGbhBaTFEUNLzvHg5QZ9HUPA6TUmB1
 8TS8b48ZWudu5l8j8AsNp7MFFpVce/9N4qo84CxnUSmZiP4PmxJb73IVVVSd5DlChQQfLhAkCV
 7CA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:10:44 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 04/28] btrfs: disallow RAID5/6 in HMZONED mode
Date:   Fri, 13 Dec 2019 13:08:51 +0900
Message-Id: <20191213040915.3502922-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
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
index 0182bfb9c903..1b24facd46b8 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -236,6 +236,13 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	/* RAID56 is not allowed */
+	if (btrfs_fs_incompat(fs_info, RAID56)) {
+		btrfs_err(fs_info, "HMZONED mode does not support RAID56");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	fs_info->zone_size = zone_size;
 
 	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",
-- 
2.24.0

