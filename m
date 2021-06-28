Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974383B6B61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 01:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhF1XjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 19:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233870AbhF1XjD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 19:39:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F262861CF4;
        Mon, 28 Jun 2021 23:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624923392;
        bh=olgmlCCEXgbIRO4D3Jq6NI3qVCMsbVCY+zrABexZDW0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DSx6uHbVVu0v8Mm36qD/eblip+oQCi5TStiOlwzscjITCTLxQBsXvqFaDHoc7xp63
         gdoD2ZTxjZ+Tp1M0Qe9PV54QiG5RwI06q+Ss2lbTbqml3G3nsiz4eLGsZsr/YTiZ6+
         /b3ktFaVxv3z8FB47+4lG628xYjyO8KRNUWPvg+5OkEDopeDpQ7OZSIRQnB80mwePh
         wTsOa97jcrAN9CoJFOk0YymeAmqUv2ehZa0Z/ReFK2Di8F8hU5/ew5HZerRkBnJc/D
         vlcDIBXjmOzv7NfBBYldnBf6fofDIgPNSSla/+TUnFGvp/MS+QQFNpUX0KwZwCk5Fb
         2FZss+xtrJTjg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EA83D60A3A;
        Mon, 28 Jun 2021 23:36:31 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNn/TL5lW44yAx3o@sol.localdomain>
References: <YNn/TL5lW44yAx3o@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNn/TL5lW44yAx3o@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 2fc2b430f559fdf32d5d1dd5ceaa40e12fb77bdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a58e203530ebdf6e5413bebc7f976d756188a4b5
Message-Id: <162492339195.13806.1637347361707615822.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 23:36:31 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 09:56:44 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a58e203530ebdf6e5413bebc7f976d756188a4b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
