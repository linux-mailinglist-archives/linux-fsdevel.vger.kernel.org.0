Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CCF32218B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 22:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhBVVgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 16:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhBVVf4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:35:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9A0A864E4D;
        Mon, 22 Feb 2021 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614029715;
        bh=4J5hUWzxOoQLHZk34zsNaBQnKxTP5Tv8KI4YmB7NRI0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Py9JyLAJosly/2DN3uWEq8Up6qq+VxS8AcrILa8VtI3dcrgt/l2Y5DdJpy89QODhV
         raFbRe/2sSCRJEUfc/B9jobSg1rdYTDxNcLDKD4dxOHfHCMTcJDrqMPiaeBXtBhdJI
         FPEJg4VwwoY5mrD9M0u/mfXt6wkNx2tyWdigcnzltAmH1lWMYvJmZJWK9cLoAVQV/a
         WvLd/OiMOc1Dyp7XrizxNZLVZA9kvMlmOWvyczF+QOW4NrtXEyEOfEkTRtY8f1h79S
         Y5lUKZkCrTKD9tMJRvmBUP+NHxvFN8/BmWUMGRNW5oTPNM9t0LPI9CqJYwOtWBvTXq
         1C5QXB4vkledg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 95F9260982;
        Mon, 22 Feb 2021 21:35:15 +0000 (UTC)
Subject: Re: [git pull] RCU-safe common_lsm_audit()
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDLhphz/PfGLTXfx@zeniv-ca.linux.org.uk>
References: <YDLhphz/PfGLTXfx@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDLhphz/PfGLTXfx@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.audit
X-PR-Tracked-Commit-Id: 23d8f5b684fc30126b7708cad38b753eaa078b3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 250a25e7a1d71da06213aa354ece44fb8faa73f7
Message-Id: <161402971560.2768.5357763934785810618.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 21:35:15 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 21 Feb 2021 22:41:42 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.audit

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/250a25e7a1d71da06213aa354ece44fb8faa73f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
