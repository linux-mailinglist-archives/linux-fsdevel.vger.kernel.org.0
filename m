Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964DD2DD037
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 12:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgLQLQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 06:16:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:56200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgLQLQ2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 06:16:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01C5EAC7F;
        Thu, 17 Dec 2020 11:15:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 78D201E135E; Thu, 17 Dec 2020 12:15:45 +0100 (CET)
Date:   Thu, 17 Dec 2020 12:15:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify fixes and improvements for 5.11-rc1
Message-ID: <20201217111545.GC6989@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.11-rc1

to get a few fsnotify fixes from Amir fixing fallout from big fsnotify
overhaul a few months back and an improvement of defaults limiting maximum
number of inotify watches from Waiman.

Top of the tree is fecc4559780d. The full shortlog is:

Amir Goldstein (3):
      fsnotify: generalize handle_inode_event()
      inotify: convert to handle_inode_event() interface
      fsnotify: fix events reported to watching parent and child

Waiman Long (1):
      inotify: Increase default inotify.max_user_watches limit to 1048576

The diffstat is

 fs/nfsd/filecache.c                  |   2 +-
 fs/notify/dnotify/dnotify.c          |   2 +-
 fs/notify/fanotify/fanotify.c        |   7 +--
 fs/notify/fsnotify.c                 | 107 +++++++++++++++++++++++------------
 fs/notify/inotify/inotify.h          |   9 ++-
 fs/notify/inotify/inotify_fsnotify.c |  51 +++--------------
 fs/notify/inotify/inotify_user.c     |  31 +++++++---
 include/linux/fsnotify_backend.h     |   9 +--
 kernel/audit_fsnotify.c              |   2 +-
 kernel/audit_tree.c                  |   2 +-
 kernel/audit_watch.c                 |   2 +-
 11 files changed, 120 insertions(+), 104 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
