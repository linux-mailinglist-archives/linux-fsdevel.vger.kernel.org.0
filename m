Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF99110DEE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 20:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfK3TkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 14:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfK3TkH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:40:07 -0500
Subject: Re: [GIT PULL] ext2, quota, reiserfs cleanups and fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575142807;
        bh=pdjkIuyvw6uy/eXd9Z7DSizjlpxnEFHFfFyLHMCFHwI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K+hOF3K38SOHtEdCmKRsHLPOU/xFfWHn+mQaHul6cSF7wrJarxqzimykio8cnp98c
         dwoI70znTaT8kTFWUEWYSgKyi5cDnnT3P7oskYH9QeyoAZYP7Os8mkC93Rep6DDgu5
         GMY5LkE0O0VXS1RMxaMXGu3E9PVUqDhvZed/xgac=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191129113314.GC1121@quack2.suse.cz>
References: <20191129113314.GC1121@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191129113314.GC1121@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.5-rc1
X-PR-Tracked-Commit-Id: 545886fead7abfdbeb46d3ac62256e1db72739a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8072d5b3cdd596c999f6e3f312ce7e4858ca356
Message-Id: <157514280729.12928.4043655846288603968.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 19:40:07 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 29 Nov 2019 12:33:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8072d5b3cdd596c999f6e3f312ce7e4858ca356

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
