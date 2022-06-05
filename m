Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEFE53D92C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 04:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245100AbiFECOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jun 2022 22:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245130AbiFECOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jun 2022 22:14:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FF9186D4;
        Sat,  4 Jun 2022 19:14:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B969E608CD;
        Sun,  5 Jun 2022 02:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B608C385B8;
        Sun,  5 Jun 2022 02:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654395240;
        bh=VTQvgFTC9onIF9Dx9KdSs1RsSxED3o22xv1olBJvVho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lu/1ht0atZWJRzXRjrQB9ueyKfR/cuff6fdbIJjIqLXPAjUaLszey8sRnYztuDvH3
         LpazdlJ7/j9zqycYc5bee9BKV120EOXta5gdUAVhZalbqLIEBQM5EoYOtlm4m9p31U
         8MlJM4VknpYMZAstvD/x8xj43V6R4ARAp/AS9M92XW/w57n3xObfGVI5fGfJrwHpkm
         59yTvATM/emVEMwXZtpXmDkJ+PLZAsPX7fIduDMv4LbhWLN3/+Qr5rz6CT4uPcceAs
         rOvdBbk9bBnmjsihFnW78c23DNSS+0GXTWMGdcvXUx9D2jEpxBCLX3oyLrFTHJcex6
         5I7Ii2aK6xSfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19876F03875;
        Sun,  5 Jun 2022 02:14:00 +0000 (UTC)
Subject: Re: [git pull] descriptor handling stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpwFEwDJXAvbGuyn@zeniv-ca.linux.org.uk>
References: <YpwFEwDJXAvbGuyn@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpwFEwDJXAvbGuyn@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-18-rc1-work.fd
X-PR-Tracked-Commit-Id: 6319194ec57b0452dcda4589d24c4e7db299c5bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbe0ee46614016146c1b3e1fc063b44333bb2401
Message-Id: <165439524010.29822.14128367156906658475.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 02:14:00 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 5 Jun 2022 01:21:23 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-18-rc1-work.fd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbe0ee46614016146c1b3e1fc063b44333bb2401

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
