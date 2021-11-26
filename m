Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E6445F613
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 21:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhKZUt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 15:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhKZUr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:47:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DCFC06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Nov 2021 12:42:14 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 259046237E;
        Fri, 26 Nov 2021 20:40:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 711D860041;
        Fri, 26 Nov 2021 20:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637959212;
        bh=6o7xyG05uFQQ4K0xAaAbq+Bl1zLsVU0mtKKjMexqDQQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z9olwYfpQakV7W+Txcapb9NRzPHRVbyUnmBlMsXLhc2tzy6ir92UPWepdz3rZK88r
         OIqk5aPwjTOnW7JoIXxM1BjxuM0BK/umWkfNem9EBhDgH2ktRFh481kKdb/Noqb3v9
         pcOd5E+nUcGFuYYkMX07E/0v9NDfAZDIprFUq/5T2xzaf6MOmZ1Tut8dMafo8s5McP
         moTZFi5t2rHVoazk9I3tqBTdtITC1eTNfmSw22CiNNuxRpR0AnZE4QbHOgmDc37gXl
         nCjpK6EFrQk5/7vFn1SU0q4s8RqOtYyUlAyMK429JTuZW+wKmIK+IvyJOLFLTNJtV9
         UVhfy+dXco62w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6AB5260A4E;
        Fri, 26 Nov 2021 20:40:12 +0000 (UTC)
Subject: Re: [GIT PULL] fuse fixes for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YaE5NdAaxf0vuEew@miu.piliscsaba.redhat.com>
References: <YaE5NdAaxf0vuEew@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YaE5NdAaxf0vuEew@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.16-rc3
X-PR-Tracked-Commit-Id: 473441720c8616dfaf4451f9c7ea14f0eb5e5d65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 925c94371c5532659f8eb5bcf3b71f78622e4f68
Message-Id: <163795921242.10744.6190991168903339012.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Nov 2021 20:40:12 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 26 Nov 2021 20:44:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/925c94371c5532659f8eb5bcf3b71f78622e4f68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
