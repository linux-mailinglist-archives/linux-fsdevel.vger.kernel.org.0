Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DDA142615
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 09:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgATIq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 03:46:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:47118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgATIq7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:46:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AAEF5B027;
        Mon, 20 Jan 2020 08:46:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E99CA1E0CF1; Mon, 20 Jan 2020 09:46:52 +0100 (CET)
Date:   Mon, 20 Jan 2020 09:46:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Reiserfs fix for v5.5-rc8
Message-ID: <20200120084652.GA19861@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.5-rc8

to get a fixup of a recently merged reiserfs fix which has caused problem
when xattrs were not compiled in.

Top of the tree is 394440d46941. The full shortlog is:

Jeff Mahoney (1):
      reiserfs: fix handling of -EOPNOTSUPP in reiserfs_for_each_xattr

The diffstat is

 fs/reiserfs/xattr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

							Thanks
								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
