Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B992718E85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEIQzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 12:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfEIQzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 12:55:03 -0400
Subject: Re: [GIT PULL] orangefs: pagecache series and one fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557420903;
        bh=eBmcqBMEY5Jjp6b97Nbb88dZvs2zsF1TSoAUry51d4E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rl9vfUI71d2SPh0C+BwYJ3k4pAeKg7IMuKprPNXxoNuoaMBcATD6OfHpZyEtMH2Ug
         3nQ3zZAJwsigtAJ3N+GoSOVPWEjLfXCYxJAhwvQ9TKBxF9eJmLG6xANlxlNzOYsivT
         m6Up5+mbvaBoZGpsOXhV1PYkWLoMscK+4fD4CMq8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSTd0B7m83=+HqJPHMZBOM3fpDtN+_ntXTHhFXV5KMvBPw@mail.gmail.com>
References: <CAOg9mSTd0B7m83=+HqJPHMZBOM3fpDtN+_ntXTHhFXV5KMvBPw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSTd0B7m83=+HqJPHMZBOM3fpDtN+_ntXTHhFXV5KMvBPw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
 tags/for-linus-5.2-ofs1
X-PR-Tracked-Commit-Id: 33713cd09ccdc1e01b10d0782ae60200d4989553
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 882388056194d2d4c3f589b194b6bdcc47e677e8
Message-Id: <155742090296.26334.8952727875215583365.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 16:55:02 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 9 May 2019 09:49:06 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.2-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/882388056194d2d4c3f589b194b6bdcc47e677e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
