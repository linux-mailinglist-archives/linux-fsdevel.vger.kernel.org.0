Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5088073F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388433AbfHCQdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 12:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387950AbfHCQdO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 12:33:14 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B1462073D;
        Sat,  3 Aug 2019 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564849993;
        bh=Zq9cTSiVMosbKCMzFpNpaoqOufJyrLHKeVK5CLX2yQQ=;
        h=Date:From:To:Cc:Subject:From;
        b=PbFAz9it4jvXL6TxJwBTB1ezowQE+Yy40kQ+9rodirjcIpgDYLCHpPTDDg8z9p/Hn
         0Bm5uZxz1iabnnbiJedczHLAilndNl8asKsFnckqWo7VsAhPzctQriEshSDBRPAWAm
         10m6xgR/PNvPBFi6z91V+SmmTupmNbJZK/mMdHyA=
Date:   Sat, 3 Aug 2019 09:33:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: cleanups for 5.3-rc3
Message-ID: <20190803163312.GK7138@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here are a couple more bug fixes that trickled in since -rc1.  It's
survived the usual xfstests runs and merges cleanly with this morning's
master.  Please let me know if anything strange happens.

--D

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.3-fixes-1

for you to fetch changes up to afa1d96d1430c2138c545fb76e6dcb21222098d4:

  xfs: Fix possible null-pointer dereferences in xchk_da_btree_block_check_sibling() (2019-07-30 11:28:20 -0700)

----------------------------------------------------------------
Changes since last update:
- Avoid leaking kernel stack contents to userspace.
- Fix a potential null pointer dereference in the dabtree scrub code.

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: fix stack contents leakage in the v1 inumber ioctls

Jia-Ju Bai (1):
      xfs: Fix possible null-pointer dereferences in xchk_da_btree_block_check_sibling()

 fs/xfs/scrub/dabtree.c | 6 +++++-
 fs/xfs/xfs_itable.c    | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)
