Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AC72EB445
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 21:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbhAEUba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 15:31:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729608AbhAEUba (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:31:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6D6AF22D6F;
        Tue,  5 Jan 2021 20:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609878649;
        bh=6jk8LUNkuT6UT8V2dIEIEAvshdN5ynbOq0LyAdOZGpU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cXNqYD3Jl5xmhbqwcfTJjHXnpuSewQOLL2CPf8AkLn5d/Ql9SkeC59rFeJeRJSe4P
         7uONjAVS9250/s/uwKDeDL/eN01W1Uj5v1phDbaCL1ZQQnALgx+90nJA1iA7GDhgij
         FaUWagEBJutDPdVlmjMcPZxapbE2PD/mJ3KUHRr0HVMYSuIOFL0FSwURUTwysB3Ed8
         56/Uhg5QL/BBSwN8xaSHuG3LJ08DpjgyTy+x+AEPlzM6cxLZlViWKys4LvXQzv2fIj
         B1ZHFlgi+1juqNeIQLjx4Sup036yLtQXwNJogOFv1Q4T8LGM+Txr5v8kcFWmWM8Fv0
         zNvdGci0WAd3g==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 5F35560158;
        Tue,  5 Jan 2021 20:30:49 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Fix directory entry name handling
From:   pr-tracker-bot@kernel.org
In-Reply-To: <313281.1609803317@warthog.procyon.org.uk>
References: <313281.1609803317@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <313281.1609803317@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-04012021
X-PR-Tracked-Commit-Id: 366911cd762db02c2dd32fad1be96b72a66f205d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6207214a70bfaec7b41f39502353fd3ca89df68c
Message-Id: <160987864937.17840.510598651603746746.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Jan 2021 20:30:49 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 04 Jan 2021 23:35:17 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-04012021

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6207214a70bfaec7b41f39502353fd3ca89df68c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
