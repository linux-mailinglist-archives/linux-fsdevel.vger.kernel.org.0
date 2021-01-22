Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48A42FFE6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 09:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbhAVImd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 03:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbhAVImI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:42:08 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF2C06178B;
        Fri, 22 Jan 2021 00:41:25 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 36so4406749otp.2;
        Fri, 22 Jan 2021 00:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=QH7Qc5EQ7iifT7PzYgbghVIv9P26i6FsrQ+fd6jlx2w=;
        b=r0BzrOD/8aKlJe4I292/JfGk8q+SEssSkkTBjumXnHMUhfyk5+ElKGazW+Tf4a66Hc
         rofMyEvAyKln95BGEZ31pSk03oLXw10PASDJ+VIsYqG43y/ZehZp7no4u5RJO30DA0CK
         5PgmEh0q8cImXoISKljnAjHjh27u/T4hoBGDQW2qZp4repP04uAUnchAYQ+yyycq1Qi+
         9DswLI66Rk7AMSqeQ6qGqElV3gzjUytCHKwmtuHiMAOar9yt+ERF0Rg+t0DosYf2NH64
         HLO0bsppV/w1W/G0aQc19l0Z/tnE2Ovusaof49jm54X2FMiXHOj3CC7wAj5BJKL3RXwW
         MXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=QH7Qc5EQ7iifT7PzYgbghVIv9P26i6FsrQ+fd6jlx2w=;
        b=qADU/nnCd54XHLLFl17lc/TByJ4wh14/ECnHwuHBls9ACaHxl/AbidquHHKMDRUsNn
         gkRZm1giYau3AG2CtDOfJj2BOzP7gLo42NIjaW013Ho4e5NVDVjvR9SNOhhfk14rTSSK
         dWkvjLF5ruV+DSIWJ9G+EeNCrrnwQ84tMce+ViXCyRtrZhUrgtF3JoqtF+errivqyeid
         aQEf9MGQKFlkvYVbTKdun8SU87ipZRz47rISjEAWsBgcLSvMdBuOeKMf+iBJF3Pz9mNz
         YaWo9fpnKgHWkcIbbuSD0dUU7SRwSzyPLNIz5duB13LYjh00NV3/pwDZBG3B1teMnDVL
         MeuQ==
X-Gm-Message-State: AOAM533EMrEL0uvsawEoDjE7hE8w2OxVQAhNDo7bD3TGjMmf9BqzMQoN
        /j0jJVdJeAlTYMa9C8YJ6PqWPDk1rLowG5Jo3jtCRYJlGJ0=
X-Google-Smtp-Source: ABdhPJxDgUWr1yNvwGw8O1L6XDuuZb4Ue2CL9xlpxJHgUOwefeqwKx21mVzvCC65O1WSjAwp6M2ZPcLK4p7JVNMp6CQ=
X-Received: by 2002:a9d:5e0f:: with SMTP id d15mr2540660oti.308.1611304885285;
 Fri, 22 Jan 2021 00:41:25 -0800 (PST)
MIME-Version: 1.0
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
 <159827190508.306468.12755090833140558156.stgit@warthog.procyon.org.uk>
 <CAKgNAkho1WSOsxvCYQOs7vDxpfyeJ9JGdTL-Y0UEZtO3jVfmKw@mail.gmail.com>
 <667616.1599063270@warthog.procyon.org.uk> <CAKgNAkhjDB9bvQ0h5b13fkbhuP9tYrkBQe7w1cbeOH8gM--D0g@mail.gmail.com>
 <CAKgNAkh9h3aA1hiYownT2O=xg5JmZwmJUCvQ1Z4f85MTq-26Fw@mail.gmail.com> <CAKgNAkju-65h1bKBUJQf-k=TCZeFmD9Nf4ZgZ9Mm_TQ1rQA6MA@mail.gmail.com>
In-Reply-To: <CAKgNAkju-65h1bKBUJQf-k=TCZeFmD9Nf4ZgZ9Mm_TQ1rQA6MA@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 22 Jan 2021 09:41:14 +0100
Message-ID: <CAKgNAkg78pHD90CuUaDtAhnwGqOwMU0SrZFny_fYXpDNSzovNA@mail.gmail.com>
Subject: Re: [PATCH 4/5] Add manpage for fsopen(2) and fsmount(2)
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

Ping!

Thanks,

Michael

On Fri, 16 Oct 2020 at 08:50, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hi David,
>
> Another ping for these five patches please!
>
> Cheers,
>
> Michael
>
> On Fri, 11 Sep 2020 at 14:44, Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> >
> > Hi David,
> >
> > A ping for these five patches please!
> >
> > Cheers,
> >
> > Michael
> >
> > On Wed, 2 Sep 2020 at 22:14, Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> > >
> > > On Wed, 2 Sep 2020 at 18:14, David Howells <dhowells@redhat.com> wrote:
> > > >
> > > > Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> > > >
> > > > > The term "filesystem configuration context" is introduced, but never
> > > > > really explained. I think it would be very helpful to have a sentence
> > > > > or three that explains this concept at the start of the page.
> > > >
> > > > Does that need a .7 manpage?
> > >
> > > I was hoping a sentence or a paragraph in this page might suffice. Do
> > > you think more is required?
> > >
> > > Cheers,
> > >
> > > Michael
> > >
> > > --
> > > Michael Kerrisk
> > > Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> > > Linux/UNIX System Programming Training: http://man7.org/training/
> >
> >
> >
> > --
> > Michael Kerrisk
> > Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> > Linux/UNIX System Programming Training: http://man7.org/training/
>
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
