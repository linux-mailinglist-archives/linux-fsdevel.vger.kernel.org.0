Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB6C28F388
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 15:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgJONmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 09:42:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:46650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgJONmP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:42:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04E6FB1A9;
        Thu, 15 Oct 2020 13:42:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A63DE1E133C; Thu, 15 Oct 2020 15:42:13 +0200 (CEST)
Date:   Thu, 15 Oct 2020 15:42:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [GIT PULL] Fix unaligned direct IO read past EOF for 5.10-rc1
Message-ID: <20201015134213.GH7037@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git dio_for_v5.10-rc1

to get a fix of unaligned direct IO read past EOF in legacy DIO code.
Somehow Gabriel wasn't able to catch Al's attention to pick up the series
and I didn't see a point in this languishing any further so I've just
picked up the series to my tree.

Top of the tree is 41b21af388f9. The full shortlog is:

Gabriel Krisman Bertazi (3):
      direct-io: clean up error paths of do_blockdev_direct_IO
      direct-io: don't force writeback for reads beyond EOF
      direct-io: defer alignment check until after the EOF check

The diffstat is

 fs/direct-io.c | 69 +++++++++++++++++++++++++---------------------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
