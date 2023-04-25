Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C076EDA55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 04:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjDYCt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 22:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjDYCtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE67FAD0F;
        Mon, 24 Apr 2023 19:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 058CA62B28;
        Tue, 25 Apr 2023 02:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BBD4C4339E;
        Tue, 25 Apr 2023 02:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682390974;
        bh=XFF09VOUcghWnatr/UrUjkY5Qj3j0aeYwA4FnXjUiu0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WnOhpLipiSFSSoOFnHD5NcZiakFzWZjtVuC5sLso/+Wl6vMjG85rWzl5Z7SLMyZx7
         Ce3UUXtzopWqWKOoi0exS+ZlNTxjpYgsSkaM/jFcGMbsM0JCfZd4G6YnkbhHdGPGJw
         VykEh7sOPdTXQfODHMTQQLlh0UsffhWmwZaPkox4F5O7yVR4wdjJ3f9JweGzh+Gm2p
         OM6SV6V4B1IdandBeESbZc+NOhnpCB95cY5fLrt9mhLahvc8giemrgiEml5hRs8Sh8
         fBF+m+FlehvRAEQ0MXjTXgonCpWNNiJwWdXTZfZ+tCaXOrnomLvKueZ/CdljDDlao7
         kU4KvSp3V80qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 587ADE5FFC9;
        Tue, 25 Apr 2023 02:49:34 +0000 (UTC)
Subject: Re: [git pull] vfs.git misc pile
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424042949.GM3390869@ZenIV>
References: <20230424042949.GM3390869@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424042949.GM3390869@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc
X-PR-Tracked-Commit-Id: 73bb5a9017b93093854c18eb7ca99c7061b16367
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 181b69dd6e61235b04742b473c23b00b731f62c3
Message-Id: <168239097435.20647.1234511854168180314.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 02:49:34 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 05:29:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/181b69dd6e61235b04742b473c23b00b731f62c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
