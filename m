Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE136CB2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbhD0SiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 14:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236834AbhD0SiX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 818CA613EA;
        Tue, 27 Apr 2021 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619548659;
        bh=dU7CVh0jkwj4jlP204GlVPXcyoEYQf9hgop/xZaQcUU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aSrREZFBdbKB/iMbw9UdLWgXL+Ctit5rGjBiXJiVPQtS1DB8R0tZc1bcxoRkq8qjV
         BQCOLfNFTYT716WIIBdQv0vwYcG8RROVq1dnAZhZbhKgxwQ4OYhHw7f7tbt7aqnbOj
         MlQiLGTcwENygI51zulurJrcn80XaCvzQpZ84HVyqI8s71KJl/nM6H+R4Q9pAxkqoi
         1cZduZ1jlyyUOdBRx+IzxOcN/yR4+4RuXQ1stfXcIGPDpnbgGc913ASI/TlPAnaerk
         iRratTDutU1a97H+jBBzzPQbEd1VUoPFegL5ej5Xy2rrDIgatDttL+kwsRbsldKK1M
         HxkR3tpWdaf3w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 74D9D609B0;
        Tue, 27 Apr 2021 18:37:39 +0000 (UTC)
Subject: Re: [git pull] vfs.git inode type handling fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIc+orIAyfwUHGFo@zeniv-ca.linux.org.uk>
References: <YIc+orIAyfwUHGFo@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIc+orIAyfwUHGFo@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.inode-type-fixes
X-PR-Tracked-Commit-Id: c4ab036a2f41184ba969f86dda73be361c9ab39d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1466bc583a81830cef2399a4b8a514398351b40
Message-Id: <161954865941.8916.12725024391833001750.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 18:37:39 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 22:28:50 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.inode-type-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1466bc583a81830cef2399a4b8a514398351b40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
