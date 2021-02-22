Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FAF3216A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 13:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBVM1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 07:27:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:45018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230389AbhBVM1i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:27:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFA42ACCF;
        Mon, 22 Feb 2021 12:26:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 887FF1E14ED; Mon, 22 Feb 2021 13:26:56 +0100 (CET)
Date:   Mon, 22 Feb 2021 13:26:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for 5.12-rc1
Message-ID: <20210222122656.GF19630@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.12-rc1

to get patch making inotify groups being charged against appropriate memcgs.

Top of the tree is ac7b79fd190b. The full shortlog is:

Shakeel Butt (1):
      inotify, memcg: account inotify instances to kmemcg

The diffstat is

 fs/notify/fanotify/fanotify_user.c |  2 +-
 fs/notify/group.c                  | 25 ++++++++++++++++++++-----
 fs/notify/inotify/inotify_user.c   |  4 ++--
 include/linux/fsnotify_backend.h   |  1 +
 4 files changed, 24 insertions(+), 8 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
