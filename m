Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0CB78CD14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 21:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjH2Thc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 15:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbjH2ThB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28368CC;
        Tue, 29 Aug 2023 12:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1713614F5;
        Tue, 29 Aug 2023 19:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 250D0C433C8;
        Tue, 29 Aug 2023 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693337817;
        bh=qcPDnnfdRHFJiTP0ZoCj2675Ni1hPuJtafJ/9/9imFM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kl5ks7oUchOdIl5RLqQua7o7MddLKP9iPaMET0/3AvlMWuNAip68LxoNr+Cj2leno
         3D5+rIqfbNs/SfKAfuMwXo0PUyOARgvRsvCMwsqIKTzBDG3pXXX+tRuwluMco0Mrp8
         Q4/6thWvyzWVFUMN41IBeTkKBC5Q3Qy8nmGMyqOENbfVIZxQ9LUv+TQV+BCfGeu4RC
         3IGIEDXOcMu+BmfWP5Ze5I3oq/b3E07DHFj9xhyGY11E9yBzFh6BZjP86bov7lCtiL
         KTGgr67BErLMg3VHLXmCOEITNlEb7dlBt/kRl9REcxk564513rECvMxB8lTTBZR1k3
         CWFzTW6ISdwfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C148C595D2;
        Tue, 29 Aug 2023 19:36:57 +0000 (UTC)
Subject: Re: [GIT PULL for v6.6] super fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230829-kasten-bedeuten-b49c0dc7dbe0@brauner>
References: <20230829-kasten-bedeuten-b49c0dc7dbe0@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230829-kasten-bedeuten-b49c0dc7dbe0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.super.fixes
X-PR-Tracked-Commit-Id: dc3216b1416056b04712e53431f6e9aefdc83177
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 468e28d4ac72869ed6c7cd7c7632008597949bd3
Message-Id: <169333781703.25364.9167863861019683699.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 19:36:57 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 12:51:21 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.super.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/468e28d4ac72869ed6c7cd7c7632008597949bd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
