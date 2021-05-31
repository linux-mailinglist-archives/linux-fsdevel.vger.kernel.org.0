Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D2339658D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 18:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhEaQkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 12:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234276AbhEaQh5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 12:37:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4ED18610A6;
        Mon, 31 May 2021 16:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622478977;
        bh=HPqLyWPCxv3Q8yftH4h9jdh9V6HkPWoOmAzsk6dNeC8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SMkvicRXiakEQZ6eyrsK1lojghyV8tsf7NugdA48QzY1sUsCKihcX5XpagugcyHWJ
         1HLhheKwdBy15Z4nOaBpIxUkaLOjEPhDutIMuW0vvCKQ3Iu9nBB0dFjFvMfgsXrNVf
         okFIrZoL8xmqmTpCCDeJ7zCiQ/vdHbCkOUrZNHR5ihvX61fj9nDZPeVKz0IbJzrsl1
         Tr8jyLcZTEzMbv4FgB3/j32fo2xOEo1gFYKszfutfxIk4R1xOfwC8tX2Sj24ytoCme
         ApGRjtcVI/TbLoWy2nY4H9R9jyKKPl04tI34OmbJitbZ7Wvr58VbkvvU1G33TxlFPl
         cjavtHfSrSNgg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 49582609EA;
        Mon, 31 May 2021 16:36:17 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify fixes for 5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210531104837.GA5349@quack2.suse.cz>
References: <20210531104837.GA5349@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210531104837.GA5349@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.13-rc5
X-PR-Tracked-Commit-Id: a8b98c808eab3ec8f1b5a64be967b0f4af4cae43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36c795513a88728cc19517354a46a73948c478dd
Message-Id: <162247897729.1691.12339836111921097239.pr-tracker-bot@kernel.org>
Date:   Mon, 31 May 2021 16:36:17 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 31 May 2021 12:48:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.13-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36c795513a88728cc19517354a46a73948c478dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
