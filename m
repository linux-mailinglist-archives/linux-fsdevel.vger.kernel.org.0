Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ABF717EE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjEaLvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjEaLvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:51:15 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D43129;
        Wed, 31 May 2023 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533853; x=1717069853;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XppOqav2UUYGSjNlhAvtpVVy7ou24D/pviKHTMytfKU=;
  b=qoCKNhtGL28Awet66nKYqUTffSVuB5s4zRnbOvalc+m8GjANYJmrji97
   2zi/2XVkMJTUOdiXummsF/DnVeB7hV0ev+/4Nf7FyRPSnCHJAwcxT7r3X
   Rd44ZUfSQT66h0/Zbh8phHYsjeS+F4cR9++XI6ZXv0KVQkNeXAI2sTnXT
   6eI+9Q/WI416m5V0jkXJkJYUvp5HKR1JvJ7bJD/Vy8pX0o3ABI7ZG4ORb
   E1QwKHS/fDeFldd4JdJhGCuzt0Q0eQCQnvJRXC/iGu9f+lmTkhpRBFGOy
   g23ndKXkYNzGIhU49zYdSnMQw9Llw1fUk7lrY4MEsVPAGFheLl1UFncpR
   w==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547905"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:50:52 +0800
IronPort-SDR: ZT+EmPGxWFd1eDYWc40Y6Ndi3E1LRAtXcJuW2ekTu3WfrFV3jhPQBdi9eiwh070xpOC/ecNcUa
 PK0jXkepqMOI77SA1mxb9xuaXTWYoyiXYigGGqFxxe057pVS/VjgYaYtOGf9Z3FtZC8qLygvr8
 70KgMZsLVpjhX0ywdHjUY6mJgckpLH3yWuy9btJdzPqBIpWTL5C41XtGG05Ny80+2sOsWr4d2k
 +EI+HCqJCSHXArN0qgX39ncedru9aQTcILzoeNxPGxSpfzKuF1KEkI4CrPjKX3+GlK1lP4K/Qn
 lPk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:05:45 -0700
IronPort-SDR: aBaTXHI9fG0yLOBPINz8tPsC3r6YDYfSeFUWj/Rk8jWbMTPrTXRa0vH3bKfIpcAQLPGli7lgPR
 YLSb9OcFMBlrCkosi2CpTFqsECBkzuv5p5Jrd02pxOPrTfbsnU9RLpQTpyompRRhsaJ47h6uI4
 HFFmIaUfh+yjrEGq8krGyD9f3JlGVP2BCq1uoUGxpapj3rkHXsTVQ9vJNkzdRx+/vCDcwtZ89Q
 47IpAVAdH8zdPYJjyDmKkai9L/bnaYPqkDkBF4KWaJslks1l4UWdEo5lNDduud2gkMCfqFjV9d
 oWk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:50:50 -0700
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
Subject: [PATCH v7 00/20] bio: check return values of bio_add_page
Date:   Wed, 31 May 2023 04:50:23 -0700
Message-Id: <cover.1685532726.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
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

We have two functions for adding a page to a bio, __bio_add_page() which is
used to add a single page to a freshly created bio and bio_add_page() which is
used to add a page to an existing bio.

While __bio_add_page() is expected to succeed, bio_add_page() can fail.

This series converts the callers of bio_add_page() which can easily use
__bio_add_page() to using it and checks the return of bio_add_page() for
callers that don't work on a freshly created bio.

Lastly it marks bio_add_page() as __must_check so we don't have to go again
and audit all callers.

Changes to v6:
- Incorporated comments from Mike and Christoph
- Collected Reviewed-bys

Changes to v5:
- Rebased onto latest Linus' master
- Removed now superfluous BUG_ON() in fs/buffer.c (Gou)
- Removed dead cleanup code in dm-crypt.c (Mikulas)

Changes to v4:
- Rebased onto latest Linus' master
- Dropped already merged patches
- Added Sergey's Reviewed-by

Changes to v3:
- Added __bio_add_folio and use it in iomap (Willy)
- Mark bio_add_folio must check (Willy)
- s/GFS/GFS2/ (Andreas)

Changes to v2:
- Removed 'wont fail' comments pointed out by Song

Changes to v1:
- Removed pointless comment pointed out by Willy
- Changed commit messages pointed out by Damien
- Colledted Damien's Reviews and Acks

Johannes Thumshirn (20):
  swap: use __bio_add_page to add page to bio
  drbd: use __bio_add_page to add page to bio
  dm: dm-zoned: use __bio_add_page for adding single metadata page
  fs: buffer: use __bio_add_page to add single page to bio
  md: use __bio_add_page to add single page
  md: raid5-log: use __bio_add_page to add single page
  md: raid5: use __bio_add_page to add single page to new bio
  jfs: logmgr: use __bio_add_page to add single page to bio
  gfs2: use __bio_add_page for adding single page to bio
  zonefs: use __bio_add_page for adding single page to bio
  zram: use __bio_add_page for adding single page to bio
  floppy: use __bio_add_page for adding single page to bio
  md: check for failure when adding pages in alloc_behind_master_bio
  md: raid1: use __bio_add_page for adding single page to bio
  md: raid1: check if adding pages to resync bio fails
  dm-crypt: use __bio_add_page to add single page to clone bio
  block: mark bio_add_page as __must_check
  block: add bio_add_folio_nofail
  fs: iomap: use bio_add_folio_nofail where possible
  block: mark bio_add_folio as __must_check

 block/bio.c                      |  8 ++++++++
 drivers/block/drbd/drbd_bitmap.c |  4 +---
 drivers/block/floppy.c           |  2 +-
 drivers/block/zram/zram_drv.c    |  2 +-
 drivers/md/dm-crypt.c            |  3 +--
 drivers/md/dm-zoned-metadata.c   |  6 +++---
 drivers/md/md.c                  |  4 ++--
 drivers/md/raid1-10.c            | 11 ++++++-----
 drivers/md/raid1.c               |  7 +++++--
 drivers/md/raid10.c              | 20 ++++++++++----------
 drivers/md/raid5-cache.c         |  2 +-
 drivers/md/raid5-ppl.c           |  4 ++--
 fs/buffer.c                      |  3 +--
 fs/gfs2/ops_fstype.c             |  2 +-
 fs/iomap/buffered-io.c           |  6 +++---
 fs/jfs/jfs_logmgr.c              |  4 ++--
 fs/zonefs/super.c                |  2 +-
 include/linux/bio.h              |  8 ++++++--
 mm/page_io.c                     |  8 ++++----
 19 files changed, 59 insertions(+), 47 deletions(-)


base-commit: 48b1320a674e1ff5de2fad8606bee38f724594dc
-- 
2.40.1

