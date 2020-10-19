Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31DA2930C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 23:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbgJSVqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 17:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgJSVqE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:46:04 -0400
Subject: Re: [GIT PULL] zonefs changes for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603143964;
        bh=b0XkMSUQuwNcs477W9klzcpKnd4e7zfBZO+RubyJIrg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q2GF9xiCCk6XbUhYB56OCBjQqVFeC5RSON0ZSO85KMKSLhnEBbiXwY6UyVlb6Ub23
         HluwOS0lY0NukAk/dm45ZeUoF/6+Zwj0DROThMgvRwlZKJT0NDJw+DjCcod9/gsKiY
         L61usarZjwmZpu5gET4OlXf3ZLscY38voTPkjoOQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201018232541.87913-1-damien.lemoal@wdc.com>
References: <20201018232541.87913-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201018232541.87913-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.10-rc1
X-PR-Tracked-Commit-Id: 48bfd5c6fac10e10b7066bf4aeb919ed9a4e87d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 922a763ae178901c2393424ba42b0aa1be22bf06
Message-Id: <160314396400.24665.5025622887283986808.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Oct 2020 21:46:04 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 19 Oct 2020 08:25:41 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/922a763ae178901c2393424ba42b0aa1be22bf06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
