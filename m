Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF5231D1EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 22:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhBPVQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 16:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBPVP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:15:59 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D9AC061574;
        Tue, 16 Feb 2021 13:15:18 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id e17so13614170ljl.8;
        Tue, 16 Feb 2021 13:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9pJQdXCNVW4q6rZ/6zXfBrmEoa3xvKen1QyJUucPzI=;
        b=bIbljLq1gKZZqu6Ih7d5RhNIa7jd+Gk1B/SaCOLrbCpw0RoZqpqV38oGmSWmWMOxCv
         bHdQKyPgLYhhDaZKGZ9HPOLZaj6ZwT9JRbJ8ny6IY7RpOkR7VM5LMeUvCafQC8D+fqR8
         AhCQuf86Dlgp8m5FLHDO/Mv5c5bcvdABtzfXw1H6c/v9CnNvBmiMs7EuEGzqrpvmIkSE
         prR/5Te/N75jDo6xb9zHwPhEuE/B/RKzz9Z46STWGd2j0Gvha7kVam+XHGxPYbXv0uBI
         6vRumFTNBa11qhK0xsS4U8e1uhGgM8lq0IUYU1tmAbUZW0PFDj3DlYn9PydCcq14AHLM
         m/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9pJQdXCNVW4q6rZ/6zXfBrmEoa3xvKen1QyJUucPzI=;
        b=LgIwhG8TnRAUab/5OJlpx9pZ/i+QoUuztHaAZv7wOgaUfPRtySjd/gkiKIjWy6BhF+
         kinM55PL9cnEG4OJNOmgbdgq0emDteblYUiW31Ha5i9AntteFYZTAqT2e6re5/mp2P5Q
         HCkNFqjyzDhctdW5yssND6Hw4bo7GdwuYEj1C2UvVq5aoEwo6aDM0dZjC93eydYxvJTW
         pgb55+4UH27JPoiwz9XDgcJMWCP8CnrqOWZfqpvqd7KtlipUetJSgJ1XtBnLOB8+Oyg2
         7KTtZK4tG1genIKmDAhK+43hhEQ7fYzm7YtsLlFnXecgEZKIlPGhVItoppzAI9q/JKHI
         8W7Q==
X-Gm-Message-State: AOAM531Z3TsK8WvPSga9trN42AGCWD+6JvSwwnE4oFZoNDEe5E+p5a/f
        w1kyZ2iOghHo83oEe9mucP0scu3l5UiIN9fmKLo=
X-Google-Smtp-Source: ABdhPJy/Ym5/KdoQHGrnafA3CW4xD7qhGPdyHZiDqHsOCPIWGr/YRipXpyKqZC0YhLwKjYY+NslNpwSOMz/xiLWD3bw=
X-Received: by 2002:a2e:9951:: with SMTP id r17mr9046188ljj.148.1613510117057;
 Tue, 16 Feb 2021 13:15:17 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de> <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
 <73ab4951f48d69f0183548c7a82f7ae37e286d1c.camel@hammerspace.com>
 <CAOQ4uxgPtqG6eTi2AnAV4jTAaNDbeez+Xi2858mz1KLGMFntfg@mail.gmail.com>
 <92d27397479984b95883197d90318ee76995b42e.camel@hammerspace.com>
 <CAOQ4uxjUf15fDjz11pCzT3GkFmw=2ySXR_6XF-Bf-TfUwpj77Q@mail.gmail.com>
 <87r1lgjm7l.fsf@suse.de> <CAOQ4uxgucdN8hi=wkcvnFhBoZ=L5=ZDc7-6SwKVHYaRODdcFkg@mail.gmail.com>
 <87blckj75z.fsf@suse.de> <CAOQ4uxiiy_Jdi3V1ait56=zfDQRBu_5gb+UsCo8GjMZ6XRhozw@mail.gmail.com>
 <874kibkflh.fsf@suse.de> <CAOQ4uxgRK3vXH8uAJKy8cFLL8siKnMMN8h6hx4yZeA5Fe0ZZYA@mail.gmail.com>
 <CAFX2Jfk0X=jKBpOzjq7k-U6SEwFn1Atw62BK2DzavM8XgeLUaQ@mail.gmail.com>
 <CAH2r5mvybG3mRUfHUub9B+nk5WrQ5Fvzu5pZ+ZynqZg4c4ct2A@mail.gmail.com> <CAOQ4uxhqaTUwD8Lw+9HWWj61EXRv4X-eE3u4DFeWnv_VOUZF5A@mail.gmail.com>
