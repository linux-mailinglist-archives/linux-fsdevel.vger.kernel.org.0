Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CFC41B281
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbhI1PCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 11:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241394AbhI1PCu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:02:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 10C146120C;
        Tue, 28 Sep 2021 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632841271;
        bh=lYcesS7qYWR+TnlLP0has/Jve8+FazeVQbXrFyxXqhY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OSYQ/nCZN6AcBbEBCk0wevMy9Boq4WJnNVjDBrMiKe6AGoDP5B7wUkAPff1mtl+gp
         MMHpWMH6MOb5b09hvgRqhWY0XRrP5gAUAOdiS5LUiLsPT+1m+uCFs5KgYYJlbpe4sV
         hCIZOranxZCt6wKXjFD9zsehQd5cwEBJH1xZB8nXjcmk54z9HxerYLMBnURbo7w8uL
         NFSFbeDMfGcGPDMnOsISBo1D8BYuWbGippzotaakG9WaorBuRLJKRDG968pukP24BN
         ZVDlvAt3mnBiHdlhvSZXoRsvc7aSE+fMVYZGNyNqTddfvOWjpI6FVAX7ekd2f4k542
         XQJ4G7lWdEu6w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F0635609D9;
        Tue, 28 Sep 2021 15:01:10 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity fix for 5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YVK0jzJ/lt97xowQ@sol.localdomain>
References: <YVK0jzJ/lt97xowQ@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YVK0jzJ/lt97xowQ@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 80f6e3080bfcf865062a926817b3ca6c4a137a57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fd3ec5c7af58d5d6b598fba22ac387645af33f4
Message-Id: <163284127092.16405.2732234461775435554.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Sep 2021 15:01:10 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Boris Burkov <boris@bur.io>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 27 Sep 2021 23:22:07 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fd3ec5c7af58d5d6b598fba22ac387645af33f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
