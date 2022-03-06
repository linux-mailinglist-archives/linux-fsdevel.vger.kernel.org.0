Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB624CEBDC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 15:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiCFOUN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 09:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiCFOUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 09:20:11 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821D038DAF;
        Sun,  6 Mar 2022 06:19:12 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 226EJA3E008889
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Mar 2022 09:19:10 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3595415C0038; Sun,  6 Mar 2022 09:19:10 -0500 (EST)
Date:   Sun, 6 Mar 2022 09:19:10 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Byungchul Park <byungchul.park@lge.com>
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
Message-ID: <YiTC3j6Igkw7xvIM@mit.edu>
References: <YiQq6Ou39uzHC0mu@mit.edu>
 <1646563902-6671-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646563902-6671-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 06, 2022 at 07:51:42PM +0900, Byungchul Park wrote:
> > 
> > Users of DEPT must not have to understand how DEPT works in order to
> 
> Users must not have to understand how Dept works for sure, and haters
> must not blame things based on what they guess wrong.

For the record, I don't hate DEPT.  I *fear* that DEPT will result in
my getting spammed with a huge number of false posiives once automated
testing systems like Syzkaller, zero-day test robot, etcs., get a hold
of it once it gets merged and start generating hundreds of automated
reports.

And when I tried to read the DEPT reports, and the DEPT documentation,
and I found that its explanation for why ext4 had a circular
dependency simply did not make sense.  If my struggles to understand
why DEPT was issuing a false positive is "guessing", then how do we
have discussions over how to make DEPT better?

> > called prepare-to-wait on more than one wait queue, how is DEPT going
> > to distinguish between your "morally correct" wkaeup source, and the
> > "rescue wakeup source"?
> 
> Sure, it should be done manually. I should do it on my own when that
> kind of issue arises.

The question here is how often will it need to be done, and how easy
will it be to "do it manually"?  Suppose we mark all of the DEPT false
positives before it gets merged?  How easy will it be able to suppress
future false positives in the future, as the kernel evolves?

Perhaps one method is to haved a way to take a particular wait queue,
or call to schedule(), or at the level of an entire kernel source
file, and opt it out from DEPT analysis?  That way, if DEPT gets
merged, and a maintainer starts getting spammed by bogus (or
incomprehensible) reports, there is a simople way they can annotate
their source code to prevent DEPT from analyzing code that it is
apparently not able to understand correctly.

That way we don't necessarily need to have a debate over how close to
zero percent false positives is necessary before DEPT can get merged.
And we avoid needing to force maintainers to prove that a DEPT report
is a false positive, which is from my experience hard to do, since
they get accused of being DEPT haters and not understanding DEPT.

	  	   	      	    	    	     - Ted
