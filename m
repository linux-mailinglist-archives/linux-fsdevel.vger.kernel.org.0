Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0EF6EDA52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 04:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjDYCt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 22:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjDYCtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38119AD29;
        Mon, 24 Apr 2023 19:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8897A62B1E;
        Tue, 25 Apr 2023 02:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0F18C433D2;
        Tue, 25 Apr 2023 02:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682390974;
        bh=H/uWcApKKZYYuPOOpu+WtCRJ1YXHmKu1FAzmVYrKiRA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s//n8omv/czAyfJwKoyUPsynFNzeLY9rF1xZlE5BQ9FhwJVYn/r00sBFGPRv4Uu8g
         VK5jtB7DmJ2MDqI5Ztr0spNROAyetYqHfWqAxdix/9GwuPf3V2nRqJ1Zkb0b9VI/DL
         Kkk60BKu0VMpuUXUng1ga+mHuAngTt4g1ErKmv6QkBHffEyg8lFcEal24x+23xOEuN
         f0Z6gWKtXpz59RMo1Bq2RCc1ZB8dW8Leal4d+V/Cw+bEZxPtuUJB+tGPMJv4U+IhUk
         RFcqaPLxptaxwwKw/Z9Au21EZ4PuEmFFlJzMrS4+BgkezZWV8pBdVr1j/2zBR+ilkV
         EjjOyjYQg4kUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D96A7E5FFC7;
        Tue, 25 Apr 2023 02:49:33 +0000 (UTC)
Subject: Re: [git pull] fget() whack-a-mole
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424042529.GI3390869@ZenIV>
References: <20230424042529.GI3390869@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424042529.GI3390869@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fd
X-PR-Tracked-Commit-Id: 4a892c0fe4bb0546d68a89fa595bd22cb4be2576
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef36b9afc2edb0764cb3df7a1cb5e86406267b40
Message-Id: <168239097388.20647.15625260196226288988.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 02:49:33 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 05:25:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef36b9afc2edb0764cb3df7a1cb5e86406267b40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
