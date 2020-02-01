Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D1A14FA71
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 20:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgBATy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 14:54:58 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:43884 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgBATy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 14:54:58 -0500
Received: by mail-il1-f193.google.com with SMTP id o13so9231429ilg.10;
        Sat, 01 Feb 2020 11:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ZM+XG0Qafoo8yoA94Tb8BHY4hUIVe3CK4bN+n5GzG8=;
        b=nM4GcWpAjqrvtL0Lcot/MfvVHtdRX+7g84363eMq/9AuOgxISlHekqaj3V52RNVmkm
         /ioWKfJZAkxg9iBcZUCW+mJwCkoFS+Gb2xhExyOKZiXItEGsDEX6Dt5Bf541NXK0sTHQ
         OfSkxk/se9sB5wMFojGXz6KvoP2KlTASo44Wb5gNchmhOs5LdCdGhr1HSlyzGMHAbUM0
         1vOEEpt5AHGPBBXSY3iF3kHqh/J8eRjPlfPcq8DEwu8wYUDvZ1sFG07i5GXZDeTamJaW
         wKuM+UDaxinaG+hK+FRey6eXOpNF3EFJAePEkon67a03z3EeFPsWnfyVfm251IsJtyWl
         LvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ZM+XG0Qafoo8yoA94Tb8BHY4hUIVe3CK4bN+n5GzG8=;
        b=jUdX4t3R3jdzd3ueQGHzY2G8+9e2sPV852u1thekUtgmkqxrqK0E2dYk1y+gqsYAjW
         2+UWJcC2URYhqeh29s04RZzVFX5B69meUq3zwJxG5k/o+agJVXyjMSaSFb5PKNadw8gT
         n7YzWTxJCE8s5cq6knc0unpeUoE3O1cjFMRRSKZ5zHl0tAr5xBj6EP0SwKSHNpK2xFbd
         NyUiEThcGzVNs6qDLJB+c8n36lelL5n4y2RP3NPjfBS65/Q7ixRiBVOXxnzk3HOe3kyO
         5Zld4lmgm/WdVYp8uBPiFmmjpgJ3z50/4+XOc5HsSJvzJyhlV39qRV5WUoQrLdqaSVRe
         HmnQ==
X-Gm-Message-State: APjAAAU7sllHClubQbzGtqt6dpvASy9CZAU04r8loFn3JNpUgu8omm2h
        c9s2NQV6nLmk+7f7ya8PRkmaksc+diyUP8ybMRo=
X-Google-Smtp-Source: APXvYqwLHAZsySBQ5toZfqW/3M9sNi5WUjCIwF+SI1xCAeDRgfX4LKqJmF2bmQV/9y0r2Ld5SOqDmVCpjzeN7PYQtxs=
X-Received: by 2002:a92:d642:: with SMTP id x2mr8368738ilp.169.1580586897434;
 Sat, 01 Feb 2020 11:54:57 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mvYTimXUfJB+p0mvYV3jAR1u5G4F3m+OqA_5jKiLhVE8A@mail.gmail.com>
 <20200130015210.GB3673284@magnolia>
In-Reply-To: <20200130015210.GB3673284@magnolia>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 1 Feb 2020 13:54:46 -0600
Message-ID: <CAH2r5mv55Ua3B8WX1Qht1xfWL-k5pGJrN+Uz0L4jHtYOo9RMKw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Enhancing Linux Copy Performance and Function
 and improving backup scenarios
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 7:54 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, Jan 22, 2020 at 05:13:53PM -0600, Steve French wrote:
> > As discussed last year:
> >
> > Current Linux copy tools have various problems compared to other
> > platforms - small I/O sizes (and most don't allow it to be
> > configured), lack of parallel I/O for multi-file copies, inability to
> > reduce metadata updates by setting file size first, lack of cross
>
> ...and yet weirdly we tell everyone on xfs not to do that or to use
> fallocate, so that delayed speculative allocation can do its thing.
> We also tell them not to create deep directory trees because xfs isn't
> ext4.

Delayed speculative allocation may help xfs but changing file size
thousands of times for network and cluster fs for a single file copy
can be a disaster for other file systems (due to the excessive cost
it adds to metadata sync time) - so there are file systems where
setting the file size first can help

> >  And copy tools rely less on
> > the kernel file system (vs. code in the user space tool) in Linux than
> > would be expected, in order to determine which optimizations to use.
>
> What kernel interfaces would we expect userspace to use to figure out
> the confusing mess of optimizations? :)

copy_file_range and clone_file_range are a good start ... few tools
use them ...

> There's a whole bunch of xfs ioctls like dioinfo and the like that we
> ought to push to statx too.  Is that an example of what you mean?

That is a good example.   And then getting tools to use these,
even if there are some file system dependent cases.

>
> > But some progress has been made since last year's summit, with new
> > copy tools being released and improvements to some of the kernel file
> > systems, and also some additional feedback on lwn and on the mailing
> > lists.  In addition these discussions have prompted additional
> > feedback on how to improve file backup/restore scenarios (e.g. to
> > mounts to the cloud from local Linux systems) which require preserving
> > more timestamps, ACLs and metadata, and preserving them efficiently.
>
> I suppose it would be useful to think a little more about cross-device
> fs copies considering that the "devices" can be VM block devs backed by
> files on a filesystem that supports reflink.  I have no idea how you
> manage that sanely though.

I trust XFS and BTRFS and SMB3 and cluster fs etc. to solve this better
than the block level (better locking, leases/delegation, state management, etc.)
though.

-- 
Thanks,

Steve
