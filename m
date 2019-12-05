Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3591148AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 22:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfLEVaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 16:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfLEVaD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:30:03 -0500
Subject: Re: [GIT PULL] fuse update for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575581403;
        bh=oZwr/JAPXTXrcsPq69YsGQO2h51xC7nCTpePfVOHBx8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b7M5HOIafjNroCh/e1g/9+1WiQd8egsUqQZLNNg4SBZO63pRSOr/2X7xREm9mVgkI
         PA5K+dKVGT/lRCtbMs9D4nPi279H7B1nCVJLsb91mHvhiSBm97twyDvgmBbvGUuS7d
         C7G3/AZf0DoABRFTfEfwrmlHyNqt3kcI3vZGGtns=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191204091059.GB16668@miu.piliscsaba.redhat.com>
References: <20191204091059.GB16668@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191204091059.GB16668@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-update-5.5
X-PR-Tracked-Commit-Id: 8d66fcb7488486bf144eab852e87e03a45e0fd3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ce4fab8191396a1b8e4bc42d3b90029876b2bcd
Message-Id: <157558140312.8243.12648934323249833371.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 21:30:03 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 4 Dec 2019 10:10:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ce4fab8191396a1b8e4bc42d3b90029876b2bcd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
