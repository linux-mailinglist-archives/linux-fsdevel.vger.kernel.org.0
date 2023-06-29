Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004537424E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 13:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjF2LSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 07:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjF2LSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B512703;
        Thu, 29 Jun 2023 04:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96AEE61522;
        Thu, 29 Jun 2023 11:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE0DC433C8;
        Thu, 29 Jun 2023 11:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688037497;
        bh=F6aQm3JGRbxp1vVmcdBNImvGLgBiTDukPCEtjAqZ/xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fP9q6HJkta54m3RQLSt2OCchKkQ50cCHHoPnfkFh3HXIRtvOBH4vXpeTbtc5Ua6jf
         6NplaOhs1ICiScViDJcTnnfwifj4zKwratwFZw7PofKVdofY/Ig7eywi0NV0KcpFA6
         aQwrieQYFiYp6WdqBA3kO8LfAPfkzkzd+cokjUFI8KeHi04Rt0Qr8l+MGQmxW0z3Gc
         +Yy+/f+Wh/MYPo3Q4V1uE4GLX8pWB6mOWZXTPQR/G6DGdU1dSJnYNBN/EHMOVYyuPo
         k0kqltc8QoJjz4m2CzMApK8iJ9lrURMQO0PH0qbEXHBMsusWsNIMZCeEwXRiFqDapX
         wQbWEbKr0vTuw==
Date:   Thu, 29 Jun 2023 13:18:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230629-fragen-dennoch-fb5265aaba23@brauner>
References: <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
 <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
 <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
 <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
 <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
 <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
 <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
 <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
 <ZJzXs6C8G2SL10vq@dread.disaster.area>
 <d6546c44-04db-cbca-1523-a914670a607f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6546c44-04db-cbca-1523-a914670a607f@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 07:33:18PM -0600, Jens Axboe wrote:
> On 6/28/23 7:00?PM, Dave Chinner wrote:
> > On Wed, Jun 28, 2023 at 07:50:18PM -0400, Kent Overstreet wrote:
> >> On Wed, Jun 28, 2023 at 05:14:09PM -0600, Jens Axboe wrote:
> >>> On 6/28/23 4:55?PM, Kent Overstreet wrote:
> >>>>> But it's not aio (or io_uring or whatever), it's simply the fact that
> >>>>> doing an fput() from an exiting task (for example) will end up being
> >>>>> done async. And hence waiting for task exits is NOT enough to ensure
> >>>>> that all file references have been released.
> >>>>>
> >>>>> Since there are a variety of other reasons why a mount may be pinned and
> >>>>> fail to umount, perhaps it's worth considering that changing this
> >>>>> behavior won't buy us that much. Especially since it's been around for
> >>>>> more than 10 years:
> >>>>
> >>>> Because it seems that before io_uring the race was quite a bit harder to
> >>>> hit - I only started seeing it when things started switching over to
> >>>> io_uring. generic/388 used to pass reliably for me (pre backpointers),
> >>>> now it doesn't.
> >>>
> >>> I literally just pasted a script that hits it in one second with aio. So
> >>> maybe generic/388 doesn't hit it as easily, but it's surely TRIVIAL to
> >>> hit with aio. As demonstrated. The io_uring is not hard to bring into
> >>> parity on that front, here's one I posted earlier today for 6.5:
> >>>
> >>> https://lore.kernel.org/io-uring/20230628170953.952923-4-axboe@kernel.dk/
> >>>
> >>> Doesn't change the fact that you can easily hit this with io_uring or
> >>> aio, and probably more things too (didn't look any further). Is it a
> >>> realistic thing outside of funky tests? Probably not really, or at least
> >>> if those guys hit it they'd probably have the work-around hack in place
> >>> in their script already.
> >>>
> >>> But the fact is that it's been around for a decade. It's somehow a lot
> >>> easier to hit with bcachefs than XFS, which may just be because the
> >>> former has a bunch of workers and this may be deferring the delayed fput
> >>> work more. Just hand waving.
> >>
> >> Not sure what you're arguing here...?
> >>
> >> We've had a long standing bug, it's recently become much easier to hit
> >> (for multiple reasons); we seem to be in agreement on all that. All I'm
> >> saying is that the existence of that bug previously is not reason to fix
> >> it now.
> > 
> > I agree with Kent here  - the kernel bug needs to be fixed
> > regardless of how long it has been around. Blaming the messenger
> > (userspace, fstests, etc) and saying it should work around a
> > spurious, unpredictable, undesirable and user-undebuggable kernel
> > behaviour is not an acceptible solution here...
> 
> Not sure why you both are putting words in my mouth, I've merely been
> arguing pros and cons and the impact of this. I even linked the io_uring
> addition for ensuring that side will work better once the deferred fput
> is sorted out. I didn't like the idea of fixing this through umount, and
> even outlined how it could be fixed properly by ensuring we flush
> per-task deferred puts on task exit.
> 
> Do I think it's a big issue? Not at all, because a) nobody has reported
> it until now, and b) it's kind of a stupid case. If we can fix it with

