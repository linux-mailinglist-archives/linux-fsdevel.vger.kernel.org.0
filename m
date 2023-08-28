Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639CB78B962
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjH1UPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbjH1UPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFE1D9;
        Mon, 28 Aug 2023 13:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81F9C6514D;
        Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAA72C43397;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253704;
        bh=BYH6FzXsDOFZXi22Pfh85NlGUobo+LnscFtTzWnqRBA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hN+RZT/mjHApwq1rpoywb1yXitZU9113kz7G7cvwjhLM8PXNbS6Pc09pgdxYozCli
         aO2tQrfHvqfHiE6xL2RIfWGEzXHpLdtZz6ayKA0n/pLZKJ520vAnQJYPVqJA5vuDdp
         uhBPOS9F5PtU6074AB3nd7cApXHFxlBAcaFP6+f0H61HenUOlbC66jiyiztyxQIlu+
         j7+A2GVoGeJ83nkTZXt1JK4oukJup1gRbuVlRurXNCULAQY9ZLjpf+H0Dibxza6MgE
         ppxZieIFikMf6wqgeKfN5KUHv2HaF+BdbUZoub4ZVnPixQGVdepaiZkZ+MPpPSReXm
         lBvFtJvvY4A4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D826FE21EDF;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
Subject: Re: [GIT PULL] procfs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824-inventar-wissen-d7801fbc9bf9@brauner>
References: <20230824-inventar-wissen-d7801fbc9bf9@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824-inventar-wissen-d7801fbc9bf9@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-fs.proc.uapi
X-PR-Tracked-Commit-Id: ccf61486fe1e1a48e18c638d1813cda77b3c0737
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4a04f92a4fd029f4a4cd7a47583f3f1bb562cd4
Message-Id: <169325370388.5740.15966744895656786216.pr-tracker-bot@kernel.org>
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

The pull request you sent on Thu, 24 Aug 2023 16:48:31 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-fs.proc.uapi

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4a04f92a4fd029f4a4cd7a47583f3f1bb562cd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
