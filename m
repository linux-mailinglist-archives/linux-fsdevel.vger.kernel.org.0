Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12947456479
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 21:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhKRUwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 15:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233433AbhKRUwI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:52:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6680061220;
        Thu, 18 Nov 2021 20:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637268547;
        bh=AWIiP7X6oV+12f/S5/q6jLCxOtYVfHMMvAMMAagrYms=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cPW6RkVNw7lPALGpOTHNDk3nULbPK40U1BBm31uwje/WN1YdL6CNkRlTHdw9nbWJi
         kbLgTupJZPhnaYnkuCO3G+eLBnRqDvLNx58cdy3ucczXOp8nUVG+52Qfgv29UPmBXw
         oBEC6fTRPR/orjkGWpNP4BkXbWYY5j83g0AJ1NNBbFFb3QY063Ca4g4p0rGFIi0Wlt
         6Vk8u1Xvv04MjgwmuXHnlqxowtytFfCyrNLeLUT/z1MN+6AB5ZwibpH8OvdWn+0ajP
         8NMXEIL5bb/RsIdXfPc2xrNeZasMW02DvCvsAw2etAQQ7bzQXO+Xyd0VTeHnAS0nfZ
         Ht/25JQz9kYEw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 60DBE60A3A;
        Thu, 18 Nov 2021 20:49:07 +0000 (UTC)
Subject: Re: [GIT PULL] UDF fix for 5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211118105210.GC13047@quack2.suse.cz>
References: <20211118105210.GC13047@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211118105210.GC13047@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.16-rc2
X-PR-Tracked-Commit-Id: a48fc69fe6588b48d878d69de223b91a386a7cb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db850a9b8d173afd622984c6d28c0064412b3fd8
Message-Id: <163726854738.10311.6969050590951177123.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 20:49:07 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 11:52:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db850a9b8d173afd622984c6d28c0064412b3fd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
