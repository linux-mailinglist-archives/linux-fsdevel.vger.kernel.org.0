Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0F321976
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 14:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhBVNyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 08:54:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:47592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhBVNyD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:54:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD4D1AD29;
        Mon, 22 Feb 2021 13:53:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A153D1E14ED; Mon, 22 Feb 2021 14:53:22 +0100 (CET)
Date:   Mon, 22 Feb 2021 14:53:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Isofs, udf, and quota changes for v5.12-rc1
Message-ID: <20210222135322.GG19630@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.12-rc1

to get several udf, isofs, and quota fixes.

Top of the tree is b9bffa10b267. The full shortlog is:

BingJing Chang (4):
      parser: add unsigned int parser
      isofs: handle large user and group ID
      udf: handle large user and group ID
      parser: Fix kernel-doc markups

Jan Kara (1):
      quota: Fix memory leak when handling corrupted quota file

Pan Bian (1):
      isofs: release buffer head before return

Steven J. Magnani (1):
      udf: fix silent AED tagLocation corruption

The diffstat is

 fs/isofs/dir.c         |  1 +
 fs/isofs/inode.c       |  9 +++++----
 fs/isofs/namei.c       |  1 +
 fs/quota/quota_v2.c    | 11 ++++++++---
 fs/udf/inode.c         |  9 ++++++---
 fs/udf/super.c         |  9 +++++----
 include/linux/parser.h |  1 +
 lib/parser.c           | 44 +++++++++++++++++++++++++++++++++-----------
 8 files changed, 60 insertions(+), 25 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
