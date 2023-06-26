Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5334A73E68B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjFZReS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjFZReK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA2C10DF;
        Mon, 26 Jun 2023 10:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E79F60EFB;
        Mon, 26 Jun 2023 17:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5BE6C433C9;
        Mon, 26 Jun 2023 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687800845;
        bh=5FptlfZFrkUzJ3FmjJ6VJraOM/UE2rGml3TWVvzy+Rc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TyQ5SWkndLTV33omnLYYsu9BQGrfPR6q07FBU7ot+bA4d2ePlApDhAjS9e9rU62nX
         xjIYy9gYdpvPovryRBRSTQ7Mdm+OGCiGTPvX1YAzL9OSNDxsGN/qZcBV731Vbkyd9p
         SPWbDq6KPCr/fXmUThd7+9+7Q7ZG0vNwzrAiBmihngknnExmjvHpJ9OdsdOi4deYhO
         nSNmkyf364oEhUWnWHlgFMEM8rS3a/GsugTK789mU9UWmEly+Y+6uYcSaYKt2o+WFm
         WtI/zVc4pxD2hqrvS1Xo/twFZ+DxTxeEwg6onPzS10VKsbkkHEWKlUTo3W7Vqf6z5s
         ByeQd9ch+WYZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0E43C43170;
        Mon, 26 Jun 2023 17:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] vfs: misc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230623-motor-quirlig-c6afec03aeb4@brauner>
References: <20230623-motor-quirlig-c6afec03aeb4@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230623-motor-quirlig-c6afec03aeb4@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.misc
X-PR-Tracked-Commit-Id: 2507135e4ff231a368eae38000a501da0b96c662
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64bf6ae93e08787f4a6db8dddf671fd3a9c43916
Message-Id: <168780084571.11860.8541733366526306018.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 17:34:05 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 23 Jun 2023 13:01:48 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64bf6ae93e08787f4a6db8dddf671fd3a9c43916

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
