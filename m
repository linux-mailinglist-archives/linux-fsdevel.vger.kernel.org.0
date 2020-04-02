Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2F19BA1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 04:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbgDBCFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 22:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgDBCFE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:05:04 -0400
Subject: Re: [GIT PULL] XArray for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585793103;
        bh=9JjWTMQZTzxCAM732VmpHKueCSqSdGhwvAHvVXu14Ko=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yBoLz3WSUxCRMOdaqvTr0pROExsRHFK3INr9lgdyqIdiO8+A+TTx7TUW5k6FmwRps
         hqENVN2F9nRJ66yQjHTemlXZ6J8jXP1Y573rRyC6kgdPfDgvEqNXnV+qRKeb0qIfar
         yV1nFId9nSzGSi0wQ7DkgIVvbzMLm2e/mIAx2icI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331141749.GB21484@bombadil.infradead.org>
References: <20200331141749.GB21484@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331141749.GB21484@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/linux-dax.git
 tags/xarray-5.7
X-PR-Tracked-Commit-Id: 7e934cf5ace1dceeb804f7493fa28bb697ed3c52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 193bc55b6d4e0a7b4ad0216ed9794252bee6436e
Message-Id: <158579310371.873.17070096012445384076.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Apr 2020 02:05:03 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 07:17:49 -0700:

> git://git.infradead.org/users/willy/linux-dax.git tags/xarray-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/193bc55b6d4e0a7b4ad0216ed9794252bee6436e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
