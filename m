Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA150496B75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jan 2022 10:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiAVJkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jan 2022 04:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiAVJkI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:40:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA7C06173B;
        Sat, 22 Jan 2022 01:40:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE813B81785;
        Sat, 22 Jan 2022 09:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44C43C004E1;
        Sat, 22 Jan 2022 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642844405;
        bh=henkmRl3HfTRAowTOP/RK23Q67yuCV3HA56VhpKoBks=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NKM6qjRQaQm4rNU9/RrE7JODEuKQEHJpghqkSS1311lLhHxtdUZm4BSjgz+h8z2zQ
         QSVYgZs739kQqWfPYOZDTRxBUjgy7GeH/n1McqDHhBOWT21dqXVsuyyGty53wWjvOQ
         TSPqLmRCdBD3sU8D1PqbcKdPA1skGg89V0ZLvieurJbQjRbaa79MvZDYTxQcWJ8d/L
         Ym3D/50s55/IJ2MkUuZxH9Z4ppCLnNkOeAFoKvpxj3hLFn2yiYOHqY5PNTkquUSmK8
         fk5jmGpQN7/QEagAqziftFzzvkIN8iBFWOjl20RuaR7K8NCcZCZEiB+X+REN4HBN6H
         uNehTqqPl+qVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23234F60796;
        Sat, 22 Jan 2022 09:40:05 +0000 (UTC)
Subject: Re: [GIT PULL] fscache: Fixes and minor updates for rewrite
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1339462.1642802244@warthog.procyon.org.uk>
References: <1339462.1642802244@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <1339462.1642802244@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220121
X-PR-Tracked-Commit-Id: cef0223191452b3c493a1070baad9ffe806babac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fd350f6ff846f788ba5f6668bacf2ce4257ed8f
Message-Id: <164284440509.7666.8294766242390570357.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 09:40:05 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        Steve French <smfrench@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 21:57:24 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fd350f6ff846f788ba5f6668bacf2ce4257ed8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
