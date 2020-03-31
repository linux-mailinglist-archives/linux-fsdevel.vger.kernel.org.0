Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1146819A141
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 23:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgCaVuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 17:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731653AbgCaVuC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:50:02 -0400
Subject: Re: [GIT PULL] fscrypt updates for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585691402;
        bh=LcVm+V24+2+NTOJ9JrmVVXkl728hyFi9uw2iR9GZGHU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QBosVPQuppbe6iZRabDz1qeEjuf4lM4SbPhgQX19V+1KKwMbxjrmHXREfGjQgEAUF
         1k3zIgblJ+TDv4YnoOKB9A98doinoZvVZuc8iMFiMPG+UFI7hDw4U4aD3I5STWWgcy
         isOSyBj3OEr06AjfDkcZv2vMHRFMaEr6lNNQwIms=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330165359.GA1895@sol.localdomain>
References: <20200330165359.GA1895@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330165359.GA1895@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 861261f2a9cc488c845fc214d9035f7a11094591
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1455c69900c8c6442b182a74087931f4ffb1cac4
Message-Id: <158569140192.7220.17954616110607840136.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 21:50:01 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 09:53:59 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1455c69900c8c6442b182a74087931f4ffb1cac4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
