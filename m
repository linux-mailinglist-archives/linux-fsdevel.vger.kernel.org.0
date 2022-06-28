Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E704355E691
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346477AbiF1OZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 10:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346462AbiF1OZp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6C32ED4A;
        Tue, 28 Jun 2022 07:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1834861AC3;
        Tue, 28 Jun 2022 14:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924F6C3411D;
        Tue, 28 Jun 2022 14:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656426343;
        bh=PPmIO7bVD772RsqbALQ+Qzk8RnGwdN0o1RpHsA5N7XM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDV/hg/pM6W4wG0fg5LgoE5btUfn/mKTtstwExulR+nlXB3uPOjK0AtuoDcPhGpgW
         jH6j8IFR6HoRLM7BI6dxLXDNihq7gPjsnKvrLRD+jnCWFMbSe9S9wUPi4tshI+aprD
         PAEWiXbjWN2ZIzfb1q91hALqWfeuDdgs5x6wHzTPFBQQj/eiwCVm3mdkChKY8Mcw4j
         5T8LKhwn2kcZVYoIiOc414g7XWGMqAU8TXqmJnuTtdYwp/+gpsNVfz2FkonAETtDNF
         /EhY0cbvGsSlPHgY6O5Jrn+I8VHRjeLYe2OrNM/9bSZsQw1sX0YlDVYL4ra7qanm3p
         gNpvZHmNG/DRw==
Date:   Tue, 28 Jun 2022 16:25:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, guowei du <duguoweisz@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duguowei <duguowei@xiaomi.com>
Subject: Re: [PATCH 6/6] fanotify: add current_user_instances node
Message-ID: <20220628142532.rinam6psfflxkimv@wittgenstein>
References: <20220628101413.10432-1-duguoweisz@gmail.com>
 <20220628104528.no4jarh2ihm5gxau@quack3>
 <20220628104853.c3gcsvabqv2zzckd@wittgenstein>
 <CAC+1NxtAfbKOcW1hykyygScJgN7DsPKxLeuqNNZXLqekHgsG=Q@mail.gmail.com>
 <CAOQ4uxgtZDihnydqZ04wjm2XCYjui0nnkO0VGzyq-+ERW20pJw@mail.gmail.com>
 <20220628125617.pljcpsr2xkzrrpxr@quack3>
 <CAOQ4uxjbKgEoRM4DXBq0T3-jP96FCHjUY0PLsqVE0_s-hS3xLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjbKgEoRM4DXBq0T3-jP96FCHjUY0PLsqVE0_s-hS3xLg@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:55:25PM +0300, Amir Goldstein wrote:
> On Tue, Jun 28, 2022 at 3:56 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 28-06-22 15:29:08, Amir Goldstein wrote:
> > > On Tue, Jun 28, 2022 at 2:50 PM guowei du <duguoweisz@gmail.com> wrote:
> > > >
> > > > hi, Mr Kara, Mr Brauner,
> > > >
> > > > I want to know how many fanotify readers are monitoring the fs event.
> > > > If userspace daemons monitoring all file system events are too many, maybe there will be an impact on performance.
> > >
> > > I want something else which is more than just the number of groups.
> > >
> > > I want to provide the admin the option to enumerate over all groups and
> > > list their marks and blocked events.
> >
> > Listing all groups and marks makes sense to me. Often enough I was
> > extracting this information from a crashdump :).
> >
> > Dumping of events may be a bit more challenging (especially as we'd need to
> > format the events which has some non-trivial implications) so I'm not 100%
> > convinced about that. I agree it might be useful but I'd have to see the
> > implementation...
> >
> 
> I don't really care about the events.
> I would like to list the tasks that are blocked on permission events
> and the fanotify reader process that blocks them, so that it could be killed.
> 
> Technically, it is enough to list the blocked task pids in fanotify_fdinfo().
> But it is also low hanging to print the number of queued events
> in fanotify_fdinfo() and inotify_fdinfo().

That's always going to be racy, right? You might list the blocked tasks
but it's impossible for userspace to ensure that the pids it parses
still refer to the same processes by the time it tries to kill them.

You would need an interface that allows you to kill specific blocked
tasks or at least all blocked tasks. You could just make this an - ahem
- ioctl on a suitable fanotify fd and somehow ensure that the task is
actually the one you want to kill?

If you can avoid adding a whole new /sys/kernel/fanotify/ interface
that'd be quite nice for userspace, I think.
