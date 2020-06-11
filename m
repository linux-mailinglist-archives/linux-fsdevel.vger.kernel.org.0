Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3771F5FA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 03:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFKBuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 21:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFKBuD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:50:03 -0400
Subject: Re: [git pull] vfs misc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591840203;
        bh=61AniKfE8KMG+kYxyj90PwPywoR7NTOaXhcdQ1CDJnk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oizPGVipZKATXlYjK6sdReX5kh/eAH71fGp+K2KIQAEQuKs//Zzl3u/oT88IkHdG1
         Bt+J5tqGdadvo/7cmwy/4qRUbspWf4qsutuvOjTGDf3ckWZ6de+/5sEQjz4xxdoVWu
         zty6hkL3E28rCqlgj9hAk4dTd6gqlDkZ2/JG3hPU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200610203019.GW23230@ZenIV.linux.org.uk>
References: <20200610203019.GW23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200610203019.GW23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: cc23402c1c2de8b1815212f3924cdbc3cda02b94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4dbb29fe9dae033a375f231da9cc27aaa09d2580
Message-Id: <159184020348.24802.17167615231251700138.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 01:50:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 10 Jun 2020 21:30:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4dbb29fe9dae033a375f231da9cc27aaa09d2580

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
