Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C0E2E2C1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Dec 2020 20:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgLYTKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Dec 2020 14:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgLYTKT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Dec 2020 14:10:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 06AA322203;
        Fri, 25 Dec 2020 19:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608923379;
        bh=4FbaZJLaIV9w+cSCqzNejnBDiIAXN5ijihhIX7i65zQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HbeyLKvTcQ0pagZmknokJj+QkktmlI/P5ckGuIwoJDOOewOvYlwLR+VuXC9KyUPqR
         hCpz7T2t9pDu5rj+WCAzbGrr3ma9vUPyN1RgGiKDvVc6q1uKJD7mw/FV6AYb390VDT
         PBUVLE1thWKgrdO4jwdE7rUQvC+M0T4DNP6tOpIUCg7eBMJEtcBZ9IJQGxQc1aCuR7
         eqecBGnPqhDttOQkmCvBq+HPcRm5vQpAPlmmjoHJikl0vSGUCZMSWWWBaTqJ7uDUt1
         EHHNNlgUYTloKBpU/3W0/2sPPcZkfHbqdEaLHl/5ZzBSMfBSQntRJkdWrMNIo0DxD0
         Hh5EyNjnQE+XA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id E8B85600CE;
        Fri, 25 Dec 2020 19:09:38 +0000 (UTC)
Subject: Re: [git pull] vfs.git misc stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201224233507.GZ3579531@ZenIV.linux.org.uk>
References: <20201224233507.GZ3579531@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201224233507.GZ3579531@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 2e2cbaf920d14de9a96180ddefd6861bcc46f07d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bb5226c8a4bbf26a9ededc90532b0ad539d2017
Message-Id: <160892337888.18440.12691447553520335493.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Dec 2020 19:09:38 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 24 Dec 2020 23:35:07 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bb5226c8a4bbf26a9ededc90532b0ad539d2017

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
