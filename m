Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3360C3FF279
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 19:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbhIBRi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 13:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346734AbhIBRiS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:38:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BAB7D610E7;
        Thu,  2 Sep 2021 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630604239;
        bh=4Fw9FFB2tSkcHBQq6SAMKc8Kr96C7vN25wTLUj0HxqY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K6aDgqQpmmhcN05su8W80ZpsU+ODdKCnRzXtWi7exPGizunXIFehNJMYJ/WMAgY36
         iIwPZnwllHnjNjWUj8F0T4KJdK6XYr7Czyg0Ul8XcdV4bu2U0sxhuU5tgl5P6wIi4x
         f/qiHGzDAxVxUlJrnytOjtw1gc6hUb2S18R7xxLfQGhrjTXLbvscGO2HSCgFQdklVs
         xvVAahL9TgT62ijiMnDJuueTuqQ0UtBQHLs2IUydR1CgDYHkwPugfMd89YNw3Q8Ovr
         zE2l2cHBJM06Lzb7HNigGoJGC7QBJ3dqXqLME4uc9BABjPkixxYO5gr7hBBL6r/I+a
         pKT+iBUxk4RsA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B4E2960A0C;
        Thu,  2 Sep 2021 17:37:19 +0000 (UTC)
Subject: Re: [GIT PULL] configfs updates for Linux 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS9jKWxJxj0+kqBE@infradead.org>
References: <YS9jKWxJxj0+kqBE@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS9jKWxJxj0+kqBE@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git tags/configfs-5.15
X-PR-Tracked-Commit-Id: c42dd069be8dfc9b2239a5c89e73bbd08ab35de0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eceae1e7acaefc0a71e4dd4b8cd49270172b4731
Message-Id: <163060423973.29568.14633387166811937856.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 17:37:19 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joel Becker <jlbec@evilplan.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 13:25:29 +0200:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eceae1e7acaefc0a71e4dd4b8cd49270172b4731

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
