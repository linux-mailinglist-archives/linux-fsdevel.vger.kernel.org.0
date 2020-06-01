Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFFD1EB269
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 01:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFAXzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 19:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgFAXzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:55:03 -0400
Subject: Re: [git pull] set_fs() removal in coredump-related area
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591055703;
        bh=2y8uKvePCN/c6RTfNiSTkGaGQGlrugI1HAr4jx+sSZU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DIpRs79GqwgnS91Sbvx6hytcyfEVLOT+SrvoHpwrapXohrdk3s9F0JgYQnq6K4AP7
         3NANwXWDKKGbyaGcod4pwkPieRJr8bzeoUJ+M94QStATkpOdMqFEhRMX1NOeDIIRK4
         IPs/+EGdpKSkHxAG1zsyhcAH1NovM3C6ZTharOVM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601183515.GG23230@ZenIV.linux.org.uk>
References: <20200601183515.GG23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601183515.GG23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.set_fs-exec
X-PR-Tracked-Commit-Id: 38cdabb7d83522394aaf2de82c3af017ad94e5d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b39a57e965403c12a27d0859901a8a7d1d7318f
Message-Id: <159105570331.29263.15907275017388640404.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 23:55:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 19:35:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.set_fs-exec

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b39a57e965403c12a27d0859901a8a7d1d7318f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
