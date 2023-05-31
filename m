Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F40717E52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjEaLin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjEaLih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:37 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B68134;
        Wed, 31 May 2023 04:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533114; x=1717069114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k4Zj5ateI81PgQX8IcVmz/ho3EHE64HEcz5aupY7/XQ=;
  b=q1SEZSLNgSqZ9V/xGuK8I6NHz4UdYKS021ujzp9PMGou9I1Fh60qj1lK
   IiQOKEu4SeKyukYJxP+KKJeWejwp6Px3zBkbc+m2kUK4L5c7gPTmVyFDe
   OqI2AeCetQ+cpPUq0yGCzU+Okdlg1szYytAlnYp+h2JZfwQFFLxTZp8iq
   TLyVTZSWIiFYj5dPbcivF/oV4l8KN8kogoS4cB6QI0PlYdOy4lbW3t7uc
   wkPaD+BYXp49Gu9/X3wltvJGv5FKcOqaChj2uiYxCLXHD3EqTJummMuaL
   Zo/9nvKXL+x7kGc3mIxZkgZKBMzOrZr4ahN9EArQkRZoAWQerBjGFfizj
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179078"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:34 +0800
IronPort-SDR: 9CZRNQfaQnubsZHlDRIkC7pvmF8/XJMxlGKUjuxU9cB6ubKcoaFcfZXaChRLIQ/TXFFvOo6hzT
 LgODFQkJ1Jf24RnVWS6pA31NCzJ0cPLLLOMZOZDPz51tIYqjxt6JVmGDsnfsOXzC4z2gyfsaNI
 Q57kXu7iaOPoUmuNa2Coqne0jZ8Hd0bEaEbLyu28l0NIRmiRwEC0J3bmqXyjrwwvgGIxZQbcS8
 Ho4PyRxqlSQZDhoHsrkcwaK//D3EANMCX53TXd1zlyrRTwLeXWexpPhh2wcDHlALk/6t4Z6kXS
 2DU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:47:46 -0700
IronPort-SDR: G8WqXACtyoR6HPoSq2YriEVlneh77SFhenTvEqq6WpnBq7KKM+sPCPm+GrqQFqWL+B2pTKVDpG
 xA0kbC9UhWyQ36N+cOeiqopLeF5+LPepU5CFaDA0g3dKAvpWpbwRf4GJeNT+WE2RSXfotM/9hs
 xUlEW+B1evXMrJEbSgp/S8wBvwpwsamqyQBaDhQZvWLew2qNZ3rVv51YiV34nwtOhpZaHa58rL
 f5PFDgZKJqwXTQa+B22CtHfK4E7KltIjz7TZDFO3mEiNIg1g7wdLPWOhPb+TiaQ+tA5euwAF26
 u8w=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:31 -0700
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
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v6 09/20] gfs2: use __bio_add_page for adding single page to bio
Date:   Wed, 31 May 2023 04:37:51 -0700
Message-Id: <15cfecbbac931aa18bfd89cede85bcde1d6edd77.1685461490.git.johannes.thumshirn@wdc.com>
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

The GFS2 superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/gfs2/ops_fstype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 9af9ddb61ca0..cd962985b058 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -254,7 +254,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 
 	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_READ | REQ_META, GFP_NOFS);
 	bio->bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
-	bio_add_page(bio, page, PAGE_SIZE, 0);
+	__bio_add_page(bio, page, PAGE_SIZE, 0);
 
 	bio->bi_end_io = end_bio_io_page;
 	bio->bi_private = page;
-- 
2.40.1

