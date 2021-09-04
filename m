Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A59400CBC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Sep 2021 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhIDTBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Sep 2021 15:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237448AbhIDTBu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Sep 2021 15:01:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2BB3060EFD;
        Sat,  4 Sep 2021 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630782048;
        bh=dyIPEFglSmcpbZ++o0HjevBqz0DvbX3FsmBUQmn5A/Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HWubG2vXLI/AXRrbb802emloFhq6lTH6yPturtAGLlc9is4LLyD7Afcys65ZBc/QL
         1IGvEkz4u73l8iHbs7+15ulEE6P5v/CG+Zl0qM+44/gcGfyPT0zsLNiLAQ9YfPda6W
         tb2H4/zIbzithMCTwfbewm1eIhpLDR16hh7wwzEV0rtquOqBRIsI+Z4cSkVcsSL21m
         9zlHrBinTSyJqYYliA6vuQwOjd4tcxls0GlHT8TeJEuVSAfKpog3Y/CfWyhV2okE6o
         ymEZdfhbTY2c3H2zDDCem6nvKK09pwmYS8cpgBcEm1+OeEi5G+6yLV7XW9Zn4U335I
         XurDNEV15cgRQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1FA5460A3E;
        Sat,  4 Sep 2021 19:00:48 +0000 (UTC)
Subject: Re: [GIT PULL] Remove in-tree usage of MAP_DENYWRITE
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210904154617.4189-1-david@redhat.com>
References: <20210904154617.4189-1-david@redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210904154617.4189-1-david@redhat.com>
X-PR-Tracked-Remote: https://github.com/davidhildenbrand/linux.git tags/denywrite-for-5.15
X-PR-Tracked-Commit-Id: 592ca09be8333bd226f50100328a905bfc377133
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49624efa65ac9889f4e7c7b2452b2e6ce42ba37d
Message-Id: <163078204812.10287.11509433342669074493.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Sep 2021 19:00:48 +0000
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat,  4 Sep 2021 17:46:17 +0200:

> https://github.com/davidhildenbrand/linux.git tags/denywrite-for-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49624efa65ac9889f4e7c7b2452b2e6ce42ba37d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
