Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE615F3BC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 05:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJDDpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 23:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiJDDpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:45:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49B55A9;
        Mon,  3 Oct 2022 20:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC895B818FD;
        Tue,  4 Oct 2022 03:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7667EC433B5;
        Tue,  4 Oct 2022 03:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664855093;
        bh=x7gd+EVcFPH1Kgn1LX7rIu4VGEoIDc3NvqgSFQjUiWw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I0UwOOhK97s2oF2aqiE7cewDDiztY8T0WCXjsrNazD/FWEE05CALJvtw3qrRK5OMi
         lemOjZK+zG38BXijAeWL5bnJpDoZ7CjMNaX9RZbrkdMt/SqWtjYc2Wo5535LLLlg4b
         rgsgn/lLL2aINK8qD/wSaCyQjD87gW3PJ0DXB2zatZQr054jYoEw8QkHfPmasVKjNt
         tCsywGL5a0MDmxStLXSnh3CaUz1zeq2eSAwYfkerGx9aXg9SI0yRyMQdiJst3qrGJl
         Thao8PDDusuXGMO6EhmoUyZr3JJiRDZW7L/Pyho0Q6r3o+Gpq80YA+xACzUPAv2p0M
         CZXDZURGiYlPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6318AE4D013;
        Tue,  4 Oct 2022 03:44:53 +0000 (UTC)
Subject: Re: [GIT PULL] STATX_DIOALIGN for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzpXpalOcvwp+keu@quark>
References: <YzpXpalOcvwp+keu@quark>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzpXpalOcvwp+keu@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/statx-dioalign-for-linus
X-PR-Tracked-Commit-Id: 61a223df421f698c253143014cfd384255b3cf1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 725737e7c21d2d25a4312c2aaa82a52bd03e3126
Message-Id: <166485509340.18435.16538782233401144601.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 03:44:53 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 2 Oct 2022 20:31:49 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/statx-dioalign-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/725737e7c21d2d25a4312c2aaa82a52bd03e3126

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
