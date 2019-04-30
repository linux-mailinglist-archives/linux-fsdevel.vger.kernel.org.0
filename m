Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E011D1025C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 00:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfD3WaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 18:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfD3WaC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:30:02 -0400
Subject: Re: [GIT PULL] fsnotify fix for v5.1-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556663401;
        bh=kB85hZlWoHy5mpITXgZc5Hc1osEo0twAZxt6IqLUfNk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RRmiHblryzKNRBYQZpzIJt83LXJUEq2gLN73HiyeUlyYNiRUgS6+w/T0bxwqFDMKQ
         UrMM+lFBN8GXqV1xx1xoYcr+LOZHcgvR35YOlfgL+VpnTvMUgZhj80OFnfgRLKo8u+
         +S93G2eAuanPQlKpByu7F0bIvRx5CrpH9V3juN1g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190430214149.GA482@quack2.suse.cz>
References: <20190430214149.GA482@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190430214149.GA482@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fsnotify_for_v5.1-rc8
X-PR-Tracked-Commit-Id: b1da6a51871c6929dced1a7fad81990988b36ed6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2bc9c908dfe3f56fe4ca4d92e5c5be80963b973
Message-Id: <155666340169.5287.7197714313580555278.pr-tracker-bot@kernel.org>
Date:   Tue, 30 Apr 2019 22:30:01 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 30 Apr 2019 23:41:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2bc9c908dfe3f56fe4ca4d92e5c5be80963b973

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
