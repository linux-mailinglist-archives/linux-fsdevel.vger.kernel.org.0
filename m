Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABBA23E5E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 04:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHGCjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 22:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgHGCjJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:39:09 -0400
Subject: Re: [GIT PULL] Fsnotify changes for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596767949;
        bh=1pWa5Gcz7yBsUM6Esa9vD7udky8+kjwLf+9SjjIZRcM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sr2pO5quvO3SjfA4x/GArtmlqvENs+UJ3FqX9lHb4iG9dRse5dDZwZPiOHi7WkfGZ
         XmvfIgNR7Xs+9K82bLrWSvdTvf1l1WEt7o0EFC/QK5ynQJJRYwxXG6wKZeAOoUKr6t
         D3VaB9C/adOiICoo64F9pI9AtOwSD8JJ7NZrEd80=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200805092811.GE4117@quack2.suse.cz>
References: <20200805092811.GE4117@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200805092811.GE4117@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.9-rc1
X-PR-Tracked-Commit-Id: 8aed8cebdd973e95d20743e00e35467c7b467d0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb65405eb6860935d54b8ba90a5e231e07378be1
Message-Id: <159676794909.23087.2870737311445066803.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 02:39:09 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 5 Aug 2020 11:28:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb65405eb6860935d54b8ba90a5e231e07378be1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
