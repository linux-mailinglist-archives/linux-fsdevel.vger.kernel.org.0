Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843771EE48F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 14:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgFDMkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 08:40:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:55236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgFDMkK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:40:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A301AF7A;
        Thu,  4 Jun 2020 12:40:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4F7A11E1281; Thu,  4 Jun 2020 14:40:08 +0200 (CEST)
Date:   Thu, 4 Jun 2020 14:40:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for 5.8-rc1
Message-ID: <20200604124008.GA2225@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.8-rc1

To get several smaller fixes and cleanups for fsnotify subsystem.

Top of the tree is 2f02fd3fa13e. The full shortlog is:

Amir Goldstein (1):
      fanotify: fix ignore mask logic for events on child and on dir

Fabian Frederick (5):
      fanotify: prefix should_merge()
      fsnotify: add mutex destroy
      fanotify: remove reference to fill_event_metadata()
      fsnotify: Remove proc_fs.h include
      fanotify: don't write with size under sizeof(response)

Gustavo A. R. Silva (1):
      fanotify: Replace zero-length array with flexible-array

Jules Irenge (1):
      fsnotify: Add missing annotation for fsnotify_finish_user_wait() and for fsnotify_prepare_user_wait()

youngjun (1):
      inotify: Fix error return code assignment flow.

The diffstat is

 fs/notify/fanotify/fanotify.c      | 9 ++++++---
 fs/notify/fanotify/fanotify.h      | 2 +-
 fs/notify/fanotify/fanotify_user.c | 8 +++++---
 fs/notify/fdinfo.c                 | 1 -
 fs/notify/group.c                  | 1 +
 fs/notify/inotify/inotify_user.c   | 4 +---
 fs/notify/mark.c                   | 6 +++++-
 7 files changed, 19 insertions(+), 12 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
