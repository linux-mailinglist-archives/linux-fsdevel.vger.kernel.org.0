Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4005D717F3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjEaLy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjEaLyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:54:05 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA347E76;
        Wed, 31 May 2023 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533995; x=1717069995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TXHm8cKgeXSbycf6VjVIJnX8HwRGv+9KYRMuHSdcMO8=;
  b=nT0CA6J1UqyIjwWMTnzUefEdhdMEXMco76Ck7s8BK7I+HFBi06ZFuEch
   MFdNG2InnUklUiT+d2Dbc1jYFzCU9wDALXbZVQ9Vqo8hHIfrszt9l07qp
   Nm9VRcpyxKtNuIr8gymVEtxMEh4xKot46fpbMTSV3fjsSX4+CR1TmJaTq
   tPVhHJRRohbXWPxajTstrPzrGAB7SmtHxa38MnXeHk2rKa7gVLoX4IaJF
   e4b69Y8Iym4E6fR0sTuRUrwtVeaLTCQbSNPGsDB2G24odZgL1S4UCoGRM
   q8flxopjCgDbRIBIoyd1DTfIn+kPthP7LackcavtWjRwI93ox00RdVrin
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="230207512"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:54 +0800
IronPort-SDR: jc+kQ+XcNju4LEwUhRPWqQnTwUgf6S/OvWhIGpVh9h+HyH3Yy7L3QwjqTQ86UM5TXt2tbDjxw7
 rQw/Ro3rrKH7UjIOigy7yIhYbnTR3idIt6TjvekM24hpM5YBVylOmYi4vpSG3/RnThA99MJO68
 TWN/JcDmF4T1gzRZU6Txo1eabChqgEOviCKU2EiGI7HQNVFLib61x5SPmaKNnqGyQqyFFHULkw
 e+C+NmQ7YXXgfGxhyq5WBl0aYjoCLCkX2nFzYKYmhmwDuAwSIBDXe6/ApgWS0NK45kM2hql1ss
 bZA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:46 -0700
IronPort-SDR: K8DGvXh3flLPynticzqNOEK+cYmmrpCanEBz66JFrWIngUtekJYSQhCrCrQqqhG+xCFaPCQa2f
 kPJSf1LI5UoWCk4clEw/qwVZ0W4JIS0jS8S+dvN+TLf0ZfYCIO+3Xte4UP0xRPIscBgFVDQ2Kd
 i0oECfF+1dh8ufMGv5dV011PahNQRw/rJMUEPkg/QmDHoXKUFcS063SfGvdOMAWACqKfwoUrw7
 ZHc2iWsZBS8kDjkwhUtPmAIWhJo/MvPANH9LDUtKSOoqChVFdvi5WpUhFTDcEYLLYC3pqPKsMY
 Ipk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:50 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, gouha7@uniontech.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v7 20/20] block: mark bio_add_folio as __must_check
Date:   Wed, 31 May 2023 04:50:43 -0700
Message-Id: <381360a45ac3684120cfbe1e07685e9c36256e47.1685532726.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685532726.git.johannes.thumshirn@wdc.com>
References: <cover.1685532726.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all callers of bio_add_folio() check the return value, mark it as
__must_check.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/bio.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index f907d75af205..c7a9425d19ee 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -467,7 +467,8 @@ void bio_chain(struct bio *, struct bio *);
 
 int __must_check bio_add_page(struct bio *bio, struct page *page, unsigned len,
 			      unsigned off);
-bool bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
+bool __must_check bio_add_folio(struct bio *bio, struct folio *folio,
+				size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
-- 
2.40.1

