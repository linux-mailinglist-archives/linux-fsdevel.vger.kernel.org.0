Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F140E5893EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 23:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbiHCVNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 17:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbiHCVNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:13:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CFD53D1F;
        Wed,  3 Aug 2022 14:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F8B66158B;
        Wed,  3 Aug 2022 21:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECD70C433D6;
        Wed,  3 Aug 2022 21:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659561220;
        bh=X8CAYWAQxfc8d8nXm7rwDGi6ayy3YflG4UwY8DySwD8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kcSael+wTPx32YfE2O3dYp0SiridlcbXFyeBBXxwB5i9eg6QGDy8SVhsNMAfNw1Ai
         Q5Xe30iM5KK7B9BNmcxU4M4xYAqsFc35sG5zvAMF+C2peMcTnmsKBNzrPUC61YJFx4
         ZJQzXgfgWwVeWnMvWzDjHw+pAdSqHiMWEQGDESfMAFWEnTPHk4PMaOgW7HN5G0Zr58
         MuMIyq+sn0rPQEyM8/z2Oy46zPPO2ShLjXdPkPZFoi02giRlQNwQXw/WXePWGFD3WL
         W/qYR5/6UJPd8pVCDFFtmO5/udG4VzQCDEbz1TOaDhTcje6BTX0BJ1MzCG5A9lwh1v
         7GRZ7FQAKLwiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA37BC43142;
        Wed,  3 Aug 2022 21:13:39 +0000 (UTC)
Subject: Re: [git pull] vfs.git pile 4 - beginning of iov_iter series
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YurOwiZoOKkj+kNW@ZenIV>
References: <YurOwiZoOKkj+kNW@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YurOwiZoOKkj+kNW@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.iov_iter-base
X-PR-Tracked-Commit-Id: dd45ab9dd28c82fc495d98cd9788666fd8d76b99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5264406cdb66c7003eb3edf53c9773b1b20611b9
Message-Id: <165956121988.15182.4850819711696593403.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 21:13:39 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 20:38:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.iov_iter-base

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5264406cdb66c7003eb3edf53c9773b1b20611b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
