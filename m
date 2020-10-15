Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3728FB21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 00:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbgJOWT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 18:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbgJOWT0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:19:26 -0400
Subject: Re: [GIT PULL] UDF, reiserfs, ext2, quota fixes for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602800366;
        bh=pgcK/XF12cFTbgBWpXZiJ7z2TC2wP1zMNriZ8Q3QZHw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1hkVvQFAXsYYpldxokHNmb7/7b6btezO8SZ/5dVSH67uFEV1/JetaZtOjLnGoHUtt
         fLNb1cLQ+GxNy0qFIAuyxaHaGA5e0q7ThE89/o0vJh0XA0MFhH7r1swIxV+5VgRQai
         GYp21V+BJAeIQ+rWmyHcqvaj+RZO4Rw5WymBw7xw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015133447.GG7037@quack2.suse.cz>
References: <20201015133447.GG7037@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201015133447.GG7037@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.10-rc1
X-PR-Tracked-Commit-Id: c2bb80b8bdd04dfe32364b78b61b6a47f717af52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b77a69b81c2fd11ac2eed31a5789b35d7f728a41
Message-Id: <160280036604.16623.15460905048063903327.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 22:19:26 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 15:34:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b77a69b81c2fd11ac2eed31a5789b35d7f728a41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
