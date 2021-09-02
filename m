Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2155C3FF26D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 19:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346736AbhIBRiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 13:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346669AbhIBRiP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9BBB461100;
        Thu,  2 Sep 2021 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630604236;
        bh=UFygXZVu5LK0earI4bYQqpslruPGLBbNZSAltfWO23w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eKzgiW3j71cjuPaHW/I6T2fE46IZ1S3CpJEvKyyvuT331pEdLvPikodq5NT0CJYoz
         YoRb7/aEzrOlGL3sHkT/PkHs3NSnop8eK9vEmsTVWp8BVF2NceD8jFDAN4w3TbK/It
         Mud7CGJag1VyMD4Sqw4yrfQMOpeXfEi4IXEHNZJlRi00MIkN3RQD2lpBybsRt7ilus
         AIv48y60zA0RjwGQn91YF4ohXok4qxWOf0rkRAQdthoIsC5qPclbVJBJH7Rv0fE6HL
         crQ1zLue17zQ5zrDKzyOoMR/vKzTZsdhR+/XdImWNL4Q+gem1kVy04MYXkjEaqg4FW
         q8kSHXn5E94yg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9641E60A0C;
        Thu,  2 Sep 2021 17:37:16 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs update for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTDW+b3x+5yMYVK0@miu.piliscsaba.redhat.com>
References: <YTDW+b3x+5yMYVK0@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-unionfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTDW+b3x+5yMYVK0@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.15
X-PR-Tracked-Commit-Id: 332f606b32b6291a944c8cf23b91f53a6e676525
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 815409a12c0a9c0de17a910fd95fe11e1eb97f32
Message-Id: <163060423660.29568.10975154693602925346.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 17:37:16 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 2 Sep 2021 15:51:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/815409a12c0a9c0de17a910fd95fe11e1eb97f32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
