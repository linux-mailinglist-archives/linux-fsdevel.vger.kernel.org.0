Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972F8534923
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 04:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiEZC7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 22:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiEZC7h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 22:59:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87484BDA1B
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 19:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EF61B81EC6
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 02:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B2E7C385B8;
        Thu, 26 May 2022 02:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653533974;
        bh=0RmtIbazL5kbySvZBdsAMp4QgfkNqGwXyIXfo0JsRz0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EdpIE5Y8KLk4Z1cwm85MkFhwE9vheq2jIwqlbklwrNMM/FshB46LknXn/3mrrStD3
         ZH4p5856OYwfKwgMUuNRSL8O6UUjbUKKeQZPfmYayzOYYlQeisVhF/5jCIVptOAiYc
         KTqSMAIjRB3TVkiFNlxb0YnaxIwDIZ8Kis+Ec6um6iXtydln18d7bo4o//YyaE026U
         vdhIDCopcHiVsLRGIwCcK30Hg23hpUlHVz6sNFPKPz9rzIqNmYICHKXQ7XisjJ+4+T
         YPVsFQgy1thvDiTUWlxtm9/bDgIKp5BmZPjuMIBNO7ZatX+EzThOgOeK7lZzzKY+CS
         aPqA3Ukw0wdug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE9BBE8DBDA;
        Thu, 26 May 2022 02:59:33 +0000 (UTC)
Subject: Re: [GIT PULL] Writeback and ext2 cleanups for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220525122452.gqkl2bmlvjym62ib@quack3.lan>
References: <20220525122452.gqkl2bmlvjym62ib@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220525122452.gqkl2bmlvjym62ib@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.19-rc1
X-PR-Tracked-Commit-Id: 2999e1e387271b3216c44168b0c5cc69f647f155
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b728edc5be161799434cc17e1279db2f8eabe29
Message-Id: <165353397397.29187.11707575586011949257.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 02:59:33 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 25 May 2022 14:24:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b728edc5be161799434cc17e1279db2f8eabe29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
