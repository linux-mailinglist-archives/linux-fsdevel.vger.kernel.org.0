Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5C1B7DFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 20:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgDXSkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 14:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbgDXSkV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:40:21 -0400
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587753620;
        bh=oGYtWO0myYIyjZeo9Jqvu/EFmmZXm1TEha+Yj0s0WQc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hSi5bio/7iNaTmm9YrrxQ/973QH26dTS21KKIyTNdqwhccRX75aPly+ikt99Fk8tg
         8X74fOctGBp5nq3xZ3neTi7GzmS9NUoCZrUdQ0YR+Xrb5bGFKeLw+JAkJCTgyXa4Hs
         NGNrHSKCiELd4NLY1Hg2wSGN1xN4Mw25NtYF98uE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3632016.1587744742@warthog.procyon.org.uk>
References: <3632016.1587744742@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3632016.1587744742@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-20200424
X-PR-Tracked-Commit-Id: c4bfda16d1b40d1c5941c61b5aa336bdd2d9904a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a195628522c08f36b3bbd0df96582a07ab272bf
Message-Id: <158775362070.26557.15195413938093187702.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Apr 2020 18:40:20 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 24 Apr 2020 17:12:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20200424

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a195628522c08f36b3bbd0df96582a07ab272bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
