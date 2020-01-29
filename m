Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401C214CC71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 15:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgA2O27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 09:28:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38182 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgA2O27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:28:59 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwoKv-004L1o-Uq; Wed, 29 Jan 2020 14:28:58 +0000
Date:   Wed, 29 Jan 2020 14:28:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] adfs series
Message-ID: <20200129142857.GY23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	adfs stuff for this cycle

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.adfs

for you to fetch changes up to 587065dcac64e88132803cdb0a7f26bb4a79cf46:

  fs/adfs: bigdir: Fix an error code in adfs_fplus_read() (2020-01-25 11:31:59 -0500)

----------------------------------------------------------------
Dan Carpenter (1):
      fs/adfs: bigdir: Fix an error code in adfs_fplus_read()

Russell King (41):
      fs/adfs: inode: update timestamps to centisecond precision
      fs/adfs: inode: fix adfs_mode2atts()
      fs/adfs: map: move map reading and validation to map.c
      fs/adfs: map: rename adfs_map_free() to adfs_map_statfs()
      fs/adfs: map: break up adfs_read_map()
      fs/adfs: map: factor out map cleanup
      fs/adfs: map: incorporate map offsets into layout
      fs/adfs: map: use find_next_bit_le() rather than open coding it
      fs/adfs: map: move map-specific sb initialisation to map.c
      fs/adfs: map: fix map scanning
      fs/adfs: dir: rename bh_fplus to bhs
      fs/adfs: dir: add common dir object initialisation
      fs/adfs: dir: add common directory buffer release method
      fs/adfs: dir: add common directory sync method
      fs/adfs: dir: add generic copy functions
      fs/adfs: dir: add generic directory reading
      fs/adfs: dir: add helper to read directory using inode
      fs/adfs: dir: add helper to mark directory buffers dirty
      fs/adfs: dir: update directory locking
      fs/adfs: dir: modernise on-disk directory structures
      fs/adfs: dir: improve update failure handling
      fs/adfs: dir: improve compiler coverage in adfs_dir_update
      fs/adfs: dir: switch to iterate_shared method
      fs/adfs: dir: add more efficient iterate() per-format method
      fs/adfs: dir: use pointers to access directory head/tails
      fs/adfs: newdir: factor out directory format validation
      fs/adfs: newdir: improve directory validation
      fs/adfs: newdir: merge adfs_dir_read() into adfs_f_read()
      fs/adfs: newdir: clean up adfs_f_update()
      fs/adfs: newdir: split out directory commit from update
      fs/adfs: bigdir: factor out directory entry offset calculation
      fs/adfs: bigdir: extract directory validation
      fs/adfs: bigdir: directory validation strengthening
      fs/adfs: bigdir: calculate and validate directory checkbyte
      fs/adfs: bigdir: implement directory update support
      fs/adfs: super: fix inode dropping
      fs/adfs: dir: remove debug in adfs_dir_update()
      fs/adfs: super: extract filesystem block probe
      fs/adfs: super: add support for E and E+ floppy image formats
      fs/adfs: mostly divorse inode number from indirect disc address
      Documentation: update adfs filesystem documentation

 Documentation/filesystems/adfs.txt |  24 +++
 fs/adfs/adfs.h                     |  32 ++--
 fs/adfs/dir.c                      | 314 +++++++++++++++++++++++++--------
 fs/adfs/dir_f.c                    | 302 +++++++++-----------------------
 fs/adfs/dir_f.h                    |  52 +++---
 fs/adfs/dir_fplus.c                | 346 +++++++++++++++++++++----------------
 fs/adfs/dir_fplus.h                |   6 +-
 fs/adfs/inode.c                    |  64 +++----
 fs/adfs/map.c                      | 247 +++++++++++++++++++-------
 fs/adfs/super.c                    | 267 ++++++++++------------------
 10 files changed, 914 insertions(+), 740 deletions(-)
