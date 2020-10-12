Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258E828C56A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 01:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbgJLXuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 19:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390498AbgJLXuF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:50:05 -0400
Subject: Re: [git pull] vfs.git mount compat series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602546605;
        bh=jl+4fMMqACZQB1o63dcM/LX8h58PEiOi/xQq3D3/Huk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RUB6pzbXmF/5YWDt3gx9SBXyv0c9GqxxCjCEgGDqHANJW44VHtdGGCJTRhj0AimMv
         /bVJ8fq+KasU6e1CNpVRhDuyZz2M6Bh4x/44z/C5jZTVdEc84NIzC5LF3ehBrY26kd
         nrHVtV69r8Bps7k5AjnkKla3PI5yCHjG+3G7/b10=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012032748.GH3576660@ZenIV.linux.org.uk>
References: <20201012032748.GH3576660@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012032748.GH3576660@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git compat.mount
X-PR-Tracked-Commit-Id: 028abd9222df0cf5855dab5014a5ebaf06f90565
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22230cd2c55bd27ee2c3a3def97c0d5577a75b82
Message-Id: <160254660512.9131.14909527555871586153.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 23:50:05 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 04:27:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git compat.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22230cd2c55bd27ee2c3a3def97c0d5577a75b82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
