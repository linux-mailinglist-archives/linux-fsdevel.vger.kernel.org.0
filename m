Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3A81BFAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 00:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfEMWzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 18:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfEMWzE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 18:55:04 -0400
Subject: Re: [GIT PULL] Fsnotify changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557788104;
        bh=CGgj29CtBcinK6dbtfj30zSagGKR+3ZD1GzHkX6wUOk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XEazL+PXFfJYsuKr2zB7rnPN5Lb99MfawqfuFNXbecGKWMzqkTjZrxqz6AKH5KuJp
         RyUCYEcfkt0F7WxZRewcgzHoVMzn8GZ6RrNRBD/yefQahkVGp5ECLjix3jf2UZwH1w
         fBsaGwqWht6VRGsbrdUlzvR6TOw3ryp25UmQwaUY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190513162114.GC13297@quack2.suse.cz>
References: <20190513162114.GC13297@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513162114.GC13297@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fsnotify_for_v5.2-rc1
X-PR-Tracked-Commit-Id: 4d8e7055a4058ee191296699803c5090e14f0dff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4c608115c6203efbab14befab90a6d1b61177d8
Message-Id: <155778810442.1812.16164415531985822126.pr-tracker-bot@kernel.org>
Date:   Mon, 13 May 2019 22:55:04 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 18:21:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4c608115c6203efbab14befab90a6d1b61177d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
