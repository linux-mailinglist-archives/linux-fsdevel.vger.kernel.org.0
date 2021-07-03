Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD633BAA29
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 21:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhGCTn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jul 2021 15:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhGCTnY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jul 2021 15:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E905C61930;
        Sat,  3 Jul 2021 19:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625341249;
        bh=SONY1NmyAMoPE6DQ/LRxW/7HZ/G/ATxVs0+eSkgUXqE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TB7CXp1xOh97H2jCRjjBUgZcdyvUGBTa9BguxAOmWe1aEkczGOYwtp9I/Y0Em4Wft
         U6lZvzGEMwpQQKc/X2rGNuqVL56HRCZ29IdyjplVYJ5SaBXSkuIzigP5OT+NbBYdcv
         R7yyGS0ihPfWTVDkR0jivl5pwYY7qWNQbTQqMkWofPvfsxMA9kTwLsjx12zKx67BKr
         kEnq0KZ0NFL+aSvJ3cYmZWc8Yqvc5vBAokA0c8+LGBvPQbWgAd1f5DTzYmkb0vQVuV
         mnO/00yUVK2RtInAVb11/pORXTdqV9JFGcxBxkBPDUkFeTA2A845DOfpCq7h59B80r
         brqycisjOsJug==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E434160283;
        Sat,  3 Jul 2021 19:40:49 +0000 (UTC)
Subject: Re: [git pull] vfs.git d_path series
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YN/RxStDmizrFH/m@zeniv-ca.linux.org.uk>
References: <YN/RxStDmizrFH/m@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YN/RxStDmizrFH/m@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.d_path
X-PR-Tracked-Commit-Id: e4b275531887fef7f7d8a7284bfc32f0fbbd4208
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f92a322a63517a798f2da57d56b483a6ae8f45a1
Message-Id: <162534124992.29280.39169687474801309.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Jul 2021 19:40:49 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 3 Jul 2021 02:56:05 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.d_path

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f92a322a63517a798f2da57d56b483a6ae8f45a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
