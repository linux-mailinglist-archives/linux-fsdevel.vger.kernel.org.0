Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3A96B5842
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 05:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCKEwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 23:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCKEwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 23:52:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250FA12CBA9;
        Fri, 10 Mar 2023 20:52:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD4B8B824B8;
        Sat, 11 Mar 2023 04:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75E7FC433EF;
        Sat, 11 Mar 2023 04:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678510329;
        bh=cw/7c/gPaa76+bE8/rr/4eTXHAwoTw0TLmE0F2lhjHo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MdtI5KnEpV4KYNV0wQ6/0KK/wNsJ7Eqky64n5AzQFMWcsFsulkKrFfmwvNtprmoH7
         qwCWs4+XUrOXCQESnzChcmD7evJDdHtryrAbhrkNlnEQlf7t8YCcAulFiIELz7VV/o
         WaaHAGcV+FzBvqgyve0iTNmOwoFrcTboKo3M+uxoRt+sN+Vuwf09micA/RIUqAs5Hv
         ZUhVgjvTb1nZr+ZsPMfgf7CaREPGyntAG9pWoF3Ehsk2lHfKgL4sVC3VZYneNq6gqP
         Rs8mbMnS8ZuvjzG/QNLYZ4VOXu9VVFH48ikEFAd9lSQfUxQbebeVFID5QexwYOCMyT
         4nnPkp3W2b/4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6129CE61B65;
        Sat, 11 Mar 2023 04:52:09 +0000 (UTC)
Subject: Re: [git pull] common helper for kmap_local_page() users in local
 filesystems
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230310204431.GW3390869@ZenIV>
References: <20230310204431.GW3390869@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230310204431.GW3390869@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-highmem
X-PR-Tracked-Commit-Id: 849ad04cf562ac63b0371a825eed473d84de9c6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d33d4c9e0888e9ee7666813b3f9ecc244a64d127
Message-Id: <167851032939.30895.4541774444993710662.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Mar 2023 04:52:09 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 10 Mar 2023 20:44:31 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-highmem

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d33d4c9e0888e9ee7666813b3f9ecc244a64d127

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
