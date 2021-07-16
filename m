Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF043CB04F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 03:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhGPBQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 21:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhGPBQE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:16:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CB112613C9;
        Fri, 16 Jul 2021 01:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626397990;
        bh=I8SXVb/RssMwFL0AVM8J0E5UMnY6LY+uEhwea3awRPw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oge3ufUz4PjKnswJSJ08TCCljzDCWHUKr1+hTryBk+sXLnZEJbmaQsFH0SyxyUuCJ
         iCZl+M0KfDiQJQBegmc2Dcx0xQhiQ8uJbJnSX6Av+jvDQXgWFmVDgfw7cF83f+srw7
         KFOwB6Luvj+jraqfnLLODEzkVwh3Vq7sUjxVIkxT1G4UVi/1O1CjuDC8wbEN6cuTcn
         5IOph/mvK0eB8CHW9qRwqwbmN5cTJ7ZsNsF4jPrslR3pz2urZSOGaFwbI87NipIJkb
         HFcAzWf2JRZ8uiptwnK/iSVspYH5+++XFBAZXHl0ccthR04X3HojF647/ryIBtaiLJ
         CeSQsrTx4tDhQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B7E556097A;
        Fri, 16 Jul 2021 01:13:10 +0000 (UTC)
Subject: Re: [GIT PULL] configfs fix for Linux 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YO8Rw23KxCDjzKeA@infradead.org>
References: <YO8Rw23KxCDjzKeA@infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YO8Rw23KxCDjzKeA@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git tags/configfs-5.13-1
X-PR-Tracked-Commit-Id: 420405ecde061fde76d67bd3a67577a563ea758e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1013d4add290c460b816fc4b1db5174f88b71760
Message-Id: <162639799069.22633.14172101716950042989.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jul 2021 01:13:10 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 14 Jul 2021 18:33:07 +0200:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-5.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1013d4add290c460b816fc4b1db5174f88b71760

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
