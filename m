Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D9B3FBD20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 21:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhH3TrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 15:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234008AbhH3TrJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:47:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 18C0560F6C;
        Mon, 30 Aug 2021 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630352775;
        bh=Jr4tE7u3KeHa0Mm+8hWQImtu02mpdb2oeK7ALdWTzjs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eE5N2dVcRDlVMDx2d4GZoubNuHIDdOmb/4Ux3kbtjHavtQYFFBsT0hzGke/KdHBIQ
         pwFSi0sk1Zn4imN8lpoL3NtM4o/HaJm59J/n1D1UW+Ubzw+3PcWIUX6ytTLVDTQKwh
         ayqfPWDPWL7oc1hTFtLcvS4VSU9sJSYSymkbsdGtqhEQVLYRE3gJPByNqUizX1roXC
         uwxIVomufUywFnxus5a0RyFZ4YnzAAf8dge0VuD9tXNwCrCxZ4Fx711ligXKOBZo5F
         gCzT9MVHA5alZ+BPupQF5RY3e+ZK+2Pjb1AeIqXpOBEsxpgb4pR1oUYvkHygLaQjuP
         GGJdwA9XF2bWQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0CD3860A5A;
        Mon, 30 Aug 2021 19:46:15 +0000 (UTC)
Subject: Re: [GIT PULL] File locking changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <03b3f42bbc92fdd1c798c29451eac66a0576adf1.camel@kernel.org>
References: <03b3f42bbc92fdd1c798c29451eac66a0576adf1.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <03b3f42bbc92fdd1c798c29451eac66a0576adf1.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git locks-v5.15
X-PR-Tracked-Commit-Id: 2949e8427af3bb74a1e26354cb68c1700663c827
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f01c935d96cd4eb8bbbc5249bd9a754b6939e0a
Message-Id: <163035277504.30336.6247977574501290219.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 19:46:15 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 27 Aug 2021 08:49:36 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git locks-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f01c935d96cd4eb8bbbc5249bd9a754b6939e0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
