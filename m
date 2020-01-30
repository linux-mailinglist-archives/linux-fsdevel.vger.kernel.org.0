Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2291014E62E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 00:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgA3XuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 18:50:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgA3XuG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:50:06 -0500
Subject: Re: [GIT PULL] UDF, quota, reiserfs,
 ext2 fixes and cleanups for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580428205;
        bh=9yOfMzK95yjGWe2dp+gwZ7/xGSSBF1dhNknaQoXQpU4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R/yHil0Gekut5pLB/xWk6nqfTzyBFG1VrsytVdcZIvAXK91KSxq7yF/DFp5uGkqDe
         gmy/DHt9o7Ok/seG2JJqZLjgUhp2PbHMDru48fRslS/WAEz8rPSYn5eANLNBuNlfjR
         59Qi99mszYvfoDgn/FJg9L8nwN9TbLc2TSYCiQsg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130161832.GA15601@quack2.suse.cz>
References: <20200130161832.GA15601@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130161832.GA15601@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.6-rc1
X-PR-Tracked-Commit-Id: 154a4dcfc95f9dfcb2fda3ddf24c0602060d1120
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0196be12aab2dc3a3e44824045229b0e539be8fd
Message-Id: <158042820548.30792.3744271537926455221.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 23:50:05 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 17:18:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0196be12aab2dc3a3e44824045229b0e539be8fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
