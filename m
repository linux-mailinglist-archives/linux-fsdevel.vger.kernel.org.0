Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890E6405DD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 22:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345192AbhIIUFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 16:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233316AbhIIUFJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 16:05:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 933666115B;
        Thu,  9 Sep 2021 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631217839;
        bh=ihLxtxWNgvVzE0MYMhf2GJMvhICyNuJfrgn2CY/n89M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aeA0bi/mnNw5Xzg+3l6guVvKGUs/czqht5CxXdSI/ZzVOCkdeQw1M+0VXazkdWlHi
         QyJJq/j2UBFQlwlDIg8msthQ/afNCiOVCTzmxI5QWM9R/M7jTB+glDdUIELoZUu9CP
         BcrLCbfR4DjQIpQxCOaNmzsEy44+WT0EIRvep4oAac3d24qGaR2vM6veQ7BvTFndVI
         s+GuiBE/CGGesopvubfn8/SqHSWluHRis9liY8aHvcvM6c0OQYf+yJ9iSzfnZCDoGL
         tjEgLvjbTnQXbLwYvyyAPQF3Vynr/7dqAEOUf75PkMo28gt0C0FueYXjyQ5dByuOT4
         +ajM/dZ0VsnaQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8DBEE60978;
        Thu,  9 Sep 2021 20:03:59 +0000 (UTC)
Subject: Re: [git pull] iov_iter fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter
X-PR-Tracked-Commit-Id: 89c2b3b74918200e46699338d7bcc19b1ea12110
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b7699c09f66f180b9a8a5010df352acb8683bfa
Message-Id: <163121783957.16320.2567864418643929092.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Sep 2021 20:03:59 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 9 Sep 2021 04:22:22 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b7699c09f66f180b9a8a5010df352acb8683bfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
