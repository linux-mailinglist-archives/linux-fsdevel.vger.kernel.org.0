Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B733DB25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 18:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbhCPRnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 13:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237711AbhCPRnA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:43:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5450D6511B;
        Tue, 16 Mar 2021 17:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615916580;
        bh=CbJBd46uYHxcCQtRzWpupewBCyioYqa+SHF3sLTw6Qc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IAUj4LVVLY2D8NChuQ5uC/4acm9CgsptjBZ08QpMnDUMkmjWNNMqe6Nlk1Cqn+TnA
         TktoNPVBv5GNfma+8NdlW7j9WFDrcfwGxoE+td77n+EuGAaqlUtYBqbbF4OJ9GJE1i
         KvucWCn9u4BWbU5jxPrphAFUwHj05BGz/FCLcrAfmOC9LXDGpl8/dI+h3y1JsXKJDW
         4m7CBC/QqKScbXT/piJg5TPyaO3CnNi6LDxji7QTjV3ohi1hDYxgPuzHp8G7SatHij
         sHx9PUoRU5bfWZNhi+b/CC8oF2yT/2LG/pFk4CZ2cXpPFJsHdstueUBCNDEEsrdnsJ
         M2jhNnwjNSpfQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4F6B760997;
        Tue, 16 Mar 2021 17:43:00 +0000 (UTC)
Subject: Re: [GIT PULL] fuse fixes for 5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210316143435.GC1208880@miu.piliscsaba.redhat.com>
References: <20210316143435.GC1208880@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210316143435.GC1208880@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.12-rc4
X-PR-Tracked-Commit-Id: f8425c9396639cc462bcce44b1051f8b4e62fddb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1df27313f50a57497c1faeb6a6ae4ca939c85a7d
Message-Id: <161591658031.21676.2321210742215971003.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Mar 2021 17:43:00 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 16 Mar 2021 15:37:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1df27313f50a57497c1faeb6a6ae4ca939c85a7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
