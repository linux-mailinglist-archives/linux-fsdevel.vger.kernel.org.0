Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D24273E684
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjFZReR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFZReK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7327D10CF;
        Mon, 26 Jun 2023 10:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEE2260F15;
        Mon, 26 Jun 2023 17:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 428B7C433D9;
        Mon, 26 Jun 2023 17:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687800846;
        bh=/2MxZe6dC6SlpLGJdo+87drVYWAHEzBLGvJW4WyNKQQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AcE4vPFku7lprq6aHPQouSqp3D2PQpm6hFiKxbxR1jU5tqKFAlOkSTim+Bc/YsIG4
         QWox1omVVmOzFGLHC2BXAJDCP4EpVH80sQY9Xo+4IGAKqTkZ27I+zoN9ZTSzZlLgdJ
         gtctILHWLOz73CDFz++Ee2zCIyJye6dCFD9DjK2c8fpapQYgwMfiYAjrWJjtTQzyi2
         pZof5pf3WM9poU32FzTu/Jf2Nn9HPydVb69E/c6srlSsZvnO+DOLZXmKDlnZ9X0CNd
         cfp2onCc8+VOnVk3FMNfisf3cx+tKxxDSVVH3r6mlpVfAIa8azCQ86g7kxmBfaZTXc
         7bd7TiScPZLYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29E5AC43170;
        Mon, 26 Jun 2023 17:34:06 +0000 (UTC)
Subject: Re: [GIT PULL] vfs: mount
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230623-leise-anlassen-5499500f0ce0@brauner>
References: <20230623-leise-anlassen-5499500f0ce0@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230623-leise-anlassen-5499500f0ce0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.mount
X-PR-Tracked-Commit-Id: 6ac392815628f317fcfdca1a39df00b9cc4ebc8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0a572d9d32fe1e95672f24e860776dba0750a38
Message-Id: <168780084614.11860.1594987760067073275.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 17:34:06 +0000
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

The pull request you sent on Fri, 23 Jun 2023 13:03:58 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0a572d9d32fe1e95672f24e860776dba0750a38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
