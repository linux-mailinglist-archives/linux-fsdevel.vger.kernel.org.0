Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648692BB675
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 21:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgKTUS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 15:18:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:47634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730046AbgKTUS4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:18:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4FEB3AC54;
        Fri, 20 Nov 2020 20:18:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D367E1E1319; Fri, 20 Nov 2020 21:18:54 +0100 (CET)
Date:   Fri, 20 Nov 2020 21:18:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fanotify fix for 5.10-rc5
Message-ID: <20201120201854.GC27360@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.10-rc5

to get an fanotify fix from Amir.

Top of the tree is 7372e79c9eb9. The full shortlog is:

Amir Goldstein (1):
      fanotify: fix logic of reporting name info with watched parent

The diffstat is

 fs/notify/fsnotify.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
