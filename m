Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC843B7C1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 05:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhF3DiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 23:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232769AbhF3DiP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3081061D08;
        Wed, 30 Jun 2021 03:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625024147;
        bh=YtguVb421KTbYcHsd8FUsC7lV/zTLby4vlfAIsudpeo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GC8nFD7GPPT3wdU9jm148Dmwap7XsQOHDm5mYAab/Fhq7G/TWL0Jrv1MUD8etakPL
         9lNo4Fb4r8vSiPIBbyKm0U8bwsaPu5BH6GyvYhRwvRKIrohf6XuSWO1HrnoAOICIbj
         Ig0K+vhdP+xya2YDdk1eMWru47N3Ag/1b7+admvhDT8fobnImAbGCcZ+CKbqkGaD+t
         +PlMEUHDkiq04zIEIrl1CxL/Cmz8xNLLVoEkWYJbG4il/rp5zU7cOkjH3oIjqrvjmi
         owc9KuqjZUjY0FN8S+OfUCNtF6c9c1e2xYCxnoJ9dJwu0JYjpqSOgaKTLaOSvN1HEZ
         tdKKEluMyaR3g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2B34C6095A;
        Wed, 30 Jun 2021 03:35:47 +0000 (UTC)
Subject: Re: [GIT PULL] openat2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210629123533.1191246-1-christian.brauner@ubuntu.com>
References: <20210629123533.1191246-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210629123533.1191246-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.openat2.unknown_flags.v5.14
X-PR-Tracked-Commit-Id: 15845cbcd12a571869c6703892427f9e5839d5fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b97902b62ae8d5bdd20f56278d8083b4324bf7b5
Message-Id: <162502414717.31877.258663419834561149.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 03:35:47 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 14:35:33 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.openat2.unknown_flags.v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b97902b62ae8d5bdd20f56278d8083b4324bf7b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
