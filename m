Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9272742F07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 22:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjF2Uwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjF2Uvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AE32D4A;
        Thu, 29 Jun 2023 13:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0472E61627;
        Thu, 29 Jun 2023 20:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F9E4C433C0;
        Thu, 29 Jun 2023 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688071897;
        bh=x+GKEsRMJslSqI8daiJR2oohFs0jyp6CpXtfrCFonDA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jT/NDQGWDeZa4SYZvQowiqhPBC3g9pOmUtBvdZc8Sn8DhIoaK0pXPDUoaHgbSv1fX
         eNqEU5Dm3rTrMjVDNMcOfyX9o90A8CJ9/ln4+quR4zCwocJ79uRqBJGpFE119NgE8c
         6SIWlerW5HvZxnM2iFECSX3T6/03uaoQscUJjfm+iKQbagjdREjEeIcjSdZo0eP/bC
         qOdA3sEVj6owLgseNr35dKD2E2eiM/2JfQIkzhWAerY6U9+Pgr8pYrANCbevOnYqXt
         Ry0BEVEkz4hg8qBgnclVYn5LhCiWe0kW8x2Aam4g+1orOnF2CS/2UZ0fENl/p6tnI4
         OPAcOsTkmsFdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B33DC40C5E;
        Thu, 29 Jun 2023 20:51:37 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs update for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626191849.3451873-1-amir73il@gmail.com>
References: <20230626191849.3451873-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626191849.3451873-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-update-6.5
X-PR-Tracked-Commit-Id: 62149a745eee03194f025021640c80b84353089b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be3c213150dc4370ef211a78d78457ff166eba4e
Message-Id: <168807189729.21634.5447622001041358411.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 20:51:37 +0000
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

The pull request you sent on Mon, 26 Jun 2023 22:18:49 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-update-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be3c213150dc4370ef211a78d78457ff166eba4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
