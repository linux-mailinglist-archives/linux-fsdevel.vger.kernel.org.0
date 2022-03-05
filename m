Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F38B4CE564
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 15:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiCEO4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 09:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiCEO4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:56:52 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EA7039B83
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Mar 2022 06:56:00 -0800 (PST)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 5 Mar 2022 23:55:58 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 5 Mar 2022 23:55:58 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Sat, 5 Mar 2022 23:55:34 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report 2 in ext4 and journal based on v5.17-rc1
Message-ID: <20220305145534.GB31268@X58A-UD3R>
References: <YiAow5gi21zwUT54@mit.edu>
 <1646285013-3934-1-git-send-email-byungchul.park@lge.com>
 <YiDSabde88HJ/aTt@mit.edu>
 <20220304032002.GD6112@X58A-UD3R>
 <YiLbs9rszWXpHm/P@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiLbs9rszWXpHm/P@mit.edu>
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

On Fri, Mar 04, 2022 at 10:40:35PM -0500, Theodore Ts'o wrote:
> On Fri, Mar 04, 2022 at 12:20:02PM +0900, Byungchul Park wrote:
> > 
> > I found a point that the two wait channels don't lead a deadlock in
> > some cases thanks to Jan Kara. I will fix it so that Dept won't
> > complain it.
> 
> I sent my last (admittedly cranky) message before you sent this.  I'm
> glad you finally understood Jan's explanation.  I was trying to tell

Not finally. I've understood him whenever he tried to tell me something.

> you the same thing, but apparently I failed to communicate in a

I don't think so. Your point and Jan's point are different. All he has
said make sense. But yours does not.

> sufficiently clear manner.  In any case, what Jan described is a
> fundamental part of how wait queues work, and I'm kind of amazed that
> you were able to implement DEPT without understanding it.  (But maybe

Of course, it was possible because all that Dept has to know for basic
work is wait and event. The subtle things like what Jan told me help
Dept be better.

> that is why some of the DEPT reports were completely incomprehensible

It's because you are blinded to blame at it without understanding how
Dept works at all. I will fix those that must be fixed. Don't worry.

> to me; I couldn't interpret why in the world DEPT was saying there was
> a problem.)

I can tell you if you really want to understand why. But I can't if you
are like this.

> In any case, the thing I would ask is a little humility.  We regularly
> use lockdep, and we run a huge number of stress tests, throughout each
> development cycle.

Sure.

> So if DEPT is issuing lots of reports about apparently circular
> dependencies, please try to be open to the thought that the fault is

No one was convinced that Dept doesn't have a fault. I think your
worries are too much.

> in DEPT, and don't try to argue with maintainers that their code MUST
> be buggy --- but since you don't understand our code, and DEPT must be

No one argued that their code must be buggy, either. So I don't think
you have to worry about what's never happened.

> theoretically perfect, that it is up to the Maintainers to prove to
> you that their code is correct.
> 
> I am going to gently suggest that it is at least as likely, if not
> more likely, that the failure is in DEPT or your understanding of what

No doubt. I already think so. But it doesn't mean that I have to keep
quiet without discussing to imporve Dept. I will keep improving Dept in
a reasonable way.

> how kernel wait channels and locking works.  After all, why would it
> be that we haven't found these problems via our other QA practices?

Let's talk more once you understand how Dept works at least 10%. Or I
think we cannot talk in a productive way.

