Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613FA437F70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 22:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhJVUsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 16:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232411AbhJVUsc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:48:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 24ACA60F6F;
        Fri, 22 Oct 2021 20:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634935574;
        bh=uswNvpg55G3awKi9Iup1xCfpiJYUzbe1wsO9Sh88fsY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KaFmzfXuatHFIUpTSoc3UMF6A9DxnBU8kmwdIXuMcVOQVGjy8RaOEl0HJJMiqKbA5
         MJQkuMMQflKDEGOVq53NFdrxWg9qbGHzKOyBYGWKtAxlikrqtBi15KhQcfEt8CLI58
         BHW1DKckzxo+aJ6XUl4uM/gDD+FSszlUSfUtkDoqKJCI5gGaoS5KZZULuxH1n7ZitG
         2fNTlNx+laJywBT9XOTwJXhMUfCwSaXkVDpUugWXumXtmHxeGuV6zWDoILfq129mNk
         1HUr5gRkVKid8VrIYV+YykhQqBQMhHtCrEeUIRN0FsKROlMf+kw0xNLDz9CGCIS1O5
         8p8W0tpOdmYzA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1140E609E2;
        Fri, 22 Oct 2021 20:46:14 +0000 (UTC)
Subject: Re: [GIT PULL] fuse fixes for 5.15-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YXLV8NeDTaBH3g/b@miu.piliscsaba.redhat.com>
References: <YXLV8NeDTaBH3g/b@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YXLV8NeDTaBH3g/b@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.15-rc7
X-PR-Tracked-Commit-Id: 964d32e512670c7b87870e30cfed2303da86d614
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ab2ed0a8d75ce55ade89e3ff6b75bef7d9fa53f
Message-Id: <163493557400.22044.9876340192451867732.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Oct 2021 20:46:14 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 22 Oct 2021 17:17:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ab2ed0a8d75ce55ade89e3ff6b75bef7d9fa53f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
