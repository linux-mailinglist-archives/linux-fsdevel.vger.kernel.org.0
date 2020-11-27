Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12712C75C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387887AbgK1VtM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730544AbgK0TwA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:52:00 -0500
Subject: Re: [GIT PULL] Writeback fis for 5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606504799;
        bh=/uD1gySi0UFn/KgocnP8aW+vAOKdbZ6Fgi8WeJdQqbQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rIvsYB5dLdye5wdpUFDs9KlozgaNOxQj2lcH9rqE/1PjhbafqBRUiWDAvolXetdkr
         swc9Q7FyEfToRZDCuIuac4zio5gOgOnSdoU2T1WuMotvtlRk4yReknnaXs0NKidDm+
         NQV7hF6gQvNd5zeieXdYPKVxX2clnrBbYSp1HkSA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201127113709.GA27162@quack2.suse.cz>
References: <20201127113709.GA27162@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201127113709.GA27162@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git writeback_for_v5.10-rc6
X-PR-Tracked-Commit-Id: fdeb17c70c9ecae655378761accf5a26a55a33cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b4049d8fc8353c20493f3767a1270a61bcc3822
Message-Id: <160650479944.7570.13607857623675511274.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 19:19:59 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 12:37:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git writeback_for_v5.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b4049d8fc8353c20493f3767a1270a61bcc3822

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
