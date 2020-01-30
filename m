Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF6014E62D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 00:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgA3XuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 18:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbgA3XuE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:50:04 -0500
Subject: Re: [GIT PULL] xfs: new code for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580428204;
        bh=tt3HgsvZ5f1NSLredYL9p0Zx285v1TU9VRXMgWzws+8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bi1YEKnTeQ+jyXt1fCe95TuPnVKwZSZuh7Zt/W13AUjth0Xdy3TDa5GIEeH8rkPDx
         sxdEZ2NuyBWgRVHaSQaSEhl22RsRHSDU+MZJA2lBOoy+tQLu6jOjsJ/y4f/nwZASYz
         r1CdGxSZ34w+fU6h1YdLRJUDOei95EaqAyJNnBA8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130161338.GX3447196@magnolia>
References: <20200130161338.GX3447196@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130161338.GX3447196@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.6-merge-6
X-PR-Tracked-Commit-Id: b3531f5fc16d4df2b12567bce48cd9f3ab5f9131
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91f1a9566f387137f2da1957792a8f9f07cd058f
Message-Id: <158042820420.30792.5005939379399587019.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 23:50:04 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 08:13:38 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.6-merge-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91f1a9566f387137f2da1957792a8f9f07cd058f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
