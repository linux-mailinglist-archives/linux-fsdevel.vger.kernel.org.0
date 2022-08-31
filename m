Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D045A8421
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 19:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiHaRUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 13:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiHaRUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:20:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E6914D07;
        Wed, 31 Aug 2022 10:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F951B821EC;
        Wed, 31 Aug 2022 17:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDB46C433D6;
        Wed, 31 Aug 2022 17:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661966402;
        bh=Wb+f0RUdv+OpPtYsBnBHQ92HpnffJq35MrM0MuW8jq0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HZODbVYkrjuwGJs2Vitc3pzMiCbp4PhKYyDTM61m9JtOCa50HBH7q+TOM9JJzRBjm
         bbEg1FxKGsy9EQRBGyeUbHPF2BciQAFy9appBLfQmagUWbgG0wg5jzq1QT0nvWOH6L
         7HTvlv99kkahl/iBsXS77gFBIFu/8XMwm00YaYfgr7vf7q+5kEq1Q+TvQjcZuvHFbi
         x5sajHMfOd9MVcCVXdBum5AmhR9r4MKVXIyZ0XSiWWuIRvj733HlKcR1gsJwikIAUx
         N1lYliVQKA4R66mcQgHQLmtsFN7pxHnIb1xi8mGRB5cIGC4Qur3ac7/6eZMIFEI/5w
         S4xxAB6R8k2QA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7FB8C4166F;
        Wed, 31 Aug 2022 17:20:02 +0000 (UTC)
Subject: Re: [GIT PULL] fscache, cachefiles: Miscellaneous fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1867371.1661962479@warthog.procyon.org.uk>
References: <1867371.1661962479@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1867371.1661962479@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220831
X-PR-Tracked-Commit-Id: 1122f40072731525c06b1371cfa30112b9b54d27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5e4d5e99162ba8025d58a3af7ad103f155d2df7
Message-Id: <166196640267.5012.5441408429818523211.pr-tracker-bot@kernel.org>
Date:   Wed, 31 Aug 2022 17:20:02 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        jlayton@kernel.org, Khalid Masum <khalid.masum.92@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sun Ke <sunke32@huawei.com>, Xin Yin <yinxin.x@bytedance.com>,
        Yongqing Li <liyongqing@bytedance.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 31 Aug 2022 17:14:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220831

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5e4d5e99162ba8025d58a3af7ad103f155d2df7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
