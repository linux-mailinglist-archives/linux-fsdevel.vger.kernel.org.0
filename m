Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB812DD04E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 12:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgLQL0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 06:26:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:35048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgLQL0L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 06:26:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 113CFAC7F;
        Thu, 17 Dec 2020 11:25:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CB5D31E135E; Thu, 17 Dec 2020 12:25:29 +0100 (CET)
Date:   Thu, 17 Dec 2020 12:25:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext2, reiserfs, quota and writeback fixes and cleanups
 for 5.11-rc1
Message-ID: <20201217112529.GD6989@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.11-rc1

The pull contains:
* couple of quota fixes (mostly for problems found by syzbot)
* several ext2 cleanups
* one fix for reiserfs crash on corrupted image
* a fix for spurious warning in writeback code

Top of the tree is f7387170339a. The full shortlog is:

Anant Thazhemadam (1):
      fs: quota: fix array-index-out-of-bounds bug by passing correct argument to vfs_cleanup_quota_inode()

Christoph Hellwig (1):
      writeback: don't warn on an unregistered BDI in __mark_inode_dirty

Gustavo A. R. Silva (1):
      ext2: Fix fall-through warnings for Clang

Ira Weiny (1):
      fs/ext2: Use ext2_put_page

Jan Kara (2):
      quota: Don't overflow quota file offsets
      quota: Sanity-check quota file headers on load

Jonathan Neuschäfer (1):
      docs: filesystems: Reduce ext2.rst to one top-level heading

Roman Anufriev (1):
      fs/quota: update quota state flags scheme with project quota flags

Rustam Kovhaev (1):
      reiserfs: add check for an invalid ih_entry_count

Xianting Tian (1):
      ext2: Remove unnecessary blank

The diffstat is

 Documentation/filesystems/ext2.rst |  1 +
 fs/ext2/dir.c                      | 14 ++++++++------
 fs/ext2/ext2.h                     |  7 +++++++
 fs/ext2/inode.c                    |  1 +
 fs/ext2/namei.c                    | 15 +++++----------
 fs/ext2/super.c                    |  2 +-
 fs/fs-writeback.c                  |  4 ----
 fs/quota/dquot.c                   |  2 +-
 fs/quota/quota_tree.c              |  8 ++++----
 fs/quota/quota_v2.c                | 19 +++++++++++++++++++
 fs/reiserfs/stree.c                |  6 ++++++
 include/linux/quota.h              | 15 ++++++++-------
 12 files changed, 61 insertions(+), 33 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
