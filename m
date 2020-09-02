Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2963A25B27A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 19:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgIBRAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 13:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgIBRAU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:00:20 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCE5208B3;
        Wed,  2 Sep 2020 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599066020;
        bh=5TBnPOJmm+0HmBQ0PdJBZ3arGLJewAGOBH/ZEfVwIUo=;
        h=Date:From:To:Cc:Subject:From;
        b=e6Co5i4digpWyRfPQH8LhZkzjhwpQdGRjBJ8U4/uB+OburtVXSoIbrheLw6LqVwLZ
         BBtwG19Ln+tnpPlE93pCGqt6gsFIuq67+2oD0WdXeWmOCkiAT8O7IE8Jwrj1AgjamX
         rzOY0UyunhREWOJ5fC6XTLgjQ4QngUz/Qpx08fSY=
Date:   Wed, 2 Sep 2020 10:00:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: small fixes for 5.9
Message-ID: <20200902170019.GO6096@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull these various corruption fixes that have come in during the
past month.  The branch merges cleanly with upstream as of a few minutes
ago, so please let me know if anything strange happens.


--D
The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.9-fixes-1

for you to fetch changes up to 125eac243806e021f33a1fdea3687eccbb9f7636:

  xfs: initialize the shortform attr header padding entry (2020-08-27 08:01:31 -0700)

----------------------------------------------------------------
Fixes for 5.9:
- Avoid a log recovery failure for an insert range operation by rolling
deferred ops incrementally instead of at the end.
- Fix an off-by-one error when calculating log space reservations for
anything involving an inode allocation or free.
- Fix a broken shortform xattr verifier.
- Ensure that the shortform xattr header padding is always initialized
to zero.

----------------------------------------------------------------
Brian Foster (2):
      xfs: finish dfops on every insert range shift iteration
      xfs: fix off-by-one in inode alloc block reservation calculation

Darrick J. Wong (1):
      xfs: initialize the shortform attr header padding entry

Eric Sandeen (1):
      xfs: fix boundary test in xfs_attr_shortform_verify

 fs/xfs/libxfs/xfs_attr_leaf.c   | 8 +++++---
 fs/xfs/libxfs/xfs_ialloc.c      | 4 ++--
 fs/xfs/libxfs/xfs_trans_space.h | 2 +-
 fs/xfs/xfs_bmap_util.c          | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)
