Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6600E7BA940
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjJESjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 14:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjJESjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:39:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7498;
        Thu,  5 Oct 2023 11:39:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0425AC433C9;
        Thu,  5 Oct 2023 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696531171;
        bh=J2bXN79D7iqgc12+Es5HwJFDx+AIUxCFgfuha2QiC9k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QYOiBoK2Yf3dRJGBbXLUUPD7HybrRFoTnXWuoas4AgYHl9w8MrrFeurUe13KpsPJr
         2vwF8MvhkxCQhgPLA0xTfCcoe7stjxVL103f1P2xCar8wtEk/HzwwtG9beNWSqy/d7
         VJEE5mga/5I/kMbgLcbVWSa3OnHBkXEscY/sK68eTW9QGbZdMLGEMs3Dp80+vhLhYx
         aiMVVgXG+a+2heioOfAVVKVVHxk4GM1LseO9oPPcd9yhPOpeY06BJx78P7wxv81iur
         p66bf3sr6TrmAqbvAjP2DVUTIJanaeFcrnJy2kOXEURcbzy41YEjpiL0Fk8LxofAIO
         YV4WTxkx9uZ4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E41ECE632D1;
        Thu,  5 Oct 2023 18:39:30 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231005131717.1311531-1-amir73il@gmail.com>
References: <20231005131717.1311531-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-unionfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231005131717.1311531-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.6-rc5
X-PR-Tracked-Commit-Id: c7242a45cb8cad5b6cd840fd4661315b45b1e841
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 403688e0ca2ed614c1c2524cb874e69d93e29edd
Message-Id: <169653117093.4044.3442582847349203540.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Oct 2023 18:39:30 +0000
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu,  5 Oct 2023 16:17:17 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/403688e0ca2ed614c1c2524cb874e69d93e29edd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
