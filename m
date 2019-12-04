Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E24B3112479
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLDIUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:20:07 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfLDIUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447607; x=1606983607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wD/L2N6Pr/GUhfnWh9kOAQLWKs9x/iWk54ItmaVu6NM=;
  b=L/UWg0pN9/uzeL4ToLZGPzMUDttMh3wFmFoR5lp4mlw7945HaeRvQ55I
   IRViboWqGRiGvijw2ewGjpbis67Hfpeb+RGOwhmcXTQ2gX8SwtI95Oypu
   VQwKDvaEGANSGEzXVrD2ABrb8RUGN2nk8uv2Kr9khdxfPqwTkhdofYqRR
   ksdvAfErfRuR4Ixz3Fuo8RHUP+DS+B89AL2tDrtcWVxVnbWNDdhef9+xS
   1c7htEGQrQVzILloNL/i88zvNvNsEyw/7LmJPMvP/j4+kQYtMm5Yfs0Sj
   A543KbRwtpyFQRH4oWYydqt3w/WxkThPF/XzUI8P6WoXwtd7ggnrzonvJ
   Q==;
IronPort-SDR: RQeP76jJPURHoea3UXt3CLLmXDxfNyaCT1bEZZyjtNO+vOPXYPBJNU1rDK3yfv0GQv6qIjyaf0
 0ELlzkBMhnv2Jb9LjzJm8NpNtOfn/EHsw7plCBsUIf462q/UDbKhPsfcZ1bcXkLSB1Z+HFWPYA
 PC2vJAmak+Yru5lFkTT0ThdpBbB4ZzN45g80cwHqvBdz2yHBr6V4ea8/odxFiijVO5xdol6wG/
 Qd/W4oGLoHTAO4eiT41b1Jl+Th/ntW82uPiy9JIeRA2jpj89/Nf2AaGTrJDmtfbnnNWxFhy/Rb
 F2c=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355101"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:07 +0800
IronPort-SDR: 8pi8bLtELeEA0kyAuN+GsoAQNFiae+WzEpvMAy/rEHBljt2Op65Mip0cdZPr1qlZZuaA5V/CgM
 q2SyKNTGgZg4l4edlkwjvsDQT3Gp5fiMdpBfY16Uchwah0Q1gesj70IwEKUajX0N611Or9bfM/
 YM1jg9HR70VI4BsOjZAKvOzngLBwYO2RJk4F3FOQmF1kZDHcmSP5GQPW7CqpDOWWhnWOPQA9V9
 IY8kPqfVnlRssIf9YAhjhF02SODnkCj4XOO/LIP/8Awr6bodcUeHFY3B81i0gGQyCyBpnsEnOP
 GDRFgdXGS4fIYSc/uUhwQxXB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:31 -0800
IronPort-SDR: +Y4a7R0qFZnE6UyOAlpKIcCUqzBllyMi3UU2Mhcc84hCZoA3ky+WqaKXLFlTUHMYoJ6CmoFWnM
 6S+QXa6jbI4axHXoWyIYVw12be/xOPphvMkxs2VhmL6jeOaWHtUA+ry28N2/6q4s5hHZlJCodi
 kdTnIw8nXoR/s3fsYts7H1MS2H34sfUEa9wyHVIOvTVTZbqZl1bBiAPsVCq4HkiAcDFA+USKHH
 SgLckHT6o7FDf17HRIzkvkwxrffXDmTrZC4Xvl3MDn8wJQHeh/tPk+5hrTWhqjxLdRseXz4NFk
 uuM=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:20:04 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 19/28] btrfs: wait existing extents before truncating
Date:   Wed,  4 Dec 2019 17:17:26 +0900
Message-Id: <20191204081735.852438-20-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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

