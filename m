Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CBB6F417D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjEBKYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjEBKXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:23:18 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50AE5FE0;
        Tue,  2 May 2023 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022919; x=1714558919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MB8IrW3XRF0b8tjpVHZZO4VEKTGu+LfkwhaA4xbI4qQ=;
  b=B8yAHDOBfYe59CxzDLAAA12mHNv4ln6RiZ87pQXsa4r0Fdo2i+8//us2
   dL6q1OmyuE5rXOMJf+5e4VguJzWkxDU8XgsRoYONRkI+j3M5k1qvVe7sf
   97DOZV314rzd7HoQvGSm6fHyLDiP+beP8giNiGR9tp335eLfgBE/Fg+8q
   IgH9QzjOB+TeEYErn/jqk/tC+9XOJJDAldmudWYOhvoFNqbDPazj5fJPD
   wpYaFH/uXGF9043QGcVWIDhz0GQw48DU7NyV90EEXE/mmC9fAuN4gTr93
   J2K7QAY6onVoAvOGv9EyHZlwHZe+Zs/vW0tKR74cEXrF2sP6s99sJziux
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="229597985"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:59 +0800
IronPort-SDR: aiWCCspf/XOM4A9JvekFiA4il1eNzf7AAb2G4tfeE5aYs8kwe84RFGnp5fC2u4cWBT1OG/7V0q
 D3S9wDIB9+3IKkwlDnlN5Bnyj8qksjKSeTE4ijLi2qWPgDzEi92ak68qEb7poIsavl1T+JYssX
 9PKvmWCWYCGjyxMKmRUTaQsl36SoezuNtDx/24ijE//As+UB4ddFBR0VjV+fcvrq8y1FRspn5q
 WQ39KgcXTxav+AYGk+XcaPPTaObwokgo3wpDhQMIXJhHTcQ7tG1RM04hY0FHvcAHeZVGtTeLVU
 h9U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:31:45 -0700
IronPort-SDR: dt0ORTo7y2OvtYPVqxqZKcSlk8TEG/M5IxYJloXDNMtpbFDpduCookvi33MCWWG4kgtbDfnjoU
 qNWcylSMPeGsO0kq0NXDl4G2C7gt3I+rFtkistntPpO5mSXx+HBp1mYREWSzEfGneChk6WparM
 /i8YU9a9mKVsFFGu/e5aSvIr5Y8Ea9LImoNB16+9AysmzPJOxOBZEoak3fvRhFlXukbVn/nkDx
 drQrakT6xd36x6OU6prDHLUpKa5+rnrr2e8A/8Ynql1R4XRsK2thU0KyPWPdS53E7jOulhZ7Dk
 rYQ=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:55 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     "axboe @ kernel . dk" <axboe@kernel.dk>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        damien.lemoal@wdc.com, dm-devel@redhat.com, hare@suse.de,
        hch@lst.de, jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-raid@vger.kernel.org,
        ming.lei@redhat.com, rpeterso@redhat.com, shaggy@kernel.org,
        snitzer@kernel.org, song@kernel.org, willy@infradead.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 18/20] block: add __bio_add_folio
Date:   Tue,  2 May 2023 12:19:32 +0200
Message-Id: <20230502101934.24901-19-johannes.thumshirn@wdc.com>
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

Just like for bio_add_pages() add a no-fail variant for bio_add_folio().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 8 ++++++++
 include/linux/bio.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 043944fd46eb..350c653d4a57 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1138,6 +1138,14 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
+void __bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
+		     size_t off)
+{
+	WARN_ON_ONCE(len > UINT_MAX);
+	WARN_ON_ONCE(off > UINT_MAX);
+	__bio_add_page(bio, &folio->page, len, off);
+}
+
 /**
  * bio_add_folio - Attempt to add part of a folio to a bio.
  * @bio: BIO to add to.
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 5d5b081ee062..4232a17e6b10 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -473,6 +473,7 @@ int bio_add_zone_append_page(struct bio *bio, struct page *page,
 			     unsigned int len, unsigned int offset);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
+void __bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
-- 
2.40.0

