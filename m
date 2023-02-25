Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5E6A2704
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 04:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBYDkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 22:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBYDkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:40:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D6B11EBA;
        Fri, 24 Feb 2023 19:40:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97D8DB81D50;
        Sat, 25 Feb 2023 03:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CFD0C4339B;
        Sat, 25 Feb 2023 03:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677296406;
        bh=DmjvVFOWG4XHWlJh+BmQndMN2vi6MbZ8L6DimONhBnQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bf8L3k+YkCk6s9ip2cvi7x07gruxniTNGHug07khD0jDakX3Z1y+f33EIn85htCje
         qQqoMAiHCqmK7m8vKtjgNzlGjg+8aYDK9wWlZZbKwQywvGAV0NwAnUk6DOwIdO3C+e
         i20icKxaTr1CHDsHVQvz0GwKejxBRpA56Np6jyWbnzrKJ/N4pj783iQC1UDRHpG0Ca
         VOal6LvAteHUFoSZYK9OFAM8je7XPQzrCiGiwp/6NcB1sEf/AwNTVOBbvewejt1of1
         2btekApjiWAS7zBpJdjHsUWofL0hmqmYwx3MwrUHEJLtLy3qmTLMBP+mUofVS6G2AY
         HHS2VvUueIWwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37BA2C43151;
        Sat, 25 Feb 2023 03:40:06 +0000 (UTC)
Subject: Re: [git pull] vfs.git sysv pile
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/gugbqq858QXJBY@ZenIV>
References: <Y/gugbqq858QXJBY@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/gugbqq858QXJBY@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sysv
X-PR-Tracked-Commit-Id: abb7c742397324f8676c5b622effdce911cd52e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6b9cf417c62601f26fa47f97d6c0681704bf0e3
Message-Id: <167729640622.19216.1776945737977196379.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 03:40:06 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 03:26:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sysv

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6b9cf417c62601f26fa47f97d6c0681704bf0e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
