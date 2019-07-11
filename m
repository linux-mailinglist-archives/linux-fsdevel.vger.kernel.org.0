Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F08F65137
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 06:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfGKEkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 00:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbfGKEkE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:40:04 -0400
Subject: Re: [GIT PULL] fsnotify changes for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562820004;
        bh=hoeeEqANfYiW5dymUEUfWaVxB9BROCsTFAZbMCqsLeA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uFq0n1/eRLGH0M9847rknDRW+qvANk4Jbp1Zl7luFTRCFIhreqTSZjDuMz2YW9vch
         AV1LDUrO631o4cpshJpapx70OV6D3T5axaJ7IWk9Q5FD+oJjcsZIrm7IxeCxldAr3t
         RQ1/AHYQ6KQvfO8wrhDUVk8EMOTWqHtz5tsevHwA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190709091643.GA5903@quack2.suse.cz>
References: <20190709091643.GA5903@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190709091643.GA5903@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fsnotify_for_v5.3-rc1
X-PR-Tracked-Commit-Id: 7377f5bec13332bc470856f337935be6cabbcf24
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6983afd9254c559acf67dd5f62df824d19851eb
Message-Id: <156282000436.18259.16979081353522392754.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 04:40:04 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 9 Jul 2019 11:16:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6983afd9254c559acf67dd5f62df824d19851eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
