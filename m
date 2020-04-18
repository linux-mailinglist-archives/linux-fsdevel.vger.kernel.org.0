Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F2D1AF445
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 21:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgDRTaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 15:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbgDRTaD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:30:03 -0400
Subject: Re: [GIT PULL] xfs: bug fixes for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587238203;
        bh=FIbYbKgtPbI6kk7P+/BHFQ2nwoJxEtLzkBjX14kgq3g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VFGeoFr7hNGmXXBmGnsz0FS0Pt6y4CRMI3+sNlTTQzGxzUPe639QXWrenAwtPh2nk
         W6SZSgR4QOm4zdbX6tPoanhPc/JjnPccTaw3xpwoABVrLrcJhbLE1UI1hbJCbAd7r9
         B39E3P/KNmxWVfFlFsyE2P5fE2qJfBD9RYhfrFd8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200418155702.GV6742@magnolia>
References: <20200418155702.GV6742@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200418155702.GV6742@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.7-fixes-3
X-PR-Tracked-Commit-Id: f0f7a674d4df1510d8ca050a669e1420cf7d7fab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0d73a868d9b411bd2d0c8e5ff9d98bfa8563cb1
Message-Id: <158723820312.11589.16029241664602724505.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Apr 2020 19:30:03 +0000
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

The pull request you sent on Sat, 18 Apr 2020 08:57:02 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.7-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0d73a868d9b411bd2d0c8e5ff9d98bfa8563cb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
