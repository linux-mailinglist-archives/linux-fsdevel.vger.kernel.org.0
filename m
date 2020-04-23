Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2B1B612D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgDWQpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 12:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbgDWQpC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:45:02 -0400
Subject: Re: [GIT PULL] Please pull first round of NFS server -rc fixes for
 v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587660302;
        bh=isgpAyPuQoQTkz/JRTcmILgPw06/ov1SPHElk2aGTlQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AWvo6I8hOGVIqdl2jwTrj4yTITzkRzdCCbUbNmxLb1yhB1oiF0G7i/B/pWqgR5kHh
         GOfNvjUyedheqe9gP1/bRVejm5u7P/EjLUhwGrp1lx7Ss1cDdYtDIkLXFLKH+0Zw5q
         g0ne8bm6IUntaYmAtT0qydUpqy5aqxhcPG/jVEdQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <AC510313-C744-4F22-82F7-F75F20F4B073@oracle.com>
References: <AC510313-C744-4F22-82F7-F75F20F4B073@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <AC510313-C744-4F22-82F7-F75F20F4B073@oracle.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/cel/cel-2.6.git
 tags/nfsd-5.7-rc-1
X-PR-Tracked-Commit-Id: 23cf1ee1f1869966b75518c59b5cbda4c6c92450
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ddd873948c9836c2b154e4fabd6e94da0ab9727
Message-Id: <158766030219.20212.18051076581025427769.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Apr 2020 16:45:02 +0000
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 23 Apr 2020 10:36:39 -0400:

> git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.7-rc-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ddd873948c9836c2b154e4fabd6e94da0ab9727

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
