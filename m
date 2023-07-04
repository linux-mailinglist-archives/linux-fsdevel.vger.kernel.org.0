Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B6D747880
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 20:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjGDS7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 14:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGDS7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B7510D5;
        Tue,  4 Jul 2023 11:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1D0461329;
        Tue,  4 Jul 2023 18:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C6E6C433C7;
        Tue,  4 Jul 2023 18:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688497154;
        bh=ddJHSNpCVBIXqy/KSUFOMWmBQV0kz7X2+arcZ5lGDTM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FWgkm/wJcUMg/hgCXeBumJ5NmiYhhm5h3V9QYZQQvZsnoG1pyyEbXQjVZWsIYz6oE
         HLgwat1k67eAJxtwpQ1eVkHSs1G3e4TAXvogS4a5/0nOk0OZop+FdtxUFU6WX1dcVn
         qTWKv/d7zACIvoOWIjJChQ8orNxuoINKHfCzITz735KceNFDbNUWIM7Ewd2EA1KoCd
         bdBNFjSDnVGEnusUhmrCbXM927XcRJKBpFYrT7AxO7H7+hmYHOtaagACpS0/wTCpjc
         122+yWNdXCYJw86yLFgc4ojl2X6wpZNqt4kcF6Oxyn5DS8Nljf6aeTikHcFigl3Nbh
         KlZZ9UMidmFRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AD6EE5381B;
        Tue,  4 Jul 2023 18:59:14 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs update for 6.5 - part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230704165304.658275-1-amir73il@gmail.com>
References: <20230704165304.658275-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230704165304.658275-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.5-2
X-PR-Tracked-Commit-Id: 7fb7998b599a2e1f3744fbd34a3e7145da841ed1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 538140ca602b1c5f3870bef051c93b491045f70a
Message-Id: <168849715410.3035.5924590022911870576.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Jul 2023 18:59:14 +0000
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue,  4 Jul 2023 19:53:04 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/538140ca602b1c5f3870bef051c93b491045f70a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
