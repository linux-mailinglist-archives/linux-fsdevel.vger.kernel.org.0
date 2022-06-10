Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6A5459B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 03:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbiFJBxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 21:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbiFJBxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42289220E10
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 18:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654825989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmmaPFipZtWgGS15GnP0nxoz6LYFbNPObNJ/8AvuP4c=;
        b=fhyDQW3QtNaw6tPZseT+PgBZZy5kytoensW7d8/a/ImBhWzcq+HmpQnNhuw8XWQLWqHwJq
        Zi0wAYia8Xrb6MoWm5q/SdFZrcwCV5sj4TPhzh9PO/ZQv+LKy77OF6H0boUefxluznbBU0
        uRBAr7Y/fedyH/RJ3KGqqbidbjvhZYs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-riay9_iON9CozCfn_JatVA-1; Thu, 09 Jun 2022 21:53:05 -0400
X-MC-Unique: riay9_iON9CozCfn_JatVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 317E11C0518D;
        Fri, 10 Jun 2022 01:53:05 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D39D91415100;
        Fri, 10 Jun 2022 01:52:59 +0000 (UTC)
Date:   Fri, 10 Jun 2022 09:52:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <YqKj9UqPjbYqnSii@T590>
References: <YhXMu/GcceyDx637@B-P7TQMD6M-0146.local>
 <a55211a1-a610-3d86-e21a-98751f20f21e@opensource.wdc.com>
 <YhXsQdkOpBY2nmFG@B-P7TQMD6M-0146.local>
 <3702afe7-2918-42e7-110b-efa75c0b58e8@opensource.wdc.com>
 <YhbYOeMUv5+U1XdQ@B-P7TQMD6M-0146.local>
 <YqFUc8jhYp5ijS/C@T590>
 <YqFashbvU+v5lGZy@B-P7TQMD6M-0146.local>
 <YqFx2GGACopPmLaM@T590>
 <YqF9X0sJjeCxwxBb@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqF9X0sJjeCxwxBb@B-P7TQMD6M-0146.local>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:55:59PM +0800, Gao Xiang wrote:
