Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84CC28C573
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 01:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391254AbgJLXuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 19:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389765AbgJLXuF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:50:05 -0400
Subject: Re: [git pull] vfs.git iov_iter series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602546604;
        bh=FREUOS5+p/0DJ54+SzP7kgalRqWwHKsB/Le6P4B1LOY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ozXsMGNjYAOsHlkZtHKz8Qjzg3OA+unDPSC+wuOMH/oy7ZMW9/PrI409d0gbpnqy2
         czpdthBAbifPZ5/+uwT/LOxffVQ0EKvs7O+DwiGcci6j8z/HZ0l1tJhrlH2WuDFEJx
         B1tzK+CvgIdjAkMAYq/pif3tZZ65ksJYy1T7QSAw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012031722.GF3576660@ZenIV.linux.org.uk>
References: <20201012031722.GF3576660@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012031722.GF3576660@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter
X-PR-Tracked-Commit-Id: 5d47b394794d3086c1c338cc014011a9ee34005c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85ed13e78dbedf9433115a62c85429922bc5035c
Message-Id: <160254660469.9131.46634232117859172.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 23:50:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 04:17:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85ed13e78dbedf9433115a62c85429922bc5035c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
