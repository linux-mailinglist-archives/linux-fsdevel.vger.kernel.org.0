Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE783AB9F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 18:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFQQyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 12:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhFQQyX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:54:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 53E706128B;
        Thu, 17 Jun 2021 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623948735;
        bh=Oh2lqZWAmscq4TGOSKx0sQdAuxi05QatMWuqVUnRGX0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b9ueAZBJKtE7dF7s9uv2oV5YwJeLezuNvjJ0Zmx9IY3yBu2TBmviTrnlNIB0ZlOfY
         YV3Ix1VA6j7HI2kzGZ/txogW1wBJC/nvjxcKBEv5hEfAAXYbxfqtzU1AF6r8r/+bfM
         IX+G55lv+vswRh5JUJbkbF6cJPicLhmyqcHtZaMCv80FYmlsvCPSreiIsskacuNIhH
         AxH6ocwlFZoeluYg6OcBykEaztOWsZjbCmfjsMw8YQQyWgQSBLR5hsR5NOmaanbqyM
         8xuMegq0Ks3J4Os7QzwGiReAuPuzMcuMUrCvJn3nHOCeH/xhuFJh5w0EGv93JYpx1q
         hAGCh4+gC0Grg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 42AC7609F5;
        Thu, 17 Jun 2021 16:52:15 +0000 (UTC)
Subject: Re: [GIT PULL] Quota and fanotify fixes for 5.13-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210617112322.GF32587@quack2.suse.cz>
References: <20210617112322.GF32587@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210617112322.GF32587@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.13-rc7
X-PR-Tracked-Commit-Id: 8b1462b67f23da548f27b779a36b8ea75f5ef249
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39519f6a56e398544d270fcb548de99b54421d43
Message-Id: <162394873521.13515.3138996428570283213.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Jun 2021 16:52:15 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 17 Jun 2021 13:23:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.13-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39519f6a56e398544d270fcb548de99b54421d43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
