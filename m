Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8CC37039B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 May 2021 00:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhD3Wlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 18:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230378AbhD3Wlb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:41:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2711961220;
        Fri, 30 Apr 2021 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619822443;
        bh=GPaMCmokkjPy47sUOsWkQEpqVas9TA62sViyq/LsuXE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U9N4/4A+1as4qrNoXxeLK1DPHlwubhn83IMZM3oDIb3SOKFMFd9V6G+tAoNMwetC/
         swT7EPjLHIcPIwtwtNJ0MO0ouXo+YgnH/IxK7YZ2AyrX7aX9mKy3F/2OaxRH/STAbw
         rwbhzyn/Wo89tQ2RDmDbnpW6BdnpYOEQoVAhlK/5fQFEChGIC+cL4t8VeJVPcGSAe8
         +oafGFnI5aAiFYKn4tTeSCtx0QPF9bFf6w2IzB3+eM9F7fOg8Ce6cf0jhNaHOUVUms
         jMPRVxtPutSIGfOVB1uRDsyt/SqRaP8e5su+ut1++WlkoBRd2jgz7S05wHa6b+F2HP
         11/a4Slk7Rfkg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2127960A23;
        Fri, 30 Apr 2021 22:40:43 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIwb3caM4c2Mi7AR@miu.piliscsaba.redhat.com>
References: <YIwb3caM4c2Mi7AR@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIwb3caM4c2Mi7AR@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.13
X-PR-Tracked-Commit-Id: 3c9c14338c12fb6f8d3aea7e7a1b7f93ce9e84b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ec1efbf9ded6cf38fd910c6fe943972d970f384
Message-Id: <161982244312.6177.5008775398079476710.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Apr 2021 22:40:43 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 30 Apr 2021 17:01:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ec1efbf9ded6cf38fd910c6fe943972d970f384

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
