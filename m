Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A63322193
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 22:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhBVVgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 16:36:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232033AbhBVVgm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:36:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id F2B8D64E61;
        Mon, 22 Feb 2021 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614029716;
        bh=dmOEq64ZhvOK0sQiy3WbXHtz/JiLCB5BzhsjjQuwE7E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NwsuMRtp+Gp271uRwbpQ4AZtasalSVvryrumTrMyHQEFv/I9ciwFaj02V9OLDv8U3
         5fixTGVTVrSSUtQiEsdAUNbJHOga4mZe/C/YMr68DvgrxzeJ8VoSfjHc/RYm2n+XPT
         wdhbma5keWB2YD/1RqCVdj41Vb2DnKWLhxh7TcL2nIdLGvfZRNzjZUnnWgzJx+ew+6
         oVnDQsnAX/q+9zjyazaK4lZeXZFpii7MAu2cXxgwq9p8wzMQHcECRomLZh/2itNp70
         EKBhGEmgUMMjhpt4itPrWpkl8716zTnv4dmqP58UjPqYZQ3Mp69PKWR3IrIjAQImdY
         /7e4w/EB0l5UQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EF4D860982;
        Mon, 22 Feb 2021 21:35:15 +0000 (UTC)
Subject: Re: [GIT PULL] writeback: Cleanup lazytime handling
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210222122315.GE19630@quack2.suse.cz>
References: <20210222122315.GE19630@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210222122315.GE19630@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git lazytime_for_v5.12-rc1
X-PR-Tracked-Commit-Id: ed296c6c05b0ac52d7c6bf13a90f02b8b8222169
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d61c6a58ae30e80fb68925877cab06ad7a4ce41e
Message-Id: <161402971597.2768.12992410000767778113.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 21:35:15 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 13:23:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git lazytime_for_v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d61c6a58ae30e80fb68925877cab06ad7a4ce41e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
