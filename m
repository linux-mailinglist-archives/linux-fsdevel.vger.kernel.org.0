Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9ABDE8D9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 18:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390762AbfJ2RFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 13:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390580AbfJ2RFD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:05:03 -0400
Subject: Re: [GIT PULL] fuse fixes for 5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572368702;
        bh=Ox7HKx5NzeW3uA2zahha7SNPObb44UmyPOAGV4rMffU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jdeVoQZfW50rwBBv/Skc8bS2og1o1HgNNSVdXbbC2ZnNKRQfv9aZ4jTiJZVgtA2bC
         +WMo+aSn7TRsJ5Q4RBSD/7nKRFvNurodZd9tnXTf+p7VM5idHy7MVF+PwiBDaen/YB
         MJtsapCmJzGFJewUKs2sJCkeoFcTQTOuD39L85O4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191029124717.GA7805@miu.piliscsaba.redhat.com>
References: <20191029124717.GA7805@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191029124717.GA7805@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-fixes-5.4-rc6
X-PR-Tracked-Commit-Id: 091d1a7267726ba162b12ce9332d76cdae602789
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23fdb198ae81f47a574296dab5167c5e136a02ba
Message-Id: <157236870243.18301.6340281762330254385.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Oct 2019 17:05:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 29 Oct 2019 13:47:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23fdb198ae81f47a574296dab5167c5e136a02ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
