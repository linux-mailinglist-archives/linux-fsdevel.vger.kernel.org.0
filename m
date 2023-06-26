Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B8973E68C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjFZReO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjFZReK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D950B10CC;
        Mon, 26 Jun 2023 10:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B1F660F1D;
        Mon, 26 Jun 2023 17:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF4CAC433CA;
        Mon, 26 Jun 2023 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687800845;
        bh=8cGR2dKgJfVPBmTODCJb8hcFIeNPG8085iREoBKgibw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VSOczCw9g90UmdCmkYdwaKOcjuZiqplEPUi/G5YuklMx+uuoWrP2rRB8K7xsALr22
         bnyM2SGMG3bthydBNafOhqixLtxGQdd+fKi/FpqnRtUqPJ/D99eufc52PQYBSCVlLI
         8ST8Y1DO5oq/sqcHWvB63h27s2lbBlvOZ5Vp7NzCtRXm4ZYvCxeXaZdJlkw/jwNiSE
         64b9ueOmtV+W8tMkZMdw6A2noZLmNrsBq6oiI90vOlHo/6cXtfaoPoJs5ljceR3lzg
         s6aWW+xZxoCsYUz65FaCdUTEm9RNrwQvdbcl6rvmpCgOxXvOLtU37nXmQqSQDwuxr5
         sn4QYivjLAS3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC111C4167B;
        Mon, 26 Jun 2023 17:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] vfs: rename
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230623-gebacken-abenteuer-00d6913052b6@brauner>
References: <20230623-gebacken-abenteuer-00d6913052b6@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230623-gebacken-abenteuer-00d6913052b6@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.rename.locking
X-PR-Tracked-Commit-Id: 2454ad83b90afbc6ed2c22ec1310b624c40bf0d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2eedfa9e27ed7b22d9c06d8d072ad2dbce4fd635
Message-Id: <168780084583.11860.8596550696974033219.pr-tracker-bot@kernel.org>
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

The pull request you sent on Fri, 23 Jun 2023 13:02:37 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.rename.locking

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2eedfa9e27ed7b22d9c06d8d072ad2dbce4fd635

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
