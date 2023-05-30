Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087C37167DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjE3PvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjE3PuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:50:24 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A074D13E;
        Tue, 30 May 2023 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461818; x=1716997818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C+NYxtWZcIKLiQW8aZvWShDgl/gtDFIUIUOTPRiObYM=;
  b=CJ62SxAA3ZrKV3Fy6kjyfmkSfiy4Mbxaj3zOaMGvY4OxQVKzFMTFsn7p
   36yLqpZbHgzqdevC0TVJyTUIAwqPyhfxgSf46SKS6dfrFbDr/xcr0WL5M
   18zGmFjl2c5+laPuI2DWdr0sLBmp4sy2J7fU9b1TAm8SRK6qY+kJMi6gS
   DYUYl4dlnqZoiHym27INlc3urKCVaTPCFWfyPhyC7CjXMFDGfMeQD9vU7
   DWurtxQBkWfpQ/1sBOTT9++XKM4pKVmSwGzqKTXafG6u6dLdyswTYu0Us
   /Zu0uLYV+9m53j9vVS7ycrKsRHTLEVz7quXvGYzz9cQLx9s6Ia6xgS1hw
   g==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129860"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:50:18 +0800
IronPort-SDR: eugwlRYBTgHW3JAYl++hD70I7vjSniHSX9s/VK13IqjrJJRvuwRwEET5JOQms/lTc0WbYd83cy
 uxcmVBJ0o6B5KsHlDXaqQU+NFsFotgg9fGSmlRPtB6TZax5ZlwATC4GMkg/lz/m3EBiVDU2t2w
 wIHUs19Rz3ikPNnhJ3KcRobsI1JA8II5Xm5ApJckHMKwaS2/ayAkTvPojqMRDUjLQLaulJIZh8
 XZC8QnhrIV73ERmHqnnLg6N02f1WnCqAUGn4ZUdCCH0yN1XXbN7xZ2R1V/qVSTnn1Yc3mIyhHp
 vIM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:05:11 -0700
IronPort-SDR: nWMXgYPXj9My0dJwx11mPIKRe2pSzWz6O3nUVEtHmwd7YXnITNPMVp+01mOZjGN5zhcXbH+IdK
 m4NVW5MyTKxZspeJpQdq/5lcWtTCTrtHWknfnsfGCvolyx2j0ZqjEnJPHzs6IqRD93mSDPBKaJ
 W3wnvvvnGzwMhFNe3tC3vpLamIMSeTnweXnIJe6DaIylSDsi76tjZmEcCIggRMz2kCpsmYogzT
 umSo039ixODhCfl7GjDCN2dVBtWEhKpEVTPbeeTLYiBLVoeQNEC7m5EzM08Q+jnw67MjY23eAu
 xTo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:50:15 -0700
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
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v6 16/20] dm-crypt: check if adding pages to clone bio fails
Date:   Tue, 30 May 2023 08:49:19 -0700
Message-Id: <e1c7ed59e2d2b69567ef2d9925fa997ecb7b4822.1685461490.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685461490.git.johannes.thumshirn@wdc.com>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com>
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

Check if adding pages to clone bio fails and if it does retry with
reclaim. This mirrors the behaviour of page allocation in
crypt_alloc_buffer().

This way we can mark bio_add_pages as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-crypt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 8b47b913ee83..0dd231e61757 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1693,7 +1693,10 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 
 		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
 
-		bio_add_page(clone, page, len, 0);
+		if (!bio_add_page(clone, page, len, 0)) {
+			WARN_ONCE(1, "Adding page to bio failed\n");
+			return NULL;
+		}
 
 		remaining_size -= len;
 	}
-- 
2.40.1

