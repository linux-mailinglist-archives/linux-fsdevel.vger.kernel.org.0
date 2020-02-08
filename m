Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD01562A2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 03:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgBHCFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 21:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgBHCFG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 21:05:06 -0500
Subject: Re: [GIT PULL] orangefs fix for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581127506;
        bh=JF4A5qmtF9yW4H1G6USOX+CytGQ+xOq8xhltBxuDYs0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Or4p3SNI668ry8uzFJ7rn0X61LHs2wHP2/MZU9CjYEH0zrZyefkIlgSRpPrTt7mcd
         5bytksmRJ/feTHBbFVm6zTSF+zw/RmYJlJ11Zmj6modCwA0Ntjg9cX/FL711Z/N+lF
         1t3ygDLR0W03+cO5lcu/FB6XXQDBcOyw3VtgX6iU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mST_fo957rXFxC3-K_LnOMxuQgBvaEj1LO8gyCFnNGV+PQ@mail.gmail.com>
References: <CAOg9mST_fo957rXFxC3-K_LnOMxuQgBvaEj1LO8gyCFnNGV+PQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mST_fo957rXFxC3-K_LnOMxuQgBvaEj1LO8gyCFnNGV+PQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
 tags/for-linus-5.6-ofs1
X-PR-Tracked-Commit-Id: 9f198a2ac543eaaf47be275531ad5cbd50db3edf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60ea27e936f2b9b7f011644a499c292f9cc11de3
Message-Id: <158112750618.31333.17636699382584542465.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 02:05:06 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 6 Feb 2020 17:40:57 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.6-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60ea27e936f2b9b7f011644a499c292f9cc11de3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
