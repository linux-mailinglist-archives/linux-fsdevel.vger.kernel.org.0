Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50A4520AB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 03:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiEJBgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 21:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiEJBgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 21:36:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B369286FCE;
        Mon,  9 May 2022 18:32:22 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24A1WFPx029254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 21:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652146337; bh=kNxC32quScbCpNyL/wTfsRZfYUcVDoGEmAnwF+CO/RI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QxJmGfW7e1IqMYLGQvzKg6+7ZkT0OwGyjZIbR34a/I8eBprlhA99gR0O0BEp3S9Ri
         QSxzKJONeuCwz07zjjnp7xXUyxbrw2mbXLk0OH60YANQzrSVgVJF5eD+RBMAgsUUWA
         T4G0Ty0kWJ5uuh0PXPt33QGdcwH53U3XMtVJjXWc8ULr3+AvIz6Pgz0xZXQIBzluR2
         CIrOokyPfzdv2U5lw9a5ZDaB9QcvNSQAyRc/2bz9cP7uvQJlW99OnxvoL7KA5YnM+l
         HDoK6memNQg7ocJ1IS4F2j1RZyXyb9B99SqHCgp+0Poku2gzFpHznTQ3ugVllQKfHb
         ErvwvUo9JMGBw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5B4DC15C3F0A; Mon,  9 May 2022 21:32:15 -0400 (EDT)
Date:   Mon, 9 May 2022 21:32:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
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
        hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
Message-ID: <YnnAnzPFZZte/UR8@mit.edu>
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
 <YnmCE2iwa0MSqocr@mit.edu>
 <YnmVgVQ7usoXnJ1N@mit.edu>
 <20220510003213.GD6047@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510003213.GD6047@X58A-UD3R>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 09:32:13AM +0900, Byungchul Park wrote:
> Yes, right. DEPT has never been optimized. It rather turns on
> CONFIG_LOCKDEP and even CONFIG_PROVE_LOCKING when CONFIG_DEPT gets on
> because of porting issue. I have no choice but to rely on those to
> develop DEPT out of tree. Of course, that's what I don't like.

Sure, but blaming the overhead on unnecessary CONFIG_PROVE_LOCKING
overhead can explain only a tiny fraction of the slowdown.  Consider:
if time to first test (time to boot the kernel, setup the test
environment, figure out which tests to run, etc.) is 12 seconds w/o
LOCKDEP, 49 seconds with LOCKDEP/PROVE_LOCKING and 602 seconds with
DEPT, you can really only blame 37 seconds out of the 602 seconds of
DEPT on unnecessary PROVE_LOCKING overhead.

So let's assume we can get rid of all of the PROVE_LOCKING overhead.
We're still talking about 12 seconds for time-to-first test without
any lock debugging, versus ** 565 ** seconds for time-to-first test
with DEPT.  That's a factor of 47x for DEPT sans LOCKDEP overhead,
compared to a 4x overhead for PROVE_LOCKING.

> Plus, for now, I'm focusing on removing false positives. Once it's
> considered settled down, I will work on performance optimizaition. But
> it should still keep relying on Lockdep CONFIGs and adding additional
> overhead on it until DEPT can be developed in the tree.

Well, please take a look at the false positive which I reported.  I
suspect that in order to fix that particular false positive, we'll
either need to have a way to disable DEPT on waiting on all page/folio
dirty bits, or it will need to treat pages from different inodes
and/or address spaces as being entirely separate classes, instead of
collapsing all inode dirty bits, and all of various inode's mutexes
(such as ext4's i_data_sem) as being part of a single object class.

> DEPT is tracking way more objects than Lockdep so it's inevitable to be
> slower, but let me try to make it have the similar performance to
> Lockdep.

In order to eliminate some of these false positives, I suspect it's
going to increase the number of object classes that DEPT will need to
track even *more*.  At which point, the cost/benefit of DEPT may get
called into question, especially if all of the false positives can't
be suppressed.

					- Ted
