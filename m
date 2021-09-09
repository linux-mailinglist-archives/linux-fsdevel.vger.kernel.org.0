Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5A405DD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345365AbhIIUFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 16:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345211AbhIIUFJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 16:05:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 25CC36113E;
        Thu,  9 Sep 2021 20:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631217840;
        bh=RbgYPUC+gtrpW90IinWQS02df+bNyA7nF17t9AR/qWg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tr/7Vq+IqJr5hmUUxh45XsrrkyHPdeK1pDJNeXBajHONVPB/rm3mvxd9AYUpmP9Ge
         I1a/lPHJRsj4ZoUqkE1u7ZjWOmPoOQj2fRiQ/4YfOVPjNT+h2WdQmOrvPFCjV8zOuW
         0ogjkO4H3pw6aKjwyo5iGCF2P00VIpOjt/QT5VLVlorvPnT3KXYpIQ+u1REhxyE+ZQ
         KoV1gekRuhWuDuH1SQUUi6RCwySXQ9H9hQyuRw76tfv7MTpH5pV73wvq01D3zlVDR8
         WG4IouCZQYKcOfJFVpXc5CVDAfw/Jow5up5zDfw4fEtko7ckE0LCpaDCAxf8MPCV2j
         wRgJHhdejh98g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 203C260978;
        Thu,  9 Sep 2021 20:04:00 +0000 (UTC)
Subject: Re: [git pull] gfs2 setattr patches
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTmNE6/yK5Q+OIAb@zeniv-ca.linux.org.uk>
References: <YTmNE6/yK5Q+OIAb@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTmNE6/yK5Q+OIAb@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.gfs2
X-PR-Tracked-Commit-Id: d75b9fa053e4cd278281386d860c26fdbfbe9d03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b871c7713d1eafc3a614883bbdf68ab1dffa883
Message-Id: <163121784012.16320.14431585762216143801.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Sep 2021 20:04:00 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 9 Sep 2021 04:26:59 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.gfs2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b871c7713d1eafc3a614883bbdf68ab1dffa883

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
