Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7278531C292
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 20:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhBOTn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 14:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhBOTnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:43:55 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8DEC061574;
        Mon, 15 Feb 2021 11:43:15 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id f20so7857633ioo.10;
        Mon, 15 Feb 2021 11:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qH4peM2xuF2HppqCjD19tPbOHZlqzT1b+rbmSIfxtYQ=;
        b=bEk2xN+rcd/TU9m1ZQu8SNvyXLSXoWYaL21tuQseUI1vMcBA5+lsJ5iGWwGJXMEVfd
         8B5AkB+vOR6eLr02oa12r96dFyCmy1V0bub9l+rmT+eUkRTVUNmKgg9fLArabfpqADbI
         q+y2TRdTWB+o3CZ1rIMUGh6ndEWB8EOvSVTAyAwp+t5SAGD4uBoyHp41tJLVSItzesrD
         LFPAWOlBD0/008QOBeAwbjGEeW45bPOzOBgLsQ3Xj7i4embdnpsjj7F260pxnvtCAoi7
         bV8NJe7MioB/S9VvCVMTQLV0U3Wqx1jWgi1iZ1INcGlcbqo8Wb9zKLicm8vN+ziAK+tZ
         V/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qH4peM2xuF2HppqCjD19tPbOHZlqzT1b+rbmSIfxtYQ=;
        b=BZgiPqb3PYnjMngx1PakGKn/h1OxIbwa07xT2fIGNm/up9DTmkSfBdWb/q6pKtrHpb
         Hl33m/W7uKhZAA/xmqcW6hRIvKEWyc/w8AKLQWACfN8zWG+IG07ZT1Yvt6hwa0+ELiPe
         l4lYtbyrQPDlfAEmeeBnTB6GkBp1Y1LOp+IP13+ImDF+Mjmxh1vwMkvaOU9He9WUDif3
         FIKGEkojNQPPU2s5Upc625o96vWA5EcwafPEjX5wn9e36VFUdZ7BpCDfoF7w8OQcyuLw
         lT622cmwmWyv4CErwa6qparWfAfSSWbXHn6WFRA92u3UnpMo75/BKW5OFoRl1D/VrDm8
         uB9g==
X-Gm-Message-State: AOAM530rGFy+aLcjhEbwOxytO/krB6JoixWKbUQzRWqypu+8rbEVFBGd
        StMqSDzaU5vASta2Ei0Q5mddo/UNPBUDDABZDoM=
X-Google-Smtp-Source: ABdhPJyouPXW7yfx7UpPKow3Z3T5iiAur2fNdcwgEnSjCz7s7V8M3IwNKM1kmOPmYW+/Q2AxNYLTb/Qx25/bO9BNeic=
X-Received: by 2002:a05:6602:2c52:: with SMTP id x18mr14319886iov.5.1613418194594;
 Mon, 15 Feb 2021 11:43:14 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de> <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
 <73ab4951f48d69f0183548c7a82f7ae37e286d1c.camel@hammerspace.com>
 <CAOQ4uxgPtqG6eTi2AnAV4jTAaNDbeez+Xi2858mz1KLGMFntfg@mail.gmail.com> <92d27397479984b95883197d90318ee76995b42e.camel@hammerspace.com>
