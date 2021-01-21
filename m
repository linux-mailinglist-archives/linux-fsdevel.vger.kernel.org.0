Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744EF2FF515
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 20:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbhAUTte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 14:49:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbhAUTtO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:49:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5FE9E23A54;
        Thu, 21 Jan 2021 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258514;
        bh=yDF9P0+5W9PnKS+KIbofT4+KmzXhU0eU7ow1dA3bT5Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ekK5EV7sDPsxY5vzRcv4/EPm2sadqcvwYsRsOzxspv8N/O7Nhyea4f5zAwu7sarCQ
         piznnjLFD1gd2y/e6oFJs3fma6LXsL07YDRGK4e/O65UxP3mN9k2UcGfu3wdcqOlr3
         wTUq4EiXQRvuws6/F/PuZ6gYcZvPn3DJxJrH3cau1eP7eD4dT1tnfxr3gn0S078goe
         TOYEZ6rtli1nYD1C1EC3S9WznBvnlzPw1yRMGnxhROk4rWatE6rSpvI9RkyR3PuTd+
         lZsMD3qhOLYO00RyCZKhn7+omuxDuFyTom8BKKctgBA1F/zrDzL8ieJd90V3KPQCh4
         PGJQbRljvXRXA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 5851E60192;
        Thu, 21 Jan 2021 19:48:34 +0000 (UTC)
Subject: Re: [GIT PULL] Fs & udf fixes for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210121131759.GE24063@quack2.suse.cz>
References: <20210121131759.GE24063@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210121131759.GE24063@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.11-rc5
X-PR-Tracked-Commit-Id: 5cdc4a6950a883594e9640b1decb3fcf6222a594
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f29bd8b2e7132b409178d1367dae1813017bd0e
Message-Id: <161125851435.32181.18328989751826713032.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Jan 2021 19:48:34 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 21 Jan 2021 14:17:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f29bd8b2e7132b409178d1367dae1813017bd0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
