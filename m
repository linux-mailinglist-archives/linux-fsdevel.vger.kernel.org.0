Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7F6442159
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 21:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhKAUHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 16:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhKAUHU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:07:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2364660E52;
        Mon,  1 Nov 2021 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635797087;
        bh=DsJjDkX8TRbN+hOtR000e0+OFA+4mRj8nd5JbJ7Ja9s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TBfrZXUf8OEFlAQrR19+evjH39yVDJt/f6pVOf0Q6c//5CWp6W8j0/dJw0OJnpQ6u
         lPc6kzLPoqXCx3fd93HC1pr+7rIJhvbiWmeuzGz3Z8+PGtR+3tMaOvZjKJKA3Ojrij
         GRgoUAFJhD/de3UKM5Ej0SK74si3GT4n648Akl9EAQ2o7PO/suyHGnAjng3N6d72K6
         tdLJvTff70l1NHCM0C+i8Xdh8EswObMcDLJhkKdp6Q1tpp0r8TpMYGyv608Ql+W6Bz
         FYsD/zDY0IcBFb3kQ+qajhIm34AdI6zj1UCEAlIN6Vzx34mZs9Vk6/IfiU/N1kkPJg
         z4VI58+LfytnQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 126EA609EF;
        Mon,  1 Nov 2021 20:04:47 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX8jdp73zUDwlB5E@sol.localdomain>
References: <YX8jdp73zUDwlB5E@sol.localdomain>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX8jdp73zUDwlB5E@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: b7e072f9b77f4c516df96e0c22ec09f8b2e76ba1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd3e8ea847eea97095aa01de3d12674d35fd0199
Message-Id: <163579708701.1875.9945029262289027407.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 20:04:47 +0000
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

The pull request you sent on Sun, 31 Oct 2021 16:15:02 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd3e8ea847eea97095aa01de3d12674d35fd0199

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
