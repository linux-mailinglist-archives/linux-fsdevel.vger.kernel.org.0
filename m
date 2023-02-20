Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B569D597
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 22:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjBTVMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 16:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjBTVMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:12:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C699A1D904;
        Mon, 20 Feb 2023 13:12:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC8160F2F;
        Mon, 20 Feb 2023 21:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9B9FC4339C;
        Mon, 20 Feb 2023 21:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676927502;
        bh=oB6qB+JT3J5TQqi0FNch335QjTT3i7Zn5WpYlg3Yf6E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=anRalbWUo1j9wtS0/JpN7o64WicfLpl/Kk1dkNFpe2RhLO1DQ5zzBTll1ureP7qiR
         ldhSJtbq33f+VWjgHK5UWHFPtgQrBrrz39K62SxKzUPXy8xkwkTgNIWpFDlXvj1JFD
         JPaHXgjx5GNesoRJNngDzUctXzjeDiDbD1OTcM27BuYWlVXUGxDXyD9L3xxn7pGhLs
         7cRQgvyYof6wC/KChq/IW0dFoBobOtoEWtk1uiWCWbeQp/7KEiJlh5EAeRjJfFLLD7
         Lwd2Xs40ZRs71V+zS2vPaCnFEXg8Pc5smyK4d/5+YZyLA5oj/e3EBB1dCY86sU3/TZ
         b/BTRs5AETdag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FF0FC43161;
        Mon, 20 Feb 2023 21:11:42 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/KIgw8gAI/gtN8E@sol.localdomain>
References: <Y/KIgw8gAI/gtN8E@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/KIgw8gAI/gtN8E@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 097d7c1fcb8d4b52c62a36f94b8f18bc21a24934
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f18f9845f2f10d3d1fc63e4ad16ee52d2d9292fa
Message-Id: <167692750258.16986.9650885696006716532.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 21:11:42 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 19 Feb 2023 12:37:23 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f18f9845f2f10d3d1fc63e4ad16ee52d2d9292fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
