Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8A621D5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfEQSfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfEQSfC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:35:02 -0400
Subject: Re: [git pull] vfs.git mount followups
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558118102;
        bh=v6YJc82Gth9hXcWwPFB7FNul0S4IbBfRHhPszymF44U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IMRSEFu5KMVBLOw+v8lWcQaBz4jse/GOkTijGL1qnUE2MBsWfbZ8NGDCPYjeH6cTa
         Tl9axGTPAFICuDV1z401XrL9cCKwHr69r2GHff3YcU68azAKZMuo1Ap+h1kYpy+BSj
         OnvShGFzhgpHreBRGeHRiozQXZ2090TpEitCKgxQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190517031125.GF17978@ZenIV.linux.org.uk>
References: <20190517031125.GF17978@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190517031125.GF17978@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: d8076bdb56af5e5918376cd1573a6b0007fc1a89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf8a9a4755737f6630756f0d87bea9b38f0ed369
Message-Id: <155811810220.11644.1180078930373187276.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 18:35:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 17 May 2019 04:11:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf8a9a4755737f6630756f0d87bea9b38f0ed369

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
