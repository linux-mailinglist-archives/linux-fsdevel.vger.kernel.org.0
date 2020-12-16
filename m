Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB72DB9BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 04:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgLPDou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 22:44:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgLPDot (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:44:49 -0500
Subject: Re: [GIT PULL] file locking fixes for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608090249;
        bh=yFXwr8p/FmqGZXeBnZMLdyXnYUeyEkL8i/XbHBHAUB0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KavTFqTWpZdJjDPQdjClLesZBqEp0zqisgXh/1NWK6cmQiaP2BaTKTBXUozCdWF2f
         Hti9GiiVGg3ReziQ7L3vTMlRdVwgVGh/Qr9bPvvF5+YtzVerX57ZSdYZd5O1NNZIiD
         a3f8IkLjMN53L2Asopg8ViCEuVLewdecQxDcre9yIlLw0gST0T1jnkIPWMwB1f/KeV
         3M5xDoyXCq9tXEHTYgYml0AjNsRei8OnL+BFjruwBgxkhHkHIhGZ1pWuFhylY4qQft
         BrB5bhf2WDMTR6pI7x/dsrypWQGmkZfoOPLtzuom83+hpJH0zHYkC2owHW5iXSEkDY
         TIv2mZVZ+MWSw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f325fd49b5e185cf77a906db48ed590a46c75ef6.camel@kernel.org>
References: <f325fd49b5e185cf77a906db48ed590a46c75ef6.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f325fd49b5e185cf77a906db48ed590a46c75ef6.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git locks-v5.11
X-PR-Tracked-Commit-Id: 8d1ddb5e79374fb277985a6b3faa2ed8631c5b4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a725cb4d708e5ac8bc76a70b3002ff64c07312d8
Message-Id: <160809024940.9893.2725979001655402326.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 03:44:09 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        Luo Meng <luomeng12@huawei.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 08:22:46 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git locks-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a725cb4d708e5ac8bc76a70b3002ff64c07312d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
