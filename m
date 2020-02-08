Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B655B1562A4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 03:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgBHCFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 21:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgBHCFI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 21:05:08 -0500
Subject: Re: [GIT PULL] fuse fixes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581127507;
        bh=VKwMrEOjf+pbAryXenvt1O89qe/OGTtrGybNATBS8eM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qBXDwPtpErz1qFtn7h9wsDiZ71eWkIFWG9ijWEQiRPmVDUSGd4WeY3jgn744fbgUu
         eySPXTf6U3Dyu+5DIkSCVDwtVSb8JywN4lWJH5UxtCQIwbbqzL0276hujM9SAn2kb+
         zZPAl1aJiRfLzvzcsJYsB05zUbfVGKgtucdiUpZU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200207153401.GC7822@miu.piliscsaba.redhat.com>
References: <20200207153401.GC7822@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200207153401.GC7822@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-fixes-5.6-rc1
X-PR-Tracked-Commit-Id: cabdb4fa2f666fad21b21b04c84709204f60af21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f757165705e92db62f85a1ad287e9251d1f2cd82
Message-Id: <158112750750.31333.3995407389947059932.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 02:05:07 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 7 Feb 2020 16:34:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f757165705e92db62f85a1ad287e9251d1f2cd82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
