Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA86307078
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 09:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhA1H5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:57:08 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22235 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhA1HM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611817976; x=1643353976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BWhCtPmFmY8SRwjALXcTfESKnsKfTCmOrzddkgcZe24=;
  b=faLGKvi9FFV57Q0dVYgonwYrSTczxE9mFzdDUiyH3A743tinm8FHpmYz
   E84KWYZzllaXLzXqmEQ3vDkz3D8fsHBtSi4Hmv/1R+AeQBknTP0ot2Svv
   rnDYlpCWtEJ2+q1R44DxVzeuA5GnmFibXE1B6D+5DQso/hdAwQoFVa5pT
   CLQn2gu7AeGLEYqMTzcoV59mbnaInDk5X20SLVrY6g8oA6DjKhe5i6x2+
   WTW7Ce2WfoH/L9CLkjXMJ2Ixf1nQnpqJivqFH3mN0W6kUljS2DJh2UW3A
   Q25yxzK7UVPZBNsUgpZo4nVvY5QMoYY170OhpNR7KneK5MlK1nUkKKU7H
   A==;
IronPort-SDR: VT21les7nQG03JqHJ+I6EARWf5lMn66DxTi2QYbOMs2YfDOw2AniSPT+pjejA5tq7xp1aaI8NN
 IJyHOrnvEj1JtURy8HGmu0MgaB3qFyIEUADD5Ek4rL9/qSDzGRwHO6xyMdhO+CtZpDm/nh3433
 uqgijKjcu6L3970RM639kqqPrmUmIl7WoTjb0NNVH7bhLYWGI4IDe794zDrJ4IASxPghSaTjLe
 TOkBT9TLksFi3mVkIqXo6YzEuM9Kaiezl7crmDupPQhL0bBL9PWXidnupZGcR3WjWU0VGSuTZw
 LNA=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158517186"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:11:38 +0800
IronPort-SDR: w5IsHUigPS/mWpQBf9qBrfSIaakaFZLRWoHP6+aNWprDyks+eKEz/GYBDl9uDW4vjngYTV/B2D
 IFvxlHDM6q/6/9nde34O8UYBh6I0uIn3r+BtZNG8Q1Tp2UBHT91nGmc+bRVSX0vH6wYM+9iszA
 F/KYhmG/TW8AEVRLeQEnipOU8wNqnajsU2fYF/lAkiJR/GA7ObRI9w0PiHGbcZOSAzOETqvDL8
 hpZV/LAw9Bj86sme5bSbMQqxe65yf8vYoskZfjC3ApT6ZscD9accTAHZbY6UsQpC8kRLHHWojB
 s+1/3Wcsa3O5HFCg61j2s/8m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:55:58 -0800
IronPort-SDR: 61Jf/0E9AfrbFBR+VL+aX9SYCVB0aW8ut/7/jLtTqvhkleWzu7b9JjkuOaGgMYwgMXw5C5Sybl
 VeNQs3LEjTqxDsR0ZyK8GA/cVYEZNMX2maaVF3ljBoeSQOO/ApbWgebfLMlSCkYd12pl+6neKj
 zn8nHOcIOMnNA2IBKV67KMXVLkXTllokNu+jCcdgoa5YFwfQecWL2vYSP5hgldmlqCiXple2ew
 fybG/wLzJMKvqPxvYQ59ATt+ZGQv1DjVDDtxXyNp0NJ+IswNbwLOu8d1uiq12NaSa1/W79MYTO
 wq8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:11:38 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Cc:     axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, agk@redhat.com,
        snitzer@redhat.com, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
        ebiggers@kernel.org, djwong@kernel.org, shaggy@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, akpm@linux-foundation.org,
        hare@suse.de, gustavoars@kernel.org, tiwai@suse.de,
        alex.shi@linux.alibaba.com, asml.silence@gmail.com,
        ming.lei@redhat.com, tj@kernel.org, osandov@fb.com,
        bvanassche@acm.org, jefflexu@linux.alibaba.com
Subject: [RFC PATCH 00/34] block: introduce bio_new()
Date:   Wed, 27 Jan 2021 23:10:59 -0800
Message-Id: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is a *compile only RFC* which adds a generic helper to initialize
the various fields of the bio that is repeated all the places in
file-systems, block layer, and drivers.

