Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346BE1F8126
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 07:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFMFlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 01:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgFMFlf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 01:41:35 -0400
Received: from localhost (unknown [148.87.23.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5915B20739;
        Sat, 13 Jun 2020 05:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592026894;
        bh=ai2IRoP3IJBb3/30meNB0Re5ou7rGub0FTjCHdXopfU=;
        h=Date:From:To:Cc:Subject:From;
        b=EaqHxoZGlWcSMDBTFY+yxamT+8GpPhY3+/M/mADaNsVrHgvTHmdIKaLD/HzBViDL6
         1Mketq5SWr/tuCsc1yZHL6p+qg6T1ElWFQsMW7iGDdY9S2qvwPexaJlKRTacO6fiDg
         6v7OP6m4HV7zY6Bn10i+x5nxUenJkSjLM0fDYMHk=
Date:   Fri, 12 Jun 2020 22:41:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: bug fixes for 5.8-rc1
Message-ID: <20200613054130.GK11245@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this last merge request before -rc1.  We've settled down
into the bugfix phase; this one fixes an error bailout path.

This branch merges cleanly with master as of a few minutes ago, so
please let me know if anything strange happens.

--D

The following changes since commit 6dcde60efd946e38fac8d276a6ca47492103e856:

  xfs: more lockdep whackamole with kmem_alloc* (2020-05-27 08:49:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.8-merge-9

for you to fetch changes up to 8cc0072469723459dc6bd7beff81b2b3149f4cf4:

  xfs: Add the missed xfs_perag_put() for xfs_ifree_cluster() (2020-06-08 20:57:03 -0700)

----------------------------------------------------------------
Fixes for 5.8:
- Fix a resource leak on an error bailout.

----------------------------------------------------------------
Chuhong Yuan (1):
      xfs: Add the missed xfs_perag_put() for xfs_ifree_cluster()

 fs/xfs/xfs_inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
