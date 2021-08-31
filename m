Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5F3FCCDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 20:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbhHaSU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 14:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231612AbhHaSU1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:20:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ADE2061051;
        Tue, 31 Aug 2021 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630433971;
        bh=PgM+rDs46+2K+qL4znNPoYRobm/RKsxxaeXjArovSN8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SWOFg1QAapkZgOnNA55lnZXl0M1sBb7SznJoScFIfq/GCb5UzGord2w7FpFz+0Iqo
         ErI9bpFhNW8BgCu1y21b9GDjnMI/oG0+gR4ICZ2vsW45Tn8V37mqWYeQsQi9HOo9GH
         +w8voK2ZTzcJco29BILtsx70Sofl/0SQgDm35+vmlA+0o2PYmkYg828wmGqMXIY7TA
         TJ0KWEjWx+TOdnyLRCfQb0yDSfu7N8BWPSlTo/eazDxoxocI6iST60/uxhwuShS1xt
         O4qt69qcDdH/pLAtNrx0qRd30oFL4aZ0zPWL6FNWLmvimhauUEZDQsAi5sRT9iA0ea
         aT1ruYletuzSQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9D47A60A6C;
        Tue, 31 Aug 2021 18:19:31 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS0LlXIhvZc4r5Vt@sol.localdomain>
References: <YS0LlXIhvZc4r5Vt@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS0LlXIhvZc4r5Vt@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 38ef66b05cfa3560323344a0b3e09e583f1eb974
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd358208d703fca446b52f3cf8f23c18f9e7705e
Message-Id: <163043397158.24672.5271221655251796062.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 18:19:31 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 09:47:17 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd358208d703fca446b52f3cf8f23c18f9e7705e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
