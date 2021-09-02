Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E6A3FF274
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 19:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346765AbhIBRiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 13:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346674AbhIBRiR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:38:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1C16560FC0;
        Thu,  2 Sep 2021 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630604239;
        bh=6HR08lp6HoGwEvv0kqklwqS3X1bMjRNNZVkrYMfOOwU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BAi1PtqhyY/K1zsKO9ojh8ifybJjijMUJMLfXltu3eJOIKGujS8rsDktAfyEj90pl
         An962hzEjQUi86/PYN33WC5bDj7yvRed2BsnS/YCDfo/wrLjUwIQdVVhC2D2nbEfWj
         dHpaKGDh8bZiUCC7nWT44hJ2DcTif4fKG6SD/AUeo8L/2fVMUY2YJfJI7Ez3JvlFWT
         lv3j3kdMIWPWeOdCXRQiWMNrJeIDHtAhJsNAJmsVYlZzcM25Wp6w1UyuK3nm/EpU5x
         OST/gl0LNZCKu9NIpXDJzlTI5LZnPwQFdCwHpak+bqThKwM6kKI4s7mcOLFZJoxTcJ
         48XtP/xBeAcUg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 15F5060A0C;
        Thu,  2 Sep 2021 17:37:19 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210831211847.GC9959@magnolia>
References: <20210831211847.GC9959@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210831211847.GC9959@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.15-merge-6
X-PR-Tracked-Commit-Id: f38a032b165d812b0ba8378a5cd237c0888ff65f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90c90cda05aecf0f7c45f9f35384b31bba38455f
Message-Id: <163060423908.29568.14182828511329643634.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 17:37:19 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 14:18:47 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.15-merge-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90c90cda05aecf0f7c45f9f35384b31bba38455f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
