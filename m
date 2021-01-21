Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7482FEB77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 14:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbhAUNTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:19:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:41218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbhAUNSl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:18:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17113B7B2;
        Thu, 21 Jan 2021 13:18:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C919A1E07FD; Thu, 21 Jan 2021 14:17:59 +0100 (CET)
Date:   Thu, 21 Jan 2021 14:17:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fs & udf fixes for v5.11-rc5
Message-ID: <20210121131759.GE24063@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.11-rc5

to get a lazytime handling fix from Eric Biggers and a fix of UDF session
handling for large devices. This is fixed up version of the broken pull
from last Friday.

Top of the tree is 5cdc4a6950a8. The full shortlog is:

Eric Biggers (1):
      fs: fix lazytime expiration handling in __writeback_single_inode()

lianzhi chang (1):
      udf: fix the problem that the disc content is not displayed

The diffstat is

 fs/fs-writeback.c | 24 +++++++++++++-----------
 fs/udf/super.c    |  7 ++++---
 2 files changed, 17 insertions(+), 14 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
