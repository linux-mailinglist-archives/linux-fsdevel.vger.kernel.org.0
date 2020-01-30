Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF314DEDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 17:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgA3QSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 11:18:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:58686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbgA3QSd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:18:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68C10AEFF;
        Thu, 30 Jan 2020 16:18:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 193151E0D5D; Thu, 30 Jan 2020 17:18:32 +0100 (CET)
Date:   Thu, 30 Jan 2020 17:18:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] UDF, quota, reiserfs, ext2 fixes and cleanups for 5.6-rc1
Message-ID: <20200130161832.GA15601@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.6-rc1

to get a couple of assorted fixes and cleanups for udf, quota, reiserfs,
and ext2.

Top of the tree is 154a4dcfc95f. The full shortlog is:

Alex Shi (2):
      fs/quota: remove unused macro
      fs/reiserfs: remove unused macros

Arnd Bergmann (1):
      quota: avoid time_t in v1_disk_dqblk definition

Chengguang Xu (1):
      ext2: set proper errno in error case of ext2_fill_super()

Jan Kara (5):
      reiserfs: Fix memory leak of journal device string
      reiserfs: Fix spurious unlock in reiserfs_fill_super() error handling
      udf: Fix free space reporting for metadata and virtual partitions
      udf: Allow writing to 'Rewritable' partitions
      udf: Clarify meaning of f_files in udf_statfs

Nathan Chancellor (1):
      ext2: Adjust indentation in ext2_fill_super

Pali Rohár (5):
      udf: Fix spelling in EXT_NEXT_EXTENT_ALLOCDESCS
      udf: Move OSTA Identifier Suffix macros from ecma_167.h to osta_udf.h
      udf: Update header files to UDF 2.60
      udf: Fix meaning of ENTITYID_FLAGS_* macros to be really bitwise-or flags
      udf: Disallow R/W mode for disk with Metadata partition

The diffstat is

 fs/ext2/super.c       |   7 ++--
 fs/quota/quota_v2.c   |   2 -
 fs/quota/quotaio_v1.h |   6 ++-
 fs/reiserfs/journal.c |   2 -
 fs/reiserfs/procfs.c  |   1 -
 fs/reiserfs/stree.c   |   6 ---
 fs/reiserfs/super.c   |   4 +-
 fs/udf/ecma_167.h     |  46 +++++++++++++----------
 fs/udf/inode.c        |   6 +--
 fs/udf/osta_udf.h     | 100 ++++++++++++++++++++++++++++++++++----------------
 fs/udf/super.c        |  40 ++++++++++++++------
 fs/udf/truncate.c     |   2 +-
 12 files changed, 137 insertions(+), 85 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
