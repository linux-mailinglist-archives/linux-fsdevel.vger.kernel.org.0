Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2C93589A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhDHQYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 12:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231843AbhDHQYa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:24:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8687E61132;
        Thu,  8 Apr 2021 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617899059;
        bh=NwOr8C7qLF1c6zr9znrGKmGe3vPH/WaAOTLC7hT0ej4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MSWd6+XJtTIsAjySdBUFaZO53EzaNxVgTL5BiB1r8WHCTrO0l++hAUQw0Wyile5P3
         JnwNUHKMX7JHAiKji80hwYLF4qjtMu37SBaU4cyzk1tiZq0LHT+5YBjEYQNoW93xE8
         0CRWyMBr1ZqmrLbLfQKfJ3ZnOD+Jo+ngzsiWteuFiH6QUbcbaGOkZoZYE8egdQCMqd
         ziVd5Zs4Xr0Wv7GWLeTGcG3921HQs/lOxLgxnqvEBC2TOYjVdUY+ziYe89Rhq0LWwY
         lXi0X7v0puPrde1S3nOZaFIlndZUAShz1ogAjjEMEe3MtveSZ+aiWYRQzlT3eMv+y2
         gzBotZ4aAvjRQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 80CB760A2A;
        Thu,  8 Apr 2021 16:24:19 +0000 (UTC)
Subject: Re: [GIT PULL] close_range fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210408103618.1206025-1-christian.brauner@ubuntu.com>
References: <20210408103618.1206025-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210408103618.1206025-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2021-04-08
X-PR-Tracked-Commit-Id: 9b5b872215fe6d1ca6a1ef411f130bd58e269012
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ea51e0e37c890847eb2b402b01389ae099efec1
Message-Id: <161789905952.11255.6566506289808701965.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Apr 2021 16:24:19 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu,  8 Apr 2021 12:36:18 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2021-04-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ea51e0e37c890847eb2b402b01389ae099efec1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
