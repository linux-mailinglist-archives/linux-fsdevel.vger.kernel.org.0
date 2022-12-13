Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E4364AE6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 04:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiLMDts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 22:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiLMDtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:49:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9271A1CB11;
        Mon, 12 Dec 2022 19:49:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C5E6B810CB;
        Tue, 13 Dec 2022 03:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F38A5C433F0;
        Tue, 13 Dec 2022 03:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670903373;
        bh=AWrMYRzJA2zKTAJR/MXqq92POZ1HcL3CzkSeGfujIls=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bz2i8sXJMTTWRb7hMskY/YGHh8U6sXbAR8yug3+WaX1mOW7DFIHhUEzRbq6t5U2bX
         1vg+hGe07Jw3Z02EyZxJ/rLTr/FB1WFrxlidkoMGmOtvpMobq+33KcB8iU6NPxpSam
         zHy++4SJjC02OHfs7kE+hK1UrCdSLKlzB0qLY/Zk7qQ2onwYBsqzv4a2ClP5aWKTXB
         2IWE1yFxjJtVyCFgHLHM+6SU9ma5O/OhyuYeLbPBt5PgLNrvvQTsIdRRugKHqVF+Bs
         2//H1oZsEy7SC/5xccRwf+fzf2XYNqX8EUWUezgaiHfwMv/SV842Mwlmw9GlJlu2mZ
         VVYxEZRWitdQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2845C00445;
        Tue, 13 Dec 2022 03:49:32 +0000 (UTC)
Subject: Re: [git pull] vfs.git misc pile
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5Z4RCCOiu1OrmS2@ZenIV>
References: <Y5Z4RCCOiu1OrmS2@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5Z4RCCOiu1OrmS2@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc
X-PR-Tracked-Commit-Id: e0c49bd2b4d3cd1751491eb2d940bce968ac65e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd90741318ee0a48244e8e4b9364023d730a80a9
Message-Id: <167090337292.3662.11974924852861054659.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 12 Dec 2022 00:39:32 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd90741318ee0a48244e8e4b9364023d730a80a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
