Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5516F4137
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjEBKVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjEBKVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:21:20 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C044E59DC;
        Tue,  2 May 2023 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022867; x=1714558867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FXpnjgB/ygwpmZKJ1wgHt/Ki7pqawjz1WS6cXCp7ZKc=;
  b=oftb+if65eoRrYysPTjuxHcH+/ocN4VpdysLF0C1a3aeGb3IszdZvY0e
   OWg0Lt1iPpf9zgugfeC5TVxH5pVa2dIvm4IhuETp2rz3Uvh25UmQJ5WK+
   nz7im9tq3r1otFhIj4UrIou5hif2C2btpCBNEO2CdKfPox3uYWa0Y0JjO
   3aAaXqV+u5F352fdyr1nioLlLTSNYjzkt/cYRj7PhAkDl0hR4zAk3ZOmy
   iop7mfTKVPvtQ7QcAUvdAohLKHgTTX51qyY6xbQc+hIX8zlMyoruvv3uG
   JYo/zsnizXIJIv24wZebYmPTe9oMJKw9XpFKRY6cYRfXT8dr2TNgXStyT
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="341747157"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:07 +0800
IronPort-SDR: bdZnNfrajn6NmYm1ma5+wy/M5rOZfsFFKm8f9hr7fTl1Ol0ajfrWph/o+iMNQs8HTwnFhLgDsT
 YNpT4iWS5MWNGYwPhn3m/KAXQLhNxOAGD+a/LSy4MCNk+je4IjFUl/FjNUriCYejXrB2MXefQr
 SSMdDsxyI8kqrfpwTnWZUiMM2KPSJ9VuigxjojfmCYB698Xh1hlX9RVNdcFENau+4ouYmpDnj7
 C3Zo9M0X5ckx7ZliScE4u+PEoUiOTVFY8drOqfFfeKo2MW05wsFKrR7Ii0+89DauPA6BO0HDwf
 X2M=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:30:54 -0700
IronPort-SDR: mWtBTTHy90djKAbegefmDyP3WKoM6oP2zY9LncgzfFocNlEb1JermO/6eC4ZJMDhie29j2OtjW
 lptdro5cMeGM9kaWql7Z3j6h1oOXaDvNIEWz/ThhgjCFgs+VsseeDM3qqWWaA8jtZNxr812aSF
 WPCYWUlvjcno+HwbuSlNFNmNJdeO4ey/RN8/SbWz6G8OgGdzvlz05cLYWgBmoPXtw1YB+d9bMD
 LEIXW/AruICqoDNWgLp43Ig0EObTHoQwnl65bD70v5tSToP+lRLcqP1Zp8ujMKyHqk2IMC6uia
 kD0=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:03 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     "axboe @ kernel . dk" <axboe@kernel.dk>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        damien.lemoal@wdc.com, dm-devel@redhat.com, hare@suse.de,
        hch@lst.de, jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-raid@vger.kernel.org,
        ming.lei@redhat.com, rpeterso@redhat.com, shaggy@kernel.org,
        snitzer@kernel.org, song@kernel.org, willy@infradead.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v5 07/20] md: raid5: use __bio_add_page to add single page to new bio
Date:   Tue,  2 May 2023 12:19:21 +0200
Message-Id: <20230502101934.24901-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The raid5-ppl submission code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked. For adding consecutive pages, the return is actually checked and
a new bio is allocated if adding the page fails.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid5-ppl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index e495939bb3e0..eaea57aee602 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -465,7 +465,7 @@ static void ppl_submit_iounit(struct ppl_io_unit *io)
 
 	bio->bi_end_io = ppl_log_endio;
 	bio->bi_iter.bi_sector = log->next_io_sector;
-	bio_add_page(bio, io->header_page, PAGE_SIZE, 0);
+	__bio_add_page(bio, io->header_page, PAGE_SIZE, 0);
 
 	pr_debug("%s: log->current_io_sector: %llu\n", __func__,
 	    (unsigned long long)log->next_io_sector);
@@ -496,7 +496,7 @@ static void ppl_submit_iounit(struct ppl_io_unit *io)
 					       prev->bi_opf, GFP_NOIO,
 					       &ppl_conf->bs);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
-			bio_add_page(bio, sh->ppl_page, PAGE_SIZE, 0);
+			__bio_add_page(bio, sh->ppl_page, PAGE_SIZE, 0);
 
 			bio_chain(bio, prev);
 			ppl_submit_iounit_bio(io, prev);
-- 
2.40.0

