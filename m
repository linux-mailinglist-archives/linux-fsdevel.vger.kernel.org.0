Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BFC400CBA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Sep 2021 21:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhIDTBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Sep 2021 15:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232820AbhIDTBs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Sep 2021 15:01:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 42C0E60EE3;
        Sat,  4 Sep 2021 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630782046;
        bh=KdxeCo6LurCDnWEQliUnDnp7vKqlZaCWXVLTI45rieE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gQN2M/9geXv0porq4D9AdbM7sP03ac3HbyCgUy78wblB/HLV0VdM0R4Ih5xcBieA8
         de/5GVK4BEQ7dVDpi8ymCnjwHm7rvUPp9rqjIFSyPNXFcbeSru6X0phTeGoD1oZqOR
         flTtWLrDANp/FHuROy6lKAzipthXCrviUZhcnhv6/n+XX0gJ4yE70yd1RPm0BlnZ0o
         FdwYN4gOhmmlCyUuHBScM66EF9qv4pyVzvE4DGqDCqHjSxvgXtEkCLYbEhz1rAtKSf
         leopTPkE+QIWVKrccps8L4ElA264KzvMa6tNA6C97eF+UFv09zkfsDhcbkDpzG46w5
         O1bSPkWPKnWQw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2BB5760A3E;
        Sat,  4 Sep 2021 19:00:46 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: new NTFS driver for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com>
References: <aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com>
X-PR-Tracked-List-Id: <ntfs3.lists.linux.dev>
X-PR-Tracked-Message-Id: <aa4aa155-b9b2-9099-b7a2-349d8d9d8fbd@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git master
X-PR-Tracked-Commit-Id: 2e3a51b59ea26544303e168de8a0479915f09aa3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7464060f7ab9a2424428008f0ee9f1e267e410f
Message-Id: <163078204612.10287.15715899876921714873.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Sep 2021 19:00:46 +0000
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     torvalds@linux-foundation.org, ntfs3@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 3 Sep 2021 18:19:50 +0300:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7464060f7ab9a2424428008f0ee9f1e267e410f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