The new helper allows callers to initialize non-optional members of bio
such as bdev, sector, op, opflags, max_bvecs and gfp_mask by
encapsulating new bio allocation with bio alloc with initialization
at one place.

The objective of this RFC is to only start a discussion, this it not 
completely tested at all.

-ck                         

Chaitanya Kulkarni (34):
  block: move common code into blk_next_bio()
  block: introduce and use bio_new
  drdb: use bio_new in drdb
  drdb: use bio_new() in submit_one_flush
  xen-blkback: use bio_new
  zram: use bio_new
  dm: use bio_new in dm-log-writes
  dm-zoned: use bio_new in get_mblock_slow
  dm-zoned: use bio_new in dmz_write_mblock
  dm-zoned: use bio_new in dmz_rdwr_block
  nvmet: use bio_new in nvmet_bdev_execute_rw
  scsi: target/iblock: use bio_new
  block: use bio_new in __blkdev_direct_IO
  fs/buffer: use bio_new in submit_bh_wbc
  fscrypt: use bio_new in fscrypt_zeroout_range
  fs/direct-io: use bio_new in dio_bio_alloc
  iomap: use bio_new in iomap_dio_zero
  iomap: use bio_new in iomap_dio_bio_actor
  fs/jfs/jfs_logmgr.c: use bio_new in lbmRead
  fs/jfs/jfs_logmgr.c: use bio_new in lbmStartIO
  fs/jfs/jfs_metapage.c: use bio_new in metapage_writepage
  fs/jfs/jfs_metapage.c: use bio_new in metapage_readpage
  fs/mpage.c: use bio_new mpage_alloc
  fs/nilfs: use bio_new nilfs_alloc_seg_bio
  ocfs/cluster: use bio_new in dm-log-writes
  xfs: use bio_new in xfs_rw_bdev
  xfs: use bio_new in xfs_buf_ioapply_map
  zonefs: use bio_new
  power/swap: use bio_new in hib_submit_io
  hfsplus: use bio_new in hfsplus_submit_bio()
  iomap: use bio_new in iomap_readpage_actor
  mm: use bio_new in __swap_writepage
  mm: use bio_new in swap_readpage
  mm: add swap_bio_new common bio helper

 block/blk-lib.c                     | 34 ++++++++++-------------------
 block/blk-zoned.c                   |  4 +---
 block/blk.h                         |  5 +++--
 drivers/block/drbd/drbd_receiver.c  | 12 +++++-----
 drivers/block/xen-blkback/blkback.c | 20 +++++++++++------
 drivers/block/zram/zram_drv.c       |  5 ++---
 drivers/md/dm-log-writes.c          | 30 +++++++++----------------
 drivers/md/dm-zoned-metadata.c      | 18 +++++----------
 drivers/nvme/target/io-cmd-bdev.c   |  9 +++-----
 drivers/target/target_core_iblock.c |  5 ++---
 fs/block_dev.c                      |  6 ++---
 fs/buffer.c                         | 16 ++++++--------
 fs/crypto/bio.c                     |  5 ++---
 fs/direct-io.c                      |  6 ++---
 fs/hfsplus/wrapper.c                |  5 +----
 fs/iomap/buffered-io.c              | 12 +++++-----
 fs/iomap/direct-io.c                | 11 ++++------
 fs/jfs/jfs_logmgr.c                 | 13 ++++-------
 fs/jfs/jfs_metapage.c               | 15 +++++--------
 fs/mpage.c                          | 18 +++++----------
 fs/nilfs2/segbuf.c                  | 10 ++-------
 fs/ocfs2/cluster/heartbeat.c        |  6 ++---
 fs/xfs/xfs_bio_io.c                 |  7 ++----
 fs/xfs/xfs_buf.c                    |  6 ++---
 fs/zonefs/super.c                   |  6 ++---
 include/linux/bio.h                 | 25 +++++++++++++++++++++
 kernel/power/swap.c                 |  7 +++---
 mm/page_io.c                        | 30 +++++++++++++------------
 28 files changed, 151 insertions(+), 195 deletions(-)

-- 
2.22.1

