Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77C1306FBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhA1HjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:39:10 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22514 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhA1HPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818131; x=1643354131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehPvHcNFObZpIErrj099M/D2lwJDNRsp+vZtBu0oImM=;
  b=NnAKH5lyyfwO1Gwiin4fPWBCqQ3tKqqW+PsDj8mcQ4RMlzuVJ9QfNRyE
   5CZvQUeXRdi5Mg0fK/Oqzy7qFEPkKUmUb6P6DMQ0WH1HiL2wjqkuJj5BB
   EV4FklXInbANDZivN+3mhsjJUA8dpnGZTbNA0GxmKGV6Cx6c0UKsMTfJL
   np60nuNVv7jo1KQqF+DLoDdXV/Ajuu2IRwtBVIadz1xN69teQ+qJ0yrYx
   0h1xOqz953VTrJiCnEn/yaJAdkiXCApDWlGn4NPljLJJ9Ry2zXYraQoEX
   djBazIhd2MJAmGJiNoCzmfQbzq5Yf1Y/Nca39Xc/Chs4SFD+fiJ14N9UU
   A==;
IronPort-SDR: jh0svJj4UKssDGxkT25U6k22x87TSqdY9GdizYujfpunry9hII/Stb4xprrvZKSibVnwCHDqgM
 yLdXl+Lv23SwJWGDlu8OKda/v/T8BU3GmZEUM6g8BkLbeLgm7UePEmpjHPCMH19HJBxeJLzlqS
 aPfBiK7twLCkRG9dr842ksf07YZemZ3L4DpHH1YW9yUgtwarv88sbX/+pUrU+2r+mbzCT7aWEi
 aM4BX+OrCqw5RZP0EgNVGNv/j18pq28wHrFrIFNyXiHN34TcS77a7xrOvw038Q6nFYwDntGUF/
 sTc=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158517430"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:14:26 +0800
IronPort-SDR: ge6KmcgkfxAkSyZ59ylI29KOkEr/IGzYlHyJ6i9r8K7+tUBuBpXjU8Vrmmzr7h4HabXHoIibYe
 dgBfvoBr7bCE/3PbR8ZrPCSjHtJ4830Rcz0skXr5odabQMyt55bs54p0a0WAEcgUqjtHNyEMhN
 09ueczfImOGCw+2V9A7k6NWDUdojrLPMKX6HLRLuq/XZrobqQCDmYwyaZ1s052fOP5FiKnTK1f
 umtgFwkgcGS8fBFiDpOYRzlY927bjkmjmvPhx+dbTaNL8O5OoVOtx3FvFfEB186Fw58zMUcegm
 XuupjC3xX+pA8/pNY2tjyUHd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:56:44 -0800
IronPort-SDR: 8zWpKV1GG73An1zpnhB0A6RHwKcvj53Vuxf9sCqOuA5ZBa5rmYze0QOVvU8HXRv/G7xpZnMIM1
 owK+1cH03BzVuf34Vf4nPTxb3MJRxKHU7MPVsfYKBvoE5U6OUm3WvlKRFiuZT6me2l9YBpl9Dw
 srBAVfHgvdy6RitQaBWTWMkJB+swHKrWKKu/bnpunnMHs5/vTt80z06ovpDFKB7vDmFytTZ38T
 a/jEmxYBTtNgI1MsJxovm0Lez6j5sfQFarO3Hedm9NgwCWDpXDWzTcx88c/FgbEiOtdVVLfaVV
 avQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:14:26 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Cc:     axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, agk@redhat.com,
        snitzer@redhat.com, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
        ebiggers@kernel.org, djwong@kernel.org, shaggy@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, akpm@linux-foundation.org,
        hare@suse.de, gustavoars@kernel.org, tiwai@suse.de,
        alex.shi@linux.alibaba.com, asml.silence@gmail.com,
        ming.lei@redhat.com, tj@kernel.org, osandov@fb.com,
        bvanassche@acm.org, jefflexu@linux.alibaba.com
Subject: [RFC PATCH 19/34] fs/jfs/jfs_logmgr.c: use bio_new in lbmRead
Date:   Wed, 27 Jan 2021 23:11:18 -0800
Message-Id: <20210128071133.60335-20-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/jfs/jfs_logmgr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 9330eff210e0..4481f3e33a3f 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1979,17 +1979,14 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bp->l_flag |= lbmREAD;
 
-	bio = bio_alloc(GFP_NOFS, 1);
-
-	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_set_dev(bio, log->bdev);
+	bio = bio_new(log->bdev, bp->l_blkno << (log->l2bsize - 9),
+			REQ_OP_READ, 0, 1, GFP_NOFS);
 
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
-	bio->bi_opf = REQ_OP_READ;
 	/*check if journaling to disk has been disabled*/
 	if (log->no_integrity) {
 		bio->bi_iter.bi_size = 0;
-- 
2.22.1

