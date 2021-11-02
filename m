Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A2D4436C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 20:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhKBTzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 15:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230043AbhKBTzA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:55:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A741960F58;
        Tue,  2 Nov 2021 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635882745;
        bh=1WwGdoy2NtAQlXi9y5fVJ/bVEwj/WfpnyFpS5ZVQWEY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D3ssoNm7Dv5shhsGkppq+n5rK7RJPBuskTXl1wMsQ/uui3MGMwKFc0PVhQrWvI1aR
         ozqYBC2aB44CLkQWHV4PHtbg+4cfhAI9tTPi38vwgdkQpkaegGZlnq6JZI9DIe9SzJ
         rCojmYDIHkx0UY0XCPf3LvVBOHT36GADJpunAZ6S+e4yo32Yg2vwj6R5FdjFi0Be3p
         5Hp0HinIwoVvuZTbfL6lexM4VPjIVdgouxp+GZJhM/tuoBfF8MRgxnronn1cATv1F0
         MOz2D1PVOOZC6ZGoWBX88WubTGHz1vKdfyCFVHHI9vd1lyFIZ/eFhK/vUiLZtZ+E29
         95CVaA3t4LVrQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9DA02609B9;
        Tue,  2 Nov 2021 19:52:25 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2: Fix mmap + page fault deadlocks
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211102135422.121093-1-agruenba@redhat.com>
References: <20211102135422.121093-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211102135422.121093-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.15-rc5-mmap-fault
X-PR-Tracked-Commit-Id: b01b2d72da25c000aeb124bc78daf3fb998be2b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6edb6ba333d31bb42d9ab8b1b6ff1c5ecbc3813c
Message-Id: <163588274563.22794.16770033660775102076.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 19:52:25 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue,  2 Nov 2021 14:54:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.15-rc5-mmap-fault

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6edb6ba333d31bb42d9ab8b1b6ff1c5ecbc3813c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
