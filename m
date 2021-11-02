Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C124436C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 20:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhKBTzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 15:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230348AbhKBTzB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:55:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C70D06103C;
        Tue,  2 Nov 2021 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635882745;
        bh=X2PNqZfaK8dci6B7EhGiHQeTSB7DIKM8msjsuYmgJqE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D3JslLL0mbr/iPjCxFpC3ZdvuGh8/cWmm1KOwzaZCtB0S5cfvFwwOv6uHNe48DKhG
         RJJMOva5Lg76lvfwBCe5+FkWgzwWp4G9TKIDRk1KECGQMe7WdxJu/B3TzVNmE8+LLh
         z7WSHtxAHXj9p7bxvc1ikI4D0OElDddDu6EzSC260Xk9rEAnSpVMiq2I3LM1QRwI20
         YbVx8bGPPWnOz22VUn2IorFsS5fkopSUUWbZCBXOpsCvoSSNwucBbh7SbF8sSpJCTQ
         7O++A9ftoogC6wfRyBZ027dFVDSYtCKwEL3wZgaaZZIT8fGkb7DxjJJ1JAhseyr/M8
         INMj9MVtmiHfQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BFA6E60A90;
        Tue,  2 Nov 2021 19:52:25 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211102184650.GH24307@magnolia>
References: <20211102184650.GH24307@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211102184650.GH24307@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-merge-4
X-PR-Tracked-Commit-Id: 2a09b575074ff3ed23907b6f6f3da87af41f592b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bba7d682277c09373b56b0461b0abbd0b3d1e872
Message-Id: <163588274577.22794.1156896528638745710.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 19:52:25 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 11:46:50 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-merge-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bba7d682277c09373b56b0461b0abbd0b3d1e872

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
