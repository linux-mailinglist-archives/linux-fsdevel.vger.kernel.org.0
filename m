Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC9B6DAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 22:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbfIRUaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 16:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387456AbfIRUaE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:30:04 -0400
Subject: Re: [git pull] work.mount - infrastructure
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568838603;
        bh=OJJZWPQXP8cUC5NclBwTlGCgX/ZEFrt8IBkCUFLs40U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zSG9UoDtKHtF6617udGaLz2Ej3jQLKahYUBdts3li4Vtv3s9/nZ2/CcxwwawIz+hZ
         3tspzZoXXGJ50bZPuszCHoLtdP4INyjQSPQTOwWCJVBgGW5FHiipKrNo5scSyOY8wB
         KrthPA4FVH/WfLW4DBjXAoGv31xetGTluGRIEsUk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190917014101.GF1131@ZenIV.linux.org.uk>
References: <20190917014101.GF1131@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190917014101.GF1131@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount-base
X-PR-Tracked-Commit-Id: 0f071004109d9c8de7023b9a64fa2ba3fa87cbed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e170eb27715fc9253ae031297d0638a3ef51b5da
Message-Id: <156883860387.13812.17628500676358897597.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 20:30:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 02:41:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount-base

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e170eb27715fc9253ae031297d0638a3ef51b5da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
