Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F317169195
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 20:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgBVTpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 14:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBVTpD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:45:03 -0500
Subject: Re: [GIT PULL] zonefs fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582400702;
        bh=3GBDpJQfkVloQMA27TrueMCrYJYUV1XmCdmOz2wkg0o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eBbByRs+HznPPbk4gpNqUKhmixvD9iZraUFgDDjSkBCZV2kSDxsMUuOeTgLDxQWK1
         0Di1luj2NMvpxv1Q2fEC/lFH4LextlWubnzRtypGEeQr/R1/W+vxCRyTuxskOVeA1B
         Er7wXsYz6tntBVr95kyySyaILLe74oqd67td8bFY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200221111558.9841-1-damien.lemoal@wdc.com>
References: <20200221111558.9841-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200221111558.9841-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/
 tags/zonefs-5.6-rc3
X-PR-Tracked-Commit-Id: 4c5fd3b791a06021084b42d5610400f846d206b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a115e5f23b948be369faf14d3bccab283830f56
Message-Id: <158240070280.14316.1259938744192542207.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Feb 2020 19:45:02 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 20:15:58 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a115e5f23b948be369faf14d3bccab283830f56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
