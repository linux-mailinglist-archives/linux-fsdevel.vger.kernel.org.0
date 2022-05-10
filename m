Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC7A520CD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 06:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiEJEdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 00:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiEJEbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 00:31:42 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10867201305;
        Mon,  9 May 2022 21:27:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 72AF23200950;
        Tue, 10 May 2022 00:27:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 10 May 2022 00:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1652156840; x=
        1652243240; bh=VLsWJyEUbg/8yUBVhrHDqMU773zHuqBYYMQbxj0NaOo=; b=o
        V7gqoi+ehEUTdy8ZZYz5zncHlJ3l9M1p/oOgjHQoaRKZXN1uwPycOF5r9kzOw2KZ
        FRYn5EqYqPdpchvASgC/mSRHPUPg0LBVpuqsRtpMpTfm8qfZ1f5ksNSZZEyA7VB9
        xQ8KD9OESVVk8Z2Lohbr3YpExGYmqz/uINoM8ktrUnTW+7cvjuv5idMuova15JxA
        EqqeixS4eSZxIQJIfZ/vpWpVu+KrxQqNr0fX1OEGrcmZ40Io8gVobg7CiuTYoPrH
        rfl8NviSHB0Shkbhj5LV8wCXSK+QDgxr66qJbXNjZ8f415XVwgMkQ3KUvJCxGEGd
        IHmGMjJ8qcyVyDvPuIRUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652156840; x=1652243240; bh=VLsWJyEUbg/8y
        UBVhrHDqMU773zHuqBYYMQbxj0NaOo=; b=fCSx/1cUCCFmuBH/kO+KYeB/Acl0X
        SBbnBRAvVXjLUnvhS8i7ijN0tcwktpTWC1Vdqf0uwbDR9CHl6xisIh2ofI9RDoVF
        9FFtSI36X9x1MuN7s699uW2Kt1UxafTzxjA1LOwcztWUWJOYEYykAO9xwFI9ZZDS
        6yJ0Xb7rMCFCbfpXMHeQVrS0w6RJTeyZ0gToPkx0uu51HGDEx9Aev1jrpDtqDGxN
        T7aYesVlzdwXzllwWht7MyD4L7gscjdWepCIu5PSzAbwQ+A9lWhovTfP5HSb/Oc4
        bdQ+9NVZ3YNg0bETNs7nqv/a6xid9hLZraavC0Ojrhcq8906eGeCXLM7A==
X-ME-Sender: <xms:qOl5Yqcj1r23I3_rE_dB3jYvIsDcpuUupXzAe7fbNaDW2Wa701nNCg>
    <xme:qOl5YkNUHzC67NXDMBEaZtC5bp0kO0cJP2JWhY3jaMqdNS7fVFpKRft8WtdpNPVg7
    NemAwO7-I6v>
X-ME-Received: <xmr:qOl5YrhqL2LB8QJ82oMF6nKeFPSHojMr3wJXasFclQLYk2pXdSHohlF4XTWinsAcMf2q4uEWQEwactreklAzJGxE3_ce_Z201xJgDAeIn972Hqgvy-GD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfevffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eivdehhfehtdffjeehlefhheekudetteegueeuteetvdeuheeufeeuveduuedvudenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:qOl5Yn8slZ7gfKeILPaISn5mCOXMvbBHZuHwrOq11OLpogEYnxRlIA>
    <xmx:qOl5YmvQ1e7TQldTAXzNW6D_q2-Qh90AIoG8DEVbbvPswF1HHQacQg>
    <xmx:qOl5YuF71DehJYxFljPazxGlTBbuJIUrwHlPg2WAaVO8V40j1-4f7g>
    <xmx:qOl5YmEVmyG4GSl2J9Hpy7PejmHo7fUp8jGymNNJqSpgIHlpiJKxKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 May 2022 00:27:14 -0400 (EDT)
Message-ID: <8ab7f51cf18ba62e3f5bfdf5d9933895413f4806.camel@themaw.net>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Date:   Tue, 10 May 2022 12:27:10 +0800
In-Reply-To: <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
         <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
         <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-05-10 at 05:49 +0200, Miklos Szeredi wrote:
