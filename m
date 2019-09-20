Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49348B8EC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2019 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438141AbfITLAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 07:00:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438139AbfITLAI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 07:00:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A4CEAEF6;
        Fri, 20 Sep 2019 11:00:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD7521E443E; Fri, 20 Sep 2019 13:00:17 +0200 (CEST)
Date:   Fri, 20 Sep 2019 13:00:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fanotify cleanup for v5.4-rc1
Message-ID: <20190920110017.GA25765@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.4-rc1

Top of the tree is ba38e358907e. The full shortlog is:

zhengbin (1):
      fanotify: remove always false comparison in copy_fid_to_user

The diffstat is

 fs/notify/fanotify/fanotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
