Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AC84BC7B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 11:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbiBSKfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 05:35:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiBSKfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:35:30 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82F2A21FC75
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 02:35:08 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 19 Feb 2022 19:35:07 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 19 Feb 2022 19:35:07 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Sat, 19 Feb 2022 19:34:58 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
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
Message-ID: <20220219103458.GD10342@X58A-UD3R>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <Yg5u7dzUxL3Vkncg@mit.edu>
 <20220217120005.67f5ddf4@gandalf.local.home>
 <Yg8eQ/iR5H/AHZIg@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg8eQ/iR5H/AHZIg@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:19:15PM -0500, Theodore Ts'o wrote:
> On Thu, Feb 17, 2022 at 12:00:05PM -0500, Steven Rostedt wrote:
> > 
> > I personally believe that there's potential that this can be helpful and we
> > will want to merge it.
> > 
> > But, what I believe Ted is trying to say is, if you do not know if the
> > report is a bug or not, please do not ask the maintainers to determine it
> > for you. This is a good opportunity for you to look to see why your tool
> > reported an issue, and learn that subsystem. Look at if this is really a
> > bug or not, and investigate why.
> 
> I agree there's potential here, or I would have ignored the ext4 "bug
> report".

I just checked this one. Appreciate it...

> When we can get rid of the false positives, I think it should be

Of course, the false positives should be removed once it's found. I will
try my best to remove all of those on my own as much as possible.
However, thing is I can't see others than what I can see with my system.

> merged; I'd just rather it not be merged until after the false
> positives are fixed, since otherwise, someone well-meaning will start
> using it with Syzkaller, and noise that maintainers need to deal with
> (with people requesting reverts of two year old commits, etc) will
> increase by a factor of ten or more.  (With Syzbot reproducers that

Agree.

> set up random cgroups, IP tunnels with wiregaurd enabled, FUSE stress
> testers, etc., that file system maintainers will be asked to try to
> disentangle.)
> 
> So from a maintainer's perspective, false positives are highly
> negative.  It may be that from some people's POV, one bug found and 20
> false positive might still be "useful".  But if your tool gains a
> reputation of not valuing maintainers' time, it's just going to make
> us (or at least me :-) cranky, and it's going to be very hard to

Agree.

> recover from perception.  So it's probably better to be very
> conservative and careful in polishing it before asking for it to be
> merged.

If it's true that there are too many false positives like 95%, then I'll
fix those fist for sure before asking to merge it. Let's see if so.

To kernel developers,

It'd be appreciated if you'd let us know if you can see real ones than
false positives in the middle of developing something in the kernel so
it's useful. Otherwise, it's hard to measure how many false positives it
reports and how valuable it is and so on...

Thanks,
Byungchul
