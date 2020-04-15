Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E022E1A97DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408249AbgDOJGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:06:24 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19517 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393878AbgDOJGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586941563; x=1618477563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AAnwE0FIuZxZnRSG0Pax7N2EfNwbtDZD2M2TFf4NlDk=;
  b=mUa0v5+oOBNmAe3SeY+NzjNeJ0kVYdVi0Lq7dkSUcSZiNVbp5CVxk1w1
   uy/qT+MuNjUOTTigNZ2U1j12u9js4KGaLOPIPBz5Co65Mqm3fpEpLARU1
   hVnFCFqMPsdCdtqV9oIL6VmTUvQOoPsIE9ymeFbOSr6N1Zqi5OmI+SLcx
   WM7+UX2HQRdvFglO6vloiQGC6lmq6ct6VxK6Cd20T6hJuFo9TbRQWSxhl
   yUyRhXVypMVAfAgdJVae5tbpMKfXmkSEKB5nnc5f9w3AszE6OW+lc2VCr
   atNdzGEs0ENQ8eVBeaVvcUvsKGTs9o3CpZTkj2RvdTKVFBPeMbvzJCTgy
   A==;
IronPort-SDR: MyeknbEkG6Ks8fAHM1z170gZTviUKkSmyD2zmvb0UATEZ6B2jIBb/qc25xYIZdQai+IkA8VvB+
 nzS9o72y/fOtyi+snG/vO3IYt8wpd0W1FlSZvJMa2mbYJYXkQQwV2nerAy6cooz/I5/xgavWHf
 nnsiVpq8clOJm+ZiNSEWLHWeZmAWt9cH7MBiMzw31sqZiRTKVaN56xRQG8lzgKeozedJtRQQt9
 YpWQrzZpWi3P9x17oBXCM+sMSAVazTajA91po2zWTMjmMB1emtEJ/it5hnkM4XaTvEZ5aclaEJ
 VCc=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; 
   d="scan'208";a="136803001"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:05:41 +0800
IronPort-SDR: zWablAZD4olXlLS23nWhUpAyu/27WSuNsAGH/6dgKB+HE21HaHrx7+CUEv+q2NIohcNkSbGYbC
 jqmL+4/AA6cxVz6WpB5gOXOdYgy3J13VrOCYzUBfHtI30rlZ7IN9Oi1SLu5omIpogBJoWdgHsC
 FnlRlgajZgPxjc5NApscPNi+1pSL5bK7ixpx5to7w+ugzXS0Iq07ksaWsAU6aWVmdqw8reAfxU
 Ozx4kpxQRrnGJzBfkaZwZKzGVjiJBq311Tlyfk0OFD1jInH1wewFsN4RW62GQwqFwU0MYdefJ4
 3SRbB2+MbLskOTNC1xMen64u
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:56:42 -0700
IronPort-SDR: VlQakm2KGJCZwf1f6XZrMtD6nmu7RsZHykkJo7/ChqFty7P9ylQllSbQn1eYudK2+SteJX6jdO
 kN+OCCAz1OCO9ZOi90PlcaTPKtJMyY58WEp8mnUeuZTK4bLOGeOCIdTrC/we8uFFCgw+4pKN0U
 Kh3JBgIiRuiJUfNK4scpLJVVLiSdjtTtDVo28Bz0phMQsfFTY42byrnZgg2cvSFEa85C4woHj0
 JTjwpDpWmGVUxRFmYTBWliZryeDhV7C9oqKfdf0eHE8p2jAVS3S0e3vmAukQzWFlw7pdfs0RL1
 cRo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Apr 2020 02:05:39 -0700
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
Subject: [PATCH v6 10/11] block: export bio_release_pages and bio_iov_iter_get_pages
Date:   Wed, 15 Apr 2020 18:05:12 +0900
Message-Id: <20200415090513.5133-11-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
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
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index ba10076ced9c..6ece2d3019b0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -942,6 +942,7 @@ void bio_release_pages(struct bio *bio, bool mark_dirty)
 		put_page(bvec->bv_page);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_release_pages);
 
 static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1104,6 +1105,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		bio_set_flag(bio, BIO_NO_PAGE_REF);
 	return bio->bi_vcnt ? 0 : ret;
 }
+EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
 
 static void submit_bio_wait_endio(struct bio *bio)
 {
-- 
2.24.1

