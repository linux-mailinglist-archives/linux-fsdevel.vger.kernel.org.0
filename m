Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AB6533534
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 04:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiEYCQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 22:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243777AbiEYCQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 22:16:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA8A19C09;
        Tue, 24 May 2022 19:16:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43880B81C28;
        Wed, 25 May 2022 02:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3C38C34100;
        Wed, 25 May 2022 02:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653444993;
        bh=q5F9s2pdE+K4CCyB8i32EvzHkMHwEzfkGQR8P31j2sQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=alj8u9u4ZWKbTxntXrENDQkfXmBzMsxsYLB3kPAuUY+ukKj6g/HoILhkEDzifpDE8
         +qMyVUDvGNnnfnHHeD6L+7rLAXVSFnxofWmxT+EtUNcS0LkpMLqb6O2Xskv3MU/TjZ
         KZdkESQCiRiYi1azI732z9M5bZlbS5FoD1PJIs99Q0J+y1TRgAae8hDG7lKd5ijCXD
         qobKjJ5dVhp8ljYjgy//P6MCFYMW3GbFtpHWAiExP53chdBoqZWjUY5X9YlS82YZG3
         UQjuB0PXXWj+3lOaOmmudt+BwAszcW+5FfsC1Tc1DOU2qUyC006XwXRWJrP7KJ488Z
         5pt0IwKb0ODZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0D91F03938;
        Wed, 25 May 2022 02:16:32 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.19-rc1 (fscache part inclusive)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yoj1AcHoBPqir++H@debian>
References: <Yoj1AcHoBPqir++H@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yoj1AcHoBPqir++H@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.19-rc1
X-PR-Tracked-Commit-Id: ba73eadd23d1c2dc5c8dc0c0ae2eeca2b9b709a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65965d9530b0c320759cd18a9a5975fb2e098462
Message-Id: <165344499284.22339.1005839809480771514.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 02:16:32 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        David Howells <dhowells@redhat.com>, Chao Yu <chao@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>, tianzichen@kuaishou.com,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        zhangjiachen.jaycee@bytedance.com, gerry@linux.alibaba.com,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Yan Song <yansong.ys@antgroup.com>,
        Xin Yin <yinxin.x@bytedance.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tao Ma <boyu.mt@taobao.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 21 May 2022 22:19:45 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65965d9530b0c320759cd18a9a5975fb2e098462

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
