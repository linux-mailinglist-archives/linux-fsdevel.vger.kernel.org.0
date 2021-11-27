Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FDA46015F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 21:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbhK0ULX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 15:11:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57840 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhK0UJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 15:09:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6B3960F05;
        Sat, 27 Nov 2021 20:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFE2C53FBF;
        Sat, 27 Nov 2021 20:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638043567;
        bh=AeByrAcKKhJkicFs97CoiA4t6vzFEZxDmMuAEu1F8jE=;
        h=Date:From:To:Cc:Subject:From;
        b=CY94MyNePeku8my7+Dhp7Tvm2XLypdpYZEQl2h3wNW7LzDmqdZEzW/uBbaD7m8IV9
         PivzmFGYfF7ghwTpmFjf/jZyjnaAomlwoyJ/8WF9wQ3DPOLZJFXSUs2ljtD+l+/b7c
         RjQIRS15dkqS49dc1qbaukn0IYm+J6ZP0ejKrwKuMREMkvQd6pnA12RCFJ/ayaaFQF
         T/RBW+UOYh5OohbF/QWgmSuNCO2VwQrQKNC1IyiIlXiS0+wwyhd3Rdvpy2G7xxeT1E
         cnJm6vpSXgcBag4iRAmHhzxNBxNjIMu/fdUkOEsVdfEVXRh/TWEQGCjo84aP/dURJh
         OnBrCYWFFjOCQ==
Date:   Sat, 27 Nov 2021 12:06:06 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: bug fixes for 5.16-rc2
Message-ID: <20211127200606.GB8467@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing fixes for a resource leak and a
build robot complaint about totally dead code for 5.16-rc2.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-fixes-1

for you to fetch changes up to 1090427bf18f9835b3ccbd36edf43f2509444e27:

  xfs: remove xfs_inew_wait (2021-11-24 10:06:02 -0800)

----------------------------------------------------------------
Fixes for 5.16-rc2:
 - Fix buffer resource leak that could lead to livelock on corrupt fs.
 - Remove unused function xfs_inew_wait to shut up the build robots.

----------------------------------------------------------------
Christoph Hellwig (1):
      xfs: remove xfs_inew_wait

Yang Xu (1):
      xfs: Fix the free logic of state in xfs_attr_node_hasname

 fs/xfs/libxfs/xfs_attr.c | 27 ++++++++++++---------------
 fs/xfs/xfs_icache.c      | 21 ---------------------
 fs/xfs/xfs_inode.h       |  4 +---
 3 files changed, 13 insertions(+), 39 deletions(-)
