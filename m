Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841C65F724A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 02:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiJGAgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 20:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiJGAgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:36:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E62BB041;
        Thu,  6 Oct 2022 17:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D25A6B821FD;
        Fri,  7 Oct 2022 00:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E9BFC433B5;
        Fri,  7 Oct 2022 00:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665102993;
        bh=xZmuAxfUszAS7J74E8uhi9aQvWZykfhej+QV1rgmkfc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cMwjzf7AwmC4MWzlvtIEyBaJQSYetf9OuGnKIv6HjggImgc8ZyeL/bT6EA+ILYc4v
         MQRImwJMCuUg4BnYSvXmjA6enWJcLcA3BqIPvhDYPtF87x6ddY3jtcEUmh/UNp4L+I
         jfR3lbl8clYHljvZHL6U6Wurw5kxT7NCxVUyd36RCk0shqrwv0qve0gqaQ2YFKbmKO
         f64O5wI9nu5xyJ24nzbsg76KoASQZui7dUp1wuhjwS6IGOKUTqlW9MeSjg20LqTbLs
         LS6aptF+eGOIZgz1YdKA64qoQuitBBAxNZPo5V75C/znyHHm5dLGVN9SeovwtaIbqw
         DcEvdW7WSjbTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BF41E2A05F;
        Fri,  7 Oct 2022 00:36:33 +0000 (UTC)
Subject: Re: [git pull] vfs.git pile 4 (file_inode)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzxlqrEtoV37hm3l@ZenIV>
References: <YzxlqrEtoV37hm3l@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzxlqrEtoV37hm3l@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-file_inode
X-PR-Tracked-Commit-Id: 4094d98e3375833737b467998219338ffd46a68b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab296221579715fb8f36a27c374ebabe5bfb7e9e
Message-Id: <166510299356.12004.11426567198740533.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 00:36:33 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 4 Oct 2022 17:56:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-file_inode

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab296221579715fb8f36a27c374ebabe5bfb7e9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
