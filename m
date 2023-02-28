Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB76A5067
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 02:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjB1BCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 20:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjB1BCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:02:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31528298EC;
        Mon, 27 Feb 2023 17:01:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9B6E60F84;
        Tue, 28 Feb 2023 01:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3309EC433A0;
        Tue, 28 Feb 2023 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677546115;
        bh=84Xvp168sokHCBrmD6E23XwAok9TjE5uZlT8zL1cCUU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cNsRvhiueD336eCgeTzlzL7CN3QR418HrwVSOd7U/zCliL7nqvIsJnUeAOsp8UOw5
         hiLt68AbPwaZc/2mRXOgQPTPuYtLP7vjKKuBDGH1Ob9Eo3AcQ2R2Pur5VBT5XHYZWf
         5QUOasmUUwZ3yRAGneBG3sRZck43cSAXv8d7yKFkuKWmdWJkd7AQ10aIUAa2yg76OE
         wVC2TNmlRYuLYhYb+1V8IasY//WsjgMIE8bRIoLn5UuT3F7ZCYsr91bgX5k5aZhWD/
         JgNbITP619mqy6l+mslm9DtMj8lrl+R5TK0UWsbgnO2FtoZOilvek311LPP2Kw7y9d
         2vNeTy3RQPm3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0AC4CE50D60;
        Tue, 28 Feb 2023 01:01:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] MAINTAINERS: update fscrypt git repo
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167754611503.27916.4447364691434133144.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Feb 2023 01:01:55 +0000
References: <20230116233424.65657-1-ebiggers@kernel.org>
In-Reply-To: <20230116233424.65657-1-ebiggers@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Eric Biggers <ebiggers@google.com>:

On Mon, 16 Jan 2023 15:34:24 -0800 you wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> fscrypt.git is being renamed to linux.git, so update MAINTAINERS
> accordingly.  (The reasons for the rename are to match what I'm doing
> for the new fsverity repo, which also involves the branch names changing
> to be clearer; and to avoid ambiguity with userspace tools.)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] MAINTAINERS: update fscrypt git repo
    https://git.kernel.org/jaegeuk/f2fs/c/31e1be62abde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


