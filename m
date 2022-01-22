Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F76496B83
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jan 2022 10:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiAVJkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jan 2022 04:40:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52238 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiAVJkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:40:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAA78B81B8F;
        Sat, 22 Jan 2022 09:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CDCBC340EA;
        Sat, 22 Jan 2022 09:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642844415;
        bh=DTSO7G4eybn9l4mzXBoewAqFEb9tUkOWaydmz3tFwbs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WiRpo9Y59yNIiSMHK1z3ZOGM01Lq2zrvDz78safPtbczfYJFPIXU8galreES9aKOP
         EWqS1+ko5xxoxZ+hxXKyHPvbMCgXw5AZWdUDN6R6HPzs9SJoW/AHbqE/6zpe3mqROq
         i0YOKHX9SLgacIpjdOtp0HdJYvyB0oUYmEVNiQ1g93N1bQ8xh9OyIpn9soetUOju/B
         RhqTMEZjcKg+aFcp2OgGhg1IKGU38V9pLl64KKUNRCzjLJ4/l0+dfo+6jQfRJzPzt/
         OhLCHDmIbm4P7QfIHn5CRHTUMjTvTr2d3mLQ/L+/Z6a1hlFv2h4/FlJJ3VIc3yV9ay
         f5035tXDlVQXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5915FF60796;
        Sat, 22 Jan 2022 09:40:15 +0000 (UTC)
Subject: Re: [GIT PULL] Three small folio patches
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YesOkLfpJWxLxRWs@casper.infradead.org>
References: <YesOkLfpJWxLxRWs@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YesOkLfpJWxLxRWs@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-5.17a
X-PR-Tracked-Commit-Id: 3abb28e275bfbe60136db37eae6679c3e1928cd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b68b10b6266009bc8770adf952d637250ee93135
Message-Id: <164284441535.7666.87487807135109673.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 09:40:15 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 19:50:40 +0000:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-5.17a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b68b10b6266009bc8770adf952d637250ee93135

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
