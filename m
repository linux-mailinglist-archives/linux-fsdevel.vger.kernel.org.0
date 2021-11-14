Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79C444F9C4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Nov 2021 18:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhKNR0F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 12:26:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhKNR0E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 12:26:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD91360EB9;
        Sun, 14 Nov 2021 17:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636910589;
        bh=kQGuEYYiOrRDCpWGkbcW29M7DIXgWvDHAW/+sLNn9Zg=;
        h=Date:From:To:Cc:Subject:From;
        b=iP8xLB2t39R2aDC+1F5dTodDZIrWS3fPOXzdbtdNjHq96OqzUqgXOAjXM7eMpmHQ5
         eg6YS8+pBf7hBq/OpAz9RHQgHzJcrJUC7CBRBl8IxdGfAzsHjpF7PJzJ8n+L+oZSoU
         cfTFKsBvbLAI0rrU/iWmx2Ej2ylqu1MQtljWj1IWkmFfFdLVrwR3/+4G61Yia6XXNn
         EET3HAsKkdb3x0mjT7Ob+7iWvo6nt4ZJw1aE5uE5XCe+bKf9kG6FGIyWVx11mc/alu
         xCCIvklQwayx4aByHY0amqw5ZJfmjA1m2oO58o+27HuRaNz4xGo9f/HndQfoLi4wLz
         ScfzdU+3PnBxQ==
Date:   Sun, 14 Nov 2021 09:23:09 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: cleanups and resyncs for 5.16
Message-ID: <20211114172309.GE24307@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing a handful of code cleanups for 5.16.

The most "exciting" aspect of this branch is that the xfsprogs
maintainer and I have worked through the last of the code discrepancies
between kernel and userspace libxfs such that there are no code
differences between the two except for #includes.  IOWs, diff suffices
to demonstrate that the userspace tools behave the same as the kernel,
and kernel-only bits are clearly marked in the /kernel/ source code
instead of just the userspace source.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit 2a09b575074ff3ed23907b6f6f3da87af41f592b:

  xfs: use swap() to make code cleaner (2021-10-30 09:28:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-merge-5

for you to fetch changes up to 4a6b35b3b3f28df81fea931dc77c4c229cbdb5b2:

  xfs: sync xfs_btree_split macros with userspace libxfs (2021-11-11 09:13:39 -0800)

----------------------------------------------------------------
Minor tweaks for 5.16:
 * Clean up open-coded swap() calls.
 * A little bit of #ifdef golf to complete the reunification of the
   kernel and userspace libxfs source code.

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: sync xfs_btree_split macros with userspace libxfs

Eric Sandeen (1):
      xfs: #ifdef out perag code for userspace

Yang Guang (1):
      xfs: use swap() to make dabtree code cleaner

 fs/xfs/libxfs/xfs_ag.c       | 2 ++
 fs/xfs/libxfs/xfs_ag.h       | 8 +++++---
 fs/xfs/libxfs/xfs_btree.c    | 4 ++++
 fs/xfs/libxfs/xfs_da_btree.c | 5 +----
 4 files changed, 12 insertions(+), 7 deletions(-)
