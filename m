Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417DE2DD9CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgLQUWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 15:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:32980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgLQUWc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:22:32 -0500
Subject: Re: [GIT PULL] Fsnotify fixes and improvements for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608236510;
        bh=2+RwjUQ7PwaFNKzGkZw0bdhVKDIb7m3/X916JqXKCBQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LaT4s4oh+3cYUphFstCRaw3N4ya0H4LzGHFn5pK+kbmXn9WrPpG6i2YKrU4XzqnaC
         JpF2M48ANftoWP54jYNb97aBxB/ebER84oL1jUbzqRCo4gwLTFMClzXBRVvpJELoew
         WWKJDEEin+iJYJiAbTicpTcwVmMd6alNSd2h4j69lBedGFHz26D4S5dcmlKcOwGbO7
         llfK+PpYdek7/KE5OQjky0GaFbylWZdIUU4Tg7AFzTnY34SuMafVtv1n3YqIB4euox
         0zxuNJfyu24Wmmv3nnjyb/Bv1P+rgwJpcv4zbZXrGBWQKrukvck4PuXkzKeywUM6P8
         dr3SBJQzK8ufg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201217111545.GC6989@quack2.suse.cz>
References: <20201217111545.GC6989@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201217111545.GC6989@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.11-rc1
X-PR-Tracked-Commit-Id: fecc4559780d52d174ea05e3bf543669165389c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14bd41e41899cbd1de4bb5ddfa46c85b08091a69
Message-Id: <160823650997.7820.15227039511147268590.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Dec 2020 20:21:49 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 17 Dec 2020 12:15:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14bd41e41899cbd1de4bb5ddfa46c85b08091a69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
