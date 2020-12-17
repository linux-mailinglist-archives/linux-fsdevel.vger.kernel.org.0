Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6222DD9CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 21:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgLQUWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 15:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:32832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgLQUVw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:21:52 -0500
Subject: Re: [GIT PULL] overlayfs update for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608236472;
        bh=ELcL03WZjKdIBTp0UxmelLMdUZBVqA8MOKAAnXbrTIk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ttlIcFE8YB4gfX8KtxX9WUnd6rmKj9nixbXfIK9tzDTlSn65SBMZYRuS2ODYP7a+i
         iW+KoJpb7NfrhbDtPlGuyMi2fu6P0Mzra3g3emLhw0PmYSVx4ohd9uoXOxQts6Eud/
         I5pcm/Ur8W3e6HBwK0RR0dODR0shaMwti9OPA28oAhvx9Rxhtub+vDBoV14htglqpp
         BJLW82bbxydhNwqQRNYznhHgafm71+GoH/svQbJSwJsrmhlfjBX0BFe/Xj5iKmLzCZ
         lPq3O2kQxq8X9f2lE0bzgljaxfLE039uysyOp2tKDldCkzYImxiDmYPlKU1Ia0u3Ao
         cCvc0EEQC7SbA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201217142025.GB1236412@miu.piliscsaba.redhat.com>
References: <20201217142025.GB1236412@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201217142025.GB1236412@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.11
X-PR-Tracked-Commit-Id: 459c7c565ac36ba09ffbf24231147f408fde4203
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92dbc9dedccb9759c7f9f2f0ae6242396376988f
Message-Id: <160823647214.7820.4991320145990086247.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Dec 2020 20:21:12 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 17 Dec 2020 15:20:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92dbc9dedccb9759c7f9f2f0ae6242396376988f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
