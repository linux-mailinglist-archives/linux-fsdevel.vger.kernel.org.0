Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1978B953
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjH1UP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjH1UPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AA4C6;
        Mon, 28 Aug 2023 13:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6D1965144;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54E2FC433D9;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253703;
        bh=HmDQEJV68K5BwwEjRc9JBMpaRF292kNd/ieNhAjMRFs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tMQCUImFeFcvx5aVFT0MpQ3dFJ9PdB3IJrUAJxmy2rxCvoME9gStvuG8go9qJLTQA
         Y2xJ887MZnl/Q/PN9Oq2ROmKCAd68+GAZ2k26gvcaWURBiUP7FmJ9vPphjdxIujfwG
         EWs1PEB7fieqvKuNB7pIZy6C3yJHjs/MxAd4/yG0lvT9LsYcbroZEXCp1LPKG2iRbG
         uVyg36khG9JRWpU9NE/ojy/wqP1ryN3+nsvgYXD4ZlvcznC0KOVNvPavugO1ZJ1Y3Q
         Rze2JxRlfrG0ksNX4w8qT8YvzyI2OdkXV+306z43zw9A8joFnPhb6ExrGtM1CI5tZ8
         COJuWNhRP3ODQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43D96C3274C;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
Subject: Re: [GIT PULL] super updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824-prall-intakt-95dbffdee4a0@brauner>
References: <20230824-prall-intakt-95dbffdee4a0@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824-prall-intakt-95dbffdee4a0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.super
X-PR-Tracked-Commit-Id: cd4284cfd3e11c7a49e4808f76f53284d47d04dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 511fb5bafed197ff76d9adf5448de67f1d0558ae
Message-Id: <169325370327.5740.9523863094227967849.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:15:03 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 16:41:04 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.super

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/511fb5bafed197ff76d9adf5448de67f1d0558ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
