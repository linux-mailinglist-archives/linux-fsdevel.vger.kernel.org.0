Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD28470E31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 23:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344847AbhLJWuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 17:50:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43686 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344774AbhLJWu3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:50:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7BCCB828A7;
        Fri, 10 Dec 2021 22:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81DFEC341C8;
        Fri, 10 Dec 2021 22:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639176411;
        bh=pxF0/2zMlOEQAX4ET+9rM3THnd4Zsq9VxSG2uxlgnFU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FkO8DCrxtuvF+rE1QLAcGq/2nIfI7WHs6mkbxWUvnMECDm9OpNsOEQN89LkYkEZt0
         OqpE6N9eBAuu5t9KVSaAu9RgEtbuiyTCXgjfun3hA8tRVp746sWZgSdXacJAHFALi1
         SYPaz66KJQWXD5DgVWhTXZQxnWMN+y1BHHFlMzeRhZ3EwP/Brra2ZIY6No6GXSFtp5
         MIQfA0NV9+mGzR7vmzbByN9MLOeE5OotHuu/hzAEMuftR1Wk7AVuGGGJFaR4mMudXS
         K8yps6uOpxu/TEmBteZsmw0M39tGrjn7wyFr2KZkc3yalwp4G52EEN5dxBEK8bMrUZ
         R6rmFfpvGRGHA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6F3C1609EB;
        Fri, 10 Dec 2021 22:46:51 +0000 (UTC)
Subject: Re: [GIT PULL] aio poll fixes for 5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YbOdV8CPbyPAF234@sol.localdomain>
References: <YbOdV8CPbyPAF234@sol.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YbOdV8CPbyPAF234@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/aio-poll-for-linus
X-PR-Tracked-Commit-Id: 4b3749865374899e115aa8c48681709b086fe6d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d21e6684779493d90f3dee90d4457d5b4aed8ad
Message-Id: <163917641144.4787.12367310718709441357.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Dec 2021 22:46:51 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Xie Yongji <xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 10:32:55 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/aio-poll-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d21e6684779493d90f3dee90d4457d5b4aed8ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
