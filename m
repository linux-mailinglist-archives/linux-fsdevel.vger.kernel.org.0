Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C1C3F3C0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Aug 2021 20:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhHUSbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Aug 2021 14:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhHUSbv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Aug 2021 14:31:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4C0BC6121F;
        Sat, 21 Aug 2021 18:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629570671;
        bh=+WUZUaLVoJMkXW9TAQbYwfFFAq/WbqJoXETLxNhjgPg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BUUvUuEZzVcq/B8dYUWaRv9rX90Dj6e7mbU0BSEDgBoBsXk8bRtGHOrrQ3iy4AImD
         Ag1U6zWy4Tz9HugFnLyvsPshZM6AmrUJk9nWa50XYgUQmhTyiQTlVskRJ2SV0mF3pg
         +Wmw5eZ6n4Yvge0PlwYTcY5+5kyGpWaAOaz1xF2/2aAkJvYbkFZ9AQJD9gmOIODAiv
         JpLkppHWtaydo4FlS9ab2MYpQaApLgSSLJ8KSbphxzqnfaLQiJ/r/PbQD7jp1mkEsp
         n6G1TNHSjsJ1KHzzlprQ1HsdRqBEr8GuMpkt9jegWrn9tzC2p+ectddPb+AsDJKb+p
         +HuYIswdt/U4A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 44DD160A6B;
        Sat, 21 Aug 2021 18:31:11 +0000 (UTC)
Subject: Re: [GIT PULL] file locking change for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <31485fdcfad7852abb7f29d73ae0ab718c6357bb.camel@kernel.org>
References: <31485fdcfad7852abb7f29d73ae0ab718c6357bb.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <31485fdcfad7852abb7f29d73ae0ab718c6357bb.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git locks-v5.14
X-PR-Tracked-Commit-Id: fdd92b64d15bc4aec973caa25899afd782402e68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15517c724c6e89ed854191028958a43274e3c366
Message-Id: <162957067127.18934.15792623893649339337.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Aug 2021 18:31:11 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 21 Aug 2021 07:44:09 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git locks-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15517c724c6e89ed854191028958a43274e3c366

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
