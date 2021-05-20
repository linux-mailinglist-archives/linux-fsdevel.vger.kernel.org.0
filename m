Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73838B495
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhETQtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 12:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236080AbhETQtE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 12:49:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CC61D610CC;
        Thu, 20 May 2021 16:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621529262;
        bh=ASwUSqcV4e3yVU6XA0GWPhnD/MkvZbjaX0SEZj+niSQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uYs0EWHVXeq1zmJR91UyEMK+fpLV0Bqt27Q4gUd5xJVBdpEdzRXjz0xBpAHnHNwUK
         gN920zgSyCrdQw2jT53FmZc/q0SS9FcLPkllDlWHQXeeEXpzFcmWzjYivnakE6U9o/
         GrJp061omNHRTYHVrl7JGk/qSamHlBN+m1zwVGuguNkciZmGNkgIqVYch4ipToPuxr
         Up7BG5xvlsEv9hlWZtA4upa76eoAbACJSUN44VivjsvJoGDOYyShrcTtS2p3aI8elk
         GwE51caSBXucWgtnTb5E9ZyD/hlnZxKsVc75LrZWTbnPUqH/cUg8pRVwKvMOGdFwxD
         FmVd/ExAYQfKQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C778B60A35;
        Thu, 20 May 2021 16:47:42 +0000 (UTC)
Subject: Re: [GIT PULL] Quota changes for 5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210520102625.GB18952@quack2.suse.cz>
References: <20210520102625.GB18952@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210520102625.GB18952@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git quota_for_v5.13-rc3
X-PR-Tracked-Commit-Id: 5b9fedb31e476693c90d8ee040e7d4c51b3e7cc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ac177143caef12b174583e410b7240c33f0289d
Message-Id: <162152926281.27581.4465848107071409501.pr-tracker-bot@kernel.org>
Date:   Thu, 20 May 2021 16:47:42 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 20 May 2021 12:26:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git quota_for_v5.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ac177143caef12b174583e410b7240c33f0289d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
