Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C35F7249
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 02:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiJGAgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 20:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiJGAgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:36:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E06A2876;
        Thu,  6 Oct 2022 17:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 77739CE1780;
        Fri,  7 Oct 2022 00:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8179C43470;
        Fri,  7 Oct 2022 00:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665102993;
        bh=oXQFuhl7D24SiOpcAZXFmtJ8gYfa2GADC2S0btZ6eFI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GWycd2D6l97FEmXnWp2j1owDqmV9smLdwQT2uBm/YjCqPhDWfkYmILKwkipGXT6wC
         eMsFWnWIUZ0YKl7379K7jixs+SNaDH7OV6cW/dnD5YjFq7WzN9Ut+Jaa0H7KbaLoGc
         mcS9Fpb9FYLBXrHqaCZUFdnhSMvv7BH9MKum1CblpcgEElgyCk1OQUU38Qho41/T3H
         eMMmDVgABS7/Y2JB6cKflzTfMXkI5cCBlkQG5NQnr+nVIrMm4JljQofdN2NkiplyLU
         oNttI8ARAweZYXy+QybFixRFUj61lAwXOr6mdEI+tCMQs+EmVkE8oJJ/H027DPlVfa
         YvsJ9yGDbhHlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2C5FE43EFB;
        Fri,  7 Oct 2022 00:36:33 +0000 (UTC)
Subject: Re: [git pull] vfs.git pile 6 (constification, mostly struct path)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzxnDoPjLjkuUlXp@ZenIV>
References: <YzxnDoPjLjkuUlXp@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzxnDoPjLjkuUlXp@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-path
X-PR-Tracked-Commit-Id: 88569546e8a13a0c1ccf119dac72376784b0ea42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c0ed7d8d6e3dc013c4599a837de84794baa5b62
Message-Id: <166510299372.12004.8436536069241357744.pr-tracker-bot@kernel.org>
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

The pull request you sent on Tue, 4 Oct 2022 18:02:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-path

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c0ed7d8d6e3dc013c4599a837de84794baa5b62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
