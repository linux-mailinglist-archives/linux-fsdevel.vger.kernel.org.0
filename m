Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D796E1851A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 23:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCMWaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 18:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgCMWaE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 18:30:04 -0400
Subject: Re: [GIT PULL] overlayfs fixes for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584138604;
        bh=I1/Uo5r8zJxfH2QrS8CQuphlInGnHcRlU6B617jbaxU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jXLA023gfw9b/ng5JOdpAAICEt3HgOdIjmtVjeblqfOJ7Y2w9JebSiZWbMFxxI321
         358rKeebDqr3AvebgdwyBhVYJUgBdTCpmcr5rNPxyBy5B6+W/clEL0cdoAzrdniSGL
         frKOzWk7UN5l2jPx4dW5UDdg6+P6AUw65l1hb6uc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200313211624.GC28467@miu.piliscsaba.redhat.com>
References: <20200313211624.GC28467@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200313211624.GC28467@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-fixes-5.6-rc6
X-PR-Tracked-Commit-Id: c853680453ac235e9010987a8bdaaba0e116d3c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2af82177af47a3bff0cd0113dfde14d6e44a6243
Message-Id: <158413860421.20505.13797238837339472073.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Mar 2020 22:30:04 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 13 Mar 2020 22:16:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2af82177af47a3bff0cd0113dfde14d6e44a6243

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
