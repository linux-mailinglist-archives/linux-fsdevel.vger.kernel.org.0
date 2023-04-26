Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E646EF8EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjDZRGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 13:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjDZRGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9327AAC;
        Wed, 26 Apr 2023 10:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADD8062121;
        Wed, 26 Apr 2023 17:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FBFCC433D2;
        Wed, 26 Apr 2023 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682528790;
        bh=bjUeFdcrAPb6A1XLGJ1j7sM0jVBuDpKaMnhSHeosS5I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Iqq0WscNVI6OfeqZpBBsOsQCtyfn6tFPQWoOIk/G9A8a4gr209P0D57zA9QtdfhzI
         49RaBH9nRFcgPDD6ddvzi+WfoimjGXhfSLVxWSYEzJxcvx/5plXsoZ+QhmxLuwrST7
         eD6X1Mr5jEjfZCeBtD0KNH29XEby92m1S0da8FnJcIa+fl0NlFosXTsrPDU7KMNTA8
         q3SN7tYFlTF78RcpnQY1ci7wpm9MU7KnwPz9VuCIOs7x9+6W4XO3dpySWta8z6gC4q
         WWUWyLC4cRohyYUDT38pybFHffocovxMs7LVwjNgB7nGDayFGUXBsQL492P7KeFlZO
         tJ8eLWmAMjyMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 008B5C43158;
        Wed, 26 Apr 2023 17:06:30 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230425062451.GA77408@sol.localdomain>
References: <20230425062451.GA77408@sol.localdomain>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230425062451.GA77408@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 83e57e47906ce0e99bd61c70fae514e69960d274
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbe0e78d0e3a83dd924ea01bebf6c45313c81607
Message-Id: <168252878999.19907.1457554584879249111.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 17:06:29 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 23:24:51 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbe0e78d0e3a83dd924ea01bebf6c45313c81607

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
