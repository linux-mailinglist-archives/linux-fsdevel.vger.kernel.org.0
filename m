Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A2A151B2E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 14:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBDNZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 08:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbgBDNZE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:25:04 -0500
Subject: Re: [GIT PULL] overlayfs update for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580822703;
        bh=Rc6NqeXWz9S3r4LWSxPFOJ2ycNr1OekbG9nhhgvWA9c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vG5IZN1vJ5ZIqJPAhvKYdjh8/GlnSTQojD1RzAybg0MIron8Xopc8DQ/DhqjyxrnB
         dVPlKVQa1NZ16nasaw+jf+MuNhfUDDlykeH9GON6+Pwa1Cro3iF5nRvexUsyEibbu3
         PFABCSVK/Bu08Edz0Yoc4CIrcpU2Vn0aSpjVdMKU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200204093758.GA7822@miu.piliscsaba.redhat.com>
References: <20200204093758.GA7822@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200204093758.GA7822@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-update-5.6
X-PR-Tracked-Commit-Id: a4ac9d45c0cd14a2adc872186431c79804b77dbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f879e1a94ac99586abf0659c03f35c1e48279c4
Message-Id: <158082270392.19118.7086093890010037735.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Feb 2020 13:25:03 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 4 Feb 2020 10:37:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f879e1a94ac99586abf0659c03f35c1e48279c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
