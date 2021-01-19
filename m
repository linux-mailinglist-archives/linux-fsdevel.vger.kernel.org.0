Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23A2FB0BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbhASFay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:30:54 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51835 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389840AbhASFPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033324; x=1642569324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7vt16PAj1e5r0qMNupRL0U4T3eLDEFSlTSo46YPqSAM=;
  b=GDQJVCZTBwXcPjv1RdwSi2yVINbHIZ+aFdYJalPM3TPZIH8OpPuiYpEi
   YqacQA5F5HqMnHH1qOV7+vbWnOFuuaEV4xpuK8T2kyvVdwzK6sAoNKz+D
   YGBBkppZrqG97SRpuqkh8Oz1dLNDpAYwfRD8Lu9hyFGB6YWh1W00Kiamy
   487YmLaa1bY/6I31qE1OvzyoHPlxUh7KNlhDH5Hxqe1/kKLnpUeOwXxb4
   0XQpoYQXvnGzy3c+evleRvEMqGtX02QoTUQXjcmOVaPZW/MPoscPm7CSA
   0GS9JYUEngtkbQlp9CPV8ws14am0gsQ0gfvyzJSSvtw3UsquxBhFYSw4y
   w==;
IronPort-SDR: /lt97+fSfzNGesrGlpa798p3tsYkBJLz++x6b7k8BP/l7NCEFMZQ60qJE+eAhekMEmhiNLGa8D
 8h1kNBptR9qTGAkhZWoM/Dj4ZLmQdrKodnmqdT9qCMXg7LTZ3wTXrpNs2zAi8cArsoDmiPMLd+
 Eb13gXq0PQwekKaxA4+fGSzKQHjdRkDeq4sX00687Fkynq7b9apf0QG3ebet/E3DsgR1OixgtR
 odFNBsifiRFKym5ucU3/B+8NLdxZcljnR3EJhWQOB35Gc0HJdeXeVQpWbGs6EvaN5OGOp2/N+R
 UyA=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157764109"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:10:58 +0800
IronPort-SDR: 1MUmC29YfeWLN0P2AdC/XQlwfAhcurVLfpQpZrOXtQIMW3Iu8XZ1LQG0lVwsyKKNPKjaTC3iAO
 ptU5uDbZG/EH/WwqmRcBEM03B+ih8ai6HGfLWtzwLmDvSduPGw86Bb8cWyFdAsf4qivGBPrfu+
 tHgn5QxHfLUbWpggz7rkjhj0DT6TswLStwuRIdlNQ7xL1P6ceemlImTobSwT1V1GHbLcGlvK5x
 QNQrKzqzsUUNeBcL7JSEOadptSkB+hUyZ4wahEbd7Ctf6W90Tei1jtkHegHHJRxFfK/zGmMHTr
 4G6rTk6cEJzHqOFiurDhkqWS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:55:35 -0800
IronPort-SDR: YVg4oetj669oXGPyen5Yz7/4lwwknpBuwOHqtYisxWomXA6swBTRl0Q6a9GaHjktx9T2m6JStb
 CDvwa7TZCZ4M9GVWSo4RbtmgfurnOujjvD4svcphbEiZT+7y+gglJ9ZlIF/tnwxqJkfJFxncIx
 g5wm4nu8oJyzJ24M9klTWymj61zMdpHfpxs6XcMjZOa3vIqm+lJQ5C0tB3xkI9dYlB+E3Ul943
 D49b5EPSkdl17MTuiUi4ULzuOqSv9X94gCd9MvAo2Xb2yDb8OLgPVo7IBgCR+uA44u4+72LP4B
 OSs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:10:58 -0800
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
Subject: [RFC PATCH 36/37] xfs: use bio_init_fields in xfs_buf
Date:   Mon, 18 Jan 2021 21:06:30 -0800
Message-Id: <20210119050631.57073-37-chaitanya.kulkarni@wdc.com>
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
 fs/xfs/xfs_buf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index f8400bbd6473..1c157cfc5f8f 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1508,10 +1508,8 @@ xfs_buf_ioapply_map(
 	nr_pages = min(total_nr_pages, BIO_MAX_PAGES);
 
 	bio = bio_alloc(GFP_NOIO, nr_pages);
-	bio_set_dev(bio, bp->b_target->bt_bdev);
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_end_io = xfs_buf_bio_end_io;
-	bio->bi_private = bp;
+	bio_init_fields(bio, bp->b_target->bt_bdev, sector, bp,
+			xfs_buf_bio_end_io, 0, 0);
 	bio->bi_opf = op;
 
 	for (; size && nr_pages; nr_pages--, page_index++) {
-- 
2.22.1

