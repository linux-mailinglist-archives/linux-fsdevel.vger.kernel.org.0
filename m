Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3C649770
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 01:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiLLAjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 19:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiLLAje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 19:39:34 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02229F49;
        Sun, 11 Dec 2022 16:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qm0mFnlyJOAlXiyB+isl1PMFIu7if3LnNLFWM+HFydA=; b=lHIQSixMLwxR2Nua76sGJSIdTy
        Vf3wPnjb1Tsr8WPZ+VviEO0fcrECKo/ttdHALYa1DvqAymdABTj1cwAn7WMFyCOlifoerIHq8tMJn
        6jMO0UiJMIZVpU6GjoS7/OzxH8b3/xlkJp5KMLf7Y6UPFz/+v1PcSf0NY3RUvb29//CnmrHmqCCuU
        VuO6IP4IRhnAOaZkRBxlasnWAgAzHNzuzyesclVONAheUiCnnQoK+p0S38bg+2cxfi/wYspvdFS6z
        U8rNQy0sl9/5cVRG1Y2DFutJPkTc2z7WCZGdb8JJZRWk6JeamHlMeI+FF5jIUGxOtkHLAlqVv/VIw
        QwHkJ0Pw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4Wqy-00B8AW-1M;
        Mon, 12 Dec 2022 00:39:32 +0000
Date:   Mon, 12 Dec 2022 00:39:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git misc pile
Message-ID: <Y5Z4RCCOiu1OrmS2@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The last commit in there (sysvfs very belated fix) had been there only
since Friday, but it's a really obvious fix - the bug had been introduced
in minixfs and sysvfs in 2002, minixfs got caught and fixed 2 years later
and sysvfs one got missed.  Fix is the same one-liner.  Up to you...

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

for you to fetch changes up to e0c49bd2b4d3cd1751491eb2d940bce968ac65e9:

  fs: sysv: Fix sysv_nblocks() returns wrong value (2022-12-10 14:13:37 -0500)

----------------------------------------------------------------
misc pile

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Chen Zhongjin (1):
      fs: sysv: Fix sysv_nblocks() returns wrong value

Christoph Hellwig (1):
      fs: simplify vfs_get_super

Jeff Layton (1):
      fs: drop useless condition from inode_needs_update_time

Zhen Lei (2):
      btrfs: replace INT_LIMIT(loff_t) with OFFSET_MAX
      get rid of INT_LIMIT, use type_max() instead

 Documentation/filesystems/mount_api.rst | 11 ------
 fs/btrfs/ordered-data.c                 |  6 ++--
 fs/inode.c                              |  3 --
 fs/super.c                              | 60 +++++----------------------------
 fs/sysv/itree.c                         |  2 +-
 include/linux/fs.h                      |  5 ++-
 include/linux/fs_context.h              | 14 --------
 7 files changed, 15 insertions(+), 86 deletions(-)
