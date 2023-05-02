Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6B06F49AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 20:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjEBS12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 14:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBS11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 14:27:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678F8197;
        Tue,  2 May 2023 11:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F26B5627C4;
        Tue,  2 May 2023 18:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D4C4C433D2;
        Tue,  2 May 2023 18:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683052044;
        bh=IPxvoxkHJ4x0pRA2C55qurKFk5SV291lUhKR3tCpUyA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gbpG6HLMFfLpeefayM7FA648XLOBcU5EAVL8s8f9GP9GhRegMCkr9uBaPGbO5mcqT
         AVME40wykh4QnR789JslrWeafWVGMo2TZTzbJNE3bbZPI8Ev35dX7rcIoUXaAJoBBi
         3xJQzShzdqAAjTcQ0ZYA3YT5LapT+EioxeeSi60u12rBKS9IHIqNmZc6mwhGeyb/nw
         C/Gp9+clPVdg/9g6MdgUqeAzjTW/65iKjXkVA1b9+kCu9M0RXI+NdJdkaGYermW+k4
         OBC1cBq4izUHqqIdrsqwtMyHjcrcM9rsDsMkoE9Hq0CPM8hzJ1sgFzn3KYWYy3M9g2
         stqA+cJchWUWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49263E5FFC9;
        Tue,  2 May 2023 18:27:24 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Fix directory size handling
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1647979.1683051720@warthog.procyon.org.uk>
References: <1647979.1683051720@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1647979.1683051720@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20230502
X-PR-Tracked-Commit-Id: 9ea4eff4b6f4f36546d537a74da44fd3f30903ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21d2be646007a1c5461f4233749c368693aa6d9f
Message-Id: <168305204429.24192.13992141451694182484.pr-tracker-bot@kernel.org>
Date:   Tue, 02 May 2023 18:27:24 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 02 May 2023 19:22:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20230502

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21d2be646007a1c5461f4233749c368693aa6d9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
