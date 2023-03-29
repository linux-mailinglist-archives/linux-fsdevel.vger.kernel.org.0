Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3B6CF023
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjC2RGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjC2RGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:06:33 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A50B44B8;
        Wed, 29 Mar 2023 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109581; x=1711645581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+NnexQOsAOUbE/augeQOa8oyAzkSCsYrdZjdeoHBcjs=;
  b=eegj7RVxqxvbatq8B2uigrOeBNSe47E0Vr4CJ8Q5pb5LijBYIm2SIfFD
   LmEpn7ZqRZu8K7NlRYIXfxRgKuoXzpgL+S+kdiGPf4S63OWbc00evtNDX
   u0RqjBgp1ahJavAYLCQrJbym3ZF/KYloSVIcUo5/Up+eIuseu3XHDhwMA
   u6XaWsGMkW2SzgXHlOeRKRRkMyQjz7vzNeTCYURvHDR6bR0Nb8CX2GpC9
   uDuDyx1CrojNNEygT6rnLH7F45mwKe4qwVqoJotcbRzfduHllM+Mhm4+i
   kx9cbNPJcKVJT9FA4pKEPEUuaBQ3wlVwXkfoJnszNCJyYKEaZApIa6pQM
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092813"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:06:20 +0800
IronPort-SDR: 4Czs/V3uRtbM6T8bvTpWTqKbjnAK/1BA1wnwQ618CHNP6O3qWFFXQgMtwW381tq8vRP7vmUzco
 5OdSPUve1Wg3TyLP439ObjlmQAT5IqMRIOCF+m8PxMJQQJ7zq2k9vckW0MjO5b1jZK742Wybhg
 roJ3UQGbmRyori1AlsQhFqctlQhwnYfTIKjSFz+DTepWukNpOnhnURkj3FK1aTZgWYb0xWjfGg
 A9TUYIpxbMaFxD73OaXs4XgaoPlP8/+dHnvKiZKQEYFM0G90aZPc+/cuKWAOCk5pVE+D2L0DJa
 IYM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:22:30 -0700
IronPort-SDR: 5o43zE44ApvlLKedTs27i6ZN/lELa7pMrmIJQK40gUpdn2C4UtQdcwlIfjiKh1n/bPpGX2YXq8
 YJJVJzgPqspxZi96lPe0WBzcRw9V0Z9BQK2DV4YAFsTQkHP1VrCBf6vXbgxIZ7J5vpxE0lTn/0
 xSGPZVtghIG7ljFrff33/jPHtv9RuCOmJLd+y2rtbDipZfTukm+09qiddbRkAF472QN1YGPAI9
 JwRocCI6ASGu/e1WbcS3qvfbyDLv4KkKB37h7xOPvZEpnFh7bqGxuER/H3ZfH5Gd/fUWjoHgjr
 ZXs=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:06:20 -0700
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
Subject: [PATCH 00/19] bio: check return values of bio_add_page
Date:   Wed, 29 Mar 2023 10:05:46 -0700
Message-Id: <cover.1680108414.git.johannes.thumshirn@wdc.com>
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

 drivers/block/drbd/drbd_bitmap.c |  8 +++++---
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
 19 files changed, 54 insertions(+), 31 deletions(-)

-- 
2.39.2

