Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E756F37D78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfFFTpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 15:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfFFTpC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:45:02 -0400
Subject: Re: [GIT PULL] overlayfs fixes for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559850302;
        bh=bMvXxNGMZgwcQt8Bga0L4BxCS+GbQCKH4lNZoO5lBXE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KysQuyfAAn68ErXCSv+006kKGhdf2t+h98o89BUNH8wwSq0CRZJB/V875lGpkD8za
         sN6ar7OcQEcC9edsTsYP+u/Cv5aFuiorZ1wrWkg22mEJeypbwkze7JyNt5dYBCENqS
         HcrK37NBqhRaP9x0tBPJjwGZJRrRqz69HSt0Ww5Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190606134418.GB26408@miu.piliscsaba.redhat.com>
References: <20190606134418.GB26408@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190606134418.GB26408@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-fixes-5.2-rc4
X-PR-Tracked-Commit-Id: 5d3211b651a012bc77410ebf097b7271a7ce5c95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d6b501fe5421c5df662e2935f55f5e3d2b5e012
Message-Id: <155985030229.29170.4073257838224103158.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jun 2019 19:45:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 6 Jun 2019 15:44:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d6b501fe5421c5df662e2935f55f5e3d2b5e012

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
