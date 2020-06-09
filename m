Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307301F49FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 01:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgFIXKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 19:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgFIXKE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:10:04 -0400
Subject: Re: [GIT PULL] afs: Misc small fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591744203;
        bh=PWL47kqkwUUVGbUhRreca/H463T7rLQ4+w8MVdM3OVw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PjSkZzlPvVuUis6st1gRwV0CzxRYmdpsOtJsda1zzd76l4nbTr6AXmoSP1oxrk7tZ
         gfz49wb6CHwgzX8YPRcdS3GGYdhjm2nurSQX0cgbL+vXqzppzXu+s8ySRV0NmTU/dE
         zJL3m51V/Qll7mHeOffIEXYDZcavA7bxTXSnQzM8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3071963.1591734633@warthog.procyon.org.uk>
References: <3071963.1591734633@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3071963.1591734633@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-20200609
X-PR-Tracked-Commit-Id: c68421bbad755a280851afff0fb236dd4e53e684
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4964dd29140a44e26474dbdca559b7393aba6c39
Message-Id: <159174420387.2962.13061146341675614064.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jun 2020 23:10:03 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        keescook@chromium.org, chengzhihao1@huawei.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 09 Jun 2020 21:30:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20200609

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4964dd29140a44e26474dbdca559b7393aba6c39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
