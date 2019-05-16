Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9861FD9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 04:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEPCFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 22:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfEPCFD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 22:05:03 -0400
Subject: Re: [GIT PULL] nfsd changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557972302;
        bh=NbkIUuaFeTaHzomlG16Jr3Cl9UevpVs9HqfdMbAlDXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AAiI0/1wXasLfUTkgJNgamvEWGEZAyQ/uFIPUdyrdkkYe2xwUvbLgbGFeDrErmENG
         NqcdDP6JtoEYpIRfA2D1QYC3sNN0zQ4rmOHEWbKjWtuBxUoLDPhebQpFloPEGcGDR0
         g9s8R/PKg+fGC1AemtNcf1qv2AFAKAPzQ+EUqpNE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190515182658.GA11614@fieldses.org>
References: <20190515182658.GA11614@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190515182658.GA11614@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.2
X-PR-Tracked-Commit-Id: 1c73b9d24f804935dbb06527b768f8f068c93472
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 700a800a949467cb86491763b983e1edcdee8642
Message-Id: <155797230278.20425.305125144618088990.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 02:05:02 +0000
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 14:26:58 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/700a800a949467cb86491763b983e1edcdee8642

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
