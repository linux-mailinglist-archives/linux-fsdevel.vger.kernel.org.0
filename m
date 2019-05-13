Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9941BAE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 18:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfEMQVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 12:21:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:33098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728579AbfEMQVP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 12:21:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAF3DAD5E;
        Mon, 13 May 2019 16:21:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 309411E3E10; Mon, 13 May 2019 18:21:14 +0200 (CEST)
Date:   Mon, 13 May 2019 18:21:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for v5.2-rc1
Message-ID: <20190513162114.GC13297@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.2-rc1

to get two fsnotify fixes. Note that there's a conflict with:
230c6402b1b3 ovl_lookup_real_one(): don't bother with strlen()
25b229dff4ff fsnotify(): switch to passing const struct qstr * for file_name

which you've already merged where one of the moved lines got updated by
these commits. I've pushed out suggested resolution to
fsnotify_testmerge_5.2-rc1.

Top of the tree is 4d8e7055a405. The full shortlog is:

Amir Goldstein (1):
      fsnotify: fix unlink performance regression

Jan Kara (1):
      fsnotify: Clarify connector assignment in fsnotify_add_mark_list()

The diffstat is

 fs/notify/fsnotify.c             | 41 ++++++++++++++++++++++++++++++++++++++++
 fs/notify/mark.c                 |  5 +++++
 include/linux/fsnotify.h         | 33 --------------------------------
 include/linux/fsnotify_backend.h |  4 ++++
 4 files changed, 50 insertions(+), 33 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
