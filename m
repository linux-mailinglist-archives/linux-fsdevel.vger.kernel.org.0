Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF52421485
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 18:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhJDQ5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 12:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237710AbhJDQ5p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:57:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 55C47613D2;
        Mon,  4 Oct 2021 16:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633366556;
        bh=l5K7xQNBNdPKAgIdcyIKJWz+b+haWF5RQHXh2O3Wt+E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NjEFZ8W2NoOP2/yD0mSsz2imns1waZEAdtLfsrSDDXu4uoAQegawPkwzGhaLiJHLK
         XAcvMqafoBOdMgM9tN6zFYgDwCjrgOw6KpBZvBZMtSaY1QZ3GEp319qJd9ZwyHwEEx
         yh6pZuhBMcpsFqB8gdfH2k5+w5XSZpROQkc4D/Hy9S8wnwUrq9iWRs/B5LXoT/hBOq
         nDCyEvCtW4ZvHW2ZmyTM1Yx6quIpPgRnxyJomJo/2CyVVkeuURmBe/Nz2fUpG3x4qC
         7bS2SmWibRUuyF8tokgL4Wm2VCL2fAd08eaNGejvFWX4Ad+c9/cnyZH0Wph3uFNzN+
         yy59t7TPV0zNA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 49A9660A17;
        Mon,  4 Oct 2021 16:55:56 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YVr8grJWnLDcBZFJ@miu.piliscsaba.redhat.com>
References: <YVr8grJWnLDcBZFJ@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YVr8grJWnLDcBZFJ@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.15-rc5
X-PR-Tracked-Commit-Id: 1dc1eed46f9fa4cb8a07baa24fb44c96d6dd35c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b60be028fc1a07a88a391aa4ff3304d9dcb3d66e
Message-Id: <163336655629.28831.11579987189805108372.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Oct 2021 16:55:56 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 4 Oct 2021 15:07:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b60be028fc1a07a88a391aa4ff3304d9dcb3d66e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
