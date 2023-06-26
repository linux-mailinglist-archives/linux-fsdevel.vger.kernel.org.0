Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EB573E681
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjFZReN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjFZReK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FC410C9;
        Mon, 26 Jun 2023 10:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EC7760EDE;
        Mon, 26 Jun 2023 17:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12608C433CD;
        Mon, 26 Jun 2023 17:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687800846;
        bh=NEua5mNpx7k7MP2bTWY/tPk3vWfbwrTaAuFabE20oy0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y3TmT2UpcvuiT/mJvs6sfl8P3rk/QjwoX51YvlhX0uqWXelSzns7F7ir0QIu4cD7H
         lAFs5B33m9L+wA6MuuL7J3ZDiaVrIwDbGbpoRasI8gU5pPOm+Wb8jFGkeRW8Sz9Ibx
         k2kgs+edttlW1abZrN1nD1TaUts7PbYhLKR50/vsUKRiDUzZQjcefOLs6jqN/KjI3d
         roFjEOJqxUVsQuwxVQK8oiGqQDkV3gl3RVNSfosapu0FvbQFkX817gXbUB2cvLaAX5
         wuvbgi0+Xodr8H2Hcmo7LRG7v0+n6aaLPVP7jd2Zajox6zjLKIM5mgQC2JtMIzsK3Z
         zblunD+0luyIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 002C9C41671;
        Mon, 26 Jun 2023 17:34:06 +0000 (UTC)
Subject: Re: [GIT PULL] vfs: file
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230623-waldarbeiten-normung-c160bb98bf10@brauner>
References: <20230623-waldarbeiten-normung-c160bb98bf10@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230623-waldarbeiten-normung-c160bb98bf10@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.file
X-PR-Tracked-Commit-Id: bc2473c90fca55bf95b2ab6af1dacee26a4f92f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f2300a7382119a857cc09e95db6e5d6fd813163
Message-Id: <168780084599.11860.3942226452785126436.pr-tracker-bot@kernel.org>
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

The pull request you sent on Fri, 23 Jun 2023 13:03:18 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f2300a7382119a857cc09e95db6e5d6fd813163

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
