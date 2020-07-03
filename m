Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1166214148
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGCVuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 17:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGCVuC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:50:02 -0400
Subject: Re: [GIT PULL] xfs: bug fixes for 5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593813002;
        bh=rCqCzu1hyIfBaoXU31J+y+i0oxUzy6aFNpuCl9XfkgY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yUeQmf5OFBCYAtxIGlHCBbzqhNM78ec9GoFUYBNYsYpNaDh74IOELiGkXNvnj59Z6
         0pNC3wF1rOoEWiOAc2aAsVk+De6WjwhhkaPYqHTSeE6TKDXVJNwIjJ2gJ7EJ93eiDf
         dkshn7/rjD/n57fk7ueaOMp/fqI8V8aFvf4rHezk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200703213158.GF7606@magnolia>
References: <20200703213158.GF7606@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200703213158.GF7606@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.8-fixes-1
X-PR-Tracked-Commit-Id: c7f87f3984cfa1e6d32806a715f35c5947ad9c09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c7d7d1fada70420851b63f2e2669cb4976a303b
Message-Id: <159381300236.15691.2599518654703891649.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 21:50:02 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 3 Jul 2020 14:31:58 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.8-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c7d7d1fada70420851b63f2e2669cb4976a303b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
