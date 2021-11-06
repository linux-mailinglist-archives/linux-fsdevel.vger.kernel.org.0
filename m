Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD6447105
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Nov 2021 00:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhKFXxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Nov 2021 19:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231741AbhKFXxH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Nov 2021 19:53:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 014F260E97;
        Sat,  6 Nov 2021 23:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636242626;
        bh=j9t5U5JjkxTptAeJIIndb6H55tH2f+XtBHLnJNXeEJA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ulCiwE0fVoNT3Sc8Nk31ZqdT+d1pHJlJ54zkbLM0M9UpljB6RMgRuFNVUaSnuEudt
         Pg3kNRk4IBtcUpGgVpic507K7KelcpogInMbVPqLmkCFZDmfHXG2B52qPA2lUFciyX
         76dcSnBSVuuvVe2sJJBLI6XM5ULRvcJ+6/fNTiixpi9DYoagdiK+aDt8pAXJa/gsj0
         rHlwDzX+gL6TjimzzWtLFsd9oJfTri/hDqJCKh77HjTqKFlJ+WqtEgceluTtaTG8me
         TYEnIOEBmjybXcER/M8BWYc66CYlqzqZActJB+n3XF8j4QhfuSeurPbAyBfx+MjUtd
         JpecM3HyC4hlg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EE184609E7;
        Sat,  6 Nov 2021 23:50:25 +0000 (UTC)
Subject: Re: [GIT PULL] Quota, isofs, reiserfs fixes for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211105135420.GA5691@quack2.suse.cz>
References: <20211105135420.GA5691@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211105135420.GA5691@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.16-rc1
X-PR-Tracked-Commit-Id: 81dedaf10c20959bdf5624f9783f408df26ba7a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8b4e5bd4889e6568e8c3db983b4320f06091594
Message-Id: <163624262596.31518.12744484352537637796.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Nov 2021 23:50:25 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 5 Nov 2021 14:54:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8b4e5bd4889e6568e8c3db983b4320f06091594

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
