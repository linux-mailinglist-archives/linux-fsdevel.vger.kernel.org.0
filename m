Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664F7370E7D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 20:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhEBSdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 14:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhEBSdq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 14:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B5C62611EE;
        Sun,  2 May 2021 18:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619980374;
        bh=Igv8BOoOO/BvJBRt7nYSXWvbc/80Y54j4E6130yYTnA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PUDFSaRA47De3P7d20TzkZEGgGqnYWNFseqDsRleR0e+6U1tp2QpNgNzZkJl8cChM
         +MgsmaCs51vHFrP1zVrDW7bJnOakRZx42El6fAuhafeRiJfm/HkzeOkey2RSt7ayd1
         RGwykMeYUI7dm79ptQEQHYHfjrvBZlCKh52HhjrmZfIZ2jHrPy+lSxNqLIqXhAj9AB
         Sxosi6ePg5gEUCRXggQjuG0O9q/RIR7atIAVZKJZ/3zziCfeROfV35s2uJyBZp8/1o
         lMcDN+ud+03M7hnSIpHVFGkv/FZkyepUaBxkVk7EG5C/GdJR11h+an3kGV1quIflo5
         5oQ/1QgYOcL4A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AFE33609CF;
        Sun,  2 May 2021 18:32:54 +0000 (UTC)
Subject: Re: [git pull] work.misc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YI4AwgZaFSGsTDR9@zeniv-ca.linux.org.uk>
References: <YI4AwgZaFSGsTDR9@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YI4AwgZaFSGsTDR9@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 80e5d1ff5d5f1ed5167a69b7c2fe86071b615f6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27787ba3fa4904422b3928b898d1bd3d74d98bea
Message-Id: <161998037471.19587.8857455333728326962.pr-tracker-bot@kernel.org>
Date:   Sun, 02 May 2021 18:32:54 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 2 May 2021 01:30:42 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27787ba3fa4904422b3928b898d1bd3d74d98bea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
