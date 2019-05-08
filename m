Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7298317038
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 06:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEHEzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 00:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHEzC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 00:55:02 -0400
Subject: Re: [GIT PULL] AFS fixes and development
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557291302;
        bh=51OU6zrDGh8cgnFmsUBmDw6WGnV4s3BjfmxvI6z4C2g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kR8NhlH8vJ2BxtiNoyo98nDAAa8xB0KX97IF/2dEOobCKYilDvWAha390WtDMa0bi
         shzRcGrY5JaLbktOjLYunLiYmJGtkpY2PQ2Wf1+fXqCB1rydw9HIs5lfBGZ56XeuGy
         WfrBfNARprBG6KfNp6H6Cx6lrRlWC8INPVMQ3XNE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <28470.1557259877@warthog.procyon.org.uk>
References: <28470.1557259877@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <28470.1557259877@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-next-20190507
X-PR-Tracked-Commit-Id: f5e4546347bc847be30b3cf904db5fc874b3c5dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5fef2a9732580c5bd30c0097f5e9091a3d58ce5
Message-Id: <155729130225.10324.6561479759670477472.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 04:55:02 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 07 May 2019 21:11:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20190507

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5fef2a9732580c5bd30c0097f5e9091a3d58ce5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
