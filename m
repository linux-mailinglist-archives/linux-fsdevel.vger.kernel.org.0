Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A72C930782
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 06:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfEaEAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 00:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfEaEAB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 00:00:01 -0400
Subject: Re: [GIT PULL] configfs fix for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559275201;
        bh=gBqtohv8L5L/MGwJDoTN7iyjbOaZAWETAIXm6f0JhZI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mGKBVC0PG0cJU5yfcQibR0ekMs0iqo7mn2UX2A90tTubunIodTlA2czx6rN1ukG8l
         aQa2Rmmprbb5djVMN/1uMyV047ZBnZsZrTtvqSM3LBIW4VuFgN8Hkyee9Ooz8YnUhn
         IK8GrG0LaIJ8SHeHFfuUx3ApytsOFfa/mLLe155A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190530085321.GA24647@infradead.org>
References: <20190530085321.GA24647@infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190530085321.GA24647@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git
 tags/configfs-for-5.2-2
X-PR-Tracked-Commit-Id: f6122ed2a4f9c9c1c073ddf6308d1b2ac10e0781
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cb7104d03dddeb2f28e590b2d1fab7bf0eef284
Message-Id: <155927520131.31954.10692279844335458558.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 04:00:01 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Becker <jlbec@evilplan.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 30 May 2019 10:53:21 +0200:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cb7104d03dddeb2f28e590b2d1fab7bf0eef284

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
