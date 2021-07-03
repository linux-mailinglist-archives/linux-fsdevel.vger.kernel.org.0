Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C427E3BAA2B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 21:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhGCTn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jul 2021 15:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhGCTnY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jul 2021 15:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 880B761380;
        Sat,  3 Jul 2021 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625341250;
        bh=JjIt/gHjyxVe+m3/pv2fLw9eExOPVjaEhHyL3w36be4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ggWiL7CtgA5lCk07p+ed8hnSAHIIUK0nMC0I1dVzaFkC3RhljUmPTMAbhuelVGk8N
         +vdtymPOqMDtvCrY7ZDCfffSBHdizXHyf5lUGpaDwTu+CaIzPEV8eJYsl0cKekI1cd
         t4RlXro8AFPiRkmB54evzvZiNXI0Y+5zk7gMHuyOC+kw3OoKyr+evLMyZ1PfejSVOr
         qt9qrDkz9YMSAqLWCSVjuFF9BFbAENE+FpkjdgJ415WmEpUkKSqfJu3pBqt1vqYWf2
         mh+L+BcElWXXAy4Q8929adadMdBaE7GJfUGibNoijB9GBcxPlgMV5rEfoyjv16sU8k
         F7xRZDQ7ZAP9A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 82CA660283;
        Sat,  3 Jul 2021 19:40:50 +0000 (UTC)
Subject: Re: [git pull] vfs.git more namei.c stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YN/S94w08pU0tZbq@zeniv-ca.linux.org.uk>
References: <YN/S94w08pU0tZbq@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YN/S94w08pU0tZbq@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namei
X-PR-Tracked-Commit-Id: 7962c7d196e36aa597fadb78c1cb4fe7e209f803
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58ec9059b396a570b208239b4edc45eeb68b14c4
Message-Id: <162534125052.29280.4175327977325998657.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Jul 2021 19:40:50 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 3 Jul 2021 03:01:11 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namei

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58ec9059b396a570b208239b4edc45eeb68b14c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
