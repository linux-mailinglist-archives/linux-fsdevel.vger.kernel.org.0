Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCCA173E1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 18:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgB1RPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 12:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1RPD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:15:03 -0500
Subject: Re: [GIT PULL] zonefs fixes for 5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582910103;
        bh=Mb9NmdZ9Ka51XphOEpkwlKhNrXu20A402BH5gZZi21A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d0K0DaXYBxZ741I7ylkRLYu+0+Fm1/IqfuowlxbLrX2mr1NRBznUsSnnpMTwG8qNC
         9l+GyIQ9hLUlUP7+/GhE422do814iYYQdaZiO2oB40WAzzwOTC2rzbMZPd7dIy82/7
         v3lCIbj+vpnzIc0xR5vMG7fUeBeAh+WiqvTtlSQo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200228080550.229277-1-damien.lemoal@wdc.com>
References: <20200228080550.229277-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200228080550.229277-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/
 tags/zonefs-5.6-rc4
X-PR-Tracked-Commit-Id: 0dda2ddb7ded1395189e95d43106469687c07795
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfeb4f9977348daaaf7283ff365d81f7ee95940a
Message-Id: <158291010340.6279.10448495585963480351.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Feb 2020 17:15:03 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 28 Feb 2020 17:05:50 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfeb4f9977348daaaf7283ff365d81f7ee95940a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
