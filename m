Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024E41EED36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 23:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgFDVPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 17:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgFDVPE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:15:04 -0400
Subject: Re: [GIT PULL] Fsnotify changes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591305303;
        bh=+gYIR8zuXt173wOGKBG8bT9DfFHuA6CVGy9A8/F1fGw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lVoqWIz/6FH/PJadaeLc2OckeYyZS+rHdziXeRMyOisB56LJSpD/fFEElqvRhpl4i
         wPTy4m9MxfY15wnn6dfBQIqQMNvwGymVTibzph8KjZU7KIcOc2x7TwiUvDdN03cM1D
         etrdu5aUGJjmbvBGBHWNam720wPr0Iw+0lHv5tIU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200604124008.GA2225@quack2.suse.cz>
References: <20200604124008.GA2225@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200604124008.GA2225@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fsnotify_for_v5.8-rc1
X-PR-Tracked-Commit-Id: 2f02fd3fa13e51713b630164f8a8e5b42de8283b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07c8f3bfef161271786f368791f5fc33c7428964
Message-Id: <159130530365.6506.2626902044219238510.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 21:15:03 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 4 Jun 2020 14:40:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07c8f3bfef161271786f368791f5fc33c7428964

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
