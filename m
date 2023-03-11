Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B84D6B5840
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 05:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCKEwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 23:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCKEwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 23:52:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6451F12CBAD;
        Fri, 10 Mar 2023 20:52:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E66646091F;
        Sat, 11 Mar 2023 04:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59445C433D2;
        Sat, 11 Mar 2023 04:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678510329;
        bh=4wiUiDiGH9KVT6wQEP3ihcTZRPwTBKOlX3LUQOA92g0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CEx3SjyRvK7lanikeQTw8VOIH43Ajfpy+RrQo9gcNcxKMDfQFW0+alU+IHjwU/PUi
         kRzo4f3gY9omv54On20uAdK+e0folP9YnIuaBp7bx1y7fEWNybm+hRwwuU+yUU/FSf
         SWhQxouwb+R1RnhejnVUVOUlZZ6gutErUUkG/rvYEPDEGFQyxgW/RXTdwXi8z0DOt4
         taGont5iF2kGvwpK+utZkyzeT6Cn4gBqp7+tYyrrY0+U2no2itpfqSsDkLBWYOzGgc
         ZWJOL2egoNZcsH/yZHH/2jG/36qUl/3hpcPYRE7ElTAdJXjSvgn2lOZCeLxH/PKKQW
         hD7G+tb5A0fAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48855E61B75;
        Sat, 11 Mar 2023 04:52:09 +0000 (UTC)
Subject: Re: [git pull] vfs.git fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230310202737.GV3390869@ZenIV>
References: <20230310202737.GV3390869@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230310202737.GV3390869@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 609d54441493c99f21c1823dfd66fa7f4c512ff4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4831f76247bc939ed1b6d71ddd23337ec8b56b8e
Message-Id: <167851032929.30895.4613790287550220737.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Mar 2023 04:52:09 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 10 Mar 2023 20:27:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4831f76247bc939ed1b6d71ddd23337ec8b56b8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
