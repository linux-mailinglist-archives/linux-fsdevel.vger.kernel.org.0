Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54A19F4B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgDFLhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 07:37:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:54706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgDFLhF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:37:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 47DD0AE2D;
        Mon,  6 Apr 2020 11:37:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 445371E1244; Mon,  6 Apr 2020 13:37:03 +0200 (CEST)
Date:   Mon, 6 Apr 2020 13:37:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext2 and udf cleanups and fixes for v5.7-rc1
Message-ID: <20200406113703.GE1143@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.7-rc1

to get a new cleanups and fixes for ext2 and one cleanup for udf.

Top of the tree is 44a52022e7f1. The full shortlog is:

Gustavo A. R. Silva (2):
      ext2: xattr.h: Replace zero-length array with flexible-array member
      udf: udf_sb.h: Replace zero-length array with flexible-array member

Jan Kara (2):
      ext2: Silence lockdep warning about reclaim under xattr_sem
      ext2: fix debug reference to ext2_xattr_cache

Randy Dunlap (1):
      ext2: fix empty body warnings when -Wextra is used

The diffstat is

 fs/ext2/xattr.c | 18 +++++++++++++-----
 fs/ext2/xattr.h |  2 +-
 fs/udf/udf_sb.h |  2 +-
 3 files changed, 15 insertions(+), 7 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
