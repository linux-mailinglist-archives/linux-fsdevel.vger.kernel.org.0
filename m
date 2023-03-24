Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0176C7F05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 14:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjCXNnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 09:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjCXNnc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:43:32 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2054C11;
        Fri, 24 Mar 2023 06:43:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E40C5C0102;
        Fri, 24 Mar 2023 09:43:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 24 Mar 2023 09:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679665399; x=1679751799; bh=9s
        FuysrRgtAWhnFubN7BKB3n7WSqgiV+U9Y1poJMXZk=; b=EO4otnn8OVCRDKBEPp
        nfLYUkoiVNfgaF6LAT/kwv2Hahmrclsw7Gkf2sAcok4mZ/Ek2ptD4ecDhs7uglyf
        s0Bw5QCmxRoooVqFCjYgqTEriMT22Kw1WWsqImDWML8bfWkDVY7dixAREgilrOo5
        gyN+FZmsakb6Owe4Ijj7r5PiuGLs7NlIT3tj0IwfycA7TeVjZAePxqGKVI6esF87
        /alVDPkm8iERn9+frjcBHF1sHOMQ0iMwDaue7IDVmlNwqm6OEidVxcStY4lUubJG
        ORSPRhadFrOgiCQkO94I/Jt2Pa1dkSK0v+D5Z2u20mBbO6lv3bYwHR0Se1Gef/3r
        4NqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679665399; x=1679751799; bh=9sFuysrRgtAWh
        nFubN7BKB3n7WSqgiV+U9Y1poJMXZk=; b=angCG0f/A6HKFstiCVbGHDiG1S0zl
        XX58P99xDP4tpZDZY59CpIcEQKSDhTnlZR38iLryrn+/YkAS06cK3ZdVpexcT6x4
        SF1M2Tw4YEuWH0yR2g4g5MNIJqCKe/+7nBTcKm6aPBeMSMkicG6BrD8LairCdR8b
        IdKd6Po+iXF3tnE2M3wtPSH5BQB3eMqUvtYaKel+EFf4HYkYPZPiTOFc9km49Tz8
        DYp9qMGga3C/2yFNIUDk98iRweFwS5iwqENzgh/WQ1Lyp52FWIH/IaiMcrKl9ZZR
        iLLHLyFWWjrBPw0dYD33rhSP/9tPPnAP8DHA8UcCKl+EaVmy4RQnL8j/w==
X-ME-Sender: <xms:9qgdZPpTRYBjPGSNwnW2vBm7GLgz88fkSgWSgvIlnVVKPX_vMXwT3g>
    <xme:9qgdZJp5ZWWkd8frqj3xaEo1GE2ZEWXLYRszpaw2h_p174iZAMw0ruk9zGwfoPKls
    6BeWANgqvrS65244gY>
X-ME-Received: <xmr:9qgdZMN6zfSM_IXnMjLNO5Dl9lO9N1aenoLGFF8NQK8pt3eTH_jTdsGy1yMs0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepleevudetgefhheekueekhfduffethfehteeftdfhvefgteelvedvudev
    teeufeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:9qgdZC7jb2KZTh476gKhL2qVluCT-BOz0-B6wOFfPWJd8QKLe7_6LA>
    <xmx:9qgdZO7Sav6XP40qw-YZczurpPIQBySUIzl7bdSB9TPOD2tR5esF6Q>
    <xmx:9qgdZKg_TKWVE6Qg-k9aOIzbxeglSyRI8W7lclkYwMVUvl3b8xDPog>
    <xmx:96gdZFae6FUAp45RgqZ6Ry7q7MqfZ-2rvMHJpOY_K_Zb4KIqvjsK_A>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 09:43:16 -0400 (EDT)
Date:   Fri, 24 Mar 2023 07:43:13 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Christian Brauner <brauner@kernel.org>
Cc:     aloktiagi <aloktiagi@gmail.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David.Laight@aculab.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, hch@infradead.org
Subject: Re: [RFC v4 2/2] file, epoll: Implement do_replace() and
 eventpoll_replace()
