Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A640B1851A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 23:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgCMWaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 18:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgCMWaF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 18:30:05 -0400
Subject: Re: [GIT PULL] fuse fixes for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584138605;
        bh=5UkxmuluBzlJRZdVX6PLZ0rWBFNEcqzwDxdODmkFb3Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rY6w/3wXXwUGFToJKNKXet+MytexT+OlP9M3VrlV/M9mS8GvSunUcpDz4JSBdCmjX
         X9Kqc5GuXeEEpDKWsQw/+Iy6+W0QoAajnpvhBbeKu6u/Q5x3S1kREKZkll17fcscw0
         VQdkpDvBjn6IQy5ZG6oDauiZqUA1+i32FzqPM6uY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200313212222.GD28467@miu.piliscsaba.redhat.com>
References: <20200313212222.GD28467@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200313212222.GD28467@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-fixes-5.6-rc6
X-PR-Tracked-Commit-Id: 3e8cb8b2eaeb22f540f1cbc00cbb594047b7ba89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e6d869f5f024adc1fb0049f085c7a433fd09b14
Message-Id: <158413860555.20505.12553315117679736925.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Mar 2020 22:30:05 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 13 Mar 2020 22:22:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e6d869f5f024adc1fb0049f085c7a433fd09b14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
