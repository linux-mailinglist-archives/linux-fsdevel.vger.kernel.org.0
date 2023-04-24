Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F83B6ED6E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjDXVpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjDXVpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:45:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096B17684;
        Mon, 24 Apr 2023 14:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C6126295F;
        Mon, 24 Apr 2023 21:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5358C4339C;
        Mon, 24 Apr 2023 21:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682372739;
        bh=35lZKONNZzWm2r9pM9aIdHYokZ3GCSWLOqxh6Ab0nsE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=drOj19Ci77oWMAHIRNJz4citRyytGyJlRWuzITk8UU/89ka0jPMwNA24EXEt0f5Ac
         RPPDcPa+c9JEGYlyyy2Omx3RlBmBpGThACjN5MpHFsg1dwY+LoocQhBs6Rxm/7WAAI
         R97goAD7Ikn4mUjpLx5VofhQ04SAnrjqr74k4bcedr2frVUQlRCI2jEx/uchv0QXZN
         5YhGKQroXMgz5jK4Ux6dFEwBcdrDvdwzc9hjzDw3+dbQu7Q5CMOD1vAxQqKOEkkNyW
         af3uwWWJodmMsdUH9Nn3YzW3LUi5y3O784q7aYMUi45If9hTA6EL7WoKrefKLQn2BP
         bRThIhQyObzqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD373E5FFCB;
        Mon, 24 Apr 2023 21:45:39 +0000 (UTC)
Subject: Re: [GIT PULL] acl updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230421-kundgeben-filmpreis-0e443f89efe2@brauner>
References: <20230421-kundgeben-filmpreis-0e443f89efe2@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230421-kundgeben-filmpreis-0e443f89efe2@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.4/vfs.acl
X-PR-Tracked-Commit-Id: e499214ce3ef50c50522719e753a1ffc928c2ec1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bcff5a3969b0e396087516ba4131596296a4478
Message-Id: <168237273983.2393.13535634002054124437.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 21:45:39 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 15:45:57 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.4/vfs.acl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bcff5a3969b0e396087516ba4131596296a4478

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
