Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD2436BD93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 04:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhD0C6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 22:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhD0C6s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:58:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12E3161164;
        Tue, 27 Apr 2021 02:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619492286;
        bh=3qWguJjdxw8GVGrlsfYMrWCs+lS583gXPbRcSFuaFxg=;
        h=Date:From:To:Cc:Subject:From;
        b=VCd6gBbcWjUjyRq3Smizb884XSr3hrWieN3sN3XflArzHRQbRwuFS0EDVjrzVLDMF
         RPX+yrMtPtc5MaGfvSNAbhjLz42X6txozYCeOQW+bXa4o2laCIs9CafDwLYqJtGS1t
         FDSEvhRssolI9C/1qJkLdq54sb9jenJyA1MQfoLAmUSWl+F5zuwqwiXRjVab0ijp5o
         SZLp5v+g+LCuJ9rqF5tFyVBOlp2CaGfTORMpxw5CpcGXF5z2Mrrv1Pr1BwPTFhLLty
         39da7iBD4DXcIJaU74/kFQC2Ro6XIy0FJTQPQCx6uTcepFtBsrcAlfowEVRhcqICM6
         4uZPintkW/vLA==
Date:   Mon, 26 Apr 2021 19:58:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] iomap: new code for 5.13-rc1
Message-ID: <20210427025805.GD3122264@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this single patch to the iomap code for 5.13-rc1, which
augments what gets logged when someone tries to swapon an unacceptable
swap file.  (Yes, this is a continuation of the swapfile drama from last
season...)

The branch merges cleanly with upstream as of a few minutes ago and has
been soaking in for-next for weeks without complaints.  Please let me
know if there are any strange problems.  I anticipate there will be a
second patch next week to remove some (AFAICT) unused struct fields to
reduce memory usage.

--D

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.13-merge-2

for you to fetch changes up to ad89b66cbad18ca146cbc75f64706d4ca6635973:

  iomap: improve the warnings from iomap_swapfile_activate (2021-03-26 10:55:40 -0700)

----------------------------------------------------------------
New code for 5.13:
- When a swap file is rejected, actually log the /name/ of the swapfile.

----------------------------------------------------------------
Christoph Hellwig (1):
      iomap: improve the warnings from iomap_swapfile_activate

 fs/iomap/swapfile.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)
