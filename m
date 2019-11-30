Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E9810DEEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 20:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfK3TkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 14:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfK3TkJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:40:09 -0500
Subject: Re: [GIT PULL] fsnotify changes for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575142808;
        bh=I5r046cKDZtCAvAoPgASRo2jOLCvk8TLuCbVk2bWpQw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H5j7QhLXxZ90ZkaySAMstSEyjuv4eM0lE8J5oXdBFt0poOLuh2NBJ2HBP8UyC4NTH
         pZSwoSswNbdjsDjqgw/MT2JPHEGRsbGUk7u5DFAzuaPillP/Ze1bb5zSs5fA3gE1uH
         tD9WPRflGTTydCKMvyPUpuNEzDfWJiI6qzistBiI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191129113651.GD1121@quack2.suse.cz>
References: <20191129113651.GD1121@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191129113651.GD1121@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fsnotify_for_v5.5-rc1
X-PR-Tracked-Commit-Id: 67e6b4ef84960704fe3fe33c4b706a2b11a7f539
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32ef9553635ab1236c33951a8bd9b5af1c3b1646
Message-Id: <157514280871.12928.4921991629718713533.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 19:40:08 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 29 Nov 2019 12:36:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32ef9553635ab1236c33951a8bd9b5af1c3b1646

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
