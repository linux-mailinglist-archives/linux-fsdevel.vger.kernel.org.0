Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF75306EEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhA1HUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:20:43 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20217 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhA1HRW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818241; x=1643354241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mzuBJgEjO7736zP2e3T55gtpCfO2cszPJHhO/o9ayC4=;
  b=Cq4rivwmONTdFSHuLy4D5r2AidprhafVdzmeSFopU2QlYyYq3Lg4vVt+
   OtfKb3n+lfdA07FYMCpFpghYF8FvpDMOpom7m/F84WY+t4caUpdIzBNmL
   SK5AUKEm5kTWybNCIvr40d0yQVBP4qx8JqD3jckzvHIx+NZ/zrFDEihFT
   /ed92dLDcAD80FV7g2oXLyg3kMa5BTBGSBeNgl2cKyF0XmshqglGH1aP3
   gBgNaECNEi5cA+aKrh80NCTMiImG0yzNymwbtzGXfpAu3QHZvKJ3yr1WA
   n15iMDAFNWBYi3Lc9QEylpy71pHEE41m77VNTZStZj5x2D5QxQhg0rm3h
   A==;
IronPort-SDR: i3VOb1Vc0xH9PsrNLbb5XF4C6lQfcVsZlegR7cBP9eDSlhYCC+JmHC4qA3khni52qEo7ljQsiG
 h58e4UjbomtRKVIAl8Vf+LeAc951JxDLxIjvbhUj8U4b/6m7NG/+PacewiFl/fTxe80NEhM2TR
 bWNpey6w+V69znkTQZHue2tgiTetppEgm2A0u66pBH2TB447TZ9hAzTxdDrIuUqH58dP1xN8pV
 n9RVeUJ78QDdATsIqOpxWwMlnOp7nVzIw3pk82McqlfeN7Dfr20M97nsktOmrNYPa80N4Tdzms
 VoY=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="159694092"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:16:11 +0800
IronPort-SDR: C5fp/AdlXlOtyI8x32t6vft96Mg8SVTvcfvUPnYZo/bpqphUFB2sPx8tVm+uO5fW1FIMaaADwR
 sO98pEOZr5xFRaxVlImbD7ZLPffDn+wFmrLP10E2GH0+j0Em6hD7NlmmuEcAL+lJIm/H6FJdkc
 /58d0dWcifHr0O5Nevfad3CmFoFNlBgV/1V4I2pm+gFAjwV4M0wPvcFiMO3RRDyu2p17ggnY5n
 RCGr7898FU6X5epiKYTQGTA2eNvRv87erM9PQPFlKlqUMAlEHpftKPpkg8x16CYzAUurs7eSBL
 InUdwyIhDlJDTSrdncGWLZce
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 23:00:31 -0800
IronPort-SDR: g9DYrZw82vrtcoqwLuT41C5LPwtay4x47njX4TQvn100PG3qzIQDYIPSbD2aKZ0nambVfkCSmu
 JHC6z8/1ifbcXhuz1R2nfguMjBFRQ4RaTCr3wehJDb3ERuWQ1NBrP8es0szoYDQyY3216WdfEV
 JcMopMzzk+/Wudlq5O10ELulyKCOeTk+PuDGw5+9rtJas4CG58lZZY6nLuQYmFyKdDpDYbQYnL
 x05lIaxi3M2yfAJSgs6mfnc20aeVZIpUbieSq2c4z3+si2ic8ziehclZMxZZAWaM0XsUZa2+hJ
 /C8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:16:11 -0800
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
Subject: [RFC PATCH 33/34] mm: use bio_new in swap_readpage
Date:   Wed, 27 Jan 2021 23:11:32 -0800
Message-Id: <20210128071133.60335-34-chaitanya.kulkarni@wdc.com>
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
 mm/page_io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 25b321489703..7579485ccb5e 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -342,7 +342,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		return 0;
 	}
 
-	bio = bio_alloc(sis->bdev, swap_page_sector(page), REQ_OP_WRITE,
+	bio = bio_new(sis->bdev, swap_page_sector(page), REQ_OP_WRITE,
 			REQ_SWAP | wbc_to_write_flags(wbc), 1, GFP_NOIO);
 	bio->bi_end_io = end_write_func;
 	bio_add_page(bio, page, thp_size(page), 0);
@@ -406,10 +406,8 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	ret = 0;
-	bio = bio_alloc(GFP_KERNEL, 1);
-	bio_set_dev(bio, sis->bdev);
-	bio->bi_opf = REQ_OP_READ;
-	bio->bi_iter.bi_sector = swap_page_sector(page);
+	bio = bio_new(sis->bdev, swap_page_sector(page), REQ_OP_READ, 0, 1,
+			GFP_KERNEL);
 	bio->bi_end_io = end_swap_bio_read;
 	bio_add_page(bio, page, thp_size(page), 0);
 
-- 
2.22.1

