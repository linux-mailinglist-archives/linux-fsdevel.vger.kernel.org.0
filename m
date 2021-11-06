Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACD9447106
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Nov 2021 00:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhKFXxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Nov 2021 19:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231743AbhKFXxH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Nov 2021 19:53:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2D16E61139;
        Sat,  6 Nov 2021 23:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636242626;
        bh=nd3MvovGtumotB9ddSZQu0gmg2bO6cjLdSrfRoAMp/0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fNV4JOSn33WELYB9Y+IPVGCur7TAbGmLIG2pIVf98o0ai7wPL/dK8bpkakBcQOFdg
         DomGjeC5Qv/I0iwRX94EYeZYqdyhaK721qfvgDMwRgyjvLQOOkSYzAbfoUxhvE+7QR
         Zr5elmFpR1b1+T4GGreigVpc0QFqo4DCdIpJko93XImz8y6uoDM6qLMtGRYn9xlbm0
         TeyEBzNQ8z4ypeR5wQ2PQeCYBVzXWUOcx4JNljbQhRUw4/wbY6apKtNBZq8K6FOJ3h
         09HU8KYxvG/lJ/WS3y8K/eN0l9G46kQWy4/GI0EIy8mbcIMqL8+hGs7V2zUAFiYuLz
         avzFPLOslWq0A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 27AA560981;
        Sat,  6 Nov 2021 23:50:26 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify changes for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211105140027.GB5691@quack2.suse.cz>
References: <20211105140027.GB5691@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211105140027.GB5691@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.16-rc1
X-PR-Tracked-Commit-Id: 15c72660fe9a3fddb301ac90175860b14c63ff03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2acda7549e7081f75bac6e1e51518eb8a3bf5d5d
Message-Id: <163624262615.31518.9141174164185231474.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Nov 2021 23:50:26 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 5 Nov 2021 15:00:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2acda7549e7081f75bac6e1e51518eb8a3bf5d5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
