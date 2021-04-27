Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D651236CC22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbhD0UIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 16:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236459AbhD0UI1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:08:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 397DA613F7;
        Tue, 27 Apr 2021 20:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619554064;
        bh=Xe7uZKXQbcz5+y1Ao+wOwFPwl7AaUqCn22AfInFRkho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M98ldJlb/t6T/90trCoWci+5QRdUmXq1bkheo1KbGzoIKdQoyzv7vz6EgkdeO2tAY
         +eoCaR6gISgWC28sTwi0vRQvkLMDiio5ToHwHGsP1tQcCBtcx0kHc3WBbhMq9Pj9Kf
         9jTtIFUqQZ3njC2GneMBSsjJpr2fRt7j70MHf/HoS0/YWOvzMlfCLAmxP40A/MDPhl
         N6vzJKEEXPfmNaKWavnWaEJeRzXAZ8306xejMfeY+26du2KW6L+MID7UZ5KHzI9NZX
         pXN/4jZHoc+PROwEczI5GjfKjQdTDpNJxt9N4X4E0EjeOjC0oL4skFCRJilV61PARz
         4btLuXsJUaU9w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 346E1609B0;
        Tue, 27 Apr 2021 20:07:44 +0000 (UTC)
Subject: Re: [GIT PULL] fs mapping helpers update
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210427114332.1713512-1-christian.brauner@ubuntu.com>
References: <20210427113845.1712549-1-christian.brauner@ubuntu.com> <20210427114332.1713512-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210427114332.1713512-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.helpers.v5.13
X-PR-Tracked-Commit-Id: db998553cf11dd697485ac6142adbb35d21fff10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34a456eb1fe26303d0661693d01a50e83a551da3
Message-Id: <161955406420.17333.7462248698530442828.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 20:07:44 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 13:43:32 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.helpers.v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34a456eb1fe26303d0661693d01a50e83a551da3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
