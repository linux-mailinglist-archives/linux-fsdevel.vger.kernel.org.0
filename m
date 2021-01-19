Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19322FB22D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 07:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbhASFaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:30:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40896 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389696AbhASFMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033161; x=1642569161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B7JA06wyQJSeb+bJeyEVFkKODUviRdB86RqHthiYHdM=;
  b=ouOni97SuZpoqJlXXMcRL7lRR1+iNiwMjgVznXYaIpadeZkz1qFERecB
   GAgRhCX6aFbGYbhtkRY0ZL8+qDTao4cKyK1G6N4raXIecORW2jrnTm9Rl
   +WJAFJ7ge6CuohqthMSSzE7svIfZ3AExhhkdjau7AM0koee5UzV2cfGtb
   cNn/iQt7WH8wHwpV/9VxnmuhIEHrHBWwdg640EQYLLQ6KVH2tj4HoFPF4
   cGE3qeCiPOwjP20FK4cJEdw2+naPLMdmNKrDoY3LuuL2dvBy5ffRQ4Kxt
   7TysnhjM4bXenexVljdGuiiAT7ooRZIY6oLpqF1FaivFuc1h2+on+3jlp
   Q==;
IronPort-SDR: 4z3aZWZxCieA0rN+zw+fq/P2stf8dEc/KSM3wno5g1uuWad03M3zF3LM+LbSNxlSdRuTHZon5K
 T4LoCENiOPO+6NeITJkShalOOBLH/UzAy9QF60LtvSRLcgJKXr4fAjJQ/L38UAGlkpvHZP50y7
 LUKS9S0zrquBEwe14reUOk74yIlT+yRdNWSQ4Pr4jKXF/vvueUHSdEf4RIlzCXjH6UpOxn5lqQ
 oebmwJxVz+wW8rs5/VsBNsaXbxh8DYdm2VRRMve9rXeMhBLDRTJkSnqJ0pimFzUyxzRge4EYtV
 c9E=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157758840"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:10:34 +0800
IronPort-SDR: z5AjucngcymGRAYBcpkxPRmq8c6STPUfEwLD7pAaYBHKcfyLw07jEzY+AqXkwxDYI5OYKqXSlc
 5ksr+M7axDeDOj6TKOwy0DBz8fjK+4QV4T+/EYgplCiJDr1fAGVBLk/ZuLIQ/lYZJ/da/84FYs
 qahtD8qVdMViDqzy/LzRWYVEY2jy8CIbuJk5N8H8p/mZ27OueXGI11W9/tkCcWaWipEYerTJ2v
 X9ORk22Ipcp0F45ExX5U1iLgnhPh3OzdCVNBYpsM+rqpxPzfepTA5QfdFuvlwct/3ckYP3MSxH
 gULS906KTfNqDI6IXk0RTS0p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:53:09 -0800
IronPort-SDR: To60I5qpFjC/qrOYyP0e+8PtEHWn/E+IX3B/NtCL2AEGlknL6XuDdu2+0YOMCEUl9jN0+NDuzq
 dZBtHVmFs8c2MbBK6nyyqiUGvL7D/ICacqAETpUNh7sNU3jN3gr3oMEn5okCkDfyC/0Irc2Fc4
 74E8Jj0L1yozehCSNmdf8CdFJegKv/E3LC+h6Fa4Hmz/L2OxthixlGPQheihc6U0PL3qEeNS+1
 hIM5iqNNXixY/QFjQ8bMwljmNMnnwya/seW7BmRZG7IJzaltfLW+/RKR36uM7dMhYxQCE98dv2
 Nnw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:10:34 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        darrick.wong@oracle.com, shaggy@kernel.org, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, tj@kernel.org,
        osandov@fb.com, bvanassche@acm.org, gustavo@embeddedor.com,
        asml.silence@gmail.com, jefflexu@linux.alibaba.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 33/37] jfs: use bio_init_fields in metadata
Date:   Mon, 18 Jan 2021 21:06:27 -0800
Message-Id: <20210119050631.57073-34-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/jfs/jfs_metapage.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 176580f54af9..5cea9c137a48 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -417,10 +417,10 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 		len = min(xlen, (int)JFS_SBI(inode->i_sb)->nbperpage);
 
 		bio = bio_alloc(GFP_NOFS, 1);
-		bio_set_dev(bio, inode->i_sb->s_bdev);
-		bio->bi_iter.bi_sector = pblock << (inode->i_blkbits - 9);
-		bio->bi_end_io = metapage_write_end_io;
-		bio->bi_private = page;
+		bio_init_fields(bio, inode->i_sb->s_bdev,
+				pblock << (inode->i_blkbits - 9),
+				page, metapage_write_end_io, 0, 0);
+
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		/* Don't call bio_add_page yet, we may add to this vec */
@@ -497,11 +497,9 @@ static int metapage_readpage(struct file *fp, struct page *page)
 				submit_bio(bio);
 
 			bio = bio_alloc(GFP_NOFS, 1);
-			bio_set_dev(bio, inode->i_sb->s_bdev);
-			bio->bi_iter.bi_sector =
-				pblock << (inode->i_blkbits - 9);
-			bio->bi_end_io = metapage_read_end_io;
-			bio->bi_private = page;
+			bio_init_fields(bio, inode->i_sb->s_bdev,
+					pblock << (inode->i_blkbits - 9,
+					page, metapage_read_end_io, 0, 0);
 			bio_set_op_attrs(bio, REQ_OP_READ, 0);
 			len = xlen << inode->i_blkbits;
 			offset = block_offset << inode->i_blkbits;
-- 
2.22.1

