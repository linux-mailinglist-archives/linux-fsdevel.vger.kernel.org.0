Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6FD4C017D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiBVSin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 13:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiBVSim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:38:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E10213D3F
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 10:38:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDDC96154D
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 18:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C9AEC340E8;
        Tue, 22 Feb 2022 18:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645555095;
        bh=gB54WjblF3I3+ayy9rZukjqlIGJ8A4FxTXADy8KPRRE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KIvV3PlcQziiBvW53Svg15LeiwlIVtUiKnNLa/6yusKM9pfjK33ZfPYC9B8J9U7fE
         uWwwX0aQA5j4kdhgPuNpDooRhsy3j/3cT9++snEZjO4oGciLaY6AGupp/mW97CagV5
         FgkKchL4Zq7HKrRyFfcFlU5kr7us7qt4Es8qhNRFIZ6H0n3GT/UBSUJbZHUMY2N2xx
         8q8oe7VCoJJuZK3ObeNIFyLyMp6E2nNufNUg6YzlXc0g1Lq9xG7vXmdVYTi/8YLFu6
         sHkOUUhuc2psiKQvEkOTTG1uRbRLMvbxKaWucThB7E+RsUkOm0x+l6GZgbqMjRQmP/
         QrTk6Hj1RoYYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23B16E6D458;
        Tue, 22 Feb 2022 18:38:15 +0000 (UTC)
Subject: Re: [git pull] ITER_PIPE fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhUiFV3fHA4gO/is@zeniv-ca.linux.org.uk>
References: <YhUiFV3fHA4gO/is@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhUiFV3fHA4gO/is@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 9d2231c5d74e13b2a0546fee6737ee4446017903
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 917bbdb107f8767cb78f24e7d6725a2f93b9effe
Message-Id: <164555509513.7521.6778950467094977870.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Feb 2022 18:38:15 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 22 Feb 2022 17:49:09 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/917bbdb107f8767cb78f24e7d6725a2f93b9effe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
