Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89413EC3E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbhHNQi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 12:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235606AbhHNQiz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 12:38:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E9F2460E8D;
        Sat, 14 Aug 2021 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628959107;
        bh=ZuDtNB82k7DqQosN72ce26UlMpAGCpkhcFDpESby54I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rvyhz1E+yRWobxGjK4r18iCg86Rp/DK+/v6RT+fR3Xgz84i6boq9pUCbvG8ey0Klv
         OIU7qJT73BGjKBmPdy3EYgA5B2rdVEyP/nG3jqceNxEFzmT611cdMVs2/z8JrtbYSZ
         M3Jog6H1xx+/wyRWWI2c38YPtrsjS5lf6qZP/A/IqYGTeex7KEEsS7FIeJQq8iZwLB
         RUlGDQ3CZyxZtFN9EBNJoSsHFXONR+m/l3+6xMU8/pHWFygAdedNCrAxaHk40ZAqnt
         /t5f98NuRHP3N/j1PGheAfLz70Em+QZOaB2gTZdTmXi0vd7BOXmdn+R5qRovmwjaD4
         qrXIECN2H+qOA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E3968609AF;
        Sat, 14 Aug 2021 16:38:26 +0000 (UTC)
Subject: Re: [GIT PULL] configfs fix for Linux 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YRdp2yz+4Oo2/zHy@infradead.org>
References: <YRdp2yz+4Oo2/zHy@infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YRdp2yz+4Oo2/zHy@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git tags/configfs-5.14
X-PR-Tracked-Commit-Id: 769f52676756b8c5feb302d2d95af59577fc69ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 118516e2127722e46c5c029010df4e8743bc9722
Message-Id: <162895910692.32142.13242510525578888067.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Aug 2021 16:38:26 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 14 Aug 2021 08:59:39 +0200:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/118516e2127722e46c5c029010df4e8743bc9722

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
