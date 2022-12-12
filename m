Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0464A5FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 18:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiLLReE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 12:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiLLRdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ABA13D7D;
        Mon, 12 Dec 2022 09:33:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 325D4B80DE2;
        Mon, 12 Dec 2022 17:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEAF0C433F2;
        Mon, 12 Dec 2022 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670866402;
        bh=eSmOQLAHqmEkrp7YCaSJCP0taxmKCaKl6YZCvxezgjY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e0TmW6oBs5UTc+q76/FxQSE1rcS0yW7cXixM4HOSKKrA4KjZU38yeDuACkAsN45f/
         lVQJBvSnZJ3JkJe1pBOkS+Iprsi7YSkZr3VOc8fQeahTLUQBpQNGDaWlE3jV7qvcqC
         P4g2Y6YI3t8wDfsGpc09VeJEIOmBO61LQoIXhOu1dN6gSQOuLZRDsVL1dTAbfI1CLa
         Qy3fB+8YTQ9ZVOpKOajCZz2SVq7rpD17rUwLss/BimQ/ZOHwOYT4ss5o0jCmvejM99
         +lInp3d4D/ldRLgfvWjMBM8/QkC54WExvyTwIqnTcFE4FVFeWKLsBrbb+g7aEBnpDh
         u7GQlgmp+l8Cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCD87C00448;
        Mon, 12 Dec 2022 17:33:22 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202212051637.93142F409@keescook>
References: <202212051637.93142F409@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202212051637.93142F409@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.2-rc1
X-PR-Tracked-Commit-Id: 6a46bf558803dd2b959ca7435a5c143efe837217
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fc035058eab3a485060374d78012708524ca133
Message-Id: <167086640276.22610.757986337750816625.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 17:33:22 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Andrei Vagin <avagin@gmail.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Bo Liu <liubo03@inspur.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Liu Shixin <liushixin2@huawei.com>,
        Li Zetao <lizetao1@huawei.com>, Rolf Eike Beer <eb@emlix.com>,
        Wang Yufen <wangyufen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 5 Dec 2022 16:41:23 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fc035058eab3a485060374d78012708524ca133

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
