Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01B478B96C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjH1UP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbjH1UPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD716D9;
        Mon, 28 Aug 2023 13:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A7A0640AF;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D27E3C433C7;
        Mon, 28 Aug 2023 20:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253702;
        bh=e+KDDjyco721oFp77XytuEjt2pxw4cgUoEMbQsVrFRI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cmF22fud+qj7Vd34DcNpI6AfiN36HLT3gw8CRN8nywM2BHZKijHycWljOdRCgieWq
         QndTr/R5bow8hubOLayS0P/m/RUDBTgzhCaN1r786ejL1DJXZSuSy8c5bgKruaAW2M
         Tti5uQ7f0gizhS/edVcDrXkP8UWGFg2Iiie1EeI7Pi/VsopER9Hd6ITNqzK8nRjU1b
         AQ4U0uaGIE/S1WP7ZzFgquD17Ip8oYAtUf7ZMfO3w6+qSkKJdQhOjip93lKqEnXEou
         aMtJJ79a37EEhs+98iuslHLEsNfvE0hSdmpIrfsiMWRjVCyUFWSxPdgJUyqtPE3BpL
         B6bitJuO8YGMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C021FC3959E;
        Mon, 28 Aug 2023 20:15:02 +0000 (UTC)
Subject: Re: [GIT PULL] multi-grained timestamps
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824-sowie-april-a3f262c64848@brauner>
References: <20230824-sowie-april-a3f262c64848@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824-sowie-april-a3f262c64848@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.ctime
X-PR-Tracked-Commit-Id: 50e9ceef1d4f644ee0049e82e360058a64ec284c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 615e95831ec3d428cc554ac12e9439e2d66038d3
Message-Id: <169325370278.5740.8365678885497265658.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:15:02 +0000
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

The pull request you sent on Thu, 24 Aug 2023 16:19:41 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.ctime

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/615e95831ec3d428cc554ac12e9439e2d66038d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
