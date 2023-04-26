Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB136EF8F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbjDZRGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjDZRGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC1976B7;
        Wed, 26 Apr 2023 10:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA91962AC2;
        Wed, 26 Apr 2023 17:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27B71C433D2;
        Wed, 26 Apr 2023 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682528791;
        bh=W6nCekIj691sbm0f2i0XugD/TfNMf1T/rUD3ZLRQXN0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ABup75OSNU3/VFYHFGgZgQ3e8hA9PLyzoZ9brf5FJp7UhAk0M1Hw/vwWBJc98v+2Q
         Zaar29rvQN0KY/3u6TDnpiH2P5Xh8QR2FyeodryyrpsXq8VSWIK5e4FODIZHYzGqYq
         8iXxZ79Pon2dWN1DU9C/Ect0MjPiEvNFQxpWFQEVfu9zw7iRafOG2B+PN3gCGvMq3l
         YTuUkf1KKAcf/QLdxxIN4ReuvzF7oAl9WkpLaJ/bcdtWe9BU5DHbEoXyZ7xS/trguH
         +iorfylDKdB962FTTcfol7nWq2/6gEfoG+1xZXdQn7uQTmMLW0OmOB5Ju+g2qmAfB+
         uic2DedW+4ywQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17602C43158;
        Wed, 26 Apr 2023 17:06:31 +0000 (UTC)
Subject: Re: [GIT PULL] ext2, reiserfs, udf, and quota cleanups and fixes for
 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230425103501.ib4qoy4j5a3mzf2c@quack3>
References: <20230425103501.ib4qoy4j5a3mzf2c@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230425103501.ib4qoy4j5a3mzf2c@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.4-rc1
X-PR-Tracked-Commit-Id: 36d532d713db5797b844fb8bd61a068d3cd4ee3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94fc0792661a96d64a4bb79cf10d0793ecadf76e
Message-Id: <168252879109.19907.15488614970114917288.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 17:06:31 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 12:35:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94fc0792661a96d64a4bb79cf10d0793ecadf76e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
