Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9963255D48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgH1PD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 11:03:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:37720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgH1PD4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:03:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B11D4AF1F;
        Fri, 28 Aug 2020 15:04:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9CDDB1E12C0; Fri, 28 Aug 2020 17:03:55 +0200 (CEST)
Date:   Fri, 28 Aug 2020 17:03:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Writeback fixes for 5.9-rc3
Message-ID: <20200828150355.GA4614@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git writeback_for_v5.9-rc3

to get fixes for writeback code occasionally skipping writeback of some
inodes or livelocking sync(2).

Top of the tree is 5fcd57505c00. The full shortlog is:

Jan Kara (4):
      writeback: Protect inode->i_io_list with inode->i_lock
      writeback: Avoid skipping inode writeback
      writeback: Fix sync livelock due to b_dirty_time processing
      writeback: Drop I_DIRTY_TIME_EXPIRE

The diffstat is

 fs/ext4/inode.c                  |   2 +-
 fs/fs-writeback.c                | 103 ++++++++++++++++++++-------------------
 fs/xfs/libxfs/xfs_trans_inode.c  |   4 +-
 include/linux/fs.h               |   7 ++-
 include/trace/events/writeback.h |  14 +++---
 5 files changed, 67 insertions(+), 63 deletions(-)

							Thanks


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
