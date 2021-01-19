Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307922FB453
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 09:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbhASFXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:23:21 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34502 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389640AbhASFHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032860; x=1642568860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2EwAg85Rl2+jMe62nRnS8RL98bOCXmnfO5riJrV6i0c=;
  b=GjcXuKIfE7oPUJJM/Wi2vVnUpYud2gKvIpltIXHVNrAg3RsXPu43SSpM
   wIW3+AVU6/Swl0XW8ZahSdWTuFz45x0PRFdfyO6jSRBESB3FGqMrqsV51
   LqkiqQ6Mgcp5WA0fCSeOO9AkjTdUCbrZXnNCSfz2UwQChlBG1Ttqr5VHX
   GXRzXfm92QORv96J/4QuRWF+9tkr+pcO4FELeyKPoafSsntR2wTSd/PaH
   Iw7sQzoXv+E9E2JN2DSUUWOHaWKDpdqLHfZz17GiunoEXJigP+2IH4ZKA
   x4hjKdDD2Xj6pDfIKfk4mM4S2sDepgL7SmTMUx4dUWt2yBgJNl9B9ln3F
   w==;
IronPort-SDR: 7F9V8E2gCFx1ENrckraC/aOPabyshxzdGR1mhufNzVCSB1ZQqnbgSiAulHQ+fQrQf0VUfZp2RQ
 lD9qauiuxEBB9PMtkyVUCtlbRRvbja4mqWOP92mvguWXYPFPRt0ywXlzt4nwaxSEuykNRTLHwY
 46Oyg2LmyN3IKgagwVvK4ScZzXbnceF3nrKIl0BsSg9m7EerKdRxhTPeeLR437E7+7EOo/WM3N
 rxvlmtGFm6UcYsU0Qk1//34mDVQN7IyG+xRcn7TqkyNt+L1lv3J+Us9C6/ANlf4U03PgJBiMf4
 7rY=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="268080837"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:06:34 +0800
IronPort-SDR: nICJNTCp5DZTCdEW+BDS8Z2snIrYrlMGiOG+8k41nZ+toTeWOlVhexX9dHTlwiqlcEC7mJSKUG
 Iy/fc+BGI7Gq8Tc8eNWRNodotuWudKLMuHWvPgvyglmYCy3CVY5v6y+KCctMt1KQr1t/A5vu6G
 EU8YQ12jfB7JSDNqLnc6qhTKltQXkH+QIkeCJgH1ExuBNJ/LLJLVkSZoi6pcXoZsChyTgxhzzc
 M/7G2USRTjBZjdX6m3rZ7UDS60bVW6YpGRy6Hay6Zi1n8mTtRVmKMccQ45eAk1w07M3Ya+tZ9I
 WeterqNf9O4H/xA4G74z3xOk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:49:09 -0800
IronPort-SDR: w8TQaHPmOf4afpFLhHFiHm4s9YBVvwz1nCheCJ4OBOH8yQ2UY0NC3Tt/JdFHF9KkeR+DlxZGUH
 e7bQB+02ddXqKaR8b/7v1Y7wXKviC9dKqJTPF9aSTC9cHooTn06sxWBBnh6ybRkpJPiq1eaXml
 Li9XSEIsEl1dTBAvxWyxQKBso9dBp+WZiRKxmJUsbAqs+G/qtiWTWXlVZWjYoZKV0OKSYwZfdM
 WxDGvor0MhqHOPvWCUI9b0h4sFeSeNraJk/cdT+mEYZtqS1ubVV2lyl7ZqDz6u2Z/jCzzw/RkG
 Jdo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:06:34 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        darrick.wong@oracle.com, shaggy@kernel.org, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, tj@kernel.org,
        osandov@fb.com, bvanassche@acm.org, gustavo@embeddedor.com,
        asml.silence@gmail.com, jefflexu@linux.alibaba.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 00/37] block: introduce bio_init_fields()
Date:   Mon, 18 Jan 2021 21:05:54 -0800
Message-Id: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is a *compile only RFC* which adds a generic helper to initialize
the various fields of the bio that is repeated all the places in
file-systems, block layer, and drivers.

The new helper allows callers to initialize various members such as
bdev, sector, private, end io callback, io priority, and write hints.

The objective of this RFC is to only start a discussion, this it not 
completely tested at all.                                                                                                            
Following diff shows code level benefits of this helper :-
 38 files changed, 124 insertions(+), 236 deletions(-)

