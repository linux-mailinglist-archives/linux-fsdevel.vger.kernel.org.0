Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C03340CE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 19:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhCRSYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 14:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232336AbhCRSYL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:24:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4EA4B64E2E;
        Thu, 18 Mar 2021 18:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616091851;
        bh=RDhFZjLNet2EdmO3I9YsHaj5bym3mRlsIzr4283Ahws=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RmtDNbH0qb6cnSwQ9fuxFKauWa2fcYK1OrPUYW3lj1LFdSAsXS9m1WdHZyY+3E5k2
         RW8nfL+yQ5ouyq8Doe+p4OaPuWkuuINdPioNMv2j5pamW4PKaagmVipDNSRJ0PEYNh
         8r/5y2Sigwd6foRmtY+5IJUj8m35MXo/BUYOQ+gbW/8ZWkvvBIT2aqrktBmZiJsMm9
         CpKl9e4M+XR2MYIfxfaUfFoC61INejd0dAPjzPiOWXXvi/PPWUWav79ZJ5Ej2Dysip
         bNQwcGq8BZKu3G62mJ2kChm4ewTGAdsvTgWAR4AQzl6A9+5Y/fTKetPJF8VcoZ+LFK
         D4krdNHlngg1A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3E50D600E8;
        Thu, 18 Mar 2021 18:24:11 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: fixes for 5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210318160545.GK22100@magnolia>
References: <20210318160545.GK22100@magnolia>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210318160545.GK22100@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git iomap-5.12-fixes
X-PR-Tracked-Commit-Id: 5808fecc572391867fcd929662b29c12e6d08d81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ff0f3bf5d6513dfb7462246d9c656da7c02b37e
Message-Id: <161609185119.1841.14290945236600692021.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Mar 2021 18:24:11 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, linux-btrfs@vger.kernel.org,
        naohiro.aota@wdc.com, riteshh@linux.ibm.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 18 Mar 2021 09:05:45 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git iomap-5.12-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ff0f3bf5d6513dfb7462246d9c656da7c02b37e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
