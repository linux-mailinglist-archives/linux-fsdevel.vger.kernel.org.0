Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6145926B5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Aug 2022 23:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiHNVvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Aug 2022 17:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHNVvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:51:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64972120A6;
        Sun, 14 Aug 2022 14:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 166E9B80BA3;
        Sun, 14 Aug 2022 21:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1855C433D6;
        Sun, 14 Aug 2022 21:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660513907;
        bh=wBrqcOv2/wyT6IsGtSBX2iuPGkcAX6m8mubdinrFZ5M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=thr2iE/dpEPobaPaHHvAIjjE6eSkM+O6QuIPYeVIp7Hh98duJga9Db5Dh+KHuK7qj
         sfijBUSkrGhndsBMeU1wqCx3VmvUVpKi34TrSAJ3ttMcB6cHeWGSrtVzAJU1JAkTTh
         Js5NQu5DptHxJGZ4J9CdiYkFjkg+Q8cVageRkFAb1WNd6xx3DPCW+J0S0tmCC7Ye7B
         fiqulCZfoQPnwtWK8B5MD6egTu65nXYzIGgQ24G6YkFQuwfh/aUOKcpybt4BpNl2IZ
         2SAOF/ZnUEsvHfjhyECvXByEMg5c7Y+cakccd4FhPy6daV5vN7rWbrlFBA63fvR0BH
         VAfoREvf9q9LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F04FC43141;
        Sun, 14 Aug 2022 21:51:47 +0000 (UTC)
Subject: Re: [git pull] regression fix in lseek series
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvlLh8qZnCTmACaf@ZenIV>
References: <YvlLh8qZnCTmACaf@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvlLh8qZnCTmACaf@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 3f61631d47f115b83c935d0039f95cb68b0c8ab7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74cbb480d0efa61efa09e5ebd081a32e1d355bba
Message-Id: <166051390764.2989.2908450609311058474.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Aug 2022 21:51:47 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 14 Aug 2022 20:22:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74cbb480d0efa61efa09e5ebd081a32e1d355bba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
