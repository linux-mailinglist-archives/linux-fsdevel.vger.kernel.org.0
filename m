Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B60389386
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 18:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347489AbhESQVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 12:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347448AbhESQVm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 12:21:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 78FC36135A;
        Wed, 19 May 2021 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621441222;
        bh=G2bfthrxd0h0vGaQZxtYX8r1fNAF04/j6KQbLE42Ovw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RkIyVCf6N0uPzP5FAqkwuqrgiW9YYwg1Al0I+Tnwk4+Glg3FP19YAZWd5KB3UAy6i
         kl10VNd9SySxBxZjEkQ6UAE6NJgYiFQtnD4OO3tq/a255GCQPbUYMPuNPR4gV7R+SS
         CHhukZ4sfQMdzo2392ew01geKkH2oTrII85GXxCAPaGdws+62KzMcni8tLJJGkWOkz
         TJidK3A/9R2WAND5oiJKKDZuY3PkXKIohAqMR/ltiGM6yO1zeZugZZD/2L53TRQZLy
         bT6/z0V5QXo0NKwI5dy56/JSZaINKJ/zhZID2KaMf1HQueZ5AoQCdX/KIMgk2IUQYq
         JRM2Z48RP59Nw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 68A6660A47;
        Wed, 19 May 2021 16:20:22 +0000 (UTC)
Subject: Re: [GIT PULL] fs mount_setattr fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210519132055.682958-1-brauner@kernel.org>
References: <20210519132055.682958-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210519132055.682958-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.mount_setattr.v5.13-rc3
X-PR-Tracked-Commit-Id: 2ca4dcc4909d787ee153272f7efc2bff3b498720
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3d0e3fd41b7f0f5d5d5b6022ab7e813f04ea727
Message-Id: <162144122236.10055.12662584507788251773.pr-tracker-bot@kernel.org>
Date:   Wed, 19 May 2021 16:20:22 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 19 May 2021 15:20:55 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.mount_setattr.v5.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3d0e3fd41b7f0f5d5d5b6022ab7e813f04ea727

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