Message-ID: <ZB2o8cs+VTQlz5GA@tycho.pizza>
References: <20230324063422.1031181-2-aloktiagi@gmail.com>
 <ZBzRfDnHaEycE72s@ip-172-31-38-16.us-west-2.compute.internal>
 <20230324082344.xgze2vu3ds2kubcz@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324082344.xgze2vu3ds2kubcz@wittgenstein>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:23:44AM +0100, Christian Brauner wrote:
> On Thu, Mar 23, 2023 at 10:23:56PM +0000, Alok Tiagi wrote:
> > On Mon, Mar 20, 2023 at 03:51:03PM +0100, Christian Brauner wrote:
> > > On Sat, Mar 18, 2023 at 06:02:48AM +0000, aloktiagi wrote:
> > > > Introduce a mechanism to replace a file linked in the epoll interface or a file
> > > > that has been dup'ed by a file received via the replace_fd() interface.
> > > > 
> > > > eventpoll_replace() is called from do_replace() and finds all instances of the
> > > > file to be replaced and replaces them with the new file.
> > > > 
> > > > do_replace() also replaces the file in the file descriptor table for all fd
> > > > numbers referencing it with the new file.
> > > > 
> > > > We have a use case where multiple IPv6 only network namespaces can use a single
> > > > IPv4 network namespace for IPv4 only egress connectivity by switching their
> > > > sockets from IPv6 to IPv4 network namespace. This allows for migration of
> > > > systems to IPv6 only while keeping their connectivity to IPv4 only destinations
> > > > intact.
> > > > 
> > > > Today, we achieve this by setting up seccomp filter to intercept network system
> > > > calls like connect() from a container in a container manager which runs in an
> > > > IPv4 only network namespace. The container manager creates a new IPv4 connection
> > > > and injects the new file descriptor through SECCOMP_NOTIFY_IOCTL_ADDFD replacing
> > > > the original file descriptor from the connect() call. This does not work for
> > > > cases where the original file descriptor is handed off to a system like epoll
> > > > before the connect() call. After a new file descriptor is injected the original
> > > > file descriptor being referenced by the epoll fd is not longer valid leading to
> > > > failures. As a workaround the container manager when intercepting connect()
> > > > loops through all open socket file descriptors to check if they are referencing
> > > > the socket attempting the connect() and replace the reference with the to be
> > > > injected file descriptor. This workaround is cumbersome and makes the solution
> > > > prone to similar yet to be discovered issues.
> > > > 
> > > > The above change will enable us remove the workaround in the container manager
> > > > and let the kernel handle the replacement correctly.
> > > > 
> > > > Signed-off-by: aloktiagi <aloktiagi@gmail.com>
> > > > ---
> > > >  fs/eventpoll.c                                | 38 ++++++++
> > > >  fs/file.c                                     | 54 +++++++++++
> > > >  include/linux/eventpoll.h                     | 18 ++++
> > > >  include/linux/file.h                          |  1 +
> > > >  tools/testing/selftests/seccomp/seccomp_bpf.c | 97 +++++++++++++++++++
> > > >  5 files changed, 208 insertions(+)
> > > > 
> > > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > > index 64659b110973..958ad995fd45 100644
> > > > --- a/fs/eventpoll.c
> > > > +++ b/fs/eventpoll.c
> > > > @@ -935,6 +935,44 @@ void eventpoll_release_file(struct file *file)
> > > >  	mutex_unlock(&epmutex);
> > > >  }
> > > >  
> > > > +static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
> > > > +			struct file *tfile, int fd, int full_check);
> > > > +
> > > > +/*
> > > > + * This is called from eventpoll_replace() to replace a linked file in the epoll
> > > > + * interface with a new file received from another process. This is useful in
> > > > + * cases where a process is trying to install a new file for an existing one
> > > > + * that is linked in the epoll interface
> > > > + */
> > > > +void eventpoll_replace_file(struct file *toreplace, struct file *file)
> > > > +{
> > > > +	int fd;
> > > > +	struct eventpoll *ep;
> > > > +	struct epitem *epi;
> > > > +	struct hlist_node *next;
> > > > +	struct epoll_event event;
> > > > +
> > > > +	if (!file_can_poll(file))
> > > > +		return;
> > > > +
> > > > +	mutex_lock(&epmutex);
> > > > +	if (unlikely(!toreplace->f_ep)) {
> > > > +		mutex_unlock(&epmutex);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	hlist_for_each_entry_safe(epi, next, toreplace->f_ep, fllink) {
> > > > +		ep = epi->ep;
> > > > +		mutex_lock(&ep->mtx);
> > > > +		fd = epi->ffd.fd;
> > > > +		event = epi->event;
> > > > +		ep_remove(ep, epi);
> > > > +		ep_insert(ep, &event, file, fd, 1);
> > > 
> > > So, ep_remove() can't fail but ep_insert() can. Maybe that doesn't
> > > matter...
> > > 
> > > > +		mutex_unlock(&ep->mtx);
> > > > +	}
> > > > +	mutex_unlock(&epmutex);
> > > > +}
> > > 
> > > Andrew carries a patchset that may impact the locking here:
> > > 
> > > https://lore.kernel.org/linux-fsdevel/323de732635cc3513c1837c6cbb98f012174f994.1678312201.git.pabeni@redhat.com
> > > 
> > > I have to say that this whole thing has a very unpleasant taste to it.
> > > Replacing a single fd from seccomp is fine, wading through the fdtable
> > > to replace all fds referencing the same file is pretty nasty. Especially
> > > with the global epoll mutex involved in all of this.
> > > 
> > > And what limits this to epoll. I'm seriously asking aren't there
> > > potentially issues for fds somehow referenced in io_uring instances as
> > > well?
> > > 
> > > I'm not convinced this belongs here yet...
> > 
> > Thank you for reviewing and proving a link to Andrew's patch.
> > 
> > I think just replacing a single fd from seccomp leaves this feature in an
> > incomplete state. As a user of this feature, it means I need to figure out what
> > all file descriptors are referencing this file eg. epoll, dup'ed fds etc. This
> > patch is an attempt to complete this seccomp feature and also move the logic of
> > figuring out the references to the kernel.
> 
> I'm still not convinced.
> 
> You're changing the semantics of the replace file feature in seccomp
> drastically. Whereas now it means replace the file a single fd refers to
> you're now letting it replace multiple fds.

Yes; the crux of the patch is really the epoll part, not the multiple
replace part. IMO, we should drop the multiple replace bit, as I agree
it is a pretty big change.

The change in semantics w.r.t. epoll() (and eventually others),
though, is important. The way it currently works is not really
helpful.

Perhaps we could add a flag that people could set from SECCOMP_ADDFD
asking for this extra behavior?

> > 
> > The epmutex is taken when the file is replaced in the epoll interface. This is
> > similar to what would happen when eventpoll_release would be called for this
> > same file when it is ultimately released from __fput().
> > 
> > This is indeed not limited to epoll and the file descriptor table, but this
> > current patch addresses is limited to these interfaces. We can create a separate
> > one for io_uring.
> 
> The criteria for when it's sensible to update an fd to refer to the new
> file and when not are murky here and tailored to this very specific
> use-case. We shouldn't be involved in decisions like that. Userspace is
> in a much better position to know when it's sensible to replace an fd.
> 
> The fdtable is no place to get involved in a game of "if the fd is in a
> epoll instance, update the epoll instance, if it's in an io_uring
> instance, update the io_uring instance, ...". That's a complete
> layerying violation imho.
> 
> And even if you'd need to get sign off on this from epoll and io_uring
> folks as well before we can just reach into other subsytems from the
> fdtable.

Yep, agreed.

> I'm sorry but this all sounds messy. You can do this just fine in
> userspace, so please do it in userspace. This all sound very NAKable
> right now.

We have added lots of APIs for things that are possible from userspace
already that are made easier with a nice API. The seccomp forwarding
functionality itself, pidfd_getfd(), etc. I don't see this particular
bit as a strong argument against.

Tycho
