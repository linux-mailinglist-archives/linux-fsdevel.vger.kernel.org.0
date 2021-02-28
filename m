Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C097632716F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 08:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhB1Hhm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 02:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhB1Hhf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 02:37:35 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5418FC06174A;
        Sat, 27 Feb 2021 23:36:04 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z9so1645252iln.1;
        Sat, 27 Feb 2021 23:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scgNq2qr/fS3zgbjE4ob7cJfumUVL9VhZ4bMBRl7Uss=;
        b=r7sTlLonSNHX2Jdi5Tni3ywijjLuY7HgN+8aCGsBEeChgEEsZMq3vwPre4C45bjzu0
         saM/cGlttgVsCrH+tnHM7zciFz1kkOiclw0uTsC8Qo/FjrQ3//1OSHMPduxyDf8JVPLq
         smXLtMJokE5B+sOE70sGVjT9laNQVn26RvGzcfTRd/A/3ikx3/GU5t5DX3yhl16IlQio
         yJvr1JQscpFDErpK5I04ZBVEl4DeUug3X07UUfEL1ht5bva+MFZjlyE26wvPy7IZW6M2
         lLVNiJbd63UEiXZbRpTA3WfmznnL0p4IZV9JM9UjOO+nWCa1uJwHLQPPcnaxzd6JP/e+
         8mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scgNq2qr/fS3zgbjE4ob7cJfumUVL9VhZ4bMBRl7Uss=;
        b=eE5CnbErx3kwdDjnv8qKTwCz/aANgOlAVyuioVJhJzGZpaiZpQjeeV/1h5IE9BGxbY
         L/0WXJM2TO8aAgaRRewsvZwy0t3P1r6CPp3kKwgMiOzTvF6PFs2ngMe69ZwjMvB6ahox
         QMqwhH/fMetK49grmSgN1eY7d/5wJ2lq2sb4L5t63/jXAm08HIIDSBJ5gE9tkigonhhw
         xjVtSaDOXZvAVGaqaYdVmtgmDGPKA4vdIT03sQ+qaV73b5v3I0P298oAbhe8qXENkyko
         ay6Gl8BLnPWEjfiqxZFnBXhVMV4HrJjobNxYWRloLcx8hjcSgIF3eNkQ9954P1qfiOOU
         QWyg==
X-Gm-Message-State: AOAM531JH8N4+5fYGWaR28qGEtqL7ac5pYyKYOxRYC/gPoKvGGy3BAIk
        bm4LVzR7YpnKJmMBuevtuzY44YLGeq2bNkD5RVM=
X-Google-Smtp-Source: ABdhPJwT+3m/YuBdehW73a8hRtE5d0iHCP+pOKiPO/W3q4Fryk1KPMak091BDtVHiHR5cYHjm0r6JDv9A+Q5GhvAeJo=
X-Received: by 2002:a92:2c08:: with SMTP id t8mr8743672ile.72.1614497763520;
 Sat, 27 Feb 2021 23:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20210222102456.6692-1-lhenriques@suse.de> <20210224142307.7284-1-lhenriques@suse.de>
 <CAOQ4uxi3-+tOgHV_GUnWtJoQXbV5ZS9qDZsLsd9sJxX5Aftyew@mail.gmail.com>
 <6b896b29-6fc1-0586-ef31-f2f3298b56b0@gmail.com> <CAOQ4uxgFCBNwRD7e1srwaVrZMGfOE_JXENL4Q2En52srdj2AYA@mail.gmail.com>
 <CAH2r5mvJPh6H_Owt7QiBY0xWO0T6ai65R5tspn+cDru0_P0V4A@mail.gmail.com>
