Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B827E31CB76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 14:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhBPNw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 08:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBPNws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 08:52:48 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C56C061756;
        Tue, 16 Feb 2021 05:52:07 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id u20so10183996iot.9;
        Tue, 16 Feb 2021 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Udr/uppAMHmYikfRcuoFaAlS+xZhJpxbzyBUOtI9wrk=;
        b=Fy/wJSxbB0krgrqyFWMD8WxIG8EB1AfwsYuCEIZVLa3TxfnbcEJqz1X18LzcK1fAt7
         4CjUXknRFAGmXbtUqDlvXj4mcva2R9VVEfehzyPdYx1ptURMNlLn6tXU3Zh4tGPxCCkM
         Z3GWtH4bE09tDcfR+Dqh4iAjhaaC4tP4JzDYEAUzUo4mKGfGRDJ4T0t3fHBlHLOLibdf
         x8Ui48xAxAo1dvBJxeg5+VzjB6qklJ/nBXXed7AWPf859RQvH2YiDKW+YE+u8OOeQY+z
         z2XEQg8j/dveh8MszPz2XYnaeqqf6oMc0RwP9o5RMURB3d+wnWIKepja9kZOCVKp+zGm
         8W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Udr/uppAMHmYikfRcuoFaAlS+xZhJpxbzyBUOtI9wrk=;
        b=dug58UZLGAzhAhKp5XMmJuy91VA0mL6nYiO6JCcs1j8z3bkgu6BqiuWef8DcXXVn6D
         pKKw1RlwKMyEI5/pIi2BJVGsjjnnOq+WRtV7E1FzvS6jKI1cOIj3BRjkMLg1QplfXkCN
         y9pcW/QwkjLdqsxEHTYQ4diLvgRx44yVMer6dlOu7FiMPjn63sGI1psYBNQJTtmbBoEu
         r1iQLAENh76Xh4Ts9gZU9VYvipz6X11IDnDUGvJC/HTNuqJvFSZAh2gK0aTVataiOhm4
         18tic0Lfp3dDcG2o2PpmaWyKekiJad769EKpvasmkkkncFX/3k3/3Kq1lsQhilYqwd7F
         ovDQ==
X-Gm-Message-State: AOAM5339FrMVkN2y7ui2nlVTnC3m+NcbGiVdSIb9In4YiGu5cZwpFidZ
        xYtGjk/U01Emlf4BfV/F8ZMZutzGf58dTml1jRw=
X-Google-Smtp-Source: ABdhPJxCRp3/lBHTsRsTI8B3GxGfemBTBTejnJhPDIktXg8Ixbg/0SiVI1SYY7t6Ww8hOj1hz0L786KcAp4lmuPCfGw=
X-Received: by 2002:a02:660b:: with SMTP id k11mr20707151jac.120.1613483527097;
 Tue, 16 Feb 2021 05:52:07 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de> <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
 <73ab4951f48d69f0183548c7a82f7ae37e286d1c.camel@hammerspace.com>
 <CAOQ4uxgPtqG6eTi2AnAV4jTAaNDbeez+Xi2858mz1KLGMFntfg@mail.gmail.com>
 <92d27397479984b95883197d90318ee76995b42e.camel@hammerspace.com>
 <CAOQ4uxjUf15fDjz11pCzT3GkFmw=2ySXR_6XF-Bf-TfUwpj77Q@mail.gmail.com> <87r1lgjm7l.fsf@suse.de>
In-Reply-To: <87r1lgjm7l.fsf@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 Feb 2021 15:51:56 +0200
Message-ID: <CAOQ4uxgucdN8hi=wkcvnFhBoZ=L5=ZDc7-6SwKVHYaRODdcFkg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "iant@google.com" <iant@google.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
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

> Ugh.  And I guess overlayfs may have a similar problem.

Not exactly.
Generally speaking, overlayfs should call vfs_copy_file_range()
with the flags it got from layer above, so if called from nfsd it
will allow cross fs copy and when called from syscall it won't.

There are some corner cases where overlayfs could benefit from
COPY_FILE_SPLICE (e.g. copy from lower file to upper file), but
let's leave those for now. Just leave overlayfs code as is.

>
> > This is easy to solve with a flag COPY_FILE_SPLICE (or something) that
> > is internal to kernel users.
> >
> > FWIW, you may want to look at the loop in ovl_copy_up_data()
> > for improvements to nfsd_copy_file_range().
> >
> > We can move the check out to copy_file_range syscall:
> >
> >         if (flags != 0)
> >                 return -EINVAL;
> >
> > Leave the fallback from all filesystems and check for the
> > COPY_FILE_SPLICE flag inside generic_copy_file_range().
>
> Ok, the diff bellow is just to make sure I understood your suggestion.
>
> The patch will also need to:
>
>  - change nfs and overlayfs calls to vfs_copy_file_range() so that they
>    use the new flag.
>
>  - check flags in generic_copy_file_checks() to make sure only valid flags
>    are used (COPY_FILE_SPLICE at the moment).
>
> Also, where should this flag be defined?  include/uapi/linux/fs.h?

Grep for REMAP_FILE_
Same header file, same Documentation rst file.

>
> Cheers,
> --
> Luis
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 75f764b43418..341d315d2a96 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1383,6 +1383,13 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>                                 struct file *file_out, loff_t pos_out,
>                                 size_t len, unsigned int flags)
>  {
> +       if (!(flags & COPY_FILE_SPLICE)) {
> +               if (!file_out->f_op->copy_file_range)
> +                       return -EOPNOTSUPP;
> +               else if (file_out->f_op->copy_file_range !=
> +                        file_in->f_op->copy_file_range)
> +                       return -EXDEV;
> +       }

That looks strange, because you are duplicating the logic in
do_copy_file_range(). Maybe better:

if (WARN_ON_ONCE(flags & ~COPY_FILE_SPLICE))
        return -EINVAL;
if (flags & COPY_FILE_SPLICE)
       return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
                                 len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
if (!file_out->f_op->copy_file_range)
        return -EOPNOTSUPP;
return -EXDEV;

>  }
> @@ -1474,9 +1481,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  {
>         ssize_t ret;
>
> -       if (flags != 0)
> -               return -EINVAL;
> -

This needs to move to the beginning of SYSCALL_DEFINE6(copy_file_range,...

Thanks,
Amir.
