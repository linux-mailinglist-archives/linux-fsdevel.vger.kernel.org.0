Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A354320CCA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhBUSlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 13:41:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhBUSlE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:41:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9FE6C64F04;
        Sun, 21 Feb 2021 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932783;
        bh=ExY7nMX+kg5cIN1bkc58jHVWbsM7wSFpFLshZoRf7Hk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EfWE7MhqVXzQ6BBnQ/+/+b5S5csaQuAb1Cn63lHYtsT6fIuKAW57lxepBEqk0NOI2
         7/IHtpTDVhokHt6ESrf02D5qXjxPlZDZai9gB9XLiEiEEwtWyhD+P3rslD8/YVuFAF
         6wAYUfR6iVfionXDXzYkmebaGsvNZJgo6TbT7IVeFV+UvRU41pfpA9TbLPVGW8lFpx
         1A0nIqXRfm8BxZqn89tvaE5OwOmvCzUUUDlgdFkDU3o2Pu7Tdf3Cem709zc/ZFL2vq
         EB0Ah/M4oMuSIecoSOCj4WUnIPGTTHyud/gypTpK81R1lApitkaJiwya9SBB+bXaAo
         vNt9mO3iCRRKA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9B1F460191;
        Sun, 21 Feb 2021 18:39:43 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: new code for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210219033302.GY7193@magnolia>
References: <20210219033302.GY7193@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210219033302.GY7193@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.12-merge-2
X-PR-Tracked-Commit-Id: ed1128c2d0c87e5ff49c40f5529f06bc35f4251b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f016a316f2243efb0d1c0e7259f07817eb99e67
Message-Id: <161393278362.20435.17293846078865363205.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:43 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, linux-btrfs@vger.kernel.org,
        naohiro.aota@wdc.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 18 Feb 2021 19:33:02 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.12-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f016a316f2243efb0d1c0e7259f07817eb99e67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
