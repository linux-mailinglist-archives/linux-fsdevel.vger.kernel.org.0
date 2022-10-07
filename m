Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81775F7BF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 19:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJGRAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 13:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJGRAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:00:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A85D8F976
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 10:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7B8DB8241E
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 17:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97491C4347C;
        Fri,  7 Oct 2022 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665162017;
        bh=vvHwft+WAvD/QJp9Y6EVrArLE6ebGcT/HuOWPpcDZZg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lQZ0o2s7ySPmTmOrnLGCb4feLI+h0C+R+419vdP1XGMbFDKTycnoZ9a38oX7Wr1op
         aKMCjnt9Y8D5BCDP47hzD+X+lSKS3OL4xQJCJzYt5ou0BKEJO2J9OTeg7ij054MDqh
         NKGm+2NeYEEiX/b8Icw1akzQ1Is+nyKw+xWgH0KiVpi1kf8dHxNRVNa0SFsu5Vzj/r
         0UzST3aogpIpOLiSWmFiGuzLCuL3smyzrAkDIUBB4ToESrNSvas2xc5sk5lk43B2Ed
         CEqHhOlTkgnaYu30ZqE/Q5C4hCOcAUErraJ2RuyJh7gx5Tdiy+1btvFD0SgZQS9m2/
         DMLPCbRywbhjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84445E21ED6;
        Fri,  7 Oct 2022 17:00:17 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221007124834.4guduq5n5c6argve@quack3>
References: <20221007124834.4guduq5n5c6argve@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221007124834.4guduq5n5c6argve@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify-for_v6.1-rc1
X-PR-Tracked-Commit-Id: 7a80bf902d2bc722b4477442ee772e8574603185
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abf625dc8c1db167150c844028a2f9f4c329fe68
Message-Id: <166516201753.22254.12764469144635411319.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 17:00:17 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 14:48:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify-for_v6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abf625dc8c1db167150c844028a2f9f4c329fe68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
