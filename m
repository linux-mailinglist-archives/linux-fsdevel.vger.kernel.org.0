Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F646F0F97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 02:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjD1Aba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 20:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344458AbjD1Ab2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:31:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21CF40FE
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 17:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 416986408D
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 00:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94A22C433EF;
        Fri, 28 Apr 2023 00:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682641884;
        bh=l2moRdvb4ZDBB4s1anOqzQGUMRYRz+FY5MusdtvYmos=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KL0GR0vmZIZAncdMrHaMZgaAa8bqibgYQWEiGMyK6A7fJJXD8Sze8Mne/QPyWD4fB
         i/4CZf5/vbPd3J7hO1mHmDjwEgS/BdR/HahHM+qd6wziK5iHEbmTaTPbULDAobxsT4
         WWPagFuEEB6igZbHkB4M6q2TO3NHYds4bzzuz3wGWv1ddwzo/4nJtWD3ruH8wBvS6V
         0x8iEA78ObHcwjoxqLTVYPI54ApO76nwWkht/t0Y6NYrlYy3FKIN6m7V1e5hneMygQ
         mlRHIDOKZD8YexZekpN7YuteI+UcuQuqQlHH8sYDt9XGny4OwHjc/hNTX/oTdg486C
         duxoPnR/+IMPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 837B6C39562;
        Fri, 28 Apr 2023 00:31:24 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEcE6Ex20CwMfMKj@bombadil.infradead.org>
References: <ZEcE6Ex20CwMfMKj@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEcE6Ex20CwMfMKj@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.4-rc1
X-PR-Tracked-Commit-Id: e3184de9d46c2eebdb776face2e2662c6733331d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 888d3c9f7f3ae44101a3fd76528d3dd6f96e9fd0
Message-Id: <168264188453.7031.14885326619333470363.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 00:31:24 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        arnd@arndb.de, chi.minghao@zte.com.cn, mcgrof@kernel.org,
        wangkefeng.wang@huawei.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, sujiaxun@uniontech.com,
        nixiaoming@huawei.com, akpm@linux-foundation.org, vbabka@suse.cz,
        willy@infradead.org, j.granados@samsung.com,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 15:38:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/888d3c9f7f3ae44101a3fd76528d3dd6f96e9fd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
