Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECFB1A4D29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Apr 2020 03:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDKBUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 21:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgDKBUE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:20:04 -0400
Subject: Re: [GIT PULL] orangefs: a fix and two cleanups and a merge conflict
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586568004;
        bh=6T2VQApC3NkKw7DoEort9CtNiuIlCpTergh5jCrcdE8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o4t8Wqn6YY+xbCxJjSx9xYScDWnGUr+PlLfeD4Ojigahe0JEYK0NXyIbKWBvAmB7v
         JWuq0vUtUiawbUyNBl1SdVA4oliLTHHsjJvffxpdVAh6W6VvHbjq3tUo4++Zoz8opS
         feWIB+M1rsTg4kc4I37spN7vezxSvD0SjmAxwuVA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSSeHarznzQOBr4GkdxMHqSTEEj786o8yG1nZ35C0FYSng@mail.gmail.com>
References: <CAOg9mSSeHarznzQOBr4GkdxMHqSTEEj786o8yG1nZ35C0FYSng@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSSeHarznzQOBr4GkdxMHqSTEEj786o8yG1nZ35C0FYSng@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
 tags/for-linus-5.7-ofs1
X-PR-Tracked-Commit-Id: aa317d3351dee7cb0b27db808af0cd2340dcbaef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e4bdcfa21297ab6f4d963edae3abb8ec4eac312
Message-Id: <158656800463.16442.17342596625957694196.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Apr 2020 01:20:04 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, hubcapsc@gmail.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 10 Apr 2020 10:52:50 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.7-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e4bdcfa21297ab6f4d963edae3abb8ec4eac312

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
