Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1674D4D88F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 20:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfFTS1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 14:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbfFTSFC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:05:02 -0400
Subject: Re: [GIT PULL] Two fixes for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053902;
        bh=4AODWoUhQPY9rAm07k10q6DuK4BqrcxFhxXpkJeZUGY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n1OrqJtRZoKBSGKi/s6GKQMitfnPyA87I8K0BabKcvxkxzx7mfA3IWyVKy6kYEGB5
         9I+QRlRcjSxVRW8cblEOtFMjiT5dfTDT+n/KS3ba7aqgRKI1RrQQmtxYad42Ec8GZ/
         FrUcecp2j2iOAAE3UfyaDZ0l5ey5jgS7tj+dMH2Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190620130625.GB30243@quack2.suse.cz>
References: <20190620130625.GB30243@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190620130625.GB30243@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.2-rc6
X-PR-Tracked-Commit-Id: c285a2f01d692ef48d7243cf1072897bbd237407
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d72558b2b33128363e5af7f57c59766a256e8434
Message-Id: <156105390202.28041.14463462348682375862.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jun 2019 18:05:02 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 20 Jun 2019 15:06:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d72558b2b33128363e5af7f57c59766a256e8434

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
