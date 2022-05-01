Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB09516535
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 May 2022 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349073AbiEAQ3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 May 2022 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiEAQ26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 May 2022 12:28:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB638654A
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xJ2dpSJBPSM/7yxW13WAhiJ7TmyprwEINpREsEdkU9c=; b=DNDOlU6Vd5mPP2LAh+ai/GRkAd
        t6xUY0bHVwXqdQvVRJxc4AYbaqRFXkWxs8V2DTPSWy7SRZK3RxLsLLvILpe95eUAd5I8k7Ir8ZHF5
        QluIP4hyx4LDnQms+1nZcrWBvjZ5eGHp1eEl6nsAqWf07QaDuTXZ0x3unhX5Qldh92ZO52nqFBTYv
        USC6bpnyffM8/A0xvvMUnnL58jrXxsogD82RdEZXdAk/qhJ8lQFKWBHcDNgrxe3cSY5FMVlRqCZAW
        4iBOW1QZfD01YjurLYI1tITs7LD8s+SGQlH+jbCiKTYgJ8x0Ai/5rtkjwUv4U+GMMFnM1BaluGVf+
        NMSxVcyg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlCNv-00GZxP-4X; Sun, 01 May 2022 16:25:23 +0000
Date:   Sun, 1 May 2022 09:25:23 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <Ym60c5kgI1qtgyyO@bombadil.infradead.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
 <YiepUS/bDKTNA5El@sashalap>
 <Yij4lD19KGloWPJw@bombadil.infradead.org>
 <Yirc69JyH5N/pXKJ@mit.edu>
 <Yiu2mRwguHhbVpLJ@bombadil.infradead.org>
 <YivHdetTMVW260df@mit.edu>
 <CAOQ4uxg+5XUxD19Zh_WoTjVc+yU-mjjCrgWN+85=oZe=pSKO2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg+5XUxD19Zh_WoTjVc+yU-mjjCrgWN+85=oZe=pSKO2Q@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 09:58:53PM +0300, Amir Goldstein wrote:
> On Sat, Mar 12, 2022 at 12:04 AM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> Hi Ted,
> 
> I penciled a session on "Challenges with running fstests" in the
> agenda.
> 
> I was hoping that you and Luis could co-lead this session and
> present the progress both of you made with your test frameworks.

I'm starting to think that since IO has no session yet scheduled
in for this session it may make sense to make this generic about
fstests and blktests. In fact even fio has tests these days which
we should all be running too.

My point though is that I think that it may make sense to have
both IO and fstests share this for perhaps a common:

"Challenges with running fstests and blktests"

  Luis
