Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E32B3CBC8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 21:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhGPTba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 15:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231266AbhGPTba (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:31:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1028E613F8;
        Fri, 16 Jul 2021 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626463715;
        bh=EpSzHRBriXPFnyaba+SQpvtVAW+mfYFvMO0hOGAWFpU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r73vaRyqCikTzJUTT1TzaqM31jwiQHcLtMsWSo6Q6ussdYz4ZcZsdlAN6xRxWCvEz
         37BhJhfwhKMOz8+lp1TOsfHrPTBxzVvBiBHnKCU1mhIqY2s1TeMQ7y8dcAbacahZ/v
         9HVASwemM1N76wHDVVmtPXjFuMv4t+BBtnmQ3eJPVoRzqlyjnopikVnvAG4fl3/zYF
         1M0tR7ZqxMDBl0Moz+tEQPl5NOuIdHOaE5nvJwr6o1aKe2kBCBfxjZ+zXuATr+ZaIo
         lCEFALylAxsOXk/o0kMo4h+4Gehik1845CRfpqvLeGIhfCRjXlQv5x3I4w9RZCvt5z
         MDk+3io4MORQQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 00F30609DA;
        Fri, 16 Jul 2021 19:28:35 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 5.14-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210716050613.875067-1-damien.lemoal@wdc.com>
References: <20210716050613.875067-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210716050613.875067-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.14-rc2
X-PR-Tracked-Commit-Id: 2f53d15cf95824ed320abed3c33759b8b21aca15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45312bd762d37bfc7dda6de8a70bb5604e899015
Message-Id: <162646371499.3285.3170558855798192717.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jul 2021 19:28:34 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 16 Jul 2021 14:06:13 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45312bd762d37bfc7dda6de8a70bb5604e899015

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
