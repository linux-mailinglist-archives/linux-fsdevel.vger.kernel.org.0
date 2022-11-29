Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBCA63B81D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 03:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiK2CpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 21:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiK2CpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:45:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6924731E;
        Mon, 28 Nov 2022 18:44:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9904CCE1147;
        Tue, 29 Nov 2022 02:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA8D9C433C1;
        Tue, 29 Nov 2022 02:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669689895;
        bh=b4PoGV2FhG8h0v2IENILrYu5RU07cPKyB+6H+pvVuFs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=esqsa14/vgeLs3bb/upR2JETxhHwGMPZKNnX4Vf3oWikZw8QzM0axXdF6ild1w3c+
         tNiXUmJ4lzmdkV5WYfYy3RnZnW/JzQX/nhx3hvOlqiiOzqL5qAtnECuMDE6rjPyWLo
         jAYfKPZN70v3QxXZjKNCfD1NpusRNkzaMoDKYlN5nXe8MvsFkYsle9yIe41oj9+II5
         9cCxXd0BEQiuvETr4ytWIUpivyC0sLoHya1Epwb+5imtxP1amkVwKf5U1TCQXzXR1K
         9LFZlswSUWCFXen7MCp1HyI93p0qIlz4TlJYoMfHzdt2OT+u1x2PZwsUeP93v8acZt
         e7zvI0E9xDvPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C72D4C395EC;
        Tue, 29 Nov 2022 02:44:55 +0000 (UTC)
Subject: Re: [GIT PULL] fuse fixes for 6.1-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4S1CNZ6Zk6k1SVn@miu.piliscsaba.redhat.com>
References: <Y4S1CNZ6Zk6k1SVn@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4S1CNZ6Zk6k1SVn@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.1-rc8
X-PR-Tracked-Commit-Id: 44361e8cf9ddb23f17bdcc40ca944abf32e83e79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f35badccddb7727086eb6481c25c5de9eb417db6
Message-Id: <166968989580.2175.4358793310301821607.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Nov 2022 02:44:55 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 28 Nov 2022 14:18:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f35badccddb7727086eb6481c25c5de9eb417db6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
