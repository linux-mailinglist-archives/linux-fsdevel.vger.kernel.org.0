Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62BF32218A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 22:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBVVgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 16:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230444AbhBVVfz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:35:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 66CA764E4A;
        Mon, 22 Feb 2021 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614029715;
        bh=dFcogshuu4iXNPje2Jk1D7iOAI034H/CCT85vVmn6oQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WcTAom9nKuUeXm0niBi7Xm6lPEpI2pfPoPc97mCV54SCloQ5rjYSyljpwKCBanE+A
         RhAm6TyAQW5KFH2c9jrxa3cfXDJlmiltWPCzoR/Mr2V7LM5Rgd7UV6ozf7672ylJZw
         b/UBlc501Z82YYB7Qb1zERzVvDr7WeQDEZz9aF49n6sDG/lAZ+cM5SGPDRNJ0r9YjU
         UnLXrmf3AroqFL04LOoB1v38CoVJ0lcMsIAQmNiG36dlB4FM6qsZcDKQxOziMNshd1
         7HkXcYxZu9eqcR70jA3tTR/k+IDH0gPO9EkGNbcb7EKuBp7ZWbCNTCDGPEjJFCPhJy
         uDOcQ23YslMow==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 626F760982;
        Mon, 22 Feb 2021 21:35:15 +0000 (UTC)
Subject: Re: [git pull] d_name whack-a-mole
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDLfXNMwX6X4R/QS@zeniv-ca.linux.org.uk>
References: <YDLfXNMwX6X4R/QS@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDLfXNMwX6X4R/QS@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.d_name
X-PR-Tracked-Commit-Id: d67568410ae1c95004fad85ff1fe78204752f46c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 205f92d7f2106fb248d65d2abce943ed6002598f
Message-Id: <161402971539.2768.2584250045244968878.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 21:35:15 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 21 Feb 2021 22:31:56 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.d_name

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/205f92d7f2106fb248d65d2abce943ed6002598f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
