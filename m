Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C82863354
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 11:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfGIJQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 05:16:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:37564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfGIJQp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 05:16:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D7C6B125;
        Tue,  9 Jul 2019 09:16:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 81D6B1E4338; Tue,  9 Jul 2019 11:16:43 +0200 (CEST)
Date:   Tue, 9 Jul 2019 11:16:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for v5.3-rc1
Message-ID: <20190709091643.GA5903@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.3-rc1

The pull contains a cleanups of fsnotify name removal hook and also a patch
to disable fanotify permission events for 'proc' filesystem.

Top of the tree is 7377f5bec133. The full shortlog is:

Amir Goldstein (10):
      fsnotify: add empty fsnotify_{unlink,rmdir}() hooks
      btrfs: call fsnotify_rmdir() hook
      rpc_pipefs: call fsnotify_{unlink,rmdir}() hooks
      tracefs: call fsnotify_{unlink,rmdir}() hooks
      devpts: call fsnotify_unlink() hook
      debugfs: simplify __debugfs_remove_file()
      debugfs: call fsnotify_{unlink,rmdir}() hooks
      configfs: call fsnotify_rmdir() hook
      fsnotify: move fsnotify_nameremove() hook out of d_delete()
      fsnotify: get rid of fsnotify_nameremove()

Jan Kara (1):
      fanotify: Disallow permission events for proc filesystem

The diffstat is

 fs/afs/dir_silly.c                 |  5 -----
 fs/btrfs/ioctl.c                   |  4 +++-
 fs/configfs/dir.c                  |  3 +++
 fs/dcache.c                        |  2 --
 fs/debugfs/inode.c                 | 21 ++++++++++---------
 fs/devpts/inode.c                  |  1 +
 fs/namei.c                         |  2 ++
 fs/nfs/unlink.c                    |  6 ------
 fs/notify/fanotify/fanotify_user.c | 22 ++++++++++++++++++++
 fs/notify/fsnotify.c               | 41 --------------------------------------
 fs/proc/root.c                     |  2 +-
 fs/tracefs/inode.c                 |  3 +++
 include/linux/fs.h                 |  1 +
 include/linux/fsnotify.h           | 26 ++++++++++++++++++++++++
 include/linux/fsnotify_backend.h   |  4 ----
 net/sunrpc/rpc_pipe.c              |  4 ++++
 16 files changed, 76 insertions(+), 71 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
