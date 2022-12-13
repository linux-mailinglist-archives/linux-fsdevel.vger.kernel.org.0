Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D23364AE64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 04:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiLMDtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 22:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiLMDtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:49:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6C91DF1B;
        Mon, 12 Dec 2022 19:49:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD29560010;
        Tue, 13 Dec 2022 03:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D792C433EF;
        Tue, 13 Dec 2022 03:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670903372;
        bh=GUFfcScP/G08jm8bkNmHtPE9iKxfaNmgjBdgT7NxiiM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HTJSu1dqg7csYAh6kp+8I64YR19O9StMMqWD+cwmm/z9WprTHchtpg6X6455ODBUe
         YpfwCoXUA5QRjCMJPA4MvgzEoQ8wcIrXIt8wT+vmN1N6Rntc+BE7Wuz3yIDDwXZJtA
         NwF69I2IWX0U+2NORuoUe33JdBA/6osqpEhGuh6eoD0wyxdd3CD5hKdI1lggiTBL3w
         8y1C5FdAH221xdAS5u3Ywvy0QM1K68hkZ1txx2JWA0BOXpvTvWIvbmNCxZKk4oDVLD
         2ah7mRhR+2QlSZ9+jK6Uy4VubNfMtQFh/MA+mxdbwc8KIWUfctcG7j0iiq4cOrP2ZW
         N0sE1LehG8NrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19B5DC00445;
        Tue, 13 Dec 2022 03:49:32 +0000 (UTC)
Subject: Re: [git pull] vfs.git iov_iter pile
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5Z3OMYJOMxQqXQf@ZenIV>
References: <Y5Z3OMYJOMxQqXQf@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5Z3OMYJOMxQqXQf@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-iov_iter
X-PR-Tracked-Commit-Id: de4eda9de2d957ef2d6a8365a01e26a435e958cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75f4d9af8b67d7415afe50afcb4e96fd0bbd3ae2
Message-Id: <167090337209.3662.7675523558317890008.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 03:49:32 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
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

The pull request you sent on Mon, 12 Dec 2022 00:35:04 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-iov_iter

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75f4d9af8b67d7415afe50afcb4e96fd0bbd3ae2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