In-Reply-To: <92d27397479984b95883197d90318ee76995b42e.camel@hammerspace.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Feb 2021 21:43:03 +0200
Message-ID: <CAOQ4uxjUf15fDjz11pCzT3GkFmw=2ySXR_6XF-Bf-TfUwpj77Q@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "iant@google.com" <iant@google.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "lhenriques@suse.de" <lhenriques@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "llozano@chromium.org" <llozano@chromium.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 8:57 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2021-02-15 at 19:24 +0200, Amir Goldstein wrote:
> > On Mon, Feb 15, 2021 at 6:53 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2021-02-15 at 18:34 +0200, Amir Goldstein wrote:
> > > > On Mon, Feb 15, 2021 at 5:42 PM Luis Henriques <
> > > > lhenriques@suse.de>
> > > > wrote:
> > > > >
> > > > > Nicolas Boichat reported an issue when trying to use the
> > > > > copy_file_range
> > > > > syscall on a tracefs file.  It failed silently because the file
> > > > > content is
> > > > > generated on-the-fly (reporting a size of zero) and
> > > > > copy_file_range
> > > > > needs
> > > > > to know in advance how much data is present.
> > > > >
> > > > > This commit restores the cross-fs restrictions that existed
> > > > > prior
> > > > > to
> > > > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > > > > devices")
> > > > > and
> > > > > removes generic_copy_file_range() calls from ceph, cifs, fuse,
> > > > > and
> > > > > nfs.
> > > > >
> > > > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > > > > devices")
> > > > > Link:
> > > > > https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> > > > > Cc: Nicolas Boichat <drinkcat@chromium.org>
> > > > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > > >
> > > > Code looks ok.
> > > > You may add:
> > > >
> > > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > I agree with Trond that the first paragraph of the commit message
> > > > could
> > > > be improved.
> > > > The purpose of this change is to fix the change of behavior that
> > > > caused the regression.
> > > >
> > > > Before v5.3, behavior was -EXDEV and userspace could fallback to
> > > > read.
> > > > After v5.3, behavior is zero size copy.
> > > >
> > > > It does not matter so much what makes sense for CFR to do in this
> > > > case (generic cross-fs copy).  What matters is that nobody asked
> > > > for
> > > > this change and that it caused problems.
> > > >
> > >
> > > No. I'm saying that this patch should be NACKed unless there is a
> > > real
> > > explanation for why we give crap about this tracefs corner case and
> > > why
> > > it can't be fixed.
> > >
> > > There are plenty of reasons why copy offload across filesystems
> > > makes
> > > sense, and particularly when you're doing NAS. Clone just doesn't
> > > cut
> > > it when it comes to disaster recovery (whereas backup to a
> > > different
> > > storage unit does). If the client has to do the copy, then you're
> > > effectively doubling the load on the server, and you're adding
> > > potentially unnecessary network traffic (or at the very least you
> > > are
> > > doubling that traffic).
> > >
> >
> > I don't understand the use case you are describing.
> >
> > Which filesystem types are you talking about for source and target
> > of copy_file_range()?
> >
> > To be clear, the original change was done to support NFS/CIFS server-
> > side
> > copy and those should not be affected by this change.
> >
>
> That is incorrect:
>
> ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file
> *dst,
>  u64 dst_pos, u64 count)
> {
>
>  /*
>  * Limit copy to 4MB to prevent indefinitely blocking an nfsd
>  * thread and client rpc slot. The choice of 4MB is somewhat
>  * arbitrary. We might instead base this on r/wsize, or make it
>  * tunable, or use a time instead of a byte limit, or implement
>  * asynchronous copy. In theory a client could also recognize a
>  * limit like this and pipeline multiple COPY requests.
>  */
>  count = min_t(u64, count, 1 << 22);
>  return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> }
>
> You are now explicitly changing the behaviour of knfsd when the source
> and destination filesystem differ.
>
> For one thing, you are disallowing the NFSv4.2 copy offload use case of
> copying from a local filesystem to a remote NFS server. However you are
> also disallowing the copy from, say, an XFS formatted partition to an
> ext4 partition.
>

Got it.
This is easy to solve with a flag COPY_FILE_SPLICE (or something)
that is internal to kernel users.

FWIW, you may want to look at the loop in ovl_copy_up_data()
for improvements to nfsd_copy_file_range().

We can move the check out to copy_file_range syscall:

        if (flags != 0)
                return -EINVAL;

Leave the fallback from all filesystems and check for the
COPY_FILE_SPLICE flag inside generic_copy_file_range().

Thanks,
Amir.
