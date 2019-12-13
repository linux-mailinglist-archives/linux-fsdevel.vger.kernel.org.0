Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7948D11DCF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbfLMELV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:21 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11924 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731971AbfLMELV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210281; x=1607746281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wD/L2N6Pr/GUhfnWh9kOAQLWKs9x/iWk54ItmaVu6NM=;
  b=X0lOXTIQ3BG1QQoZl6ahwV9E4ZVfangqJgZNsjT6QBeD1T4M8yWU8H7i
   ZFrAff9y8cI0i9lnNBgvTyAdGo5wqqmdTf6jSAFALZO3nvxJcEBpCelHY
   UELl94qSKdBxqWYOCxrlMEtx8fjWrm3mMLPn6CingbLhxAqRPZwfjmHJZ
   jsw4JQgVKhQaGA+Ajicod3ssUiO1XBYrPY976RAF6KpiiFbymM809wQoI
   1YM54+C4Zirf1fn/LoWgawJthgKGZQK3i/bQEwq9kg/KB93Ov6l6Qijen
   Y12I2Uk4Hff98YzPsNXy6uQHTowMMs2YoC57grmqAOkt5UJdHexTl14yt
   w==;
IronPort-SDR: gAmeiG3Y+NmxZvk+/2hRYKRs6g/x+Eol6nQV5HVv/+RwdQcxfXaNlIF2gbAQk2T0zuh4x5u+6C
 mVC7PqW0AyUyqs9F5i1O7HBZFozXbpgy0rlkc5x1J5/6ZMrbo9AB6RLJifi3LCx6CNGQh4fG0Q
 V6MdSKve64i4u+SuCaDcFNtD8jWxtA3V+fxVwhmNnPTe4bNuUEGhkKITguPD0H85eMSzCmNEC/
 9SE5j9UiFA3rSgNJX1L1n3Ef6ptFV8bUztCTzJDN6jpeLUaoIRdZsqsyKxHZ1XR20UL64SC/zv
 sRs=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860151"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:21 +0800
IronPort-SDR: 39vxF6kLF76rpoMv34SNQNWRMsSdFze8XArP6vQewR5FYQ+UgXMa55w+oDrG1EynGXGudaSKIW
 YuY7P/0cWYR4Z6vSil1ajkj7VHm1J512e0J5lH7OGPR/x2dVAkcmwEdgMlqTS+7aFZD1JjyBhU
 Nks7DWPndx/n6cKSJZTerlhCvPNg4cmbV3zN237jU147nCJ0HZ16E+PjFndxZTXdE+rA8D1tRe
 xq+twOrEoHuaGstnkbKxrbcTO19mHX5iBa4DBeZuSpAtZnN1kmCcxxT8jgpjM/JwW5ODWeCs2x
 n7Sz9PedhJZmtM4KTr6d7Oxx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:52 -0800
IronPort-SDR: uMgkIIqOysCICsBrWkJRsE+573X4Ytl374/8bBbh7dS5bi7u0BnRe6kR+EQxIa0gqhIiQRTmid
 iwGi2vGZU+A6/VYVI6Ae2gNONa4Ddu632dfIxHQq/0DQhx7FjuHWsRpxPROgH0pI0VToYM9/5w
 ZXgv5gVQGzPo3kMlUG1/24ovt9gL4HgqY+F1aOnGrEt3vrY5sZ0yzeWamiJM6tMxF3WyjYT+qh
 4QaikLO6toBt+6xxbXfSmUVmomkTBICFRxbQaEdPrSeZH89EO7ufShWsU20qnmmVySLiV8FEAo
 E7o=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:19 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 19/28] btrfs: wait existing extents before truncating
Date:   Fri, 13 Dec 2019 13:09:06 +0900
Message-Id: <20191213040915.3502922-20-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
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
index 44658590c6e8..e7fc217be095 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5323,6 +5323,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
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
2.24.0

