Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE185F3BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 05:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJDDpx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 23:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJDDpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:45:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C0D13F8F;
        Mon,  3 Oct 2022 20:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BD58B818F0;
        Tue,  4 Oct 2022 03:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CFF9C43470;
        Tue,  4 Oct 2022 03:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664855101;
        bh=WlYvFPSGgYR6UTDQlTVeJEQwAl1BFf/oeGCWQvKiLM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OU9flvPcMyBXfPPotW+FND/Md/rqH1XV/gV4t5fkg9Ra97k8h8bJOEuRhxd7+cUwh
         VKjeSDfUN76tGY6Qlnw9P1jqtKlt8RVyiyhvv8h7lMe7mdI8NM0nxxCkD3210Lg27V
         riXtiSEco5qHgu9nX4gUPOX0gNZT/Cw6qW1h8LTBIguqYN1CRecrL8Y2sVaJVPsVis
         GYKF3kx1xALmH7I1atHRVkVc0DLimw1ILG3ZZUvAmso7/INN2PVDMPVnNf4SjHQvTX
         4BfD3CkwCaLDMMatCRBAmU6QdJIVy9WbmL7rJgMJQK7SlIEFhq1JAxnhdgRAatpKF2
         /XKWMUDTnON8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C652E4D013;
        Tue,  4 Oct 2022 03:45:01 +0000 (UTC)
Subject: Re: [GIT PULL] vfsuid updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221003111943.743391-2-brauner@kernel.org>
References: <20221003111943.743391-1-brauner@kernel.org> <20221003111943.743391-2-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221003111943.743391-2-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.vfsuid.fat.v6.1
X-PR-Tracked-Commit-Id: 41d27f518b955ef4b75b02cc67392aef0809a78d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bea8ff34a8a5a46c9550aad6f6381b9fce0f958
Message-Id: <166485510104.18435.13727158667994525603.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 03:45:01 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon,  3 Oct 2022 13:19:43 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.vfsuid.fat.v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bea8ff34a8a5a46c9550aad6f6381b9fce0f958

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
