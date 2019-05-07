Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6B916BC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 21:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfEGTzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 15:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEGTzE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 15:55:04 -0400
Subject: Re: [git pull] vfs.git pile 2: several fixes to backport
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557258904;
        bh=/83/qUhmulr3gfmajVdgvpSWbPWs0ibbHASeiBTN3RY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WtKtLBEaS4SwS5dONShXgzuyCYl/eRVUBgAOyN0tfvgAz4OUiyawAfzYiV42iFXM7
         bsyZ4oAc2YgJ0Fj6PlaTBY1gXkpwndVGyM4r2mR+HoGaQeS8mYwgrdjOJplD/BE4Tv
         wPZWQZuR9p8ujcqJNrqPqkKljp/X7PKlmdWrc2uo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507005842.GG23075@ZenIV.linux.org.uk>
References: <20190507005842.GG23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507005842.GG23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git stable-fodder
X-PR-Tracked-Commit-Id: ce285c267a003acbf607f3540ff71287f82e5282
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78438ce18f26dbcaa8993bb45d20ffb0cec3bc3e
Message-Id: <155725890428.4809.11935756105494832624.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 19:55:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 01:58:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git stable-fodder

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78438ce18f26dbcaa8993bb45d20ffb0cec3bc3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
