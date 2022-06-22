Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31FC555096
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 18:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376342AbiFVQA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 12:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376304AbiFVQAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89591CFCE;
        Wed, 22 Jun 2022 08:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86FE76197F;
        Wed, 22 Jun 2022 15:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB551C34114;
        Wed, 22 Jun 2022 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655913528;
        bh=eJXLKQ3BYgNftB2DvfgHxogKBElNoxFmgA7Jbw3c6A4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lDanj8MFmMSAAWgwRBAE5PvgE6L0etVXvvng4lufcoK8jCY+eIBJqBh3Rjhs5U3Db
         Er7/j4pol3nQI/x4U8FUZFRH+TkfE+PdaTzgf1GHQqwIxW7nsfOflQrhvpRUZCrCQu
         AvTN0QXXV9ovcObREi8qDy20n/ww+od7WMRx5Vw4Fr/4tcsOdZOni3fmztkRZ79nkx
         mtn0QZhWX2D+cjzh3sHA8DCHojAVGAig24TRabx9h5ie150o+SKtvKMDnVSVrmOjFC
         JGv/UOJdwqqpKpFI4CkH/UX3GFxQTAHf4ntg7lQf6uvz8sKDC7Ou5zLg5ryJh3jiA1
         gsXdNromFXzfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5260E574DA;
        Wed, 22 Jun 2022 15:58:47 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YrKeHMRfXTNw3vTE@codewreck.org>
References: <YrKeHMRfXTNw3vTE@codewreck.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YrKeHMRfXTNw3vTE@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-5.19-rc4
X-PR-Tracked-Commit-Id: b0017602fdf6bd3f344dd49eaee8b6ffeed6dbac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3abc3ae553c7ed73365b385b9a4cffc5176aae45
Message-Id: <165591352786.24413.10949630559737106168.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Jun 2022 15:58:47 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 22 Jun 2022 13:44:12 +0900:

> https://github.com/martinetd/linux tags/9p-for-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3abc3ae553c7ed73365b385b9a4cffc5176aae45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
