Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7FC1702A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 06:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEHEzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 00:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfEHEzG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 00:55:06 -0400
Subject: Re: [git pull] vfs.git several struct file-related pieces
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557291305;
        bh=t20W/ZrKJ9ZjuMlDVudi+Fy/P+J0pTP+WyTUuw7OmZg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z5qSibKI3A+c4lT2AAVOsT1IPwW2WFdCPy3XqwGTwopP0f67qt7vkt/kKhBMwdmwx
         L8cppsh0O1jDv2O9IH+FpLf6nzZNhOAw1EZkjPXeGSL0fcJ9jQQRRKUTY8JD8w7fU9
         FAxDXK7zrq/uXU7WavmnduX2pZRsxZidmeFvvyMs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507205209.GM23075@ZenIV.linux.org.uk>
References: <20190507205209.GM23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507205209.GM23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.file
X-PR-Tracked-Commit-Id: 3b85d3028e2a0f95a8425fbfa54a04056b7cbc91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d897166d8598e362a31d79dfd9a1e2eedb9ac85c
Message-Id: <155729130574.10324.14228101879148424298.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 04:55:05 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 21:52:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d897166d8598e362a31d79dfd9a1e2eedb9ac85c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
