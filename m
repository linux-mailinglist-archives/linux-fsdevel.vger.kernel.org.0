Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D3F37039C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 May 2021 00:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhD3Wlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 18:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhD3Wlb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:41:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E30EC61210;
        Fri, 30 Apr 2021 22:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619822442;
        bh=fxlHNYXgieC6m1s7KsrjN7MvCwTb0qH/VjvuO3Yc0jQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ue8Db4gUlOmKT/HGFs0eT7p3RtoDUH9Bw4f4gWz0TN8YUQgX92z4cNYfEZn3JFy3f
         W6zfLIVoDkdvctkNw+uHrV3FC1mwgsy+dXcdtzr4iyIgyulWG9PYC6zRQYM6hqjTW3
         VLc2tVJb03UOVDBu9/0AlQU0xKnjNO2aw7rHvj/mG3tIDjDaadb+0f9t+/YV3BQ7Ki
         9emrPdzRIv0TrYOZhjHyH3LvKgKEWXGBU8DXTEZL8tUPpUXNS1PuZfhO4LG22vlbni
         jGDKV+JsPQyKOsnyuY5tCUVmbMuj3FbP0KX4oufh1CXX0jFNvrz31eyBWM7Ndl0oUT
         kWcotEk6oTANw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D066060A23;
        Fri, 30 Apr 2021 22:40:42 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs update for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIwYirYCIdcVUjk6@miu.piliscsaba.redhat.com>
References: <YIwYirYCIdcVUjk6@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIwYirYCIdcVUjk6@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.13
X-PR-Tracked-Commit-Id: 5e717c6fa41ff9b9b0c1e5959ccf5d8ef42f804b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d652502ef46895820533aada50ddfd94abe078fe
Message-Id: <161982244278.6177.768802087309533777.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Apr 2021 22:40:42 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 30 Apr 2021 16:47:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d652502ef46895820533aada50ddfd94abe078fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
