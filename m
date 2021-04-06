Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426CE355CC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 22:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbhDFUPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 16:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhDFUPK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:15:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 59900613C2;
        Tue,  6 Apr 2021 20:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617740102;
        bh=d0i5fE9ZWgos2cHY/Wh7wQMy1grscqYIv68Ws0MnzMU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MBuDK154jGz6b0DWDnqKJwHOEufLCQ1DbmlUsxuPTlA9JKmrDX+lxkoMGGAvhVM/1
         AUanySBdqrkQGDhdX0h98jMThy6CIqkNamAYuDvqRWv4DjMVImzwz4/n7+23Nbc2I4
         oXBbmj1N5Ayt4fA3aLlDAI/1QgBgiZ3iwldBHtKHd+qTv3mxpIWwFO3EEn/Hi3G02b
         4AOGb9YfyPilIdbVGXUz2cHRq1oZC28PorWegQAhpNkP3QRj2eny4bYSbewP5qHxsB
         qJATKIMzXTc9lnAKT1TDKhCoQLn1Ku5Y0GfgvDwHqEg8knh6ndKSiijS83DcuJ/46i
         wUk9YeiusyCWw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 46ACF60978;
        Tue,  6 Apr 2021 20:15:02 +0000 (UTC)
Subject: Re: [git pull] a couple of fixes in vfs.git
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YGyXH6qTQbcoOLJ+@zeniv-ca.linux.org.uk>
References: <YGyXH6qTQbcoOLJ+@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YGyXH6qTQbcoOLJ+@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 7d01ef7585c07afaf487759a48486228cd065726
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d743660786ec51f5c1fefd5782bbdee7b227db0
Message-Id: <161774010222.9523.18312914559066876658.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Apr 2021 20:15:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 6 Apr 2021 17:15:11 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d743660786ec51f5c1fefd5782bbdee7b227db0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
