Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34C728195F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 19:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgJBRgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 13:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBRgN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:36:13 -0400
Subject: Re: [git pull] epoll fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601660173;
        bh=+loR71LWEPhA+LFp6jMelBXimV3Kw4zy/FeO1z5xD9k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U92NwxLvFKJviG5IlMnThQ6rthb2AttTGCvHjOuRO8v9VFDidk96TJEeO7yWyGunC
         X1vbx4LghqUAdpEAscFIg6QBtGMNPYKPGf65U6aCEfQoTIYL3XF/sARDLqF7mpam37
         KjR3PHVlieYmEERc0u6Imk86wkVNNwu3bmSlWHW0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201002172025.GJ3421308@ZenIV.linux.org.uk>
References: <20201002172025.GJ3421308@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201002172025.GJ3421308@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll
X-PR-Tracked-Commit-Id: 3701cb59d892b88d569427586f01491552f377b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 712138c7f7427c9cb67634ba432be98d42435deb
Message-Id: <160166017328.10690.13121348190171622227.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Oct 2020 17:36:13 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 2 Oct 2020 18:20:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/712138c7f7427c9cb67634ba432be98d42435deb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
