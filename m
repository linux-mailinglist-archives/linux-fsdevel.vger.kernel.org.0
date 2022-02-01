Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C5E4A664E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 21:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbiBAUqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 15:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242490AbiBAUqQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:46:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F21BC06173B;
        Tue,  1 Feb 2022 12:46:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF827B82F94;
        Tue,  1 Feb 2022 20:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C229AC340EC;
        Tue,  1 Feb 2022 20:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643748373;
        bh=Ct+pR4f8J9Y0ZwKUO+1AXgVWuI3ffLJnSa0ysUAIp6U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G3k+tJhfcPm5qatvx4iTAtSQ/GorTS5vrrZIH0f2xvntglMBESdxSDYoUmkzkiDmQ
         94QHCWNW6A/a7ChOeu7KG9fzR/fna7ijUc6REi0uJtg9oeowFO0N8OnC3CAmBDatP9
         JD4YR7gxh9u/DU2XDkpLFThZc2iIlOnFvlaKgpabJjsH+VUBSE4g0X+xN9Tx22Z7oK
         MTayEnCNfnpmllZuAb9Lp19UmyQ4namEQhSVjhWZ0otpnTQB4Kk9Hy/Bnsdu7oKzvL
         PDLQLoukeakTs+EBupL72DBjjMLpo7mniHRNWKhWLag6Cdlg+7k2cZym2ZMhZ/FiYC
         rU1oQlLVttqGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B19B3E5D08C;
        Tue,  1 Feb 2022 20:46:13 +0000 (UTC)
Subject: Re: [GIT PULL] unicode patches for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87czk7qql0.fsf@collabora.com>
References: <87czk7qql0.fsf@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87czk7qql0.fsf@collabora.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-for-next-5.17-rc3
X-PR-Tracked-Commit-Id: 5298d4bfe80f6ae6ae2777bcd1357b0022d98573
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 630c12862c21a312c15a494922cdbf9c1beb1733
Message-Id: <164374837372.6282.6935374706373859684.pr-tracker-bot@kernel.org>
Date:   Tue, 01 Feb 2022 20:46:13 +0000
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, hch@lst.de,
        chao@kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 31 Jan 2022 21:16:11 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-for-next-5.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/630c12862c21a312c15a494922cdbf9c1beb1733

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
