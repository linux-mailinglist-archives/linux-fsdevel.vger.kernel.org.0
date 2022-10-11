Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EAD5FAB51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 05:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJKDn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 23:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJKDnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:43:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9CA7D1F5;
        Mon, 10 Oct 2022 20:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A346B811DA;
        Tue, 11 Oct 2022 03:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E4C8C433D7;
        Tue, 11 Oct 2022 03:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665459800;
        bh=4qw0B4dsI+e/2vkMAHNYQsRax18HhfCG8FNSu4W67t4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q+KqUVTawKj3ZfQcbI2njITRkhVljt7nkijKlaDARCDhu1sSuhbUQjvv9qoo0RXH6
         zD013r3qKCJ76rebBye92hugdjhvYg9onO3+O+6t0D3CKscXxWApPHgawDIogpbnBv
         wTF6Idn2wwQnA2ejNxp+KcV5SKplAPAnX0l40rLs1yZI01Ut/B3siZAYavcnElhXvL
         VwF28XEgLz/Cun45fFyRFMt/fcjEBXOoNxIOej0yfUgJ/DnAFXifoYW5m4P41bfhry
         n0BcpM4xgaw/hIEqj/t+rEpq70MwDv4PjNae4TvdT5PbRXMrDw+UGJzt4/LPsePFxL
         PRO0o++9MXvvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36976E270E4;
        Tue, 11 Oct 2022 03:43:20 +0000 (UTC)
Subject: Re: [git pull] vfs.git pile 7 (tmpfile)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0DRFtPcQ2jeZfXa@ZenIV>
References: <Y0DRFtPcQ2jeZfXa@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0DRFtPcQ2jeZfXa@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-tmpfile
X-PR-Tracked-Commit-Id: 7d37539037c2fca70346fbedc219f655253d5cff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f721d24e5dae8358b49b24399d27ba5d12a7e049
Message-Id: <166545980021.4678.11073567245199213844.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 03:43:20 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 8 Oct 2022 02:23:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-tmpfile

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f721d24e5dae8358b49b24399d27ba5d12a7e049

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
