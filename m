Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 445DA5FF95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 04:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfGECzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 22:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfGECzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:55:03 -0400
Subject: Re: [git pull] do_move_mount() fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562295302;
        bh=GojBOsycOWpwWi8x7jw/e7f5BslK2F42lo4GldRNtVA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Bztu1ceuas0Beto9hMQFM0FDAHS3ESddGTwwMDJx61u3nNW6N2qV30IsLnRyIEWj9
         c9Qd92ffLSSkqSrpv09PC3mozCDf4MX1tC/YZocNBKxmR9YIU/21M/0UCbBoDVCj2N
         vh6Yj6rEjfLBkFz0nPa14XvaqgjuFqi8dbNCkmBA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190704205740.GJ17978@ZenIV.linux.org.uk>
References: <20190704205740.GJ17978@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190704205740.GJ17978@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 570d7a98e7d6d5d8706d94ffd2d40adeaa318332
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cd7cdc7e420a343743db781484e801fd784a1f1
Message-Id: <156229530218.12956.1982394929470545811.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jul 2019 02:55:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 4 Jul 2019 21:57:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cd7cdc7e420a343743db781484e801fd784a1f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
