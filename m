Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075CE412972
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 01:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbhITXfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 19:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238986AbhITXdg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:33:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0FA7960F56;
        Mon, 20 Sep 2021 23:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632180729;
        bh=6kAENSCIeNPtlS308QydqmtW6JFhCqP4orq7EVkOqTQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M5bzd37Lor9eCpiwe4LH5tBfnU/WStsU8CTS8ow0TZpAKylr/evYua+JSMgtoUji2
         sKPsqJDeB/dkpAs1Ls9uMlIZXGdx21FqY8gC994Hm6XYUzDOoK8WVxeGn4PybVp0q2
         vSKUeTRrW2EQUd7Z6I1B8qyAjSsxpmQkL33jUCLiD30pnRjnezZSEPm4s5Bd10bnTV
         eK82Uj6NcBjoH6VQj2UKn+MGID/rPoHjIRVyuuaMtI1rk53AmONJtHoIS4els7qSq3
         DBP90FMXSDMJCalysPxHGEvKh/2Gu4NROHMwhSFuPMvZdsxKfU42uZfOZKht1b3gIZ
         DJ7yBxCXqwU9g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F08CA60A37;
        Mon, 20 Sep 2021 23:32:08 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Fixes for 3rd party-induced data corruption
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1161899.1631530176@warthog.procyon.org.uk>
References: <1161899.1631530176@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1161899.1631530176@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20210913
X-PR-Tracked-Commit-Id: 9d37e1cab2a9d2cee2737973fa455e6f89eee46a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9fb678414c048e185eaddadd18d75f5e8832ff3
Message-Id: <163218072892.25470.5709272357707508173.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Sep 2021 23:32:08 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        Markus Suvanto <markus.suvanto@gmail.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 13 Sep 2021 11:49:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20210913

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9fb678414c048e185eaddadd18d75f5e8832ff3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
