Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F072B44B33F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 20:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243335AbhKITeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 14:34:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243310AbhKITeg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:34:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0F5B06134F;
        Tue,  9 Nov 2021 19:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636486310;
        bh=Pe3cASHp1BywNZuy8a4wS6QDZimbMvZrwKR1F5Wzigw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Eb/MQ4er4accdTiR+roSy0GkNtQRZbuK88IuafG3Ucgk4D5QYp7QZ7UwnD+EKCa4X
         NAQQWLgkGH9a69CkXUOnbZRnjf0CGxJpthMurSwr4ZXPBZI6BfWP1KDJXyt3wCph18
         6ip1xkcwGJKi9qqwkvNv7dMzPgLxPfnN+gWTqSOHmTk1YgMQdBeqix/ALzEG3F0ZZr
         G+nkOKIMOo8JgbEhpxyaBKahBND5MGWwdC2v2/k80/03SGxCBljcZv7/HXTIyJ44cM
         R0hTbmZKZNhHYnGEHo17SBvKrxRWr4MdTGS3ydpa4lK0Nwy593qDTx6qiF4lHHCe2c
         B15Qwe+vuDjGQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 08D7C60A3C;
        Tue,  9 Nov 2021 19:31:50 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs update for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYo6eHUbXJXQkogn@miu.piliscsaba.redhat.com>
References: <YYo6eHUbXJXQkogn@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-unionfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYo6eHUbXJXQkogn@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.16
X-PR-Tracked-Commit-Id: 5b0a414d06c3ed2097e32ef7944a4abb644b89bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bdd629e5aa0e335504304be4208935948692549
Message-Id: <163648631002.13393.9322466259190410048.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Nov 2021 19:31:50 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 9 Nov 2021 10:08:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bdd629e5aa0e335504304be4208935948692549

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
