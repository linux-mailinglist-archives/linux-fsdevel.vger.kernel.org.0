Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3728A948
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgJKSYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 14:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgJKSX5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:23:57 -0400
Subject: Re: [git pull] vfs.git fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602440637;
        bh=gqyPtCSAjTL8q5TwOjjx6uDvnEf8I7XYijlLdgXdOCQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cQ1HqULxAIQLTa4UwNrq6pDwL1zccpHb9tJUkqAcAz+iLCDE/e6s9SFS+vMbfvPB5
         dPI1OzrSFDmAj5hi9mcMOmzQkQfzqKBD3xG8qiyaVm7PlHrzXP0m5wFGtxljmGziDZ
         Q6iu49jHxiP0IsnKj7AzlDQolRGQHN4IRqtqN8ts=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201011180609.GC3576660@ZenIV.linux.org.uk>
References: <20201011180609.GC3576660@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201011180609.GC3576660@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 8a018eb55e3ac033592afbcb476b0ffe64465b12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b697f86f9f136d200c9827d6eca0437b7eb96cf
Message-Id: <160244063723.8522.4923464775170530284.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Oct 2020 18:23:57 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 11 Oct 2020 19:06:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b697f86f9f136d200c9827d6eca0437b7eb96cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
