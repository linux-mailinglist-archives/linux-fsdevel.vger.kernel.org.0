Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B666D01B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjC3KpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjC3Koe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:44:34 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246977ED7;
        Thu, 30 Mar 2023 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173052; x=1711709052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pah75tbPpb3psPa1ecpfetIOIRQ7nD0HV9ZPD7l84bo=;
  b=iaW6jdfzOcsIkgftcWn7/dnvqLqTRb3aGOTUxb9YfoNdpfVo7/LvkmPf
   UPLCpg0fYpFWEDLaMiJrQxC/i10Xqxn0tE1/MGk8mLIfWpgxhMRJ+yX+6
   qvM6+Dak+trLscusnfdS6lBN7MsY3Ra5D5tRwDiWOR2TM+hbLtDIieYq1
   phVMmCgd37Vyslf1oR/vd2sMxQiGjWw0S5gCAZxv0mzmfPz+vRRfH7www
   6iCu2acuxnCdkU9JduKRbxB7GfDnfQiWHYkZVVrGDMAF0zR/rt5sjz0xU
   5nZWpoYCtnk/L/pRt2qkeIl4VU2yx95KwTVBWgNXRSzbsgP0+m4zWqUxM
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317770"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:06 +0800
IronPort-SDR: X18T+XH+rcQzbvvo/sNc7r7XEZR5juL8F/K3BFdQXNZHlsghLM5dhSwLJkvPmejKGLPpzx+DTD
 PaXAI2gp+CnUXYNNezZcy8sjUNzINUoFmcdQLIwMCGkrhqEC5giciE1ACB7ITa801AvqFqDUQG
 LXYVokCCWDQ6z8nO0f2kzcGSELvl9w3TSEhQoNE8tZcixzAefTakVmkx03kJdKa5QyhxBZItqn
 Xd/3oJeRkSfF1AZWASXpm2C0ZeCH55hyfmzY4DQzluRb7ARAWJybw1f8rpFkI/p5a6ZeLJVkVu
 oVI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:14 -0700
IronPort-SDR: 7gJ8K2GWS1teEbx0EpcTaAq94qX8hrpZe2o+rF7L8m3YPiilRNcRHQOtOnWBcq5Kei46943ftQ
 AatOKxtS7MFwij2h5iQz2mMf16oXYsi9K+DB6MmYEWH2/wKf6Jhq67kl7/JyCoJSGg9MiCS+W9
 mrW9LYIwkiiSRZtD5ihMJA2XMHB607JeeUDkojW0OuDyFEQQTb0fVeDCKSKcOQwZLNq8tnSX6N
 qQnaGAEAQ/tKNJ8ofe6AZpbyjdYyM/XDWamw0cI3BKjamWYlDUpPV17GiKF2irYNfORElYpHoT
 AxU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:04 -0700
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
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 00/19] bio: check return values of bio_add_page
Date:   Thu, 30 Mar 2023 03:43:42 -0700
Message-Id: <cover.1680172791.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Changes to v1:
- Removed pointless comment pointed out by Willy
- Changed commit messages pointed out by Damien
- Colledted Damien's Reviews and Acks

Johannes Thumshirn (19):
  swap: use __bio_add_page to add page to bio
  drbd: use __bio_add_page to add page to bio
  dm: dm-zoned: use __bio_add_page for adding single metadata page
  fs: buffer: use __bio_add_page to add single page to bio
  md: use __bio_add_page to add single page
  md: raid5-log: use __bio_add_page to add single page
  md: raid5: use __bio_add_page to add single page to new bio
  btrfs: repair: use __bio_add_page for adding single page
  btrfs: raid56: use __bio_add_page to add single page
  jfs: logmgr: use __bio_add_page to add single page to bio
  gfs: use __bio_add_page for adding single page to bio
  zonefs: use __bio_add_page for adding single page to bio
  zram: use __bio_add_page for adding single page to bio
  floppy: use __bio_add_page for adding single page to bio
  md: check for failure when adding pages in alloc_behind_master_bio
  md: raid1: use __bio_add_page for adding single page to bio
  md: raid1: check if adding pages to resync bio fails
  dm-crypt: check if adding pages to clone bio fails
  block: mark bio_add_page as __must_check

 drivers/block/drbd/drbd_bitmap.c |  4 +---
 drivers/block/floppy.c           |  2 +-
 drivers/block/zram/zram_drv.c    |  2 +-
 drivers/md/dm-crypt.c            |  9 ++++++++-
 drivers/md/dm-zoned-metadata.c   |  6 +++---
 drivers/md/md.c                  |  4 ++--
 drivers/md/raid1-10.c            |  7 ++++++-
 drivers/md/raid1.c               |  5 +++--
 drivers/md/raid10.c              | 12 ++++++++++--
 drivers/md/raid5-cache.c         |  2 +-
 drivers/md/raid5-ppl.c           |  4 ++--
 fs/btrfs/bio.c                   |  2 +-
 fs/btrfs/raid56.c                |  2 +-
 fs/buffer.c                      |  2 +-
 fs/gfs2/ops_fstype.c             |  2 +-
 fs/jfs/jfs_logmgr.c              |  4 ++--
 fs/zonefs/super.c                |  2 +-
 include/linux/bio.h              |  2 +-
 mm/page_io.c                     |  8 ++++----
 19 files changed, 50 insertions(+), 31 deletions(-)

-- 
2.39.2

