Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4257F78B95C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjH1UPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjH1UPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A040618B;
        Mon, 28 Aug 2023 13:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 358E56511A;
        Mon, 28 Aug 2023 20:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A719C433CC;
        Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253704;
        bh=NiewIqifUcek/guKXpC9BaBAAMdb94frTZJUZPfUf04=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LYXDElRM80idpBWHj52FMVFZ4ZbX/NMsxyKFbXJUhsd2+wej47lJadgte2aTSz+PO
         AfmWy6IsWIlCehoX78BKl1/CpuF2QVfpbuBUCTcS8/7BDUztBAjqBUBqK7OckZLKbr
         pdIQNFfJ11O5P5FtCOATJmCb+tglp+m48ptyulQ1eieKhfR8GUD01pszCzDR3PCu4+
         Rr07cnWkh8Z6ioAMfnZ7xH0ghxYzdTNXrD9CxcqH5K+t7k4Vf9XydwAdfsD0fpyCiw
         qxQCvbZy2RCLVW3fjC2OW/DhRDk9YIJ80qBXhIhb3eUL7FPg9Ck/EY/7PPBgJteh9F
         UCMZABtCg08+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 884D5C3959E;
        Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt update for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828034610.GA5028@sol.localdomain>
References: <20230828034610.GA5028@sol.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230828034610.GA5028@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 324718ddddc40905f0216062dfbb977809184c06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc0a38d0f638dc1229ffffa9016044202efddca0
Message-Id: <169325370454.5740.16138153330455926424.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:15:04 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 27 Aug 2023 20:46:10 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc0a38d0f638dc1229ffffa9016044202efddca0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
