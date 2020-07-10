Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540AC21BB9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgGJQzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 12:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgGJQzB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:55:01 -0400
Subject: Re: [GIT PULL] Fix gfs2 readahead deadlocks
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400101;
        bh=wxKsXizwdhdxiL1cPnlDsrPNhlGIEjOsqhJZEpZuj+8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JFRztYKd6m7AN1EyxdVWhpKeexUo+iBpIz8/a9c/L162fZBWXNPXVt3q6bmW4ebuk
         xdSaL85KAlkCTa3ZJSAuWAqEscJYaoM0waDA0Jk6jgpQjMGzC7jT2WioFtKJ9kGRdl
         qea73AF0fdDI6i+M7LvbOaH3QG55lQ/xdHD04Ed0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200710152324.1690683-1-agruenba@redhat.com>
References: <20200710152324.1690683-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710152324.1690683-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-v5.8-rc4.fixes
X-PR-Tracked-Commit-Id: 20f829999c38b18e3d17f9e40dea3a28f721fac4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d02b0478c1acb00e9d9ee40810627eba5745d94b
Message-Id: <159440010163.18761.9305081820419338793.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 16:55:01 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 17:23:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.8-rc4.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d02b0478c1acb00e9d9ee40810627eba5745d94b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
