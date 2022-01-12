Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADA248CF62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 00:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiALXuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 18:50:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44162 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbiALXtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:49:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFD5EB8218A;
        Wed, 12 Jan 2022 23:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FD83C36AE9;
        Wed, 12 Jan 2022 23:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642031361;
        bh=Qjw7uIULxio5olTOZmxu6IZozjzdZ862HeZ0UaChgTs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UYCZPydkqGg2Q3URUB6YZgIG8Y1yuYWukIzeRx8kkPNkfJa/Ut9/B6XoStJh+WQ22
         KoIQQAaRwNFvfexDI9doe0pd5Gh6011qLhi+TDzi4e5mvByUGknKza9V2jhZrzZSmT
         lkVRuWJAgbPsniqudOk05myl8fK2WCFHJV6SF1zgpGJiDv7jeKaNEV/dnFqiIzFrRd
         lqRmsd1k5QKoGHPuXjX7gfejpl/n2k3rfmMwnChTjV/sxkTkqNL6ok6u3322r+WHbU
         OsBsUiFqP3ykzRfG1vtpJpzsXgOBPlwo+Np0G0hnkXlvxBFM0gLtYfBLGBXntL1lrf
         k2J9lt1fys7DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D798F60795;
        Wed, 12 Jan 2022 23:49:21 +0000 (UTC)
Subject: Re: [GIT PULL] fscache, cachefiles: Rewrite
From:   pr-tracker-bot@kernel.org
In-Reply-To: <510611.1641942444@warthog.procyon.org.uk>
References: <510611.1641942444@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <510611.1641942444@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-rewrite-20220111
X-PR-Tracked-Commit-Id: d7bdba1c81f7e7bad12c7c7ce55afa3c7b0821ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8834147f9505661859ce44549bf601e2a06bba7c
Message-Id: <164203136150.22460.7562866194670259510.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 23:49:21 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Daire Byrne <daire@dneg.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        Matthew Wilcox <willy@infradead.org>,
        Omar Sandoval <osandov@osandov.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 23:07:24 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-rewrite-20220111

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8834147f9505661859ce44549bf601e2a06bba7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
