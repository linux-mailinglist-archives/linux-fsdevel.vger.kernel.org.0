Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37D84C94EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 20:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiCATsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 14:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiCATrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69F46D397;
        Tue,  1 Mar 2022 11:46:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80DB2B81D16;
        Tue,  1 Mar 2022 19:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 194BAC340F5;
        Tue,  1 Mar 2022 19:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646164004;
        bh=+9HZiL4PgVygGkKP1IEV0igcRDO9JBJc55Hjhj12zzc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g6+9CfAAyuhOYZ9F5azKH2kQ2WDaMY76/PCiG88JcRnO/QDnEv1fucab997NJjey1
         alc/dt3SrHyRWaleV/7vn3al/4UPiFkhF0daHtWDwW54oIVVv4NsTE+CIXrCd95AeN
         cWjyopLrJJyEL+cyXUgffl16RlJmQG0C65ZpV9fVQuf24CTz/ixflFi0kGde78MU9+
         lvJAMvYbcfrw3HF2R8SPWR4sErjAb5PPgD7p2kmysUtxOAKERvtc+qfUIYdiODvafh
         nYMZ3WkauU0YkMr34yM8MG7R5aAa+Q3+RDJK2JEai/4tGYMjud+e8UgN4PaitkE4Ne
         AV3dUf2CrCvJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8033E6D44B;
        Tue,  1 Mar 2022 19:46:43 +0000 (UTC)
Subject: Re: [GIT PULL] binfmt_elf fix for v5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202203011032.7D3F2719@keescook>
References: <202203011032.7D3F2719@keescook>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <202203011032.7D3F2719@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/binfmt_elf-v5.17-rc7
X-PR-Tracked-Commit-Id: 439a8468242b313486e69b8cc3b45ddcfa898fbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 575115360652e9920cc56a028a286ebe9bf82694
Message-Id: <164616400387.4081.18262832231088368446.pr-tracker-bot@kernel.org>
Date:   Tue, 01 Mar 2022 19:46:43 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        matoro <matoro_bugzilla_kernel@matoro.tk>,
        matoro <matoro_mailinglist_kernel@matoro.tk>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 1 Mar 2022 10:35:07 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/binfmt_elf-v5.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/575115360652e9920cc56a028a286ebe9bf82694

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