> On Mon, 9 May 2022 at 14:48, Christian Brauner <brauner@kernel.org>
> wrote:
> 
> > One comment about this. We really need to have this interface
> > support
> > giving us mount options like "relatime" back in numeric form (I
> > assume
> > this will be possible.). It is royally annoying having to maintain
> > a
> > mapping table in userspace just to do:
> > 
> > relatime -> MS_RELATIME/MOUNT_ATTR_RELATIME
> > ro       -> MS_RDONLY/MOUNT_ATTR_RDONLY
> > 
> > A library shouldn't be required to use this interface. Conservative
> > low-level software that keeps its shared library dependencies
> > minimal
> > will need to be able to use that interface without having to go to
> > an
> > external library that transforms text-based output to binary form
> > (Which
> > I'm very sure will need to happen if we go with a text-based
> > interface.).
> 
> Agreed.
> 
> >   This pattern of requesting the size first by passing empty
> > arguments,
> >   then allocating the buffer and then passing down that buffer to
> >   retrieve that value is really annoying to use and error prone (I
> > do
> >   of course understand why it exists.).
> > 
> >   For real xattrs it's not that bad because we can assume that
> > these
> >   values don't change often and so the race window between
> >   getxattr(GET_SIZE) and getxattr(GET_VALUES) often doesn't matter.
> > But
> >   fwiw, the post > pre check doesn't exist for no reason; we do
> > indeed
> >   hit that race.
> 
> That code is wrong.  Changing xattr size is explicitly documented in
> the man page as a non-error condition:
> 
>        If size is specified as zero, these calls return the  current 
> size  of
>        the  named extended attribute (and leave value unchanged). 
> This can be
>        used to determine the size of the buffer that should be
> supplied  in  a
>        subsequent  call.   (But, bear in mind that there is a
> possibility that
>        the attribute value may change between the two calls,  so 
> that  it  is
>        still necessary to check the return status from the second
> call.)
> 
> > 
> >   In addition, it is costly having to call getxattr() twice. Again,
> > for
> >   retrieving xattrs it often doesn't matter because it's not a
> > super
> >   common operation but for mount and other info it might matter.
> 
> You don't *have* to retrieve the size, it's perfectly valid to e.g.
> start with a fixed buffer size and double the size until the result
> fits.
> 
> > * Would it be possible to support binary output with this
> > interface?
> >   I really think users would love to have an interfact where they
> > can
> >   get a struct with binary info back.
> 
> I think that's bad taste.   fsinfo(2) had the same issue.  As well as
> mount(2) which still interprets the last argument as a binary blob in
> certain cases (nfs is one I know of).
> 
> >   Especially for some information at least. I'd really love to have
> > a
> >   way go get a struct mount_info or whatever back that gives me all
> > the
> >   details about a mount encompassed in a single struct.
> 
> If we want that, then can do a new syscall with that specific struct
> as an argument.
> 
> >   Callers like systemd will have to parse text and will end up
> >   converting everything from text into binary anyway; especially
> > for
> >   mount information. So giving them an option for this out of the
> > box
> >   would be quite good.
> 
> What exactly are the attributes that systemd requires?

It's been a while since I worked on this so my response might not
be too accurrate now.

Monitoring the mount table is used primarily to identify a mount
started and mount completion.

Mount table entry identification requires several fields.

But, in reality, once a direct interface is available it should be
possible to work out what is actually needed and that will be a
rather subset of a mountinfo table entry.

> 
> >   Interfaces like statx aim to be as fast as possible because we
> > exptect
> >   them to be called quite often. Retrieving mount info is quite
> > costly
> >   and is done quite often as well. Maybe not for all software but
> > for a
> >   lot of low-level software. Especially when starting services in
> >   systemd a lot of mount parsing happens similar when starting
> >   containers in runtimes.
> 
> Was there ever a test patch for systemd using fsinfo(2)?  I think
> not.

Mmm ... I'm hurt you didn't pay any attention to what I did on this
during the original fsinfo() discussions.

> 
> Until systemd people start to reengineer the mount handing to allow
> for retrieving a single mount instead of the complete mount table we
> will never know where the performance bottleneck lies.

We didn't need the systemd people to do this only review and contribute
to the pr for the change and eventually merge it.

What I did on this showed that using fsinfo() allone about halved the
CPU overhead (from around 4 processes using about 80%) and once the
mount notifications was added too it went down to well under 10% per
process. The problem here was systemd is quite good at servicing events
and reducing event processing overhead meant more events would then be
processed. Utilizing the mount notifications queueing was the key to
improving this and that was what I was about to work on at the end.

But everything stopped before the work was complete.

As I said above it's been a long time since I looked at the systemd
work and it definitely was a WIP so "what you see is what you get"
at https://github.com/raven-au/systemd/commits/. It looks like the
place to look to get some idea of what was being done is branch
notifications-devel or notifications-rfc-pr. Also note that this
uses the libmount fsinfo() infrastrucure that was done by Karal Zak
(and a tiny bit by me) at the time.

> 
> > 
> > * If we decide to go forward with this interface - and I think I
> >   mentioned this in the lsfmm session - could we please at least
> > add a
> >   new system call? It really feels wrong to retrieve mount and
> > other
> >   information through the xattr interfaces. They aren't really
> > xattrs.
> 
> I'd argue with that statement.  These are most definitely attributes.
> As for being extended, we'd just extended the xattr interface...
> 
> Naming aside... imagine that read(2) has always been used to retrieve
> disk data, would you say that reading data from proc feels wrong?
> And in hindsight, would a new syscall for the purpose make any sense?
> 
> Thanks,
> Miklos