In-Reply-To: <CAOQ4uxhqaTUwD8Lw+9HWWj61EXRv4X-eE3u4DFeWnv_VOUZF5A@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 16 Feb 2021 15:15:06 -0600
Message-ID: <CAH2r5msmtuk0f8FuZxdRBQ2d_VKXexctcP0OmnLXoDEBien-nQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Luis Henriques <lhenriques@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "iant@google.com" <iant@google.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
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

On Tue, Feb 16, 2021 at 1:40 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Feb 16, 2021 at 9:31 PM Steve French <smfrench@gmail.com> wrote:
> >
> > On Tue, Feb 16, 2021 at 1:29 PM Anna Schumaker
> > <anna.schumaker@netapp.com> wrote:
> > >
> > > On Tue, Feb 16, 2021 at 2:22 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Tue, Feb 16, 2021 at 8:54 PM Luis Henriques <lhenriques@suse.de> wrote:
> > > > >
> > > > > Amir Goldstein <amir73il@gmail.com> writes:
> > > > >
> > > > > > On Tue, Feb 16, 2021 at 6:41 PM Luis Henriques <lhenriques@suse.de> wrote:
> > > > > >>
> > > > > >> Amir Goldstein <amir73il@gmail.com> writes:
> > > > > >>
> > > > > >> >> Ugh.  And I guess overlayfs may have a similar problem.
> > > > > >> >
> > > > > >> > Not exactly.
> > > > > >> > Generally speaking, overlayfs should call vfs_copy_file_range()
> > > > > >> > with the flags it got from layer above, so if called from nfsd it
> > > > > >> > will allow cross fs copy and when called from syscall it won't.
> > > > > >> >
> > > > > >> > There are some corner cases where overlayfs could benefit from
> > > > > >> > COPY_FILE_SPLICE (e.g. copy from lower file to upper file), but
> > > > > >> > let's leave those for now. Just leave overlayfs code as is.
> > > > > >>
> > > > > >> Got it, thanks for clarifying.
> > > > > >>
> > > > > >> >> > This is easy to solve with a flag COPY_FILE_SPLICE (or something) that
> > > > > >> >> > is internal to kernel users.
> > > > > >> >> >
> > > > > >> >> > FWIW, you may want to look at the loop in ovl_copy_up_data()
> > > > > >> >> > for improvements to nfsd_copy_file_range().
> > > > > >> >> >
> > > > > >> >> > We can move the check out to copy_file_range syscall:
> > > > > >> >> >
> > > > > >> >> >         if (flags != 0)
> > > > > >> >> >                 return -EINVAL;
> > > > > >> >> >
> > > > > >> >> > Leave the fallback from all filesystems and check for the
> > > > > >> >> > COPY_FILE_SPLICE flag inside generic_copy_file_range().
> > > > > >> >>
> > > > > >> >> Ok, the diff bellow is just to make sure I understood your suggestion.
> > > > > >> >>
> > > > > >> >> The patch will also need to:
> > > > > >> >>
> > > > > >> >>  - change nfs and overlayfs calls to vfs_copy_file_range() so that they
> > > > > >> >>    use the new flag.
> > > > > >> >>
> > > > > >> >>  - check flags in generic_copy_file_checks() to make sure only valid flags
> > > > > >> >>    are used (COPY_FILE_SPLICE at the moment).
> > > > > >> >>
> > > > > >> >> Also, where should this flag be defined?  include/uapi/linux/fs.h?
> > > > > >> >
> > > > > >> > Grep for REMAP_FILE_
> > > > > >> > Same header file, same Documentation rst file.
> > > > > >> >
> > > > > >> >>
> > > > > >> >> Cheers,
> > > > > >> >> --
> > > > > >> >> Luis
> > > > > >> >>
> > > > > >> >> diff --git a/fs/read_write.c b/fs/read_write.c
> > > > > >> >> index 75f764b43418..341d315d2a96 100644
> > > > > >> >> --- a/fs/read_write.c
> > > > > >> >> +++ b/fs/read_write.c
> > > > > >> >> @@ -1383,6 +1383,13 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
> > > > > >> >>                                 struct file *file_out, loff_t pos_out,
> > > > > >> >>                                 size_t len, unsigned int flags)
> > > > > >> >>  {
> > > > > >> >> +       if (!(flags & COPY_FILE_SPLICE)) {
> > > > > >> >> +               if (!file_out->f_op->copy_file_range)
> > > > > >> >> +                       return -EOPNOTSUPP;
> > > > > >> >> +               else if (file_out->f_op->copy_file_range !=
> > > > > >> >> +                        file_in->f_op->copy_file_range)
> > > > > >> >> +                       return -EXDEV;
> > > > > >> >> +       }
> > > > > >> >
> > > > > >> > That looks strange, because you are duplicating the logic in
> > > > > >> > do_copy_file_range(). Maybe better:
> > > > > >> >
> > > > > >> > if (WARN_ON_ONCE(flags & ~COPY_FILE_SPLICE))
> > > > > >> >         return -EINVAL;
> > > > > >> > if (flags & COPY_FILE_SPLICE)
> > > > > >> >        return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> > > > > >> >                                  len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
> > > > > >>
> > > > > >> My initial reasoning for duplicating the logic in do_copy_file_range() was
> > > > > >> to allow the generic_copy_file_range() callers to be left unmodified and
> > > > > >> allow the filesystems to default to this implementation.
> > > > > >>
> > > > > >> With this change, I guess that the calls to generic_copy_file_range() from
> > > > > >> the different filesystems can be dropped, as in my initial patch, as they
> > > > > >> will always get -EINVAL.  The other option would be to set the
> > > > > >> COPY_FILE_SPLICE flag in those calls, but that would get us back to the
> > > > > >> problem we're trying to solve.
> > > > > >
> > > > > > I don't understand the problem.
> > > > > >
> > > > > > What exactly is wrong with the code I suggested?
> > > > > > Why should any filesystem be changed?
> > > > > >
> > > > > > Maybe I am missing something.
> > > > >
> > > > > Ok, I have to do a full brain reboot and start all over.
> > > > >
> > > > > Before that, I picked the code you suggested and tested it.  I've mounted
> > > > > a cephfs filesystem and used xfs_io to execute a 'copy_range' command
> > > > > using /sys/kernel/debug/sched_features as source.  The result was a
> > > > > 0-sized file in cephfs.  And the reason is thevfs_copy_file_range()
> > > > > early exit in:
> > > > >
> > > > >         if (len == 0)
> > > > >                 return 0;
> > > > >
> > > > > 'len' is set in generic_copy_file_checks().
> > > >
> > > > Good point.. I guess we will need to do all the checks earlier in
> > > > generic_copy_file_checks() including the logic of:
> > > >
> > > >         if (file_in->f_op->remap_file_range &&
> > > >             file_inode(file_in)->i_sb == file_inode(file_out)->i_sb)
> > > >
> > > >
> > > > >
> > > > > This means that we're not solving the original problem anymore (probably
> > > > > since v1 of this patch, haven't checked).
> > > > >
> > > > > Also, re-reading Trond's emails, I read: "... also disallowing the copy
> > > > > from, say, an XFS formatted partition to an ext4 partition".  Isn't that
> > > > > *exactly* what we're trying to do here?  I.e. _prevent_ these copies from
> > > > > happening so that tracefs files can't be CFR'ed?
> > > > >
> > > >
> > > > We want to address the report which means calls coming from
> > > > copy_file_range() syscall.
> > > >
> > > > Trond's use case is vfs_copy_file_range() coming from nfsd.
> > > > When he writes about copy from XFS to ext4, he means an
> > > > NFS client is issuing server side copy (on same or different NFS mounts)
> > > > and the NFS server is executing nfsd_copy_file_range() on a source
> > > > file that happens to be on XFS and destination happens to be on ext4.
> > >
> > > NFS also supports a server-to-server copy where the destination server
> > > mounts the source server and reads the data to be copied. Please don't
> > > break that either :)
> >
>
> As long as the copy is via nfsd_copy_file_range() and not from the syscall
> it should not regress.
>
> > This is a case we will eventually need to support for cifs (SMB3) as well.
> >
>
> samba already does server side copy very well without needing any support
> from the kernel.
>
> nfsd also doesn't *need* to use vfs_copy_file_range() it can use kernel APIs
> like the loop in ovl_copy_up_data(). But it does, so we should not regress it.
>
> samba/nfsd can try to use copy_file_range() and it will work if the
> source/target
> fs support it. Otherwise, the server can perfectly well do the copy via other
> available interfaces, just like userspace copy tools.

I was thinking about cifsd ("ksmbd") the kernel server from
Namjae/Sergey etc. which is making excellent progress.

-- 
Thanks,

Steve
