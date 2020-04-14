Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324081A8A9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 21:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504649AbgDNTYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 15:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504637AbgDNTYU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:24:20 -0400
Subject: Re: [GIT PULL] afs: Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586891103;
        bh=rxcX3bkiTxcRaV5uIf1VGYjtryE+LFQC/F5AUl8hJtU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XI+iFxHGSPhXA/9OrrwIZrvl/P2DJD/HXbStttid4I4GR425ULpTi4CfsNJI1sbHi
         QAnVkjMGiwLa7oxFhOdjEN2Foo0UjGV55A9Y4zx+Bls24yg+cmxafxD/1VniON6Mc4
         ORC+YNntjo/4ow7v7GyxPiPAXC2uV9xZV0QmkpTA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2940559.1586789415@warthog.procyon.org.uk>
References: <2940559.1586789415@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2940559.1586789415@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-20200413
X-PR-Tracked-Commit-Id: 40fc81027f892284ce31f8b6de1e497f5b47e71f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4cd66682b2728734b2fc44f5f1e83a5c740b5cf
Message-Id: <158689110356.29674.8805335271309740535.pr-tracker-bot@kernel.org>
Date:   Tue, 14 Apr 2020 19:05:03 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 13 Apr 2020 15:50:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20200413

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4cd66682b2728734b2fc44f5f1e83a5c740b5cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
