Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3C6F25BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 20:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjD2ST3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjD2ST1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:19:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B3B9F;
        Sat, 29 Apr 2023 11:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F23060B6B;
        Sat, 29 Apr 2023 18:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD4A4C433D2;
        Sat, 29 Apr 2023 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682792365;
        bh=8HDfUiZjrvUti/9Ci5CYxqlcQpcPcVdKxSLybQOJ1/c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pp/ubhqcsJx437DN1q0keIixF8iPP9qa6h5P2vDMGUcE93XFogT6mTR5QsCyFpsDQ
         D/Jh21nth6YUH5Ll+SOGXdJ3IR5w52ep5+cLXCO5/FpcEGvZlElC9e0HdPf7/NTD4/
         +Wg847xT0Luus5pH/evc3js8FfP7RAXNM8KODG7tmdtAJwA8tR6rNF0bruAmH1G03H
         W0MpU9aHmQil365hD4zONYC1z0TGt07QlxqriP23iKue9rNPKC3QsV1sNZN4Exj8h3
         k/a9TNlypFSzxjB4tNh0u+PJAjOyEFm4/efgDLbuR9XTjH96MlFt69bWA+0Ugzy+Ji
         jAZ8etbyhB+zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88D7EC43158;
        Sat, 29 Apr 2023 18:19:25 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtsYPer65Fjm7BFhsjKt-g4XMCtk8siYAZxXg4qpyRKXw@mail.gmail.com>
References: <CAH2r5mtsYPer65Fjm7BFhsjKt-g4XMCtk8siYAZxXg4qpyRKXw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtsYPer65Fjm7BFhsjKt-g4XMCtk8siYAZxXg4qpyRKXw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.4-rc-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 74d7970febf7e9005375aeda0df821d2edffc9f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ae78a14516b9372e4c90a89ac21b259339a3a3a
Message-Id: <168279236542.22076.7235162901818800004.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 18:19:25 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 26 Apr 2023 21:11:44 -0500:

> git://git.samba.org/ksmbd.git tags/6.4-rc-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ae78a14516b9372e4c90a89ac21b259339a3a3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
