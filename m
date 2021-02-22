Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0138D322195
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 22:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhBVVhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 16:37:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232050AbhBVVgn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:36:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5FDA564E83;
        Mon, 22 Feb 2021 21:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614029716;
        bh=Jkvx+tuTrrl5P2XZBMNxl1FZk7c4ytOXUTn6qIZ88Ac=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j6OURz1P1EorJI+jLJySgGCfJh7BQuB2Xd/o44kfyKSbFzmDrhCmm6gpa27hJfORU
         ExYEQZolq0uTk0nh3+ncPHU3o/zmgQo77d8IgwEUkV+EpCpZJK7jqKFt/eQO5p38EA
         Sg2KDEyBNxGebtpNobratNKGOGTy8VN98Ptg4plkz5hvwemQIqEdd3ZAcL3Bnsgeij
         uk0oLYwoI7K/Bzehp8US9ruFHVbaXXK2Lf6kYy420JAQsrsxNmCY4yhuhW+zPrKRmi
         uGJqBAD1eldPV86OPGLUS9QSMpRGx2VEEJbHeRq+5AaKK4cU8ZWh6TYFHCR6OBp9pd
         CS9EU9c9yLgGQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5BE1960982;
        Mon, 22 Feb 2021 21:35:16 +0000 (UTC)
Subject: Re: [GIT PULL] Isofs, udf, and quota changes for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210222135322.GG19630@quack2.suse.cz>
References: <20210222135322.GG19630@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210222135322.GG19630@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.12-rc1
X-PR-Tracked-Commit-Id: b9bffa10b267b045e2c106db75b311216d669529
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fe190462668d4dc6db56e819322624cbfda919b
Message-Id: <161402971637.2768.10903615339919882772.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 21:35:16 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 14:53:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fe190462668d4dc6db56e819322624cbfda919b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
