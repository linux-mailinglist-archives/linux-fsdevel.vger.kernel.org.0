Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45646F405
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 20:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhLITjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 14:39:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55724 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhLITjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:39:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6746B82619;
        Thu,  9 Dec 2021 19:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A868C004DD;
        Thu,  9 Dec 2021 19:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639078545;
        bh=/B8MZfuF2PiUKU/dpQjhlndknOAavngy/nwkmyVKPfM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hXhVzqn6DK/6IB5ddz/8Nl2W/U8YpDk2VeKx7mHfKvH2wq3pyOMLUJ+EehPVw5lpN
         XIDNHzU/Z7TJfc2XY+ACbvjkU2zHkiDXk1S5j8dx5k1/fmHqCKzHT9KTh/U5nK/Hbo
         f/dY3M5hsJlMVaS69nhJPByV3c+wwrAibHuwX9tF2anAdBnCGD8czTke137bDOZwS/
         SbJ1DJgm0TxHNcNp8SnQxykTnPam/E2oh1qAkG5RZeUflpe9TzF8nkFIpt3F0Fj3DL
         ePcA7vmHWo9/Kmr6dZgU8HVj1VrdMOelmLKU4xgN4SbOAbsXw+iDdMuCvHiRTj6GIq
         Y3Ofr4biEFNaw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7662260A37;
        Thu,  9 Dec 2021 19:35:45 +0000 (UTC)
Subject: Re: [GIT PULL] netfs: Potential deadlock and error handling fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2420479.1638912905@warthog.procyon.org.uk>
References: <2420479.1638912905@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2420479.1638912905@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-fixes-20211207
X-PR-Tracked-Commit-Id: 3cfef1b612e15a0c2f5b1c9d3f3f31ad72d56fcd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2990c89d1df457bd623371324998ee849806ddd3
Message-Id: <163907854547.11961.11637701892287062553.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Dec 2021 19:35:45 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        Jeffle Xu <jefflexu@linux.alibaba.com>, jlayton@kernel.org,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 07 Dec 2021 21:35:05 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-fixes-20211207

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2990c89d1df457bd623371324998ee849806ddd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
