Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9193589A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 18:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhDHQYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 12:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhDHQYa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:24:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 64DDE610D1;
        Thu,  8 Apr 2021 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617899059;
        bh=8PaSlSmT+0b1rz8D/ehydnS9QlW/YfT9bcl4a3sL4Hc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BjsyyjfuT/eXadgC6OkK21j6JhhVslsEHBVMV8aO/Ohiv0CR+gWM39tQcmpUFGMTV
         ERXRAcOndsCVXOi7lvQwiRcq/9b/F1B6BgamU0mdf4296A0ch9FWDzzKjosMSvsjne
         rDSijLBTQNZCcQQDLftAmYlV+/hA+CiHodf0wpgjYeBO05viQxrfqPywYio/XIKFzt
         VPuW3IQR0KTHFSt0i3EtNRn1O0FjemZWZWxVqijN97eIKRXiCRrvRYY0T3cWzFhARV
         p8VCfCLdvmsyxWstDdxkQrZ7wUxPm8KUdeEBq64jf/1abn5E++2c4amAsMgAjt3oIX
         dZgmK9/mFBpjA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 58F2D60975;
        Thu,  8 Apr 2021 16:24:19 +0000 (UTC)
Subject: Re: [git pull] breakage in LOOKUP_MOUNTPOINT handling
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YG5lZcubiudwsz4I@zeniv-ca.linux.org.uk>
References: <YG5lZcubiudwsz4I@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YG5lZcubiudwsz4I@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 4f0ed93fb92d3528c73c80317509df3f800a222b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 035d80695fae55ed3e788cd8a62525657a43b924
Message-Id: <161789905929.11255.3488914908748886213.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Apr 2021 16:24:19 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 8 Apr 2021 02:07:33 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/035d80695fae55ed3e788cd8a62525657a43b924

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
