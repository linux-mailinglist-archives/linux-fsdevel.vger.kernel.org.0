Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0541045647A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 21:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhKRUwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 15:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233455AbhKRUwI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:52:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 94A8361279;
        Thu, 18 Nov 2021 20:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637268547;
        bh=BJcfY+M7BqM9mN2vN4KjobuUZYZgn6MppEPzRgR3neY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KpsoYjIXhgnSOwgiVcSUjMpn6RY/FN3/0XxyicyLIRW9dBBVeMhTwVFqUYWz7fwQg
         7OIIBaxlhkjzPN3S9lQd8zaDv4g7KYcrQRrI24HEA+37B4QyNtH9lXZ3o5PtbVGBm+
         v8KTfBEEYPITcjyPBxMnqS4/0y3Tc3Hv4qG27/PiJhEz3+Md1ci/LdWtxLz/D/aA4q
         XLQ1x2zhGQJBzUQKTBZT8y16izlkDX18GJOtZ5xfgy1877wKDGkAGOhHs7eVvhLmPy
         7CzwwzK6onzCFaL0zncb66fhcV8g+rcoC+CxCXQp/DWOw44qgCl5nSwkBDYPBV74ee
         i87Utt7YYs6iA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8DA0F60A3A;
        Thu, 18 Nov 2021 20:49:07 +0000 (UTC)
Subject: Re: [GIT PULL] fs mapping fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211118135001.2800727-1-brauner@kernel.org>
References: <20211118135001.2800727-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211118135001.2800727-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.16-rc2
X-PR-Tracked-Commit-Id: 968219708108440b23bc292e0486e3cc1d9a1bed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cf7eed103d3eea600146ea1853d15ee1f2f0456
Message-Id: <163726854757.10311.13665195271329510413.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 20:49:07 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 14:50:01 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cf7eed103d3eea600146ea1853d15ee1f2f0456

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
