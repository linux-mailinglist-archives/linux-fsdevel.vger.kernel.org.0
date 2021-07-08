Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741BE3BFA0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 14:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhGHM2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 08:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhGHM2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:28:42 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256B5C061574;
        Thu,  8 Jul 2021 05:26:01 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id g3so6423117ilj.7;
        Thu, 08 Jul 2021 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUhyzTS/3w19BL385uv/zB6ZeVZ9xxjly+XV+lcwCxU=;
        b=SYP4zxzX2PEuUFFki9edXrzqMt2UpE5PvaNH0yooKw8rn2kGX8uPDKF1BGKEObsnL9
         eN2PRZFH7Ww2PskenxUUyzG6sHTgHEOtMsk8bVGLGVTVYrizJxLEbq2I5DzZcjf9V89s
         wz2r7+s+egmYQczakY8Cp4VZcAu8XmvzyidnP0u2+s9TDR5THqa7ulx37Z9iFZwBt+iS
         Ri/pz9SmWPEvq21UX+hPX9pVMD3tBazu+A+SZO31B8UJWGJGTIN4rpvz+deN1sz611lV
         Y5+kDg5v+7JI2bPbSzyYQCDaDcF7Oua1C5VJZAhhr1L46eahERB+CYbJ88fBLmCND7lF
         0ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUhyzTS/3w19BL385uv/zB6ZeVZ9xxjly+XV+lcwCxU=;
        b=IkOWjyqnf8V/LXhHqwpzdNLzTTCfAv17Dh9P8iH7HBApKof4T/9OwJ3nRPUi9Wd9d1
         UQIdNJjvzNb4Rb9uZTnJrbN6SafAQjaZ7mRCbA1LyYsuUbdOFurTicw0w6FeGb3R6NJO
         GowoiuTa29/D9P+gIyv+HdWL9R1YLFtLW5ihDMUqNb+1TG7YUa735SXJweN18vOFyE/W
         Wg0cESupA0QqI3yBwIx1wK8vnKbxQ1zvgrEC/zCMwnqHgex9lL36LNstKxuC7ICgCjM0
         NSYrNEIKKe1fNMTi/J9DW4wIRTBN+c6x1LYZYzj2WyIeox8Z3J1g0qcP1xKiFnH8e7M/
         QX6A==
X-Gm-Message-State: AOAM533rnqk6d7+GZLpQEu/RCS1nVlsSCrzhpYFzlyndmXL86n5ooufP
        mdMSsv6t5BT75To85wfRWpwMRkjFCXBdu2VmT1Q=
X-Google-Smtp-Source: ABdhPJwNEKCxOyKwwA1OH6frqzqWyNQurk/nS6Qb+KyDLplEOkZdmU1XuMHtfvADY8JQIGDdpwtwCL/isnCCeMoU+i0=
X-Received: by 2002:a92:4442:: with SMTP id a2mr2674047ilm.72.1625747160567;
 Thu, 08 Jul 2021 05:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com>
 <CAOQ4uxgigXTtGgEC3yzt3f4HDHUiYqL7vk73v6E5LGx0OoFWHg@mail.gmail.com> <20210708113215.GE1656@quack2.suse.cz>
In-Reply-To: <20210708113215.GE1656@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 8 Jul 2021 15:25:49 +0300
Message-ID: <CAOQ4uxjxVZTsRfnSjnUDAMobbcnvXJ3fhZTB7v_9wB6brnQS5w@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] File system wide monitoring
To:     Jan Kara <jack@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 8, 2021 at 2:32 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 30-06-21 08:10:39, Amir Goldstein wrote:
> > > This change raises the question of how we report non-inode errors.  On
> > > one hand, we could omit the FID report, but then fsid would also be
> > > ommited.  I chose to report these kind of errors against the root
> > > inode.
> >
> > There are other option to consider.
>
> Yeah, so reporting against root inode has the disadvantage that in
> principle you don't know whether the error really happened on the root
> inode or whether the event is in fact without an inode. So some information
> is lost here. Maybe the set of errors that can happen without an inode and
> the set of errors that can happen with an inode are disjoint, so no
> information is actually lost but then does reporting root inode actually
> bring any benefit? So I agree reporting root inode is not ideal.
>
> > To avoid special casing error events in fanotify event read code,
> > it would is convenient to use a non-zero length FID, but you can
> > use a 8 bytes zero buffer as NULL-FID
> >
> > If I am not mistaken, that amounts to 64 bytes of event_len
> > including the event_metadata and both records which is pretty
> > nicely aligned.
> >
> > All 3 handle_type options below are valid options:
> > 1. handle_type FILEID_ROOT
> > 2. handle_type FILEID_INVALID
> > 3. handle_type FILEID_INO32_GEN (i.e. ino=0;gen=0)
> >
> > The advantage of option #3 is that the monitoring program
> > does not need to special case the NULL_FID case when
> > parsing the FID to informative user message.
>
> I actually like #2 more. #1 has similar problems as I outlined above for
> reporting root dir. The advantage that userspace won't have to special case
> FILEID_INO32_GEN FID in #3 is IMHO a dream - if you want a good message,
> you should report the problem was on a superblock, not some just some
> zeroes instead of proper inode info. Even more if it was on a real inode,
> good reporter will e.g. try to resolve it to a path.
>
> Also because we will presumably have more filesystems supporting this in
> the future, normal inodes can be reported with other handle types anyway.
> So IMO #2 is the most sensible option.
>

I am perfectly fine with #2, but just FYI, there is no ambiguity around using
FILEID_ROOT - it is a special "application level" type used by nfsd to describe
a handle to the root of an export (I'm not in which protocol versions).
The inode itself does not even need to be the root of the filesystem
(it seldom is)
nfsd keeps a dentry with elevated refcount per export in order to "decode"
those export root handles.

The filesystem itself will never return this value, so when reporting
errors on a
specific inode and the specific inode is the filesystem root directory then
the type will be the same as the native filesystem type and not FILEID_ROOT.

For this reason I thought it would be safe to use FILEID_ROOT for reporting
events on sb without inode and FILEID_INVALID for reporting failure to encode
fh, for example when not guessing max_fh_len correctly.

But it's just nice to have.

> > w.r.t LTP test, I don't think that using a corrupt image will be a good way
> > for an LTP test. LTP tests can prepare and mount an ext4 loop image.
> > Does ext4 have some debugging method to inject an error?
> > Because that would be the best way IMO.
> > If it doesn't, you can implement this in ext4 and use it in the test if that
> > debug file exists - skip the test otherwise - it's common practice.
>
> Ext4 does not have an error injection facility. Not sure if we want to
> force Gabriel into creating one just for these LTP tests. Actually creating
> ext4 images with known problems (through mke2fs and debugfs) should be
> rather easy and we could then test we get expected error notifications
> back...

Ok.

Thanks,
Amir.
