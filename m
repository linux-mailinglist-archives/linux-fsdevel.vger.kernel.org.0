Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB12F3FCE06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 22:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhHaTxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 15:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhHaTxk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:53:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 78FA16102A;
        Tue, 31 Aug 2021 19:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630439564;
        bh=jZa5D6AIr4hbzXMkxktK+gC+grlVG8gL51Q4Tj7GZTE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nITVwRA7S57ai/UEXtD5rYIG9Iuw/fBpOYuF61FRaybKMCg8Cz9qnaMTPC4c0GjTB
         IbiLQf+Ivta32Vu3yQdL1zkURAdYjzJb5zjqDl88xzRwzkyQk6bFyy/6tP9P5oYRtv
         BJW/eA1Fi0H1y3rS9+9LMp+E2pDBOb8yKXpe/KVPoGYvNOe6Y/XMdodpQH7MJIIxeY
         Ffg25vIDhurA60b82REh8WVH0ZlyDNGGhiCwPhEbXbGu1Jr/z1iiQ+k22hGeM7jSOw
         u0c/jTpBAjHi+OWuSUA+V6A6NfIqX1zgnfMIBDvrXwBwLB3PI38CPesSbseSvL8vSu
         82Xy1ZzfI6V1Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 67F8060A6F;
        Tue, 31 Aug 2021 19:52:44 +0000 (UTC)
Subject: Re: [GIT PULL] move_mount updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210831100119.2297736-1-christian.brauner@ubuntu.com>
References: <20210831100119.2297736-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210831100119.2297736-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.move_mount.move_mount_set_group.v5.15
X-PR-Tracked-Commit-Id: 8374f43123a5957326095d108a12c49ae509624f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dd5915a5cbda100e67823e7a4ca7af919185ea6
Message-Id: <163043956436.8865.9529492510006031457.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 19:52:44 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 12:01:20 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.move_mount.move_mount_set_group.v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dd5915a5cbda100e67823e7a4ca7af919185ea6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
