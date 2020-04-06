Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E21419FAB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgDFQpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 12:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbgDFQpE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:45:04 -0400
Subject: Re: [GIT PULL] ext2 and udf cleanups and fixes for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586191504;
        bh=S3almCuQdxi5NuNZgVGpmWn3/2yCs4P/lLo76bKqv1w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VkbxORoGWE7VI1hvFDHId+2VodfDRlxlNPWVdEZ/9JFPMFzJWT+4i06YRteS+z0F2
         AIjesfP2g9T+uyAw5DI6mefdGAA6dvaICVGN/3POserER1/3hM+4qoCJuu/x0VtBkT
         XfGzknYR3uNlsVRG1wyqcitoKxkOLOh3kMJ3JD94=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200406113703.GE1143@quack2.suse.cz>
References: <20200406113703.GE1143@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200406113703.GE1143@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.7-rc1
X-PR-Tracked-Commit-Id: 44a52022e7f15cbaab957df1c14f7a4f527ef7cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74e934ba0d6edff10eefe6c40f48edb6ebdfadc1
Message-Id: <158619150398.17891.10028358036909518309.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Apr 2020 16:45:03 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 6 Apr 2020 13:37:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74e934ba0d6edff10eefe6c40f48edb6ebdfadc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
