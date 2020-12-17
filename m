Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419DE2DD9C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 21:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgLQUVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 15:21:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgLQUVw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:21:52 -0500
Subject: Re: [GIT PULL] fuse update for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608236471;
        bh=htZ9dC7kXJNGV5gFerar4D+zh2VagPXohApZTnVqpcE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=O1UY/jhL5J/wngOjAHqGXbPn8umbkf7Bw/QVEdV+qF4jhLjt42QR4wDQmc9Q33rrl
         uySH1pOBlgGKGlE5sJjgo3zNN90tZcvvaqE/1MTjw2fRy9UxrMWhE8ZESnxzoWR/Yp
         MoNkh1braE+lt4QlEPV/BmPui39tpI1TLfS48yoN33HVpaV0I+BSl+2Auk1/PcIVZt
         Ain3wSxxCHOXlJnl56Hd8mqGC8H3nS0CWBaWSD+E8VOVdslo5TJGKws+ZT9ZqXzhsy
         0Sg91c8wAz1SgQA2oT6OwP9QcLbx7sMooJ72SnwCj7oEocGUWR0S7PLvME5Y6OQyuq
         owDm7xtY3h/zQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201217131822.GA1236412@miu.piliscsaba.redhat.com>
References: <20201217131822.GA1236412@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201217131822.GA1236412@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.11
X-PR-Tracked-Commit-Id: 5d069dbe8aaf2a197142558b6fb2978189ba3454
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65de0b89d7d5e173d71cb50dfae786133c579308
Message-Id: <160823647175.7820.14305348502699197759.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Dec 2020 20:21:11 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 17 Dec 2020 14:18:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65de0b89d7d5e173d71cb50dfae786133c579308

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
