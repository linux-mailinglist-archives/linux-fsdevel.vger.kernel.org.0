Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941F93D1748
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 22:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbhGUTHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 15:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232622AbhGUTHL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:07:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6BA1C61208;
        Wed, 21 Jul 2021 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626896865;
        bh=i3ClP/ySeTW8UzaTHjmH9w442P6AbI3jr7evO/kZ9Yo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pdL2JkeUAztQPcbdF84g99KoOJTviNGjIu7JUTqf+RVC6Tm0pQzeyDnH8c/hNzNiJ
         DAwNSs6lpO13Ps0kHUjZvl5Mn6MA1/8jIdXillK++JBDTEUH3kIq9RNGaXpvdk7WSA
         Dipel4WQVugaPHIidCZ/DU5YkfoID8t41IIoQizApqN9GT0iYu9hwMknnritJ4QuXI
         W9KPrMFnGfMyk4O9vZZEZKwhkfMqPx99eWmjys7FxrWp6p5I+8SkRhE56dHfl/bXKq
         iFssE+2zs1J6WVsrsdJaM3b8n6Q/CMVsuQtRFHEyq8yOGFOycHR3D3lqnscvCq7kCl
         69hhzD063mTrQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 547DC60A4E;
        Wed, 21 Jul 2021 19:47:45 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <281335.1626877326@warthog.procyon.org.uk>
References: <281335.1626877326@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <281335.1626877326@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20210721
X-PR-Tracked-Commit-Id: b428081282f85db8a0d4ae6206a8c39db9c8341b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4e62aaf95e8a340f3a6e0e2fc9a649f875034b3
Message-Id: <162689686528.6427.15425115148571359800.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Jul 2021 19:47:45 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tom Rix <trix@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Alexey Dobriyan (SK hynix)" <adobriyan@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 21 Jul 2021 15:22:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20210721

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4e62aaf95e8a340f3a6e0e2fc9a649f875034b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
