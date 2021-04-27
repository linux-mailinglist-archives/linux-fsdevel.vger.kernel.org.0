Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373D836CB2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhD0SiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 14:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238516AbhD0SiX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F37A661139;
        Tue, 27 Apr 2021 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619548660;
        bh=k6Pu9NHC5O5d0LtbJ14Ai7cyISagxteunOh2mQTXrnc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aHgVkSJpEFGCOTg2Z+r3Hyt3dOCbm8XWRsAmixJUE4WpLr0ZjFAZBq/2U1UWsHcmL
         D9H2vZCZsO2kbuCbzuzjCWUwh7DHq4WHF8GubjNXm1a6lRzzbkEuiKL+rJvcQAQ55h
         vBkiV2+Qr8v//rN133RHVsKmuX3QblJklG5V/441ZZfkovpwlCp2iM9Hx5TwlSMfZ4
         NkAUUUXuFNqqaxrjGqmwoNHu9EchFn3cjmXpWoHdjBTNi+ZUstzXiIrlHycNfqN750
         dMtfZI/0FyA2FapkFFOYoEUSxhNJ6sVgMbV65ixx1WYSvog4Hky5KiEVlSzqWpOY1+
         JOJ5cSWssVtGg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EE06C609B0;
        Tue, 27 Apr 2021 18:37:39 +0000 (UTC)
Subject: Re: [git pull] fileattr series from Miklos
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIdByy4WJcXTN7Wy@zeniv-ca.linux.org.uk>
References: <YIdByy4WJcXTN7Wy@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIdByy4WJcXTN7Wy@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git miklos.fileattr
X-PR-Tracked-Commit-Id: c4fe8aef2f07c8a41169bcb2c925f6a3a6818ca3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4f7fae10169cf626bb83e97f229ee78c71ceea8
Message-Id: <161954865996.8916.5627965543576287749.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 18:37:39 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 22:42:19 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git miklos.fileattr

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4f7fae10169cf626bb83e97f229ee78c71ceea8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
