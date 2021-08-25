Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998EE3F75BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbhHYNU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 09:20:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56896 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbhHYNU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:20:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DF6C5221D1;
        Wed, 25 Aug 2021 13:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629897581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BHE3PMOHPoYmNlJ805SfAY9yMeZ2MCWpkSFto0h5vvo=;
        b=PyOSbIbn4fxHeNVJIcycP+FwwchsdKnR1qI8YPMINJWVPBYxdo7HD/H6TR8LtvmhqT5R1w
        FfrhXdFXkistUgBSVYMaG3KwewG0esVLj0+w8Kg+muwy24EWb4l8tCK/gzk+z852pyICcv
        xagyZm4R3iMW4sW5mDrYH4rE3LqFGVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629897581;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BHE3PMOHPoYmNlJ805SfAY9yMeZ2MCWpkSFto0h5vvo=;
        b=1Bvv3E0UMMI009llMtXPoSNEeC2RSl9BQHfLfzdc+t8K5foiyudZEWIA+KQMHbG8F1+z2a
        j1l2BlxC16wp9fAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id CC520A3B8E;
        Wed, 25 Aug 2021 13:19:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AA8D11F2BA4; Wed, 25 Aug 2021 15:19:41 +0200 (CEST)
Date:   Wed, 25 Aug 2021 15:19:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] UDF and isofs fixes and cleanups for 5.15-rc1
Message-ID: <20210825131941.GG14620@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  another early pull request for the merge window. Could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.15-rc1

to get several smaller fixes and cleanups in UDF and isofs.

Top of the tree is 58bc6d1be2f3. The full shortlog is:

Jan Kara (4):
      udf: Check LVID earlier
      udf: Remove unused declaration
      udf: Get rid of 0-length arrays
      udf: Get rid of 0-length arrays in struct fileIdentDesc

Pali Rohár (2):
      udf: Fix iocharset=utf8 mount option
      isofs: joliet: Fix iocharset=utf8 mount option

Stian Skjelstad (1):
      udf_get_extendedattr() had no boundary checks.

The diffstat is

 fs/isofs/inode.c  | 27 ++++++++++----------
 fs/isofs/isofs.h  |  1 -
 fs/isofs/joliet.c |  4 +--
 fs/udf/dir.c      |  5 ++--
 fs/udf/ecma_167.h | 44 ++++++++++++++++----------------
 fs/udf/inode.c    |  3 +--
 fs/udf/misc.c     | 13 ++++++++--
 fs/udf/namei.c    | 13 +++++-----
 fs/udf/osta_udf.h | 22 +++++-----------
 fs/udf/super.c    | 75 ++++++++++++++++++++++++++-----------------------------
 fs/udf/udf_sb.h   |  2 --
 fs/udf/udfdecl.h  |  4 +++
 fs/udf/unicode.c  |  4 +--
 13 files changed, 103 insertions(+), 114 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
