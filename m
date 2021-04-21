Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDACE3668F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbhDUKNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 06:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbhDUKNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:13:09 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5CCC06174A;
        Wed, 21 Apr 2021 03:12:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p8so20143101iol.11;
        Wed, 21 Apr 2021 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RaMdrAkT8XnJJBnqUpp1IB7qEdHKeQbsDu7VJL67ns=;
        b=OZBxsLzkOzkPCJEOorVhdgB6NBcrdl2DfTDje+GG9G5aIGW/zXD6XU2wBSHdUh2/OV
         wHgXlYeFitDRITGIL/DaXVBHDxnD3i5tUp4LT2Df2AmO5cgpMB0UukaDaEqVXt/2JRfe
         6Lo5ehjrEsa0x/h0TPBd2vmsar54cvDdIu0TS9Tc/rALshH98cCNFOWI9AsoMBNJZUy6
         oMyLGk+sf5DTyNa4G2wmUX4P8buLKo2UyWq2ZEuggbHguvY5FjT5uzLnCoMBG/s9H8VJ
         IQ6B5+1Ppk2M0tvmDimNwkDKgf+pNiHFWpOngj10vpA1NOw9o2dqpwvvaCmM/f0wCrF4
         1L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RaMdrAkT8XnJJBnqUpp1IB7qEdHKeQbsDu7VJL67ns=;
        b=I2am6QBac81xTXzXiuxH0xo73EZTJ2A3wsmB8UWRGfERQLxE6z8rvp2t8iGowt54gF
         ePrC6B+MR40OphRLY4QqRs6PMKOA7aykXdBdfou64rwba0cQumOLz0kO1BA3xZCJDcwZ
         5ZuSe+xgsA4xFs8oVOFcLNBqZHWBoJKnBBnqRN+5gOR4irp1Yf4c/c7/HuJNDQqTaWK2
         RETXnsTAtT2XbF/AFW4ue5FslwoALfeTkH4ImBuRuszjHtQ6ktJH15iVfB0S3b/DvomQ
         WGN6hwh45RRzI00HsDZuy3dpCyDaf24BUAQmL4TAV5G7lPLJpfLchGE8WybLthXxROSA
         fTqw==
X-Gm-Message-State: AOAM531nuGLyvoxB710xg81I7r9FwFBLuVMJhItqKCyOgDG2BiaQMpfW
        EH4lhBJCRx3sTXp5sCxP/2R730yV0KnfU7xvbF0=
X-Google-Smtp-Source: ABdhPJzs6V3xBg7NWo7TJQZCmTlPHRwBemmMsx0FTxfz7yXWtQkB8im5R3jA96QPTwnJMTilL3DbVM1cxqgHuKNgtMI=
X-Received: by 2002:a02:331b:: with SMTP id c27mr12995345jae.30.1618999955242;
 Wed, 21 Apr 2021 03:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618527437.git.repnop@google.com> <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein> <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein> <YH4+Swki++PHIwpY@google.com>
 <20210421080449.GK8706@quack2.suse.cz> <CAOQ4uxhmJgbSbk_w_gsYg+zLb9GJv6_oGrmfPiNEYao_U3z9=Q@mail.gmail.com>
 <20210421100027.GP8706@quack2.suse.cz>
In-Reply-To: <20210421100027.GP8706@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Apr 2021 13:12:23 +0300
Message-ID: <CAOQ4uxjo=b8hp6o2j-HbNhSpehwiQ4fW8y6DLojhNc+QYx6qqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 1:00 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 21-04-21 12:29:14, Amir Goldstein wrote:
> > On Wed, Apr 21, 2021 at 11:04 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 20-04-21 12:36:59, Matthew Bobrowski wrote:
> > > > On Mon, Apr 19, 2021 at 05:02:33PM +0200, Christian Brauner wrote:
> > > > > A general question about struct fanotify_event_metadata and its
> > > > > extensibility model:
> > > > > looking through the code it seems that this struct is read via
> > > > > fanotify_rad(). So the user is expected to supply a buffer with at least
> > > > >
> > > > > #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
> > > > >
> > > > > bytes. In addition you can return the info to the user about how many
> > > > > bytes the kernel has written from fanotify_read().
> > > > >
> > > > > So afaict extending fanotify_event_metadata should be _fairly_
> > > > > straightforward, right? It would essentially the complement to
> > > > > copy_struct_from_user() which Aleksa and I added (1 or 2 years ago)
> > > > > which deals with user->kernel and you're dealing with kernel->user:
> > > > > - If the user supplied a buffer smaller than the minimum known struct
> > > > >   size -> reject.
> > > > > - If the user supplied a buffer < smaller than what the current kernel
> > > > >   supports -> copy only what userspace knows about, and return the size
> > > > >   userspace knows about.
> > > > > - If the user supplied a buffer that is larger than what the current
> > > > >   kernel knows about -> copy only what the kernel knows about, zero the
> > > > >   rest, and return the kernel size.
> > > > >
> > > > > Extension should then be fairly straightforward (64bit aligned
> > > > > increments)?
> > > >
> > > > You'd think that it's fairly straightforward, but I have a feeling
> > > > that the whole fanotify_event_metadata extensibility discussion and
> > > > the current limitation to do so revolves around whether it can be
> > > > achieved in a way which can guarantee that no userspace applications
> > > > would break. I think the answer to this is that there's no guarantee
> > > > because of <<reasons>>, so the decision to extend fanotify's feature
> > > > set was done via other means i.e. introduction of additional
> > > > structures.
> > >
> > > There's no real problem extending fanotify_event_metadata. We already have
> > > multiple extended version of that structure in use (see e.g. FAN_REPORT_FID
> > > flag and its effect, extended versions of the structure in
> > > include/uapi/linux/fanotify.h). The key for backward compatibility is to
> > > create extended struct only when explicitely requested by a flag when
> > > creating notification group - and that would be the case here -
> > > FAN_REPORT_PIDFD or how you called it. It is just that extending the
> > > structure means adding 8 bytes to each event and parsing extended structure
> > > is more cumbersome than just fetching s32 from a well known location.
> > >
> > > On the other hand extended structure is self-describing (i.e., you can tell
> > > the meaning of all the fields just from the event you receive) while
> > > reusing 'pid' field means that you have to know how the notification group
> > > was created (whether FAN_REPORT_PIDFD was used or not) to be able to
> > > interpret the contents of the event. Actually I think the self-describing
> > > feature of fanotify event stream is useful (e.g. when application manages
> > > multiple fanotify groups or when fanotify group descriptors are passed
> > > among processes) so now I'm more leaning towards using the extended
> > > structure instead of reusing 'pid' as Christian suggests. I'm sorry for the
> > > confusion.
> > >
> >
> > But there is a middle path option.
> > The event metadata can be self described without extending it:
> >
> >  struct fanotify_event_metadata {
> >         __u32 event_len;
> >         __u8 vers;
> > -       __u8 reserved;
> > +#define FANOTIFY_METADATA_FLAG_PIDFD   1
> > +       __u8 flags;
> >         __u16 metadata_len;
> >         __aligned_u64 mask;
> >         __s32 fd;
>
> Well, yes, but do we want another way to describe what fanotify_event_metadata
> actually contains? I don't think parsing extended event information is that
> bad to make changes like this worth it...

Fine by me.
But in that case, we should report pidfd in addition to pid.

There is an advantage in doing that -
For the use case of filtering out events generated by self_pid
of the listener, there is no need to follow pidfd in order to check
if event->pid == self_pid.

Thanks,
Amir.
