Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49364B8358
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 23:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404808AbfISVaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 17:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404795AbfISVaG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:30:06 -0400
Subject: Re: [GIT PULL] orangefs: a fix and a cleanup
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568928606;
        bh=U1iOEhb7AtkM48ANcaBAUaiGNNfs+ylj/rInVLihcso=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YGp8ypHGizGOEQbi1lfjKliuAvsu1wi+IhRZa+n0mk/EV/RGn7Bqhnp+/9pY7wvDB
         gaJuVSVCIZWZ0Mblbti2HRvEX89uKb+gXiqaKFIBt0wNshTgQ7vp3uyMByp/D8idx+
         elNdRL+EtKNkBpHPHQCpyJWOhaHynClCLHgUWNVs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSR8PB9WEoKSHBzhmRLQEA==qMJd3NPyNAnzHqe0khzbpw@mail.gmail.com>
References: <CAOg9mSR8PB9WEoKSHBzhmRLQEA==qMJd3NPyNAnzHqe0khzbpw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSR8PB9WEoKSHBzhmRLQEA==qMJd3NPyNAnzHqe0khzbpw@mail.gmail.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/hubcap/linux.git
 tags/for-linus-5.4-ofs1
X-PR-Tracked-Commit-Id: e6b998ab62be29eb244fdb0fa41dcb5a8ad065f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a0d796100daa8e75cda2c166c85d57775704fd4
Message-Id: <156892860627.30913.11251581342542141190.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 21:30:06 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 12:23:26 -0400:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.4-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a0d796100daa8e75cda2c166c85d57775704fd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
