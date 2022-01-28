Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE749FE5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 17:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350289AbiA1Qus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 11:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350285AbiA1Qur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:50:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F6C061714
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jan 2022 08:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E032060DE9
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jan 2022 16:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54579C340E6;
        Fri, 28 Jan 2022 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643388646;
        bh=5ZKkkKi1MsJMvHl3NsAmUwx/6RDFRETHZuMBPpsIzmE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jPUY/9rOTLRDB4qVVdQQaY+lQosw+5ocF70wHxxUxXrcTDe3kKb/vD7T1+L4MF0ZB
         xaaag4aqpu1D9IDwGnDE2SVJRiuznhhg1YPGJxWOC3jiR+HdCKJSOpV5sQpiM8jQkp
         fNwf4ykPlc68K4WG+wR2AWgSGGdvVIluBqku/jiXHo3sQ90p4h0GcTHZp/nw6vgQHa
         w/72Bgj87DliVWFJgo1/DRlY5r4nYyWUB6xZ00W/7sDSdXiWbCTLfbk0WJBqyJopNP
         NXpjd6HdDX+Kpb8jwAvQiX2GuFeuDNGgHJ0UerMpSpmpgZNmZyQr19B+j0zGmIsrOO
         obFFiHZKaNYbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 423A8F60799;
        Fri, 28 Jan 2022 16:50:46 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify fixes for 5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220128112531.pgttgwgavqxk7xwq@quack3.lan>
References: <20220128112531.pgttgwgavqxk7xwq@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220128112531.pgttgwgavqxk7xwq@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.17-rc2
X-PR-Tracked-Commit-Id: 29044dae2e746949ad4b9cbdbfb248994d1dcdb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4897e722b54f10e2e96c3eeca260caa7a8b0dbff
Message-Id: <164338864626.23534.3312834879638038502.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 16:50:46 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 12:25:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4897e722b54f10e2e96c3eeca260caa7a8b0dbff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
