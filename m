Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3DD8C0E34
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2019 01:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfI0XAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 19:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI0XAF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 19:00:05 -0400
Subject: Re: [GIT PULL] add virtio-fs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569625204;
        bh=lZdnGmEpHQjZEC9pHyYMZwLDTAoeVbVYJFbPvrM2Gog=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RLNZkEXkmtVATcT3eC83J6UAuJ3Ayf9N10slIKejiKMcwXitP2/4qJAreZs5CXw1V
         eLrCHP0Or21LRyTcHm4Ik8S9SHYqV31FnhPrZjKE1Ko19vkAVKs1mq4T3KelTDFByX
         bmy0W4HOkFOWx2Gd7ex27AVuVNfdlium6MpiNAcc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190926084340.GB1904@miu.piliscsaba.redhat.com>
References: <20190926084340.GB1904@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190926084340.GB1904@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/virtio-fs-5.4
X-PR-Tracked-Commit-Id: a62a8ef9d97da23762a588592c8b8eb50a8deb6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f744bdee4fefb17fac052c7418b830de2b59ac8
Message-Id: <156962520482.10299.16614851801819928945.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Sep 2019 23:00:04 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 10:43:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/virtio-fs-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f744bdee4fefb17fac052c7418b830de2b59ac8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
