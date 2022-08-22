Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6814D59C728
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 20:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbiHVStg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbiHVSsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:48:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D0E1834B;
        Mon, 22 Aug 2022 11:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEAC7B81729;
        Mon, 22 Aug 2022 18:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98E40C433C1;
        Mon, 22 Aug 2022 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661194080;
        bh=clC5is74/O4awHwHq5LNdqFHJlw7ennCmTCaUiuyZfQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F9hm9s4q20vyZBNlQWW6DFZI23WSpkLegcJNwHoRZBDURXvib7I7ArQ6PDN5xKPvv
         bCI0qzerVRER9TKUx6jsfDNIr42pxnd/QjsUVxiNsFzxixGjGQfGlC2L0wa6zMvJoF
         um+CuKGmSIWlpIXjqGgC0zhEFiy1oVtYNcbXLtKmeu1AvxBduI8vwUGudWpvei/tzG
         u5E0vpz5vHi0bg72raP4cWdtpEtAIcVj8i2dAWL14d0Y1W+954L01/O8BX2iBhxzBC
         +JBMacj1ydjUac8amnlGT2MY/h4tnpyHwUJ1e3cfPiVdwlWIqzZ/Ys3kJ0AI28lq4T
         NNQoZ7vneyZZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A88AC4166E;
        Mon, 22 Aug 2022 18:48:00 +0000 (UTC)
Subject: Re: [GIT PULL] fs idmapped fixes for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220822121125.715295-1-brauner@kernel.org>
References: <20220822121125.715295-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220822121125.715295-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.fixes.v6.0-rc3
X-PR-Tracked-Commit-Id: 0c3bc7899e6dfb52df1c46118a5a670ae619645f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3cd67d671eea1f0d3860996863bd95e1e0b1c76
Message-Id: <166119408048.19448.6440496629621677508.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Aug 2022 18:48:00 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 22 Aug 2022 14:11:25 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.fixes.v6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3cd67d671eea1f0d3860996863bd95e1e0b1c76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
