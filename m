Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4A716786
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjE3Ptf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjE3Pte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:49:34 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BE4C5;
        Tue, 30 May 2023 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461770; x=1716997770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LvvitQpZZtAL6oj1gqbFnc01A5MrDrOWTWrqLbLHBtg=;
  b=P4oq1f2bKrVhwBU6fzujvpO7p/CeDAkU18POqP3JoncHRwRaz1VF/l0G
   36HRb+z3/KVA364+M9K8CN9sDg5vfhfaAwjh7iiywsAZofnZcdhPuEwkR
   ovRuqV+VbhmvZ/Mgg1ySyx7/y4oIH1wmdihi7/T87T5Obf+pVVkm6v5nu
   gr4qiFoCZ+8aqlLnW6FVNsuekKXFYRt9QcqhSNDksmTW1d0YrnZu4OY0P
   qsoJlpCGU0eb0w2cJ4+BZd6gpKJGnxs+n3jJlDeUjgssPxUZXUPJ+WfUG
   W4DjvxDp0IYe1tO1Gvoblghs3IXGZjMyPQQasoG/zzwxtFWvQbRR9tYqU
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="336465915"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:49:29 +0800
IronPort-SDR: 2hFMsA9vye+GjsDHcOM8tZoH1C/2M/eOrWWo43/vjYZSbg2flFutxxvwqIzm9XLhHwOnBeercT
 YX82C4a2mHM86KqcuBNNo/WyUp2KpRafSyunZskXENOuuY6SZsAaS8efMX5DT1C1nq74k2Hn3G
 J7lroFHhuTMHTdl/vQ8U35kxglZukKXFgiHxzE6DLlFTahR3QnF41aXR5tV7VWpZgRxRpu+Psr
 161UWAXYhPyOtmfQAHsVIoCVkQ+My1fHWIy5W+H2WIzZeshnnRkkADvuJtHOsaQG8BBbTMrhO4
 DSE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:04:23 -0700
IronPort-SDR: UZ8AC9JVcWItXvBURdFJfv2biVq9H2WKi13hcXxNmWmdGCl2msIehsW5OQj1211e+TheiYsP0z
 f/u4ZWFf/I1HZ2VD7ZgIa4wS+N2+wjgThSQMa1tPWp1wb3hH2n3ospDXQkzLVPAAbhWcu2/tEI
 SBqKpnvb6T+sxHwXStTtNJyZxUdL6nv8qHGMBJ3g70NYauvzNiwuU67Q4Y1/R+PJCILKB5A8CO
 jEOWy50NKKPkI9VlZ2fe3M709Dt9/hM2gbd5kOLisv33sJeeo1JhbeqNpeDbTlV5YHAtNPTvrC
 PxQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:49:26 -0700
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
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 00/20] bio: check return values of bio_add_page
Date:   Tue, 30 May 2023 08:49:03 -0700
Message-Id: <cover.1685461490.git.johannes.thumshirn@wdc.com>
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
  dm-crypt: check if adding pages to clone bio fails
  block: mark bio_add_page as __must_check
  block: add __bio_add_folio
  fs: iomap: use __bio_add_folio where possible
  block: mark bio_add_folio as __must_check

 block/bio.c                      |  8 ++++++++
 drivers/block/drbd/drbd_bitmap.c |  4 +---
 drivers/block/floppy.c           |  2 +-
 drivers/block/zram/zram_drv.c    |  2 +-
 drivers/md/dm-crypt.c            |  5 ++++-
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
 include/linux/bio.h              |  5 +++--
 mm/page_io.c                     |  8 ++++----
 19 files changed, 59 insertions(+), 46 deletions(-)

-- 
2.40.1

