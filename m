Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1671138E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 20:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbjEYSSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 14:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbjEYSSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 14:18:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B37125;
        Thu, 25 May 2023 11:18:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A6C6486C;
        Thu, 25 May 2023 18:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18597C4339B;
        Thu, 25 May 2023 18:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685038731;
        bh=WUQ/fjt0OSae3yEDGeblWmc9cbDnF+Z8DPeWnrwe+Cw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eEaTbXgh+MP6EF/lc/6Z1cYy7cobzieRvrljLcwaP2j78e8X7EdQHQsqilWwLQZM/
         Vg0zod4CAWTAQNalo1kjZD9iEqpgX/s+SWR7cYBPKrxobIErG3taVXXmEzNvo79iht
         pBaAPlWI1IC0fFf+tw980DBUpN7AZY14XT6RnIDs30P1vMZPpd+YAGtclyW2sB2jY6
         ySWTFv9r4yF/y4z5Oq6t03KZKdQk7EubsodYJpOSoQh78hnTmbXoOKX8E/EwneCxmv
         xhbZQVEJVTt3An0C8ZPgGxgI4GKb/olz4qARqaUs/8JDaYFvnIjBvc7qIaj/vq0SU+
         +Zw69RPqHxpBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF569C4166F;
        Thu, 25 May 2023 18:18:50 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230525-dickicht-abwirft-04c67a09af05@brauner>
References: <20230525-dickicht-abwirft-04c67a09af05@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230525-dickicht-abwirft-04c67a09af05@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs/v6.4-rc3/misc.fixes
X-PR-Tracked-Commit-Id: 48524463f807ec516a291bdf717dcf2c8e059f51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9db898594c541444e19b2d20fb8a06262cf8fcd9
Message-Id: <168503873097.4421.10583835952565074759.pr-tracker-bot@kernel.org>
Date:   Thu, 25 May 2023 18:18:50 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 25 May 2023 14:22:35 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs/v6.4-rc3/misc.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9db898594c541444e19b2d20fb8a06262cf8fcd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
