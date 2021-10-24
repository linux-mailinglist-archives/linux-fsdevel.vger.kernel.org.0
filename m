Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0DC438BBA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Oct 2021 21:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhJXT6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Oct 2021 15:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231579AbhJXT6p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Oct 2021 15:58:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9AF1960EE3;
        Sun, 24 Oct 2021 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635105384;
        bh=Mz1bpOH0QkW1mB3K9a7McP/BDR8k0n+RKRx7GTXsO8w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uioiZvaYA96iiFv5IA1LkQPt9CF6S3LF+jzZe5D9o+EkWJH4icNvqA6YXtLmF/1a9
         JGVtNvv7t+DhVR0mZ5kZ6VuLWErzljrQi55IlPrZSS2j+HUJaEf924zgUcIZ0nGLhq
         YVqKcrUkQXGLl5OI9PzI7Wz7Iu/tMYBSucVawa1D6vkXfV+iHzmAYH4ILN8T+cMHau
         JcOeHMNi1vfSB5X8WS+CXJ0TjHISIZZpHJv76/q116sYSAR2SBMMiV2bw+aEHczhCp
         g+qsJ3l5Xa6ZdaZ5tzWbvb/yqX58SmMWpAtMPfd+r9GBu4cMFsztqcGOWZcukYCytN
         qobt9OFHkXFDA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 89657609D5;
        Sun, 24 Oct 2021 19:56:24 +0000 (UTC)
Subject: Re: [git pull] autofs braino fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YXWhxthSSQgLryOk@zeniv-ca.linux.org.uk>
References: <YXWhxthSSQgLryOk@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YXWhxthSSQgLryOk@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 25f54d08f12feb593e62cc2193fedefaf7825301
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b20078fd69a3da08d85c79b95101cf25c4afcc97
Message-Id: <163510538450.17585.6845971569874636621.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Oct 2021 19:56:24 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 24 Oct 2021 18:11:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b20078fd69a3da08d85c79b95101cf25c4afcc97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
