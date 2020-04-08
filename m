Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FDF1A2B1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 23:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgDHV3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 17:29:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39860 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbgDHV3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:29:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id a43so10628845edf.6;
        Wed, 08 Apr 2020 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=A//Ihtk8E6tGXssdeUVjq+HsfLF2Kwp1UsiAdKMAPC0=;
        b=MowKziS/aP0dLyQZfm3LH2OOVnSziB5+YdNABqp5DaO6phZMONdWTHrVb68lnPg/xo
         kU7SNyJ55ozs6l8SVZQ4sTKHnKMiU7K1trC42DZ8nQv+XCBy3tJRNa7MlUi3CFG85uuy
         DHrwLeRL96bm0aApoHpe1wE7oNoDwkk88NOE5rYA46ujRbnXR6PeVbnwXmeCYctS2JE8
         zaUbA8cWy1HyIiCWsFipHTdTn58SLJpHd8btcG80FrOTsa5FPNgR5zmzR9+JEE64Nvsb
         1FSlURpgnIhGlgrhr8hPuLihnQzuIgEdiwHzcLxmg9fHMgCdU4R9OGUM9ukHQJTMivP3
         jOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=A//Ihtk8E6tGXssdeUVjq+HsfLF2Kwp1UsiAdKMAPC0=;
        b=cjevSeseNfmcJXrgH6+q0dxEjNx3UJMrHrguerhvMrOmvS3lDhPomwjfAMS3YWw5Dr
         KEWcEaHYFR7uRrHhCedEyroH3yLeD5oxepBHDp/pOp9yAtjH0aY1V2YEdwODr3eokfBq
         NLReOddEafYWjgx9cpnJDiOUC5tW6HoNk0w2a+zcIpB/k5NZTt7ssONEuMb4dfmVg6e/
         o4eyhi6NaZzb/GGJftNHGi9crc4ktekbmmqgUbuToiZ50+Awhb1M8YwfwRxCMJhh2Nt2
         HCtGVZQvF1iaa5KLuF9rB6N7J2ihL4vGv+8jZcI3cMpUykjv6IyMXw1USlPMdpAD2azI
         NTiA==
X-Gm-Message-State: AGi0PuZxf3wrC1s/+jvNeTNDeUtlD/tJAlPcA9sImISi2j1YfXCZvaT7
        W9niv41zW7xK5acl1+Ja47hXtU2STvgZY/thvCo=
X-Google-Smtp-Source: APiQypIcLuUPcM7dpcYmVLN0FYDPTb1IWXC7Gx88nUJmVVsFuobNJPDrfewiy+GojX6YPVRfdLX7XRnOLG2Q2pY9QhQ=
X-Received: by 2002:a05:6402:30b2:: with SMTP id df18mr8251337edb.149.1586381377148;
 Wed, 08 Apr 2020 14:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200202151907.23587-1-cyphar@cyphar.com> <20200202151907.23587-3-cyphar@cyphar.com>
 <1567baea-5476-6d21-4f03-142def0f62e3@gmail.com> <20200331143911.lokfoq3lqfri2mgy@yavin.dot.cyphar.com>
 <cd3a6aad-b906-ee57-1b5b-5939b9602ad0@gmail.com>
In-Reply-To: <cd3a6aad-b906-ee57-1b5b-5939b9602ad0@gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 8 Apr 2020 23:29:25 +0200
Message-ID: <CAKgNAki8z_eGej6dqsZLZ5UKVXdmWX00FfR0GMSJtjS4WkiSwA@mail.gmail.com>
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Aleksa,

Ping!

Cheers,

Michael

