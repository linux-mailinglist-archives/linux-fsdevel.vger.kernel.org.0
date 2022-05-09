Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9751F27E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 03:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiEIBdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 21:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiEIBbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 21:31:42 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE4B013D33
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 18:23:38 -0700 (PDT)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 9 May 2022 10:23:37 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.127 with ESMTP; 9 May 2022 10:23:37 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Mon, 9 May 2022 10:22:02 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>, duyuyang@gmail.com,
        johannes.berg@intel.com, Tejun Heo <tj@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@lge.com, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, sj@kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, ngupta@vflare.org,
        linux-block <linux-block@vger.kernel.org>,
        paolo.valente@linaro.org, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        jack@suse.com, Jeff Layton <jlayton@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
Message-ID: <20220509012202.GB6047@X58A-UD3R>
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
 <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whnPePcffsNQM+YSHMGttLXvpf8LbBQ8P7HEdqFXaV7Lg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 04, 2022 at 11:17:02AM -0700, Linus Torvalds wrote:
> On Wed, May 4, 2022 at 1:19 AM Byungchul Park <byungchul.park@lge.com> wrote:
> >
> > Hi Linus and folks,
> >
> > I've been developing a tool for detecting deadlock possibilities by
> > tracking wait/event rather than lock(?) acquisition order to try to
> > cover all synchonization machanisms.
> 
> So what is the actual status of reports these days?

I'd like to mention one important thing here. Reportability would get
stronger if the more wait-event pairs get tagged everywhere DEPT can
work.

Everything e.g. HW-SW interface, any retry logic and so on can be a
wait-event pair if they work wait or event anyway. For example, polling
on an IO mapped read register and initiating the HW to go for the event
also can be a pair. Definitely those make DEPT more useful.

---

The way to use the APIs:

1. Define SDT(Simple Dependency Tracker)

   DEFINE_DEPT_SDT(my_hw_event); <- add this

2. Tag on the waits

   sdt_wait(&my_hw_event); <- add this
   ... retry logic until my hw work done ... <- the original code

3. Tag on the events

   sdt_event(&my_hw_event); <- add this
   run_my_hw(); <- the original code

---

These are all we should do. I believe DEPT would be a very useful tool
once all wait-event pairs get tagged by the developers in all subsystems
and device drivers.

	Byungchul

> Last time I looked at some reports, it gave a lot of false positives
> due to mis-understanding prepare_to_sleep().
> 
> For this all to make sense, it would need to not have false positives
> (or at least a very small number of them together with a way to sanely
> get rid of them), and also have a track record of finding things that
> lockdep doesn't.
> 
> Maybe such reports have been sent out with the current situation, and
> I haven't seen them.
> 
>                  Linus