> On Thu, Jun 09, 2022 at 12:06:48PM +0800, Ming Lei wrote:
> > On Thu, Jun 09, 2022 at 10:28:02AM +0800, Gao Xiang wrote:
> > > On Thu, Jun 09, 2022 at 10:01:23AM +0800, Ming Lei wrote:
> > > > On Thu, Feb 24, 2022 at 08:58:33AM +0800, Gao Xiang wrote:
> > > > > On Thu, Feb 24, 2022 at 07:40:47AM +0900, Damien Le Moal wrote:
> > > > > > On 2/23/22 17:11, Gao Xiang wrote:
> > > > > > > On Wed, Feb 23, 2022 at 04:46:41PM +0900, Damien Le Moal wrote:
> > > > > > >> On 2/23/22 14:57, Gao Xiang wrote:
> > > > > > >>> On Mon, Feb 21, 2022 at 02:59:48PM -0500, Gabriel Krisman Bertazi wrote:
> > > > > > >>>> I'd like to discuss an interface to implement user space block devices,
> > > > > > >>>> while avoiding local network NBD solutions.  There has been reiterated
> > > > > > >>>> interest in the topic, both from researchers [1] and from the community,
> > > > > > >>>> including a proposed session in LSFMM2018 [2] (though I don't think it
> > > > > > >>>> happened).
> > > > > > >>>>
> > > > > > >>>> I've been working on top of the Google iblock implementation to find
> > > > > > >>>> something upstreamable and would like to present my design and gather
> > > > > > >>>> feedback on some points, in particular zero-copy and overall user space
> > > > > > >>>> interface.
> > > > > > >>>>
> > > > > > >>>> The design I'm pending towards uses special fds opened by the driver to
> > > > > > >>>> transfer data to/from the block driver, preferably through direct
> > > > > > >>>> splicing as much as possible, to keep data only in kernel space.  This
> > > > > > >>>> is because, in my use case, the driver usually only manipulates
> > > > > > >>>> metadata, while data is forwarded directly through the network, or
> > > > > > >>>> similar. It would be neat if we can leverage the existing
> > > > > > >>>> splice/copy_file_range syscalls such that we don't ever need to bring
> > > > > > >>>> disk data to user space, if we can avoid it.  I've also experimented
> > > > > > >>>> with regular pipes, But I found no way around keeping a lot of pipes
> > > > > > >>>> opened, one for each possible command 'slot'.
> > > > > > >>>>
> > > > > > >>>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
> > > > > > >>>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
> > > > > > >>>
> > > > > > >>> I'm interested in this general topic too. One of our use cases is
> > > > > > >>> that we need to process network data in some degree since many
> > > > > > >>> protocols are application layer protocols so it seems more reasonable
> > > > > > >>> to process such protocols in userspace. And another difference is that
> > > > > > >>> we may have thousands of devices in a machine since we'd better to run
> > > > > > >>> containers as many as possible so the block device solution seems
> > > > > > >>> suboptimal to us. Yet I'm still interested in this topic to get more
> > > > > > >>> ideas.
> > > > > > >>>
> > > > > > >>> Btw, As for general userspace block device solutions, IMHO, there could
> > > > > > >>> be some deadlock issues out of direct reclaim, writeback, and userspace
> > > > > > >>> implementation due to writeback user requests can be tripped back to
> > > > > > >>> the kernel side (even the dependency crosses threads). I think they are
> > > > > > >>> somewhat hard to fix with user block device solutions. For example,
> > > > > > >>> https://lore.kernel.org/r/CAM1OiDPxh0B1sXkyGCSTEpdgDd196-ftzLE-ocnM8Jd2F9w7AA@mail.gmail.com
> > > > > > >>
> > > > > > >> This is already fixed with prctl() support. See:
> > > > > > >>
> > > > > > >> https://lore.kernel.org/linux-fsdevel/20191112001900.9206-1-mchristi@redhat.com/
> > > > > > > 
> > > > > > > As I mentioned above, IMHO, we could add some per-task state to avoid
> > > > > > > the majority of such deadlock cases (also what I mentioned above), but
> > > > > > > there may still some potential dependency could happen between threads,
> > > > > > > such as using another kernel workqueue and waiting on it (in principle
> > > > > > > at least) since userspace program can call any syscall in principle (
> > > > > > > which doesn't like in-kernel drivers). So I think it can cause some
> > > > > > > risk due to generic userspace block device restriction, please kindly
> > > > > > > correct me if I'm wrong.
> > > > > > 
> > > > > > Not sure what you mean with all this. prctl() works per process/thread
> > > > > > and a context that has PR_SET_IO_FLUSHER set will have PF_MEMALLOC_NOIO
> > > > > > set. So for the case of a user block device driver, setting this means
> > > > > > that it cannot reenter itself during a memory allocation, regardless of
> > > > > > the system call it executes (FS etc): all memory allocations in any
> > > > > > syscall executed by the context will have GFP_NOIO.
> > > > > 
> > > > > I mean,
> > > > > 
> > > > > assuming PR_SET_IO_FLUSHER is already set on Thread A by using prctl,
> > > > > but since it can call any valid system call, therefore, after it
> > > > > received data due to direct reclaim and writeback, it is still
> > > > > allowed to call some system call which may do something as follows:
> > > > > 
> > > > >    Thread A (PR_SET_IO_FLUSHER)   Kernel thread B (another context)
> > > > > 
> > > > >    (call some syscall which)
> > > > > 
> > > > >    submit something to Thread B
> > > > >                                   
> > > > >                                   ... (do something)
> > > > > 
> > > > >                                   memory allocation with GFP_KERNEL (it
> > > > >                                   may trigger direct memory reclaim
> > > > >                                   again and reenter the original fs.)
> > > > > 
> > > > >                                   wake up Thread A
> > > > > 
> > > > >    wait Thread B to complete
> > > > > 
> > > > > Normally such system call won't cause any problem since userspace
> > > > > programs cannot be in a context out of writeback and direct reclaim.
> > > > > Yet I'm not sure if it works under userspace block driver
> > > > > writeback/direct reclaim cases.
> > > > 
> > > > Hi Gao Xiang,
> > > > 
> > > > I'd rather to reply you in this original thread, and the recent
> > > > discussion is from the following link:
> > > > 
> > > > https://lore.kernel.org/linux-block/Yp1jRw6kiUf5jCrW@B-P7TQMD6M-0146.local/
> > > > 
> > > > kernel loop & nbd is really in the same situation.
> > > > 
> > > > For example of kernel loop, PF_MEMALLOC_NOIO is added in commit
> > > > d0a255e795ab ("loop: set PF_MEMALLOC_NOIO for the worker thread"),
> > > > so loop's worker thread can be thought as the above Thread A, and
> > > > of course, writeback/swapout IO can reach the loop worker thread(
> > > > the above Thread A), then loop just calls into FS from the worker
> > > > thread for handling the loop IO, that is same with user space driver's
> > > > case, and the kernel 'thread B' should be in FS code.
> > > > 
> > > > Your theory might be true, but it does depend on FS's implementation,
> > > > and we don't see such report in reality.
> > > > 
> > > > Also you didn't mentioned that what kernel thread B exactly is? And what
> > > > the allocation is in kernel thread B.
> > > > 
> > > > If you have actual report, I am happy to take account into it, otherwise not
> > > > sure if it is worth of time/effort in thinking/addressing one pure theoretical
> > > > concern.
> > > 
> > > Hi Ming,
> > > 
> > > Thanks for your look & reply.
> > > 
> > > That is not a wild guess. That is a basic difference between
> > > in-kernel native block-based drivers and user-space block drivers.
> > 
> > Please look at my comment, wrt. your pure theoretical concern, userspace
> > block driver is same with kernel loop/nbd.
> 
> Hi Ming,
> 
> I don't have time to audit some potential risky system call, but I guess
> security folks or researchers may be interested in finding such path.

Why do you think system call has potential risk? Isn't syscall designed
for userspace? Any syscall called from the userspace context is covered
by PR_SET_IO_FLUSHER, and your concern is just in Kernel thread B,
right?

If yes, let's focus on this scenario, so I posted it one more time:

>    Thread A (PR_SET_IO_FLUSHER)   Kernel thread B (another context)
> 
>    (call some syscall which)
> 
>    submit something to Thread B
>                                   
>                                   ... (do something)
> 
>                                   memory allocation with GFP_KERNEL (it
>                                   may trigger direct memory reclaim
>                                   again and reenter the original fs.)
> 
>                                   wake up Thread A
> 
>    wait Thread B to complete

You didn't mention why normal writeback IO from other context won't call
into this kind of kernel thread B too, so can you explain it a bit?

As I said, both loop/nbd has same situation, for example of loop, thread
A is loop worker thread with PF_MEMALLOC_NOIO, and generic FS code(read,
write, fallocate, fsync, ...) is called into from the worker thread, so
there might be the so called kernel thread B for loop. But we don't see
such report.

Yeah, you may argue that other non-FS syscalls may be involved in
userspace driver. But in reality, userspace block driver should only deal
with FS and network IO most of times, and both network and FS code path
are already in normal IO code path for long time, so your direct claim
concern shouldn't be one problem. Not mention nbd/tcmu/... have been used
or long long time, so far so good. 

If you think it is real risk, please find it for nbd/tcmu/dm-multipath/...
first. IMO, it isn't useful to say there is such generic concern without
further investigation and without providing any detail, and devil is always
in details.

> 
> The big problem is, you cannot avoid people to write such system call (or 
> ioctls) in their user daemon, since most system call (or ioctls)
> implementation assumes that they're never called under the kernel memory
> direct reclaim context (even with PR_SET_IO_FLUSHER) but userspace block
> driver can give such context to userspace and user problems can do
> whatever they do in principle.
> 
> IOWs, we can audit in-kernel block drivers and fix all buggy paths with
> GFP_NOIO since the source code is already there and they should be fixed.
> 
> But you have no way to audit all user programs to call proper system calls
> or random ioctls which can be safely worked in the direct reclaim context
> (even with PR_SET_IO_FLUSHER).
> 
> > 
> > Did you see such report on loop & nbd? Can you answer my questions wrt.
> > kernel thread B?
> 
> I don't think it has some relationship with in-kernel loop device, since
> the loop device I/O paths are all under control.

No, it is completely same situation wrt. your concern, please look at the above
scenario.

> 
> > 
> > > 
> > > That is userspace block driver can call _any_ system call if they want.
> > > Since users can call any system call and any _new_ system call can be
> > > introduced later, you have to audit all system calls "Which are safe
> > > and which are _not_ safe" all the time. Otherwise, attacker can make
> > 
> > Isn't nbd server capable of calling any system call? Is there any
> > security risk for nbd?
> 
> Note that I wrote this email initially as a generic concern (prior to your
> ubd annoucement ), so that isn't related to your ubd from my POV.

OK, I guess I needn't to waste time on this 'generic concern'.

> 
> > 
> > > use of it to hung the system if such userspace driver is used widely.
> > 
> > >From the beginning, only ADMIN can create ubd, that is same with
> > nbd/loop, and it gets default permission as disk device.
> 
> loop device is different since the path can be totally controlled by the
> kernel.
> 
> > 
> > ubd is really in same situation with nbd wrt. security, the only difference
> > is just that nbd uses socket for communication, and ubd uses io_uring, that
> > is all.
> > 
> > Yeah, Stefan Hajnoczi and I discussed to make ubd as one container
> > block device, so normal user can create & use ubd, but it won't be done
> > from the beginning, and won't be enabled until the potential security
> > risks are addressed, and there should be more limits on ubd when normal user
> > can create & use it, such as:
> > 
> > - not allow unprivileged ubd device to be mounted
> > - not allow unprivileged ubd device's partition table to be read from
> >   kernel
> > - not support buffered io for unprivileged ubd device, and only direct io
> >   is allowed
> 
> How could you do that? I think it needs a wide modification to mm/fs.
> and how about mmap I/O?

Firstly mount isn't allowed, then we can deal with mmap on def_blk_fops, and
only allow open with O_DIRECT.

> 
> > - maybe more limit for minimizing security risk.
> > 
> > > 
> > > IOWs, in my humble opinion, that is quite a fundamental security
> > > concern of all userspace block drivers.
> > 
> > But nbd is still there and widely used, and there are lots of people who
> > shows interest in userspace block device. Then think about who is wrong?
> > 
> > As one userspace block driver, it is normal to see some limits there,
> > but I don't agree that there is fundamental security issue.
> 
> That depends, if you think it's a real security issue that there could be
> a path reported to public to trigger that after it's widely used, that is
> fine.

But nbd/tcmu is widely used already...

> 
> > 
> > > 
> > > Actually, you cannot ignore block I/O requests if they actually push
> > 
> > Who wants to ignore block I/O? And why ignore it?
> 
> I don't know how to express that properly. Sorry for my bad English.
> 
> For example, userspace FS implementation can ignore any fs operations
> triggered under direct reclaim.
> 
> But if you runs a userspace block driver under a random fs, they will
> just send data & metadata I/O to your driver unconditionally. I think
> that is too late to avoid such deadlock.

What is the deadlock? Is that triggered with your kernel thread B deadlock?

> 
> > 
> > > into block layer, since that is too late if I/O actually is submitted
> > > by some FS. And you don't even know which type of such I/O is.
> > 
> > We do know the I/O type.
> 
> 1) you don't know meta or data I/O. I know there is a REQ_META, but
>    that is not a strict mark.
> 
> 2) even you know an I/O is under direct reclaim, how to deal with that?
>   just send to userspace unconditionally?

All block driver doesn't care REQ_META, why is it special for userspace
block driver?


Thanks,
Ming

