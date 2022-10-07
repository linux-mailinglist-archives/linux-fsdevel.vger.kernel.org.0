Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5D5F724E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 02:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiJGAgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 20:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiJGAgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0F1B6023;
        Thu,  6 Oct 2022 17:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F6A661B9F;
        Fri,  7 Oct 2022 00:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75CD3C433D7;
        Fri,  7 Oct 2022 00:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665102993;
        bh=tKuW9f08bu/Mh99jDjIE2JWgjAhMazXuBZJ2wUrHBW0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AldwRkpfbKqYZhIi42SR06wmlEo62z3x/SuSxz1TR8fZueQuSywR+zhtl60KwukZZ
         Ixo+mie7igYOMzoMbxYkxWLGwOyo+NFvHZF9VKMvPFTTMOtRD5GxNKaWytuanoWMVJ
         9l4tETfjjHK/4VTtlaPUI5vzrCbLoxlTVADY2Ynf/43Mw+Pxk76FyrdtSjv287pGnc
         hkeZqs7zkOPKjBstMRvmxLVLoVM8/sMpdiDAyQAvrw0FUFFXwlpyaUi0+QeYVknu4q
         h48qheXvu8xNjnn7gOfni/l5NFgINvCXpMvsUdQDkljg4oeTmYWiS5oigqgCK6UhL9
         bo0zpIu+jUW5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64C64E2A05E;
        Fri,  7 Oct 2022 00:36:33 +0000 (UTC)
Subject: Re: [git pull] vfs.git pile 3 (file)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzxlYFiWmx5nK+gT@ZenIV>
References: <YzxlYFiWmx5nK+gT@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzxlYFiWmx5nK+gT@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-file
X-PR-Tracked-Commit-Id: 47091e4ed9af648d6cfa3a5f0809ece371294ecb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a3353c5c441175582cf0d17f855b2ffd83fb9db
Message-Id: <166510299340.12004.13822342246599122525.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 00:36:33 +0000
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

The pull request you sent on Tue, 4 Oct 2022 17:54:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a3353c5c441175582cf0d17f855b2ffd83fb9db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
