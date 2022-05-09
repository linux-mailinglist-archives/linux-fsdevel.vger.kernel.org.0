Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFA552079E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 00:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiEIWc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 18:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiEIWcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 18:32:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D4A218FF1;
        Mon,  9 May 2022 15:28:29 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 249MSH8J011968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 18:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652135302; bh=PomMNNmWyc5YBypwEkVpIDxcMt6S+On8bnwlKnLl0F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=qTYb7bkM1f13CgzxxkHgcYUUpcdSEBUT/tf50JNLJU6fPsMDK8SQS+i92s1ti4Tyx
         iGRFTPavJ8h99X4QcJ0MwhYWhsXkPhTDRlGmwzn8rsbAT6j0ocGR+0IBGf/l3GeS9p
         LGPO99ypG2x1hYMGpqrIpEGraGGHFFaOH2O/u2mcZIe5Cthtyd8ZMw5zx+aBVHeUyS
         q1m/CT4ksHBOdjSUNJMk5ZmO3eaaCHwKpIPr+dHOgp2v+EZ3T7b866dCtzUxZEdDmc
         46n8znwTj37kjfLzCUBNC9Lu/FzPz5XH57jT/qwRwyVJwYbjXb4jLc48Dtq9Cx7vGI
         OMQGEtAlJ47LQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A4D2D15C3F0A; Mon,  9 May 2022 18:28:17 -0400 (EDT)
Date:   Mon, 9 May 2022 18:28:17 -0400
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
Message-ID: <YnmVgVQ7usoXnJ1N@mit.edu>
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
 <YnmCE2iwa0MSqocr@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnmCE2iwa0MSqocr@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oh, one other problem with DEPT --- it's SLOW --- the overhead is
enormous.  Using kvm-xfstests[1] running "kvm-xfstests smoke", here
are some sample times:

			LOCKDEP		DEPT
Time to first test	49 seconds	602 seconds
ext4/001      		2 s		22 s
ext4/003		2 s		8 s
ext4/005		0 s		7 s
ext4/020		1 s		8 s
ext4/021		11 s		17 s
ext4/023		0 s		83 s
generic/001		4 s		76 s
generic/002		0 s		11 s
generic/003		10 s		19 s

There are some large variations; in some cases, some xfstests take 10x
as much time or more to run.  In fact, when I first started the
kvm-xfstests run with DEPT, I thought something had hung and that
tests would never start.  (In fact, with gce-xfstests the default
watchdog "something has gone terribly wrong with the kexec" had fired,
and I didn't get any test results using gce-xfstests at all.  If DEPT
goes in without any optimizations, I'm going to have to adjust the
watchdogs timers for gce-xfstests.)

The bottom line is that at the moment, between the false positives,
and the significant overhead imposed by DEPT, I would suggest that if
DEPT ever does go in, that it should be possible to disable DEPT and
only use the existing CONFIG_PROVE_LOCKING version of LOCKDEP, just
because DEPT is S - L - O - W.

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

						- Ted

P.S.  Darrick and I both have disabled using LOCKDEP by default
because it slows down ext4 -g auto testing by a factor 2, and xfs -g
auto testing by a factor of 3.  So the fact that DEPT is a factor of
2x to 10x or more slower than LOCKDEP when running various xfstests
tests should be a real concern.