On Wed, 1 Apr 2020 at 08:38, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello Aleksa,
>
> On 3/31/20 4:39 PM, Aleksa Sarai wrote:
> > On 2020-03-30, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wro=
te:
> >> Hello Aleksa,
> >>
> >> On 2/2/20 4:19 PM, Aleksa Sarai wrote:
> >>> Rather than trying to merge the new syscall documentation into open.2
> >>> (which would probably result in the man-page being incomprehensible),
> >>> instead the new syscall gets its own dedicated page with links betwee=
n
> >>> open(2) and openat2(2) to avoid duplicating information such as the l=
ist
> >>> of O_* flags or common errors.
> >>>
> >>> In addition to describing all of the key flags, information about the
> >>> extensibility design is provided so that users can better understand =
why
> >>> they need to pass sizeof(struct open_how) and how their programs will
> >>> work across kernels. After some discussions with David Laight, I also
> >>> included explicit instructions to zero the structure to avoid issues
> >>> when recompiling with new headers.
> >>>
> >>> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> >>
> >> Thanks. I've applied this patch, but also done quite a lot of
> >> editing of the page. The current draft is below (and also pushed
> >> to Git). Could I ask you to review the page, to see if I injected
> >> any error during my edits.
> >
> > Looks good to me.
> >
> >> In addition, I've added a number of FIXMEs in comments
> >> in the page source. Can you please check these, and let me
> >> know your thoughts.
> >
> > Will do, see below.
> >
> >> .\" FIXME I find the "previously-functional systems" in the previous
> >> .\" sentence a little odd (since openat2() ia new sysycall), so I woul=
d
> >> .\" like to clarify a little...
> >> .\" Are you referring to the scenario where someone might take an
> >> .\" existing application that uses openat() and replaces the uses
> >> .\" of openat() with openat2()? In which case, is it correct to
> >> .\" understand that you mean that one should not just indiscriminately
> >> .\" add the RESOLVE_NO_XDEV flag to all of the openat2() calls?
> >> .\" If I'm not on the right track, could you point me in the right
> >> .\" direction please.
> >
> > This is mostly meant as a warning to hopefully avoid applications
> > because the developer didn't realise that system paths may contain
> > symlinks or bind-mounts. For an application which has switched to
> > openat2() and then uses RESOLVE_NO_SYMLINKS for a non-security reason,
> > it's possible that on some distributions (or future versions of a
> > distribution) that their application will stop working because a system
> > path suddenly contains a symlink or is a bind-mount.
> >
> > This was a concern which was brought up on LWN some time ago. If you ca=
n
> > think of a phrasing that makes this more clear, I'd appreciate it.
>
> Thanks. I've made the text:
>
>                      Applications  that  employ  the RESOLVE_NO_XDEV flag
>                      are encouraged to make its use configurable  (unless
>                      it is used for a specific security purpose), as bind
>                      mounts are widely used by end-users.   Setting  this
>                      flag indiscriminately=E2=80=94i.e., for purposes not=
 specif=E2=80=90
>                      ically related to security=E2=80=94for all uses of o=
penat2()
>                      may  result  in  spurious errors on previously-func=
=E2=80=90
>                      tional systems.  This may occur if, for  example,  a
>                      system  pathname  that  is used by an application is
>                      modified (e.g., in a new  distribution  release)  so
>                      that  a  pathname  component  (now)  contains a bind
>                      mount.
>
> Okay?
>
> >> .\" FIXME: what specific details in symlink(7) are being referred
> >> .\" by the following sentence? It's not clear.
> >
> > The section on magic-links, but you're right that the sentence ordering
> > is a bit odd. It should probably go after the first sentence.
>
> I must admit that I'm still confused. There's only the briefest of
> mentions of magic links in symlink(7). Perhaps that needs to be fixed?
>
> And, while I think of it, the text just preceding that FIXME says:
>
>     Due to the potential danger of unknowingly opening
>     these magic links, it may be preferable for users to
>     disable their resolution entirely.
>
> This sentence reads a little strangely. Could you please give me some
> concrete examples, and I will try rewording that sentence a bit.
>
> >> .\" FIXME I found the following hard to understand (in particular, the
> >> .\" meaning of "scoped" is unclear) , and reworded as below. Is it oka=
y?
> >> .\"     Absolute symbolic links and ".." path components will be scope=
d to
> >> .\"     .IR dirfd .
> >
> > Scoped does broadly mean "interpreted relative to", though the
> > difference is mainly that when I said scoped it's meant to be more of a=
n
> > assertive claim ("the kernel promises to always treat this path inside
> > dirfd"). But "interpreted relative to" is a clearer way of phrasing the
> > semantics, so I'm okay with this change.
>
> Okay.
>
> >> .\" FIXME The next piece is unclear (to me). What kind of ".." escape
> >> .\" attempts does chroot() not detect that RESOLVE_IN_ROOT does?
> >
> > If the root is moved, you can escape from a chroot(2). But this sentenc=
e
> > might not really belong in a man-page since it's describing (important)
> > aspects of the implementation and not the semantics.
>
> So, should I just remove the sentence?
>
> Thanks,
>
> Michael
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/



--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