Agreed.

> minimal impact, should we? Yep. Particularly as the assumptions stated
> in the original commit I referenced were not even valid back then.

There seems to be a wild misconception here which frankly is very
concering. Afaik, it is absolutely not the case that an fput() from an
exiting task ends up in delayed_work(). But I'm happy to be convinced
otherwise.

But thinking about it for more than a second, it would mean that __every
single task__ that passes through do_exit() would punt all its files to
delayed_fput() for closing. __Every single task on the system__.

What sort of DOS vector do people think we built into the kernel's exit
path? Hundreds or thousands of systemd services can have thousands of
fds open and somehow we punt them all to delayed_fput() when they get
killed, shutdown, or exit?

do_exit()
-> io_uring_files_cancel() /* can register task work */
-> exit_files()            /* can register task work */
-> exit_task_work()
   -> task_work_run()      /* run queued task work and when done set &work_exited sentinel */

Only after exit_task_work() is called do we need to rely on
delayed_fput(). But all files in the tasks fd table will have already
been registered for cleaned up in exit_files() via task work if that
task does indeed hold the last reference.

Unless, we're in an interrupt context or we're dealing with a
PF_KTHREAD...

So, generic/388 calls fsstress. If aio and/or io_uring is present
fsstress will be linked against aio/io_uring and will execute these
codepaths in its default invocation.

Compile out the aio and io_uring support, register a kretprobe via
bpftrace and snoop on how many times delayed_fput() is called when the
test is run with however many threads you want: absolutely not a single
time. Every SIGKILLed task goes through do_exit(), exit_files(),
registers their fputs as task work and then calls exit_task_work(), runs
task work, then disables task work and finally dies peacefully.

Now compile in aio and io_uring support, register a kretprobe via
bpftrace and snoop on how many times delayed_fput() is called and see
frequent delayed_fput() calls for aio and less frequent delayed_fput()
calls for io_uring.

Taking aio as an example, if we SIGKILL the last userspace process with
the aio fd it will exit and at some point the kernel will hit exit_aio()
on last __mmput():

do_exit()
-> exit_mm()
   -> mmput() /* mm could be pinned by some crap somewhere */
      -> exit_aio()
-> io_uring_files_cancel() /* can use task work */
-> exit_files()            /* can use task work */
-> exit_task_work()	   /* no more task work after that */
   -> task_work_run()      /* run queued task work and only when done set &work_exited sentinel */

If there are any outstanding io requests that haven't been completed
then aio will cancel them and punt them onto the system work queue.
Which is, surprise, a PF_KTHREAD. So then delayed_fput() is hit.

io_uring hits this less frequently but it does punt work to a kthread
via io_fallback_tw() iirc if the current task is PF_EXITING and so uses
delayed_fput() in these scenarios.

So this is async io punting to a kthread for cleanup _explicitly_ that's
causing issues here and it is an async io problem.

Why is this racy? For this to become a problem delayed_fput() work
must've been registered plus the delayed_fput() being called from the
system workqueue must take longer than the task work by all of the other
exiting threads.

We give zero f***s about legacy aio - Heidi meme-style. Not a single
line of code in the VFS will be complicated because of this legacy
cruft that everyone hates with a passion. Ultimately it's even why we
ended up with the nice io_uring io_worker model.

And io_uring - Jens can correct me - can probably be improved to rely
task work even if the task is PF_EXITING as long as exit_task_work()
hasn't been called for that task which I reckon it hasn't. So probably
how io_uring cancels work in io_uring_files_cancel() needs to be tweaked
if that really is an issue.

But hard NAK on fiddling with umount for any of this. Umount has never
and will never give any guarantee that a superblock is gone when it
returns. Even if it succeeds and returns it doesn't mean that the
superblock has gone away and that the filesystem can be mounted again
fresh.

Bind mounts, mount namespaces, mount propagation, independent of someone
pinning files in a given mount or kthread based async io fput cleaning
make this completely meaningless. We can't guarantee that and we will
absolutely not get in the business of that in the umount code.

If this generic/388 test is to be reliable rn in the face of async io,
the synchronization method via fsnotify that allows you get notified
about superblock destruction should be used.
