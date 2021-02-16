Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94A031CF7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhBPRqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 12:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhBPRpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:45:46 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4654C061574;
        Tue, 16 Feb 2021 09:44:59 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e2so1835451ilu.0;
        Tue, 16 Feb 2021 09:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoZ/N56GQhoxf41Tk4mVvqd4ibjjEWbrDLYw01R5jJs=;
        b=WJpbCbhdJGCGVVCAJu8u15jv3lgj7w9h9G014Jl+FhhfmmWAsVI48wEU1hWHz3Sk2E
         6qAQzRhEpu80uCWdF+5w++mrXYtNSoINwxgBTnk4Ab8cpI/PiHqZFa8FXg4H7uzWxK8E
         0A2W6Sbh00VhahYUtVOq7QOSqmKbsfkozF05V9p2y2MwKxR8B4CQpg0P86Se+Hzw7+Qq
         puiXVDxzjb0peELErkjcAxGesRH/Lqq2nkc0doOrCXL/WG0cWNY/a58bapKK6eRxjlRD
         EOY3u5/NHEcUVpHh6bD5ax/7UnEj3wutnWTXLZfrVv9CcSHIPVThfYT28kSpXE0QBe4G
         ThUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoZ/N56GQhoxf41Tk4mVvqd4ibjjEWbrDLYw01R5jJs=;
        b=BpFeRNUkYr9wtUlEKCe6Lbq7W7UWO9sSAOlY6CCFdkE2/V7y7We1fA8z1kdS5iyRFE
         f3CkmzJqlJAFPoyeH4izbClolhb1CaGJtyeOpcqTDcGMjyoIa0+9UQp+lXIkQihmCsrh
         DFbQc/kIU0QuGO3++3VeNBiCAA5eh3WxLjB69fykM1uZMWLyZpJSkQ2E3Xuyc7HgrIyr
         +HykPYw+bwwNzoyJDB/RWAG4SvVOs7tsKHbCoDCpJvxcq/DiarTP/mA/6PIijKjrnCcH
         D+GXKVbrHB4/GzJJTAgHpjZ3wcyCh3u+fj00tDhDcKoIwJj2G38TB9gGkxCi/1fehCOV
         6U+w==
X-Gm-Message-State: AOAM532RPXPt9f8AQiaLwQn1NGXPPuw/FYGMirYpz272U4JqVAaz4iPK
        +HJR9kBDuc91dldPD2VCOOg6mAMcO3uFQDQPpbQ=
X-Google-Smtp-Source: ABdhPJz6M7eNgrLD9ssOJCuZpIHXbv/mzcJG8zgFQ4MPmn+Q/MAe8WqT6hNZZBReyRXF5Rv/3eCfCTAojdBt6qAj6iM=
X-Received: by 2002:a92:8e42:: with SMTP id k2mr18429275ilh.250.1613497499157;
 Tue, 16 Feb 2021 09:44:59 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de> <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
 <73ab4951f48d69f0183548c7a82f7ae37e286d1c.camel@hammerspace.com>
 <CAOQ4uxgPtqG6eTi2AnAV4jTAaNDbeez+Xi2858mz1KLGMFntfg@mail.gmail.com>
 <92d27397479984b95883197d90318ee76995b42e.camel@hammerspace.com>
 <CAOQ4uxjUf15fDjz11pCzT3GkFmw=2ySXR_6XF-Bf-TfUwpj77Q@mail.gmail.com>
 <87r1lgjm7l.fsf@suse.de> <CAOQ4uxgucdN8hi=wkcvnFhBoZ=L5=ZDc7-6SwKVHYaRODdcFkg@mail.gmail.com>
 <87blckj75z.fsf@suse.de>
In-Reply-To: <87blckj75z.fsf@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 Feb 2021 19:44:48 +0200
Message-ID: <CAOQ4uxiiy_Jdi3V1ait56=zfDQRBu_5gb+UsCo8GjMZ6XRhozw@mail.gmail.com>
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

On Tue, Feb 16, 2021 at 6:41 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> >> Ugh.  And I guess overlayfs may have a similar problem.
> >
> > Not exactly.
> > Generally speaking, overlayfs should call vfs_copy_file_range()
> > with the flags it got from layer above, so if called from nfsd it
> > will allow cross fs copy and when called from syscall it won't.
> >
> > There are some corner cases where overlayfs could benefit from
> > COPY_FILE_SPLICE (e.g. copy from lower file to upper file), but
> > let's leave those for now. Just leave overlayfs code as is.
>
> Got it, thanks for clarifying.
>
> >> > This is easy to solve with a flag COPY_FILE_SPLICE (or something) that
> >> > is internal to kernel users.
> >> >
> >> > FWIW, you may want to look at the loop in ovl_copy_up_data()
> >> > for improvements to nfsd_copy_file_range().
> >> >
> >> > We can move the check out to copy_file_range syscall:
> >> >
> >> >         if (flags != 0)
> >> >                 return -EINVAL;
> >> >
> >> > Leave the fallback from all filesystems and check for the
> >> > COPY_FILE_SPLICE flag inside generic_copy_file_range().
> >>
> >> Ok, the diff bellow is just to make sure I understood your suggestion.
> >>
> >> The patch will also need to:
> >>
> >>  - change nfs and overlayfs calls to vfs_copy_file_range() so that they
> >>    use the new flag.
> >>
> >>  - check flags in generic_copy_file_checks() to make sure only valid flags
> >>    are used (COPY_FILE_SPLICE at the moment).
> >>
> >> Also, where should this flag be defined?  include/uapi/linux/fs.h?
> >
> > Grep for REMAP_FILE_
> > Same header file, same Documentation rst file.
> >
> >>
> >> Cheers,
> >> --
> >> Luis
> >>
> >> diff --git a/fs/read_write.c b/fs/read_write.c
> >> index 75f764b43418..341d315d2a96 100644
> >> --- a/fs/read_write.c
> >> +++ b/fs/read_write.c
> >> @@ -1383,6 +1383,13 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
> >>                                 struct file *file_out, loff_t pos_out,
> >>                                 size_t len, unsigned int flags)
> >>  {
> >> +       if (!(flags & COPY_FILE_SPLICE)) {
> >> +               if (!file_out->f_op->copy_file_range)
> >> +                       return -EOPNOTSUPP;
> >> +               else if (file_out->f_op->copy_file_range !=
> >> +                        file_in->f_op->copy_file_range)
> >> +                       return -EXDEV;
> >> +       }
> >
> > That looks strange, because you are duplicating the logic in
> > do_copy_file_range(). Maybe better:
> >
> > if (WARN_ON_ONCE(flags & ~COPY_FILE_SPLICE))
> >         return -EINVAL;
> > if (flags & COPY_FILE_SPLICE)
> >        return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> >                                  len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
>
> My initial reasoning for duplicating the logic in do_copy_file_range() was
> to allow the generic_copy_file_range() callers to be left unmodified and
> allow the filesystems to default to this implementation.
>
> With this change, I guess that the calls to generic_copy_file_range() from
> the different filesystems can be dropped, as in my initial patch, as they
> will always get -EINVAL.  The other option would be to set the
> COPY_FILE_SPLICE flag in those calls, but that would get us back to the
> problem we're trying to solve.

I don't understand the problem.

What exactly is wrong with the code I suggested?
Why should any filesystem be changed?

Maybe I am missing something.

Thanks,
Amir.
