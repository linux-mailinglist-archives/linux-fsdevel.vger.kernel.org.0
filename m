Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5421EED37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 23:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgFDVPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 17:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgFDVPE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:15:04 -0400
Subject: Re: [GIT PULL] ext2 and reiserfs cleanups for 5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591305304;
        bh=c0gGRCTTw5zq+fi5ge40lffJ3Jj4/dBzaY9GAqW+XhM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HDTjYPmK9u+FqyJqlBwA3dB6Zr8SQLpqrufWl1P6SF1EINv32kI+1p3baRkLvxurF
         gUapZCtJFoeKcIzhL/oy3A2KbC8RFhNyNHT5ukgAnnW+fmEz96hW/4I6gxC0lCTBrR
         Xf/IoZ2Jart/AoWp8/P8CjPYjEYP75zzOS+6eLZQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200604124338.GB2225@quack2.suse.cz>
References: <20200604124338.GB2225@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200604124338.GB2225@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.8-rc1
X-PR-Tracked-Commit-Id: 5626de1e96f75cc4bede0743ac994e504e2e7726
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 051c3556e3d6cc43bca71a624081de9c599df944
Message-Id: <159130530458.6506.1774252619203022622.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 21:15:04 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 4 Jun 2020 14:43:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/051c3556e3d6cc43bca71a624081de9c599df944

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
