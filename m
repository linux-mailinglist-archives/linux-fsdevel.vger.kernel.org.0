Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF379D5F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 18:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbjILQOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 12:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbjILQOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:14:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829BA10DE;
        Tue, 12 Sep 2023 09:14:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12EB3C433C7;
        Tue, 12 Sep 2023 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694535248;
        bh=q+8WGvxapL5JoVV7wpEEc1vkOLLgKIqDszqp5vNEALU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=te91HFp5V8f6jz2JjcU8xqhbqV79x5hRDH/deaJB2mqw9HKauXKPy0AbxRTK21MMD
         Pm44yBnyx78O7mEBxNCa5FG31MSefC2o4/MzgXsnZ+Jbnw4vIb5G9i5w6yJ513OQbt
         ckWhps39zjqVolmXEnMey5WKDvMVuKuGA3Ja6Q5i2w4dxSdqboTijkGwulyvZ9QDUU
         yhaQInAeyYd0+SBxZCiPZ/zmc0JZsKynymQkEkbrsn/wVJx7fL3F57K/BmK83fE323
         yHUXRrR7Hm8VyoTatV19SXewU7o0QwufO1F7XFPfmNuztwanYuKQ7S/l+aLoTTQW/g
         43jdkd4Wmb4qQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F40D1E1C280;
        Tue, 12 Sep 2023 16:14:07 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230911080601.3145430-1-amir73il@gmail.com>
References: <20230911080601.3145430-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230911080601.3145430-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-fixes-6.6-rc2
X-PR-Tracked-Commit-Id: 724768a39374d35b70eaeae8dd87048a2ec7ae8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afe03f088fc177e8461270a959823fc2e2b046e5
Message-Id: <169453524798.14950.8327984008146482308.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Sep 2023 16:14:07 +0000
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 11 Sep 2023 11:06:01 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-fixes-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afe03f088fc177e8461270a959823fc2e2b046e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
