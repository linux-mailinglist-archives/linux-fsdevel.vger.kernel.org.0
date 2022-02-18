Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF7F4BBF62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 19:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbiBRSW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 13:22:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiBRSWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:22:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEA43BBE3;
        Fri, 18 Feb 2022 10:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m+5LEIPzvpW/ZP5xSqR3hrDOfDmhLm4QKQDmOWUd7Bw=; b=3o+0/fYLnSfHYG6jw6Yxf0C6I6
        pqepEaZSs/WKBvDo7w1i94mVnUGiiIgiwlf3Pe4/sJ9b19vKTSGwlaLCCVk8KMtXZMH+z0bs7mCBS
        qQ3Ty2VSIB750PZmBfU51rw8tyU+mZJE/R/l5ZlV3Vk2SB8hs+ytVn+Rp/ri/8BsjUmfZBvYM8J6C
        gEHpH6tmeAZ/asQDec3w6xn169M1i/4SIwoCi0Ve24PrcLyp36Yi/dU0N2p0mQWs2zbO7TJyzrKf+
        F++mkDEyzgoS4V17b9bsCJp5p+3bOU2T2zq048+tfwfQ5CMI8xlOjilgAsNdI3jpjc8YymPSE/o1A
        KO5OEosQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL7tE-00FUba-GR; Fri, 18 Feb 2022 18:21:56 +0000
Date:   Fri, 18 Feb 2022 10:21:56 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org
Cc:     Zhen Ni <nizhen@uniontech.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH v3 0/8] sched: Move a series of sysctls starting with
 sys/kernel/sched_*
Message-ID: <Yg/jxFqiuyR/xB2s@bombadil.infradead.org>
References: <20220215114604.25772-1-nizhen@uniontech.com>
 <Yg3+bAQKVX+Dj317@bombadil.infradead.org>
 <20220217185238.802a7e2dd1980fee87be736c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217185238.802a7e2dd1980fee87be736c@linux-foundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:52:38PM -0800, Andrew Morton wrote:
> On Wed, 16 Feb 2022 23:51:08 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > Are you folks OK if say Stephen adds a sysctl-next for linux-next so
> > we can beat on these there too?
> 
> Sure.  I just sent you a couple which I've collected.

OK thanks! I've merged those into sysctl-next [0]

Stephen,

Can you add it to the set of trees you pull? I'll send a patch to add
this to MAINTAINERS too then.

[0] git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-next

  Luis
