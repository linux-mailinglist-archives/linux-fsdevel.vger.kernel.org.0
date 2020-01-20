Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A07A14322E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 20:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgATTaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 14:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgATTaD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:30:03 -0500
Subject: Re: [GIT PULL] Reiserfs fix for v5.5-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579548602;
        bh=mRiCwMyQ3coX3uVAzLY4es0jmhSxNLGLMPcjlFWMo/k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PaxVJdpfgunLiPU1ykpFLvlKPupJ7j8RQz/PaKOMLSM1wa4LMCXVZHcTNLA3KAPjN
         COTTrKdn11+oKGsJcsMFSNOGI5TFq2UH2sg1392JTjiQ30AGhPOtaE7WI71lMLiEze
         oyDiCvSmbcU60sXVFlGem+P9CcxeB2OViPpqCpto=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200120084652.GA19861@quack2.suse.cz>
References: <20200120084652.GA19861@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200120084652.GA19861@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fixes_for_v5.5-rc8
X-PR-Tracked-Commit-Id: 394440d469413fa9b74f88a11f144d76017221f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d96d875ef5dd372f533059a44f98e92de9cf0d42
Message-Id: <157954860255.4605.17357131375772327184.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Jan 2020 19:30:02 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 20 Jan 2020 09:46:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.5-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d96d875ef5dd372f533059a44f98e92de9cf0d42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
