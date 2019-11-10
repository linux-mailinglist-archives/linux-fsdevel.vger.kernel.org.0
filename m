Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F62F6BA3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2019 22:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfKJVfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Nov 2019 16:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfKJVfC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:35:02 -0500
Subject: Re: [GIT PULL] configfs regression fix for 5.4-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573421702;
        bh=pv05HTXYV/pLlLfrFsJsfYgT/cv28uXADDSGjyyqJo8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DAPN5Bx5fVB1cW11jeTNe03kEtCicWmeKIm3q3HBXw7M8rWuSFtZrDsc9dcCfMZZc
         5lAFfaNdMgzaUBSLKMEny0Sa6dfvRJR0vC1UCLbmxZeCJpq+7jeR4Xh/uXhYuBukfq
         qDeG8sARWUHJqRB0eTZqv0BzZBFnfHv3L0yiYEy4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191110141648.GA23526@infradead.org>
References: <20191110141648.GA23526@infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191110141648.GA23526@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git
 tags/configfs-for-5.4-2
X-PR-Tracked-Commit-Id: e2f238f7d5a1fa69ff1884d37acf9a2a3a01b308
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5871fcba46edcf7380d9d86e6a07b3366c3c2f6
Message-Id: <157342170229.28901.17480806844972872966.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:35:02 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 15:16:48 +0100:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5871fcba46edcf7380d9d86e6a07b3366c3c2f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