In-Reply-To: <CAH2r5mvJPh6H_Owt7QiBY0xWO0T6ai65R5tspn+cDru0_P0V4A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 28 Feb 2021 09:35:52 +0200
Message-ID: <CAOQ4uxix2dTUcV+GF0+6vbw1_6dv3JSyBSLSeQH5Gsnwtf+8_A@mail.gmail.com>
Subject: Re: [PATCH] copy_file_range.2: Kernel v5.12 updates
To:     Steve French <smfrench@gmail.com>
Cc:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Luis Henriques <lhenriques@suse.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 28, 2021 at 1:08 AM Steve French <smfrench@gmail.com> wrote:
>
> On Fri, Feb 26, 2021 at 11:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sat, Feb 27, 2021 at 12:19 AM Alejandro Colomar (man-pages)
> > <alx.manpages@gmail.com> wrote:
> > >
> > > Hello Amir, Luis,
> > >
> > > On 2/24/21 5:10 PM, Amir Goldstein wrote:
> > > > On Wed, Feb 24, 2021 at 4:22 PM Luis Henriques <lhenriques@suse.de> wrote:
> > > >>
> > > >> Update man-page with recent changes to this syscall.
> > > >>
> > > >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > > >> ---
> > > >> Hi!
> > > >>
> > > >> Here's a suggestion for fixing the manpage for copy_file_range().  Note that
> > > >> I've assumed the fix will hit 5.12.
> > > >>
> > > >>   man2/copy_file_range.2 | 10 +++++++++-
> > > >>   1 file changed, 9 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
> > > >> index 611a39b8026b..b0fd85e2631e 100644
> > > >> --- a/man2/copy_file_range.2
> > > >> +++ b/man2/copy_file_range.2
> > > >> @@ -169,6 +169,9 @@ Out of memory.
> > > >>   .B ENOSPC
> > > >>   There is not enough space on the target filesystem to complete the copy.
> > > >>   .TP
> > > >> +.B EOPNOTSUPP
> > >
> > > I'll add the kernel version here:
> > >
> > > .BR EOPNOTSUPP " (since Linux 5.12)"
> >
> > Error could be returned prior to 5.3 and would be probably returned
> > by future stable kernels 5.3..5.12 too
> >
> > >
> > > >> +The filesystem does not support this operation >> +.TP
> > > >>   .B EOVERFLOW
> > > >>   The requested source or destination range is too large to represent in the
> > > >>   specified data types.
> > > >> @@ -187,7 +190,7 @@ refers to an active swap file.
> > > >>   .B EXDEV
> > > >>   The files referred to by
> > > >>   .IR fd_in " and " fd_out
> > > >> -are not on the same mounted filesystem (pre Linux 5.3).
> > > >> +are not on the same mounted filesystem (pre Linux 5.3 and post Linux 5.12).
> > >
> > > I'm not sure that 'mounted' adds any value here.  Would you remove the
> > > word here?
> >
> > See rename(2). 'mounted' in this context is explained there.
> > HOWEVER, it does not fit here.
> > copy_file_range() IS allowed between two mounts of the same filesystem instance.
> >
> > To make things more complicated, it appears that cross mount clone is not
> > allowed via FICLONE/FICLONERANGE ioctl, so ioctl_ficlonerange(2) man page
> > also uses the 'mounted filesystem' terminology for EXDEV
> >
> > As things stand now, because of the fallback to clone logic,
> > copy_file_range() provides a way for users to clone across different mounts
> > of the same filesystem instance, which they cannot do with the FICLONE ioctl.
> >
> > Fun :)
> >
> > BTW, I don't know if preventing cross mount clone was done intentionally,
> > but as I wrote in a comment in the code once:
> >
> >         /*
> >          * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
> >          * the same mount. Practically, they only need to be on the same file
> >          * system.
> >          */
> >
> > >
> > > It reads as if two separate devices with the same filesystem type would
> > > still give this error.
> > >
> > > Per the LWN.net article Amir shared, this is permitted ("When called
> > > from user space, copy_file_range() will only try to copy a file across
> > > filesystems if the two are of the same type").
> > >
> > > This behavior was slightly different before 5.3 AFAICR (was it?) ("until
> > > then, copy_file_range() refused to copy between files that were not
> > > located on the same filesystem.").  If that's the case, I'd specify the
> > > difference, or more probably split the error into two, one before 5.3,
> > > and one since 5.12.
> > >
> >
> > True.
> >
> > > >
> > > > I think you need to drop the (Linux range) altogether.
> > >
> > > I'll keep the range.  Users of 5.3..5.11 might be surprised if the
> > > filesystems are different and they don't get an error, I think.
> > >
> > > I reworded it to follow other pages conventions:
> > >
> > > .BR EXDEV " (before Linux 5.3; or since Linux 5.12)"
> > >
> > > which renders as:
> > >
> > >         EXDEV (before Linux 5.3; or since Linux 5.12)
> > >                The files referred to by fd_in and fd_out are not on
> > >                the same mounted filesystem.
> > >
> >
> > drop 'mounted'
> >
> > >
> > > > What's missing here is the NFS cross server copy use case.
> > > > Maybe:
>
> At least for the SMB3 kernel server (ksmbd "cifsd") looks like they use splice.
> And for the user space CIFS/SMB3 server (like Samba) they have a configurable
> plug in library interface ("Samba VFS modules") that would allow you
> to implement
> cross filesystem copy optimally for your version of Linux and plug
> this into Samba
> with little work on your part.
>
> > >
> > > Again, this wasn't true before 5.3, right?
> > >
> >
> > Right.
> > Actually, v5.3 provides the vfs capabilities for filesystems to support
> > cross fs copy. I am not sure if NFS already implements cross fs copy in
> > v5.3 and not sure about cifs. Need to get input from nfs/cis developers
> > or dig in the release notes for server-side copy.
>
> The SMB3 protocol has multiple ways to do "server side copy" (copy
> offload to the server), some of which would apply to your example.
> The case of "reflink" in many cases would be most efficient, and is supported
> by the Linux client (see MS-SMB2 protocol specification section 3.3.5.15.18) but
> is supported by fewer server file systems, so probably more important
> to focus on
> the other mechanisms which are server side copy rather than clone.  The most
> popular way, supported by most servers, is  "CopyChunk" - 100s of
> millions of systems
> support this (if not more) - see MS-SMB2 protocol specification
> section 2.2.31.1 and
> 3.3.5.15.16 - there are various cases where two different SMB3 mounts
> on the same
> client could handle cross mount server side copy.
>
> There are other mechanisms supported by fewer servers SMB3 ODX/T10 style copy
> offload (Windows and some others see e.g. Gordon at Nexenta's presentation
> https://www.slideshare.net/gordonross/smb3-offload-data-transfer-odx)
> but still popular for virtualization workloads.  For this it could be
> even more common
> for those to be different mounts on the client.  The Linux client does
> not support
> the SMB3 ODX/T10 offload yet but it would be good to add support for it.
> There is a nice description of its additional benefits at
> https://docs.microsoft.com/en-us/windows-hardware/drivers/storage/offloaded-data-transfer
>
> But - yes SMB3 on Linux can have cross mount file copy today, which is
> far more efficient

Can have? or does have?
IIUC, server-side copy ability exists for "same cifs fs" for a long time and
since v5.3, it is available for "same cifs connection", which is not exactly
the same as "same cifs fs" but also not really different for most people.
Can you elaborate about  that?
Just assume the server can do anything. What can the Linux client do
since v5.3 or later?

> (having the server do the copy for us) rather than sending large
> reads/writes back and
> forth over the network from the client.  In the future I am hoping that use case
> becomes even more common over SMB3 as cloud servers improve.
>
>
> > > > You may refer the reader to VERSIONS section where it will say which
> > > > filesystems support cross-fs copy as of kernel version XXX (i.e. cifs and nfs).
> > > >
> > > >>   .SH VERSIONS
> > > >>   The
> > > >>   .BR copy_file_range ()
> > > >> @@ -202,6 +205,11 @@ Applications should target the behaviour and requirements of 5.3 kernels.
> > > >>   .PP
> > > >>   First support for cross-filesystem copies was introduced in Linux 5.3.
> > > >>   Older kernels will return -EXDEV when cross-filesystem copies are attempted.
> > > >> +.PP
> > > >> +After Linux 5.12, support for copies between different filesystems was dropped.
> > > >> +However, individual filesystems may still provide
> > > >> +.BR copy_file_range ()
> > > >> +implementations that allow copies across different devices.
>
> Yes - this could be very important, especially for cifs (smb3) going forward.
>
>
>
> --
> Thanks,
>
> Steve
