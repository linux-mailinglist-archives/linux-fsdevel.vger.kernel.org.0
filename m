Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2BA799665
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbjIIFFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 01:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbjIIFFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 01:05:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17971BC1;
        Fri,  8 Sep 2023 22:05:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6805FC433C8;
        Sat,  9 Sep 2023 05:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694235944;
        bh=SdIEpcqAEofTvunL+Q/268WFo7lxaf5CapcX0yqZgd4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G90J1twi0u0k5J77Xvwm6QM5u3+G4hL3zN9f817gYJgUAZf5kznlNLiinXDcpg8PR
         xWBAVgIx5WiuGtlOiPzrUoWNJcDGI3odJLFiwX7DyWpOG1sVL3x25QuWlwO0krXor5
         zmG4KoM6S24zrbrO7+2ELQvM7bJtf/X6uFYsg1GB82FYUk9LOMvIqhS8va7m2XfMX1
         NhdTMRDzbEeYzVxa0cpXWFpZLeqrg/Y0c86YDqQHYZjKXeI1Z1t5vkI1Obo3hEVLvl
         OvMxxZCEcxFJqBPfd2QUEuH51Brvh/QMObclgAc3NGw0Wwru4ZEkfAGUc5Q4qv0bJv
         84bSvXrozLjEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 554B6E505B7;
        Sat,  9 Sep 2023 05:05:44 +0000 (UTC)
Subject: Re: [GIT PULL] XArray for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPtdbS6FTadc3LVA@casper.infradead.org>
References: <ZPtdbS6FTadc3LVA@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPtdbS6FTadc3LVA@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/xarray.git tags/xarray-6.6
X-PR-Tracked-Commit-Id: 2a15de80dd0f7e04a823291aa9eb49c5294f56af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3095dd99dd759a5cab8bb81674bc133b1365fb6b
Message-Id: <169423594434.31372.11897994774461493926.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Sep 2023 05:05:44 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 8 Sep 2023 18:44:13 +0100:

> git://git.infradead.org/users/willy/xarray.git tags/xarray-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3095dd99dd759a5cab8bb81674bc133b1365fb6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
