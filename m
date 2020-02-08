Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF91E1562A0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 03:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBHCFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 21:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgBHCFF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 21:05:05 -0500
Subject: Re: [GIT PULL] nfsd changes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581127504;
        bh=ANc267yKWJN+Eqx4gw41Or2/pDqDx0YxOLyD1p/SkzY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=svUWkqZJz8oArI3sbju9ZXC7NajLVlxx5WG4OSfreYu9IFhjDV+39oUeRiu2GofC6
         uoa3ikgAF8XQVE/J7x+X8nfF2owftDvlPJQm2WECAOQYjBgrZ7vJ+XpIVgYEU+PRH8
         4AfG61JgC+E9IkOr0bPe8tz83QiXKAz5AjTAxusg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200207211255.GA17715@fieldses.org>
References: <20200207211255.GA17715@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200207211255.GA17715@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.6
X-PR-Tracked-Commit-Id: 3d96208c30f84d6edf9ab4fac813306ac0d20c10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08dffcc7d94b7751663f1b0d66b45ff3a98375a2
Message-Id: <158112750484.31333.484768800606756517.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 02:05:04 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 7 Feb 2020 16:12:55 -0500:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08dffcc7d94b7751663f1b0d66b45ff3a98375a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
