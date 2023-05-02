Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059396F4101
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjEBKUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEBKUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:20:37 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371BD30C6;
        Tue,  2 May 2023 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022836; x=1714558836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jN2uhwv5m+CE8gDQC4BYKQ6UTcUdO1Yo6AhgEOdVjMw=;
  b=Eg84E3NU39Afjdnd27RxgOENtV+YCj/rLO2pyaPKJPnzx8DlGQWSo04x
   ibysIn8ANCOiF4WKNQhVpKO4iaMreMk2BJLMGUZSw9p+Omv8hlP+K5mlG
   KjBhjevvIyhClXyCDAvecXg89DY2tNhpnEPlYc7hLIvPoWGTWZAsmEF6v
   APHGlusu1JzkKk7ExTAxV0jJk6jdkTqboBOxTHjDSUvK0K1drWIPufS/T
   3fes27YLyWPDgzI7d5O1U9v+C+RIPtwsC0Z6AxyoOZ5wYe1GzXft71zp7
   CDLkfNDyR02l/gGfvkczY6nMtNDJXSyuC9JjDd/4FWqeEZHxGb/f81B3c
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="234672809"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:20:35 +0800
IronPort-SDR: mjaCeZrG+vlN0sCoF3MgUfscrMMD2KJWBcGS+mn4WzcT8Nbp+M/QI9d9/LveE1gEy9MOly8id4
 wT3KPzQiThe6AMaa0p5j5fBy3p1LxvsG3YarHpvc3lhKg9/+WAmc5IyhNDuOB91mBQLpSoz4nf
 Ua2DgDUj0v3hPWyv4Wpk1FN/viKLmJFS5+8pQV4gpaSIQakZwgkuFjC+szBwWwt52WnSXje7cu
 49tsTLU6LKrNzSwtf/6/8EKTRuv2NChXaYAIwaRbuGOZoW3AC2IAs5EjEekhjkXSJCXPv+q9w2
 Qn8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:30:23 -0700
IronPort-SDR: II0VPVGqsVVzFv+CDBgRTuszrP/jrhnqWD28hz4KmIk0OWZ9iuuunBJznbIJJEWysUomM83PbW
 tHpIqF+Wkzt60j425jkVHSTfRN97pvpj4qRJGP1XK/rYUtVFMFwW07KYIR+NBQHS3CcgY7qgcQ
 QoPqPucc39VmFll8EWhRke9TeNwUD/RetNk6TeKPQdBhijuGDl8aTzuwdYvSvt9Rua9BZLT2+I
 uqumhMLeAhgcuUfutHNKva+v42l5kJ3gIfcZswnraO/ApNiUR1Ze30swYPZMzn8zkEyKLhcsrU
 NTE=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:20:32 -0700
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
Subject: [PATCH v5 00/20] bio: check return values of bio_add_page
Date:   Tue,  2 May 2023 12:19:14 +0200
Message-Id: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.0
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

We have two functions for adding a page to a bio, __bio_add_page() which is
used to add a single page to a freshly created bio and bio_add_page() which is
used to add a page to an existing bio.

While __bio_add_page() is expected to succeed, bio_add_page() can fail.

This series converts the callers of bio_add_page() which can easily use
__bio_add_page() to using it and checks the return of bio_add_page() for
callers that don't work on a freshly created bio.

Lastly it marks bio_add_page() as __must_check so we don't have to go again
and audit all callers.

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
 drivers/md/dm-crypt.c            |  9 ++++++++-
 drivers/md/dm-zoned-metadata.c   |  6 +++---
 drivers/md/md.c                  |  4 ++--
 drivers/md/raid1-10.c            | 11 ++++++-----
 drivers/md/raid1.c               |  7 +++++--
 drivers/md/raid10.c              | 20 ++++++++++----------
 drivers/md/raid5-cache.c         |  2 +-
 drivers/md/raid5-ppl.c           |  4 ++--
 fs/buffer.c                      |  2 +-
 fs/gfs2/ops_fstype.c             |  2 +-
 fs/iomap/buffered-io.c           |  6 +++---
 fs/jfs/jfs_logmgr.c              |  4 ++--
 fs/zonefs/super.c                |  2 +-
 include/linux/bio.h              |  5 +++--
 mm/page_io.c                     |  8 ++++----
 19 files changed, 63 insertions(+), 45 deletions(-)


base-commit: 865fdb08197e657c59e74a35fa32362b12397f58
-- 
2.40.0

