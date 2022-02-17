Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE694BAD8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 00:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiBQXzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 18:55:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiBQXzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:55:33 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7BB033EA5
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 15:55:12 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 18 Feb 2022 08:55:11 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 18 Feb 2022 08:55:11 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 18 Feb 2022 08:55:04 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Jens Axboe <axboe@kernel.dk>, paolo.valente@linaro.org,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com
Subject: Re: Report in ata_scsi_port_error_handler()
Message-ID: <20220217235504.GB20620@X58A-UD3R>
References: <1644984747-26706-1-git-send-email-byungchul.park@lge.com>
 <1644984964-28300-1-git-send-email-byungchul.park@lge.com>
 <1644984964-28300-3-git-send-email-byungchul.park@lge.com>
 <94b1cba2-0e78-bbc0-0321-8be70b2b3be2@opensource.wdc.com>
 <CAHk-=wgfpfWuNQi2SjXQL1ir6iKCpUdBruJ+kmOQP1frH7Zdig@mail.gmail.com>
 <20220216133318.204f36ac@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216133318.204f36ac@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:33:18PM -0500, Steven Rostedt wrote:
> On Wed, 16 Feb 2022 10:09:14 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > Byungchul, could you fix those two issues? Some of your reports may
> > well be entirely valid, but the hard-to-read hex offsets and the
> > knowledge that at least some of them are confused about how
> > prepare_to_wait -> wait actually works makes the motivation to look at
> > the details much less..
> 
> Hi Byungchul,
> 
> I'm not sure what your tool is using to attach to the kernel to analyze the
> events (perhaps tracepoints?). But you can have the prepare_to_wait event
> just flag the task is about to wait, and then attach to the schedule
> (sched_switch) event to denote that it actually waited.
> 
> Of course have the finish_wait() clear the flag.

(Sorry for late reply, which was because of my email client issue.)

Thank you for the hint. However, unfortunately, I didn't use tracepoint
for that. However, the key idea is the thing that I should take!

Thanks a lot!

Thanks,
Byungchul

> 
> -- Steve
