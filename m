Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130CC2FB275
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 08:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbhASF2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:28:42 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51811 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389393AbhASFLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033092; x=1642569092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qoLn2/rcoIe5Xy1n1hC3Lt6hQmgoOhAQmKsRVXN2pPE=;
  b=KoF7KWQBPdGWGHFA65SbXnOdhUqaL3slSuZod9pGPHFjUfmAVD3NmS6n
   1uK3cMo1BqS00wSrxw2aD3H9f0zIM42pQ3HipI80wM84BXnFnxw5T0Jfn
   m4ZF+36CRCeTfIt8NdlOyGC65OZ2V6p48gNQnNFS16SZLrhLtifUx0Rst
   lugCPmT/XxFnTV3vyLfVSSmaRuUNiArPc6WJqi2cbHEK8Fumq+xVBwSjs
   6MoCesfjkTIhEith4mGQMaJzrHDuCevd+8mazJ8Bd0hhbubgTDjUbO2AM
   4boDZHIMJgwNmKAUzzHWL6ntFOvAwhTWIuQmXGpctLUvvKGFHNjDI/P4/
   g==;
IronPort-SDR: Sc1cagcp05wNi2gPdQB66ZrsusaAKJdzIDe8CzUtmgYSVeCWffOGB4WamBfNMqdybt8inn5CFE
 4c4eaVNL/mxAhB4VNOta4avTywzNn1LZHVlhQjwF+r5TtB/utQTB/kD+QlEOH3BdF18S1Nb4WS
 YWHMv0vZxi1o0bBsjOLaEru9HdlhdWPIWW8QMHhuTvPa7TwtfzyPWgSszh1c4DZrUZqOGggoKg
 Jsxg/mlpDBbAS2i0FBx23xPliBUIcVqCj1c4YNtIomXUOeisByIUhducn7/0CbpMmvHpMnBj9h
 7Vs=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157763964"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:09:06 +0800
IronPort-SDR: l0fGcm/mOaOvrk3ufBaX+Z/JgvxI9YqtJPwTy7GsQJFIw+iHk2No+n9cg2xF3/o1kj41JtgFoy
 KgqJ5FUZvI7zi5KU/Y1P55lf9RcNzP0Ipuh5OQYWlzhIQdbSkO+NBnXNTFsREg+DOVFKYwVPE3
 673Y2brb4YkMXNlnLa3fTxM/hxCJrtRJtqk7KclrfCGAQS632iQYaCXGQWK3FDUqqdKyQa3hHL
 85lBTtP5HoxeeunvXyGizhknf6hV66hPA/ZmJXnnLBOF781krzjsvPFwrSAt4qSmMt0kosYvZz
 wVJ5mlUHv3PO8nmWRIAhnwu7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:51:42 -0800
IronPort-SDR: YTx2sPI+S6B3s0zwLxmE9JLYYaAYYdsBlTi/QBtBxd/WH8egWo/s2t318EELWraWDHn4aYbSz+
 GTI/c0RV1f+ot/Yyog9omiJsfpSR5vK5KT4IJoKlPtJElbAfKckX/OVaF06ki+8DfWwezcFUha
 cQceDg9EfnRtvtgEBcHMkJqbMz+Hf9lDezVT3gRBkt4FXtAK8F0+3Jw8Dlu3r3MJXdxsm4oEy7
 lej+XAjPd2ZdZGUr333NTWzmm/vXM3I7gj6chGIMLH1v36uCSVr35WYHxwt+NXTGuosML8y4Lr
 Cxg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:09:06 -0800
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
Subject: [RFC PATCH 21/37] dm-bufio: use bio_init_fields
Date:   Mon, 18 Jan 2021 21:06:15 -0800
Message-Id: <20210119050631.57073-22-chaitanya.kulkarni@wdc.com>
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
 drivers/md/dm-bufio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 9c1a86bde658..1295e7e33e06 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -633,11 +633,8 @@ static void use_bio(struct dm_buffer *b, int rw, sector_t sector,
 		return;
 	}
 
-	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, b->c->bdev);
 	bio_set_op_attrs(bio, rw, 0);
-	bio->bi_end_io = bio_complete;
-	bio->bi_private = b;
+	bio_init_fields(bio, b->c->bdev, sector, b, bio_complete, 0, 0);
 
 	ptr = (char *)b->data + offset;
 	len = n_sectors << SECTOR_SHIFT;
-- 
2.22.1

