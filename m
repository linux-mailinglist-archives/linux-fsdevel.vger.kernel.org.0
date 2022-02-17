Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961FB4BA6A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 18:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243569AbiBQRG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 12:06:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiBQRG5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:06:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504FAD76D3;
        Thu, 17 Feb 2022 09:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NkjFwjiqqX4QT/vg5SjVKkMGqKMMG5H/BF/lqfeUh3I=; b=CWQCbSEAF0GrUvyXOamn3kOn4G
        p7Qe3Bn4mhcwIIFNxozrBIeBisE0iKowk5CTtNW3j6nRX3bN5SeFq384aMEQx7BeItIuVOFwk8knh
        hufw5kkq3viwBBYj6eTlz6AA8PjAhWHRXzdebniWVxI9by1coH+3HRLHph6mh6jSpsAe+IrDyc5fA
        17ufitcGrr72bV+eQ4Rh9UOjDPsAi/2MnZGBWQXRfuFZyY1C/F1wQs+b5CpZDIY5lODR3AElwylOh
        ZwiG6DIMWTR/CpTK73Hw7b0Uob6KvItGO8QJ+XMVHJP1XDSBju2mA5yxqes3wIWbrh2aNeOKAwCEz
        MMZxPuCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKkEU-00Fn52-T9; Thu, 17 Feb 2022 17:06:18 +0000
Date:   Thu, 17 Feb 2022 17:06:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Byungchul Park <byungchul.park@lge.com>,
        torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: [PATCH 00/16] DEPT(Dependency Tracker)
Message-ID: <Yg6AigFqdhdO5/ya@casper.infradead.org>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <Yg5u7dzUxL3Vkncg@mit.edu>
 <20220217120005.67f5ddf4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217120005.67f5ddf4@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 12:00:05PM -0500, Steven Rostedt wrote:
> On Thu, 17 Feb 2022 10:51:09 -0500
> "Theodore Ts'o" <tytso@mit.edu> wrote:
> 
> > I know that you're trying to help us, but this tool needs to be far
> > better than Lockdep before we should think about merging it.  Even if
> > it finds 5% more potential deadlocks, if it creates 95% more false
> > positive reports --- and the ones it finds are crazy things that
> > rarely actually happen in practice, are the costs worth the benefits?
> > And who is bearing the costs, and who is receiving the benefits?
> 
> I personally believe that there's potential that this can be helpful and we
> will want to merge it.
> 
> But, what I believe Ted is trying to say is, if you do not know if the
> report is a bug or not, please do not ask the maintainers to determine it
> for you. This is a good opportunity for you to look to see why your tool
> reported an issue, and learn that subsystem. Look at if this is really a
> bug or not, and investigate why.

I agree with Steven here, to the point where I'm willing to invest some
time being a beta-tester for this, so if you focus your efforts on
filesystem/mm kinds of problems, I can continue looking at them and
tell you what's helpful and what's unhelpful in the reports.
