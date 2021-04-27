Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF33736CC53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbhD0Ud0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 16:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236967AbhD0UdY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:33:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F1A5C613E7;
        Tue, 27 Apr 2021 20:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619555561;
        bh=JmoPGjEYi3HBTGoAQwT0Pp8lTIax0AdDaUZ2F8FIxBQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fvAFIcZ9BA9sqBi1qzqRjRgYcQL8W/k3vhgo+/jBB0KOGjevF2Xx9QeXN9WGs6/xr
         CMsQ+ndZ80+xnJ5aq72s0YHjJTazY/4WA3UBUIu7SQG5VAtv/bbgFD58i1yF3Epmwd
         CplKtHGhp2PNvd2xVnyjWHuIqMSSGKjOoomS0JYf//AUThj8F8xTvKao5UlBV0MCS+
         Lmn2Ix6UGrMIWyKrwu0rQlpmxmR06t3coTMBwhETf2NTRUgKmKSB/b/HFunNCgLabG
         KVjr9SjPn6VRjDoI85qlfiK2S4V0t0zBF3cSQdBp/yRNoY6NCnZaSMo6TYbqd2sZrN
         wDybeqa2pk7rA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EA624609CC;
        Tue, 27 Apr 2021 20:32:40 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Preparation for fscache overhaul
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3785063.1619482429@warthog.procyon.org.uk>
References: <3779937.1619478404@warthog.procyon.org.uk> <3785063.1619482429@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3785063.1619482429@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-netfs-lib-20210426
X-PR-Tracked-Commit-Id: 3003bbd0697b659944237f3459489cb596ba196c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fafe1e39ed213221c0bce6b0b31669334368dc97
Message-Id: <161955556095.29692.2509137907732531548.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 20:32:40 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Christoph Hellwig <hch@lst.de>,
        David Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 01:13:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-netfs-lib-20210426

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fafe1e39ed213221c0bce6b0b31669334368dc97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
