Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9345F724F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 02:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiJGAgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 20:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiJGAgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35653BEFB0;
        Thu,  6 Oct 2022 17:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E127161B9A;
        Fri,  7 Oct 2022 00:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ECC5C433D6;
        Fri,  7 Oct 2022 00:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665102993;
        bh=r/whBGlFGYLar5r6hEiGQ02ScdUAtI19UXatfCuxx8g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G3qqaDyL6rfNrYdJX9j1roPVJDssKzxqxBcvB2AfcbrcCGzmAeJbhCMe5vVt7YJjP
         K+Ir5YkGwLHFfk3dXL/0CvLIpoEyXrxkgjZpJHGukzwqkWZh6o7jvnxDBfiEYGktwU
         Y92F+ddXDlJqps6zC4+xhmVY3jmjhR55+7qIKprtqjCCBtGavo6JmZRhDNOMUq2mJ7
         X/3xDQz0ZBMlDfczRG4I1LX80yYcW8VLbsCt528RLqx4+c7Hlg+HjjfVCM96+gJv67
         wawg3yq9ph0Boaf1mBQYte0z09L164oGSx/cgJMMB5knX70ZEDje+N29lB8ZW+3Qvg
         GngQckU5MOE/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B92EE2A05F;
        Fri,  7 Oct 2022 00:36:33 +0000 (UTC)
Subject: Re: [git pull] vfs.git pile 2 (d_path)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yzxk9FF7G4LpBVCS@ZenIV>
References: <Yzxk9FF7G4LpBVCS@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yzxk9FF7G4LpBVCS@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-d_path
X-PR-Tracked-Commit-Id: c4c8451147da569a79eff5edcd2864e8ee21d7aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70df64d6c6c2f76be47311fa6630d6edbefa711e
Message-Id: <166510299324.12004.3776494710352315205.pr-tracker-bot@kernel.org>
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

The pull request you sent on Tue, 4 Oct 2022 17:53:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-d_path

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70df64d6c6c2f76be47311fa6630d6edbefa711e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
