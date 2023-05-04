Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF80D6F6329
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 05:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjEDDNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 23:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEDDNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 23:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3656BE73;
        Wed,  3 May 2023 20:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC6C16312E;
        Thu,  4 May 2023 03:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D7A0C433EF;
        Thu,  4 May 2023 03:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683170009;
        bh=mMZ0HLBLLLSXUtUztbVAlspnjdc2X7k1K2fjwqMop9o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eEaH+wpaJvXrHBYmj07EaEL2urAb5JA2u67w0V3S+ucQRXCtgqUpri1uEe2YpBM+0
         Q/v/q2vjVDp6kfsgf6G/sfxfbUizVJYOFwJIPL3hpOjbM+umYpCoNi6WAMxma+4Kl/
         Dcx+xJCf4dFNTorUyb7GTCU24atHAwfKUjJUgti7+bjd2RJm0OBJau12JRewpLcf8L
         TmOTcPEyrZ9UUpnsyAOq6z3uFEBNnZAp31xwHSENn4vGWY1TKaU9XRRiyiCMxVR/tx
         fOWoJcYKcOY70wUf0FKVA43rsxXgHkOUzAeOhsAXCSFl8Xh7Ea/a+E6puXLUEILH/j
         QA4y2hyXOlfIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C4CBC43158;
        Thu,  4 May 2023 03:13:29 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.4-rc4 v2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZFKzZeAs5Mdfv5ha@bombadil.infradead.org>
References: <ZFKzZeAs5Mdfv5ha@bombadil.infradead.org>
X-PR-Tracked-List-Id: <patches.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZFKzZeAs5Mdfv5ha@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.4-rc1-v2
X-PR-Tracked-Commit-Id: 0199849acd07d07e2a8e42757653ca8b14a122f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 049a18f232887834fc77e7cee46f06b5043aea22
Message-Id: <168317000904.23861.1522125793306825547.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 03:13:29 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        ebiggers@kernel.org, jeffxu@google.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 12:17:57 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.4-rc1-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/049a18f232887834fc77e7cee46f06b5043aea22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