-ck

Chaitanya Kulkarni (37):
  block: introduce bio_init_fields() helper
  fs: use bio_init_fields in block_dev
  btrfs: use bio_init_fields in disk-io
  btrfs: use bio_init_fields in volumes
  ext4: use bio_init_fields in page_io
  gfs2: use bio_init_fields in lops
  gfs2: use bio_init_fields in meta_io
  gfs2: use bio_init_fields in ops_fstype
  iomap: use bio_init_fields in buffered-io
  iomap: use bio_init_fields in direct-io
  jfs: use bio_init_fields in logmgr
  zonefs: use bio_init_fields in append
  drdb: use bio_init_fields in actlog
  drdb: use bio_init_fields in bitmap
  drdb: use bio_init_fields in receiver
  floppy: use bio_init_fields
  pktcdvd: use bio_init_fields
  bcache: use bio_init_fields in journal
  bcache: use bio_init_fields in super
  bcache: use bio_init_fields in writeback
  dm-bufio: use bio_init_fields
  dm-crypt: use bio_init_fields
  dm-zoned: use bio_init_fields metadata
  dm-zoned: use bio_init_fields target
  dm-zoned: use bio_init_fields
  dm log writes: use bio_init_fields
  nvmet: use bio_init_fields in bdev-ns
  target: use bio_init_fields in iblock
  btrfs: use bio_init_fields in scrub
  fs: use bio_init_fields in buffer
  eros: use bio_init_fields in data
  eros: use bio_init_fields in zdata
  jfs: use bio_init_fields in metadata
  nfs: use bio_init_fields in blocklayout
  ocfs: use bio_init_fields in heartbeat
  xfs: use bio_init_fields in xfs_buf
  xfs: use bio_init_fields in xfs_log

 block/blk-lib.c                     | 13 +++++--------
 drivers/block/drbd/drbd_actlog.c    |  5 +----
 drivers/block/drbd/drbd_bitmap.c    |  5 +----
 drivers/block/drbd/drbd_receiver.c  | 11 +++--------
 drivers/block/floppy.c              |  5 +----
 drivers/block/pktcdvd.c             | 12 ++++--------
 drivers/md/bcache/journal.c         | 21 ++++++++-------------
 drivers/md/bcache/super.c           | 19 +++++--------------
 drivers/md/bcache/writeback.c       | 14 ++++++--------
 drivers/md/dm-bufio.c               |  5 +----
 drivers/md/dm-crypt.c               |  4 +---
 drivers/md/dm-log-writes.c          | 21 ++++++---------------
 drivers/md/dm-zoned-metadata.c      | 15 +++++----------
 drivers/md/dm-zoned-target.c        |  9 +++------
 drivers/md/md.c                     |  6 ++----
 drivers/nvme/target/io-cmd-bdev.c   |  4 +---
 drivers/target/target_core_iblock.c | 11 +++--------
 fs/block_dev.c                      | 17 +++++------------
 fs/btrfs/disk-io.c                  | 11 ++++-------
 fs/btrfs/scrub.c                    |  6 ++----
 fs/btrfs/volumes.c                  |  4 +---
 fs/buffer.c                         |  7 ++-----
 fs/erofs/data.c                     |  6 ++----
 fs/erofs/zdata.c                    |  9 +++------
 fs/ext4/page-io.c                   |  6 ++----
 fs/gfs2/lops.c                      |  6 ++----
 fs/gfs2/meta_io.c                   |  5 ++---
 fs/gfs2/ops_fstype.c                |  7 ++-----
 fs/iomap/buffered-io.c              |  5 ++---
 fs/iomap/direct-io.c                | 15 +++++----------
 fs/jfs/jfs_logmgr.c                 | 16 ++++------------
 fs/jfs/jfs_metapage.c               | 16 +++++++---------
 fs/nfs/blocklayout/blocklayout.c    |  8 ++------
 fs/ocfs2/cluster/heartbeat.c        |  4 +---
 fs/xfs/xfs_buf.c                    |  6 ++----
 fs/xfs/xfs_log.c                    |  6 ++----
 fs/zonefs/super.c                   |  7 +++----
 include/linux/bio.h                 | 13 +++++++++++++
 38 files changed, 124 insertions(+), 236 deletions(-)

-- 
2.22.1

