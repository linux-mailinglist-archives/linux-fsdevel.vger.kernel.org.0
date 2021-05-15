Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D353819D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 May 2021 18:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhEOQaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 May 2021 12:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233369AbhEOQaJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 May 2021 12:30:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 486CA613C4;
        Sat, 15 May 2021 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621096136;
        bh=X3+Sb559v2Vf5aXRxfe8iEp/yqakvWJ6olj5taOgRdI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rGbBBANDPEGJmbN5BSFfEf1NqHj4EXm8iOba/5hzLWCqpu7l17lCfUcLTgt01b8d2
         nBoJkZ3efceeHbympLKgqo6n197u8xb0B6/jlJecDLFdOwI6TpExDMIciEB6KC0uxM
         SxJ+J1vFQwPW/588QDAPpEmXP80gtnyCMzGPT8acPAOvRiv7Cocxn0NDqA8yNot+3c
         9Y15uyxAS0qskB0HmatntEXIOP073uusPxEhEmGLXrK6mL5va/VkyvdYIKzMmVSm6x
         1vI1yeJiihmSUQztk9hfHggH2gDhwVBbwPFhD0tWIZhzEtUjkw134A97nDYnCJD/6T
         7+d1rN/9SpXSw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4260760727;
        Sat, 15 May 2021 16:28:56 +0000 (UTC)
Subject: Re: [GIT PULL] dax fixes for v5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4hDfxpYh1rvvqFCQ+eNk_XxZD3grUOYkHWbERfxky43xQ@mail.gmail.com>
References: <CAPcyv4hDfxpYh1rvvqFCQ+eNk_XxZD3grUOYkHWbERfxky43xQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4hDfxpYh1rvvqFCQ+eNk_XxZD3grUOYkHWbERfxky43xQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-5.13-rc2
X-PR-Tracked-Commit-Id: 237388320deffde7c2d65ed8fc9eef670dc979b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 393f42f113b607786207449dc3241d05ec61d5dc
Message-Id: <162109613626.13678.5421183533760328887.pr-tracker-bot@kernel.org>
Date:   Sat, 15 May 2021 16:28:56 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, nvdimm@lists.linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 14 May 2021 16:33:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-5.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/393f42f113b607786207449dc3241d05ec61d5dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
