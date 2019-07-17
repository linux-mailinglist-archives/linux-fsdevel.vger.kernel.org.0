Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C6E6B449
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 04:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfGQCFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 22:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfGQCFE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 22:05:04 -0400
Subject: Re: [GIT PULL] orangefs: two small fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563329104;
        bh=xwh439x4L+4o6HDOo0eU3WwdHuWJp29e+G6lgf0mAuo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=toiaOWYkotPAdF4Zdbo9mWgbOrqtZry1iXeLK52pJ8V5/pWntRLjfLLhPrAYmhH9p
         gutoq20S2ajWuG9eCDR7y09yit1PK5po24J82y89Zn8QmCGSG1/PBASKOW3iKlfx0Z
         2tAQWoRBdVEZNy50GvVKJaxmnNo4BNErFs9AkQ4w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSRq3h=vT1ZXMrZNn3_0gWtYSEPOUv=NyY9Ukhgi_Xa68A@mail.gmail.com>
References: <CAOg9mSRq3h=vT1ZXMrZNn3_0gWtYSEPOUv=NyY9Ukhgi_Xa68A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSRq3h=vT1ZXMrZNn3_0gWtYSEPOUv=NyY9Ukhgi_Xa68A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
 tags/for-linus-5.3-ofs1
X-PR-Tracked-Commit-Id: e65682b55956e9fbf8a88f303a48e7c1430ffe15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a8ad0ffa4d80a544f6cbff703bf6394339afcdf
Message-Id: <156332910394.16657.3657174104012053044.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 02:05:03 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 16 Jul 2019 13:17:33 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.3-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a8ad0ffa4d80a544f6cbff703bf6394339afcdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
