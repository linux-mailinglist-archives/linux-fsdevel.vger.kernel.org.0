Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16150322194
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 22:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhBVVg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 16:36:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38835 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232035AbhBVVgm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:36:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3077464E62;
        Mon, 22 Feb 2021 21:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614029716;
        bh=23YMgNvgKKUny2OTzZWhMIwgYSgLf0BKEm57uM9lf9M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rvgK54yItGFz+iH10JDTOBb8dXlsDSneA2yUm4zyiiJ2Xx1pefzTiZxxppl1xU1iU
         DEojvllB9SStt2UPcTY8KMgXJI8TPqUChG0yzWHlOEUSHxdvYf38iQAdfytMK0YX77
         1hPR1Ax5Nc/Q7BE3i5WRUONYCLoARHPjEiLrU2uKuiHRwW6uRIhOGHAd4ZI0Rg4qrE
         MWERLwnVMPFoKY5AvaGgd2Dfd6NTOOFFilNKbEFvZ/c7KLMQdVPjR4e7vXrq0+Gnap
         BBAVmVKYaBTxqxHsI0BJnXeXaHXMdOTRcclsgyUCOfv5vYI5a58qM5bOpbdIIrVUM4
         Usy7+wPn2F7fg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2CD72609CC;
        Mon, 22 Feb 2021 21:35:16 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify changes for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210222122656.GF19630@quack2.suse.cz>
References: <20210222122656.GF19630@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210222122656.GF19630@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.12-rc1
X-PR-Tracked-Commit-Id: ac7b79fd190b02e7151bc7d2b9da692f537657f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db990385427c278eef56aac2e2588ec8b8cab5b4
Message-Id: <161402971617.2768.7103970371281642263.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 21:35:16 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 13:26:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db990385427c278eef56aac2e2588ec8b8cab5b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
