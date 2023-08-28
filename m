Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F678B95B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjH1UPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjH1UPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79939EE;
        Mon, 28 Aug 2023 13:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1032C65150;
        Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78742C43391;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253703;
        bh=PV6ROfRvuLhYHSYKGTeljdU1IpPcbd/reA2i5riFLZw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZcRhch+20HLhL2qlWiKv5uWUXijkKXHi4v2taTCsfN2Iy1cebIw3nb2Le6jrEZs1R
         iZP8bZS52Gq5z6lYiz0vhBN626OXaqhjDHxCMm961xv0U6sAbG+vYpb1sUkpI3jkAn
         Z1itSdGW3A0izFYQGLz9xrzBSDr0Ilydypu9X5ug72DiF8BvSLkN9etYagiK/mULem
         gviAGoa0+j27rypXrjlendFrH+DTfuieEXQGewCg4NFzREGAJLgyMR/bp0h2RLqPBc
         ZXr+PPZ5K51dPjYxWH2hdXljTrJp17Ra1+QCpMYUmXCVVfOhOlMC26vDUrDAGOMoiv
         DT6oc7qCEh9Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67384E21EDF;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
Subject: Re: [GIT PULL] fchmodat2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824-frohlocken-vorabend-725f6fdaad50@brauner>
References: <20230824-frohlocken-vorabend-725f6fdaad50@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824-frohlocken-vorabend-725f6fdaad50@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.fchmodat2
X-PR-Tracked-Commit-Id: 71214379532794b5a05ea760524cdfb1c4ddbfcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 475d4df82719225510625b4263baa1105665f4b3
Message-Id: <169325370341.5740.17162895264793775047.pr-tracker-bot@kernel.org>
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

The pull request you sent on Thu, 24 Aug 2023 16:44:15 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.fchmodat2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/475d4df82719225510625b4263baa1105665f4b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
