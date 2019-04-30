Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F6101F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfD3Vlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 17:41:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:57870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbfD3Vlw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 17:41:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B94AAAD2B;
        Tue, 30 Apr 2019 21:41:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BA22C1E3BEC; Tue, 30 Apr 2019 23:41:49 +0200 (CEST)
Date:   Tue, 30 Apr 2019 23:41:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify fix for v5.1-rc8
Message-ID: <20190430214149.GA482@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.1-rc8

to get a fix of user trigerable NULL pointer dereference syzbot has
recently spotted. The problem has been introduced in rc1 so no CC stable is
needed.

Top of the tree is b1da6a51871c. The full shortlog is:

Jan Kara (1):
      fsnotify: Fix NULL ptr deref in fanotify_get_fsid()

The diffstat is

 fs/notify/fanotify/fanotify.c | 14 ++++++++++++--
 fs/notify/mark.c              | 12 ++++++------
 2 files changed, 18 insertions(+), 8 deletions(-)

Also I'm sorry but the tag is not signed as I'm at LSF/MM this week and
forgot my Yubikey at home...

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
