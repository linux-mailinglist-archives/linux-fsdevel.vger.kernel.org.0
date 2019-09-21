Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C646CB9FCC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfIUVuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Sep 2019 17:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfIUVuE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Sep 2019 17:50:04 -0400
Subject: Re: [GIT PULL] ext2, quota, udf fixes and cleanups for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569102604;
        bh=VCZ5eeav+2WLHuN7ZtK9vRISUVWtuP/gMFg/Homt+RE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=psGtB+8nlNemX7jJeiOV6/Rs5LOLFmhsc+aYLVw37MBlNfgj7eknVMHF+mkrQF5ch
         muUJ4qlU2Ke/HbGM2ncGaw+kZDp5tk3tvDZB/q9KI4+fcnl28vU1amX/ii7wGe3qZS
         d9FH704Kg69JmWvwAHKeY+udba6Lmo7IkSMjZswk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190920111404.GC25765@quack2.suse.cz>
References: <20190920111404.GC25765@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190920111404.GC25765@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.4-rc1
X-PR-Tracked-Commit-Id: 6565c182094f69e4ffdece337d395eb7ec760efc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ce1e15d9a85a2b589a68a04afb2b2ded109b680
Message-Id: <156910260433.18589.1149383805874077796.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 21:50:04 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 20 Sep 2019 13:14:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ce1e15d9a85a2b589a68a04afb2b2ded109b680

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
