Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1951A386A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgDIQyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 12:54:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24729 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgDIQyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586451253; x=1617987253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/sRG9rMebxTyOpqZFaCW5QMmTu1k57daJpfK2lPqV/s=;
  b=pJUC/xHpcA/zW+qNMNfcAnpBYYy09YhIaX9gXBabQm3cKPz5Dc9cBE6v
   42LRdRPeAjI+8ymOrnaZmwFIoFU/qPu0k3mOLzcrECNRnN5bzjhHV826l
   Fn/sXo4UtLKwrUHxQBsMYqIDFKoewqYjiLijEaG82DuUT9ggfXXom/Tnr
   aSSun8UMB2DCHUpQv85EBj+IP5eyhtQFsIzNOgv623ppC4UYVfG3MP29b
   aShOkIsXfRzqfCGSa/fD1vojV30BKIOBj68GyojgyO8KY4saTONhkUOhG
   9v9Pjrna4N84H9w73PzxrUUlYUiKlff7Me9/qmUjhDhJLV0JcXIuv4UeE
   Q==;
IronPort-SDR: JpJzgSpXMOnlBRGxOlnI2pjAkP4Gr3ztYQtS9GQ5u+IKl8qs58SAGLdd8tTlHAVbNiS1vWVQy5
 xfrz14mUboOv0DihoNcbscH0tjiW9iQs1PUvAbV9oT7SI2uUfJM4vtJp51weNiD3+3w/C2SSCo
 3KzaToR8LBl22eGehkr2ikfzJT9C9IuhjH53uOwTPRRcZ55CnlwxXmxdnkcBm4xzFrjtRFdgxH
 qc4oFiNEk8yWR29nEgT+tMTcGEqa58ngp+sjcHbgvsvtm1q+L46ADkQZBYyYXzhsOEWTsFwp3I
 uKQ=
X-IronPort-AV: E=Sophos;i="5.72,363,1580745600"; 
   d="scan'208";a="136423704"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 00:54:12 +0800
IronPort-SDR: Ysbjm7qAmDkeleE6S0UKxmDUf1V1fRbfXcd++0JhIboOIbivGRgmjsstU2tkvTyh2+jFEYH3z1
 wSO0deiuJH7sILaT8YLJ6yf+3O2k+9YV0OkTV45oDKM2xt1b3SbVRQxUKZ5PTdpJ0bPhvNbJrR
 gCQfPBXuP5FzqsHSlAxDYMXNmIaksPB/fh/sUi8ua/bVFetBrDltnmMGY3KUrT3kS1r/4L18fh
 f8CzzLwXyrNsgYnOlxyIGzD33eLBRvWGtNmhnAsChrkXoSa+281Rqoj+G1v2fjeOzf2fmJVlv6
 C/krBgJqitnfdEhKtBS/4tOM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 09:44:51 -0700
IronPort-SDR: UBm2dceu86+lz/v4VdnpD6uza7DWaf+8fpqQvoDbkFJ1hfxOv63LEO/+YtKHrT19g66e3vj/h6
 g0Ozg029H6TaiPi3EJN3TdKe85GKGUi1TIwaClgrzbkgT0IbJKedmLvX7HHhhZ4NM65SxzUGEv
 xoT7h6qR9a4rTP0u9EY5awEiKBsX6dQTrA+ovckynLS8CAPET+nUf7Gpj4+Upmp1tDl0vFvsJ0
 iJV94j3XgxUqV5vdREn24AKngyCg+cq9eC+lmur+znCoa9lCdVs5clAelb+7iTQk40KSvXYiOc
 n3g=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2020 09:54:11 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 09/10] block: export bio_release_pages and bio_iov_iter_get_pages
Date:   Fri, 10 Apr 2020 01:53:51 +0900
Message-Id: <20200409165352.2126-10-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export bio_release_pages and bio_iov_iter_get_pages, so they can be used
from modular code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v3:
- Use EXPORT_SYMBOL_GPL
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 689f31357d30..4029a48f3828 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -934,6 +934,7 @@ void bio_release_pages(struct bio *bio, bool mark_dirty)
 		put_page(bvec->bv_page);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_release_pages);
 
 static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1061,6 +1062,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		bio_set_flag(bio, BIO_NO_PAGE_REF);
 	return bio->bi_vcnt ? 0 : ret;
 }
+EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
 
 static void submit_bio_wait_endio(struct bio *bio)
 {
-- 
2.24.1

