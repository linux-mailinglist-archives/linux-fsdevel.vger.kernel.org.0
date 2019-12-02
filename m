Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD210E406
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 01:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLBAKD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 19:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfLBAKD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 19:10:03 -0500
Subject: Re: [GIT PULL] compat_ioctl: remove most of fs/compat_ioctl.c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575245403;
        bh=JLeT3ZDcc7UFo4ivsVDEQvebi3MVGJat+r6C/QEGzyw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Vloo3AOhZHLfEZZ3NCL9nsuykb+vcR6I9A5H2QpQ606X2Vr8FYypxli9ja8tz6OA7
         nprRellHsOT31RRF2PSUd/QnMyMpOLhErbIfEtqj0xm6/nz2CUKPOl+DUMyoyrekVi
         9fjISaUrcdXZNexgtDowW9TvRcmm0JPWMCE96Ku0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a0vt7sBs=mG-m698yQSkoJezb=AgKNCZYCo=+OuxEzLzg@mail.gmail.com>
References: <CAK8P3a0vt7sBs=mG-m698yQSkoJezb=AgKNCZYCo=+OuxEzLzg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a0vt7sBs=mG-m698yQSkoJezb=AgKNCZYCo=+OuxEzLzg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
 tags/compat-ioctl-5.5
X-PR-Tracked-Commit-Id: 142b2ac82e31c174936c5719fa12ae28f51a55b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0da522107e5d9c000a4871d52e570912aa1225a2
Message-Id: <157524540307.21884.16064843634172446960.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 00:10:03 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 14:34:18 +0100:

> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git tags/compat-ioctl-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0da522107e5d9c000a4871d52e570912aa1225a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
