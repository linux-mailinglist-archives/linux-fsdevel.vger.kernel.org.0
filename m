Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB9FB8355
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 23:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404771AbfISVaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 17:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404768AbfISVaD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:30:03 -0400
Subject: Re: [GIT PULL] y2038: add inode timestamp clamping
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568928603;
        bh=665g5Y6hELlqZn+RSAolw2B1OrWXAkeTTqhYGBA0g2I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EP7AYkh6d0+deJbUJgv2xKMtxw56X/PXTTCKwGzXvBkit1tvVRPCXJpysUem7y97j
         gUqZHYX9ZXfoYNKdzIqoiaZJRdmECJovBsxYi4VkaBJCsedPmUJKRdsAh2R4hFPPEi
         yf2gaxXvfiP1kYDSkwH1H3jXO/dJkBUXCUThHvEA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1-rHJ0u5iJMZFNefYzhMUqSJVBXGLh2Cg4DBO5VZbi0g@mail.gmail.com>
References: <CAK8P3a1-rHJ0u5iJMZFNefYzhMUqSJVBXGLh2Cg4DBO5VZbi0g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1-rHJ0u5iJMZFNefYzhMUqSJVBXGLh2Cg4DBO5VZbi0g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
 tags/y2038-vfs
X-PR-Tracked-Commit-Id: cba465b4f9820b0d929822a70341dde14909fc18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfb82e1df8b7c76991ea12958855897c2fb4debc
Message-Id: <156892860324.30913.16652977661011085210.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 21:30:03 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 19:14:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git tags/y2038-vfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfb82e1df8b7c76991ea12958855897c2fb4debc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
