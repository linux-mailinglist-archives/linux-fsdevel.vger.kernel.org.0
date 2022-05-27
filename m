Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99453582D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 06:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbiE0EGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 00:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbiE0EGl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 00:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1412ADC;
        Thu, 26 May 2022 21:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A41BF61DBA;
        Fri, 27 May 2022 04:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0749C385A9;
        Fri, 27 May 2022 04:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653624397;
        bh=I6sNIeTE3L/jsPEBhjey3Sktkbpn1ybtGP9GSn1ETo4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pa2D/cTdja6DgO4BJ8y1ihOM/tsxSn8FVaXGHxjHCsHSZMAbr+AdCmueyYiu9bDa8
         x4NyjB/YuRLthdKhyjrj9/LRg6Jnl5N4JfqQohBjXiAgIqdh89eXPLMccZScBG3Luu
         FyJsHWo7NY27/uGoX48fqyNmsb1SnpKTvwTlxHhZSCJWMqgmjQJZKyLYMwDbxF/fHX
         IUTOrUebdUnRpe5UHk4OoTO2d8QaNqSsFasUZXs7JhccxeZ/GDtUxwsD2HFi0O3BVP
         rd9aFhVztjFBc1U/vupNMPOovtd97431zhlIJtZnMdmh3QhHFBg3QsMoYbA6zFtUrh
         Qm0hB9mJHrfmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2920EAC081;
        Fri, 27 May 2022 04:06:37 +0000 (UTC)
Subject: Re: [GIT PULL] nfsd changes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <DDB7B172-52E3-4015-9BD2-9BCDE209E5AC@oracle.com>
References: <DDB7B172-52E3-4015-9BD2-9BCDE209E5AC@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <DDB7B172-52E3-4015-9BD2-9BCDE209E5AC@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.19
X-PR-Tracked-Commit-Id: 08af54b3e5729bc1d56ad3190af811301bdc37a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d29d7fe4f0c1e81c39622cce45cd397b23dc48f
Message-Id: <165362439778.3780.1154326941363112833.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 04:06:37 +0000
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 26 May 2022 15:25:00 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d29d7fe4f0c1e81c39622cce45cd397b23dc48f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
