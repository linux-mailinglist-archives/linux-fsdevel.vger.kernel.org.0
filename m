Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2895FAB54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 05:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJKDnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 23:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJKDnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:43:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710CD7C752;
        Mon, 10 Oct 2022 20:43:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DA861093;
        Tue, 11 Oct 2022 03:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DFC1C433B5;
        Tue, 11 Oct 2022 03:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665459800;
        bh=jhwJ7HkLxQOURNVjQ4sMQTPoBm4dAaSF/3GIhqkyij0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BVcgOuVlzMOZveXBBIin03b4tAtwws/b40Xv3U90A7IPVtEUCGypuTVR/3DD9boRl
         Mz+7mBdlry94zH0uXnQ+uQJYwA+5NcGJdDqDBCWjgcFvLkT1H+rwAhcrEoeUDbpDA+
         +g7eDNCjU1zmunDgYKXkJrq/+Q1ELjMre/+mq/AoWQJSwpUOW0ynGRsXQJ6BU2ycq8
         EuU+c/kYN8VmhWHUGKhG9U+x4uPbCgth8FGQhJNQ8C/ii2/oqGAOnfboCJ5jirquAF
         hvyhJiufWL4LuaEujRQhMjeDX+YEYof9fcv3c5f3PsepK255cqtLq9CK0t/csqXIGW
         VWWowDFJlV+Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A344E29F34;
        Tue, 11 Oct 2022 03:43:20 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0OsOYmG+PU2CgcH@codewreck.org>
References: <Y0OsOYmG+PU2CgcH@codewreck.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0OsOYmG+PU2CgcH@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.1
X-PR-Tracked-Commit-Id: a8e633c604476e24d26a636582c0f5bdb421e70d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00833408bb164342990102f272c77983f1ca5e94
Message-Id: <166545980036.4678.10364481447836785451.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 03:43:20 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 10 Oct 2022 14:23:05 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00833408bb164342990102f272c77983f1ca5e94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
