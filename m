Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF1E6F25CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 20:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjD2ST4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 14:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjD2STy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:19:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859221701;
        Sat, 29 Apr 2023 11:19:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24210615C3;
        Sat, 29 Apr 2023 18:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8588DC4339C;
        Sat, 29 Apr 2023 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682792392;
        bh=kHgDemyxd+ETTICl0RvyynE82gBsklNHTWkUhPlY8rE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eOEx+zFyMgScU5K9qYWdsVGKyrM61GZSFNPe4mT1+NVH0W1OSdxi6GQOrEAwY3CHV
         ZFnBW42yEBDDF21d66tzoH/qlQoCLGkaAsG40LDTG6fVY72V95gaAz+La5qAHngrjT
         FzN+3VU2ZHh5r0Ss3sXndkaFXC0T4VZpfeYzEkyNW2qhYaU79POLwhq95wLX1cDZmT
         /cFIzLt3vT3QhtAAgnj5eDL1h4zN4H1NopHMXg+y3Yda97qxxzmSYiFuEINDsa9qw9
         dWNG1COIeXrNZoa8vXfGCiwn7T0fRTkuT+guxI5QIhHt+UcFX3vQ6xziGeWvUyWMPH
         1+NfuB0kBUukQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71F88C43158;
        Sat, 29 Apr 2023 18:19:52 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f949c754-6d38-af12-fa83-176e9971132e@paragon-software.com>
References: <f949c754-6d38-af12-fa83-176e9971132e@paragon-software.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f949c754-6d38-af12-fa83-176e9971132e@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_6.4
X-PR-Tracked-Commit-Id: 788ee1605c2e9feed39c3a749fb3e47c6e15c1b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e098dec61ba342c8cebbfdf0fcdcd9ce54f7fa1
Message-Id: <168279239246.22076.4593087405631164929.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 18:19:52 +0000
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     torvalds@linux-foundation.org, ntfs3@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 11:30:01 +0400:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e098dec61ba342c8cebbfdf0fcdcd9ce54f7fa1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
