Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CC4717F31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjEaLxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjEaLxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:53:09 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EDC1711;
        Wed, 31 May 2023 04:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533937; x=1717069937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wyX37qrNukpOnFd0kuw76h6e0vzZ4DyBtjizjt54zEs=;
  b=O1FwTGRYbxfZhzrT6T37zCMU/THkL8EkkvnapogHnlFyseiuJz9Fff2A
   JBe+uaJK82FRyEtf3lBQmuzBpobJNu9r1pi6IZaYUGqe888WnPiyZGcUA
   iXf1HbuCF47B3kc6WM3x2ogk/Bb+H9BS4k/q94g3xlPDRpaBNCry7pOjW
   enTZlM3uUGr7VvyR2HIsUFqHqnpEZ+lTQFC/frB17Cw/4maGw11tazIzL
   PETRtJmqL+eYfJeIEOZXciYvfZ3a2VSZJ43l3Sr3wbNoXV1rnLzkdshZZ
   IUoaY6W6Lp3b+NMPXzzAGOW5z8L+EKrdTbD3PHczpkF+cSymLPfy5dh99
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="230207493"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:43 +0800
IronPort-SDR: K+MqLbVzQSSB+SBhtNlc1rp49fIOg5l6RdKVWQYWTP/bhRrfUEi/mQvbLlwfH6zZU5euuENZuW
 JpZYYArUI/zZrFWUR0oM2vj1J9U2ucPF3e/gaD6/WDNateN9J7oHIdh0NGy/yLMJ7ogJWgpJKv
 t+kaoCfUBKWlBy3bD0Ee1UEGiuhmV+wknDFpUdHIABML9utMQL0zLV94Q4Ks7Sqfrp3lNdwPEG
 HU05BogOSqT1t3DQxpUCdKr7VoZZzmvFX+ULwgy2Xoeyr7etpz2XaonlcZ/48YHhVlyxHmXco3
 I3g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:36 -0700
IronPort-SDR: xo459tElfFqtwBDe2sQAJqvwfBpbSzCQVTTIg+wPUWJFH5rvf87QZ0/LRdMy+YjMhlouZBBxmo
 sSFHKg9lUYcIkRHQv54nV+2OgEzxoHzxVahxn3BeeKZAyYylUuWRRTeDS6dvBOIxkJePE/rTcC
 eYbX1rHn5bbth8QftqRWLPHth0Gq61eGFZ6K61AfXG67LUgq2wZH8hWCBqD5V+7su+uSzYeeSR
 Ss5cmfzwMHsFg984FR8v7pis/w9ow+W2i6iaGIo6tiECTtkMKiiQqzdfNTk2BbJ95DDObBEoN5
 z/8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:38 -0700
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
Subject: [PATCH v7 16/20] dm-crypt: use __bio_add_page to add single page to clone bio
Date:   Wed, 31 May 2023 04:50:39 -0700
Message-Id: <f9a4dee5e81389fd70ffc442da01006538e55aca.1685532726.git.johannes.thumshirn@wdc.com>
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

crypt_alloc_buffer() already allocates enough entries in the clone bio's
vector, so adding a page to the bio can't fail. Use __bio_add_page() to
reflect this.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-crypt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 8b47b913ee83..09e37ebf7cc8 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1693,8 +1693,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 
 		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
 
-		bio_add_page(clone, page, len, 0);
-
+		__bio_add_page(clone, page, len, 0);
 		remaining_size -= len;
 	}
 
-- 
2.40.1

