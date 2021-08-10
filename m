Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE903E7DDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 18:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhHJQ4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 12:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhHJQzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:55:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 971EC60462;
        Tue, 10 Aug 2021 16:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628614446;
        bh=yDyCnF9kOpqMQUvBKRiGkqMShf1t7P8gpGlvnG14Dss=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jrXqDDDXJjVoYx/Z1bT1JEevH6bg/txHWDVMiEi+Qc+/7XNURyHUNeP1XQSJtGESC
         SI26Xfwax8Y5CX4PyOpcsXdTIlCVRfecTHGFrmZhJEqwGU+8QZKNVp62UvUz+QNOLm
         nxIX4lFQj1siP5IBXnEXwtZS9iPr6+fsZMvMYnTrYVZV4U3hrNFbJtdV341+LT0j51
         1lLlkovHUCLiMPWg3CpSVsTi3OPZEyvAbDjpS2Lv5guwTqdUzDhLDCSm5ozj6LIOkv
         k2GW65twSH16KEeqCWhR+tNw1ZFtE6cKi+mW0RB9V9hrIZ7x3j3ZbS1bxKC8e53QOg
         kwN8ERgH9MipA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8193960986;
        Tue, 10 Aug 2021 16:54:06 +0000 (UTC)
Subject: Re: [GIT PULL v2] overlayfs fixes for 5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YRKVYyeAUqJSJ5rk@miu.piliscsaba.redhat.com>
References: <YRKVYyeAUqJSJ5rk@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YRKVYyeAUqJSJ5rk@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.14-rc6-v2
X-PR-Tracked-Commit-Id: 427215d85e8d1476da1a86b8d67aceb485eb3631
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3f0ccc59cfeb508a3774e8653069d76ffadc37e
Message-Id: <162861444647.12822.547943425823515144.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Aug 2021 16:54:06 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 10 Aug 2021 17:04:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.14-rc6-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3f0ccc59cfeb508a3774e8653069d76ffadc37e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
