Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F7F1AB26E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 22:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442010AbgDOUZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 16:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442001AbgDOUZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:25:03 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0B1C061A0C;
        Wed, 15 Apr 2020 13:25:02 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id j20so6764020edj.0;
        Wed, 15 Apr 2020 13:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TG84DAM+ZvzWT1WjDaPyx3Y8pzSbrP4EyNOH4w1Vf2Y=;
        b=l1JPPwS/D7e1Rxn1TxQe+CD0VuProMofkSe7CHsvHc7yfSLMPjRPPSqs9OolRsMu7N
         HDioibypXMJQfwAhsRnOG13Bny2s2UxLDTFe08wrySheWpE0gRMOWIoPCJ4ZU9KbP3Yc
         Amdmk/+9+ddBVRxA/2BATUTsIzzqfsY9KhPxG3tDz6seN0AEzOFRcOt3hrTlouyOlKYo
         Fpqw29lFhnwNMnYiG83Xp5BFqB/t66cVLhYFMBfNey30aqdxV87bBPUWcYXncgBQaez9
         Eqgzwe8H3qJkYZeY+iOcxqKiyIGKtXTK3HT9jk5wIKrM25INIagjci504yO7UongG3dc
         /sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TG84DAM+ZvzWT1WjDaPyx3Y8pzSbrP4EyNOH4w1Vf2Y=;
        b=O1fWxIu10eVk6zEALITUr8mQ4i2ng/qaxBhObSdhQ2PddfWtEoRSKKJroiWjTFYITh
         tUu3eUmArWvuBdd5KFmInqmQ7Iv0/e4X0tYaEypg0wElqnozm7ALy492p7oIj6w5fGLt
         MQEK+R7i9U2dFnZpj4v/UiNHTFcp+y+p5AIfBdaucR2uundqhUhU7DVYpL72lFTHOvlA
         fPGyxfD0dEgoIwax7imqM4LjYU2mr7PtS3zILjkxPgIELtFMarwkOam8mmq4pUUJxnMG
         BN0vNqyX4344hjn+Ekid1l4GzsOQ2nCGg0eBiNbz3tb8JTL9NdcurfFJ0IjJ9zAq7tqR
         FgFQ==
X-Gm-Message-State: AGi0Pua8DFMsh+9c1Qb4ZfMDCnGt8NgtG9xp8TN9AS+pH8RsKurbDkL/
        cUek+mL6EXBdPRoNj2PjsjKYJqluAkhau4kMzq0=
X-Google-Smtp-Source: APiQypKrpiRQDp+uevm4TMFo8xjLOpCqzM1jBIP63ImHO0yiIu0dgaaLktBqHiyj0911kGTBxyMRqicR4Glm/FiTkx0=
X-Received: by 2002:a05:6402:16da:: with SMTP id r26mr12259794edx.375.1586982301317;
 Wed, 15 Apr 2020 13:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200202151907.23587-1-cyphar@cyphar.com> <20200202151907.23587-3-cyphar@cyphar.com>
 <1567baea-5476-6d21-4f03-142def0f62e3@gmail.com> <20200331143911.lokfoq3lqfri2mgy@yavin.dot.cyphar.com>
 <cd3a6aad-b906-ee57-1b5b-5939b9602ad0@gmail.com> <20200412164943.imwpdj5qgtyfn5de@yavin.dot.cyphar.com>
 <cd1438ab-cfc6-b286-849e-d7de0d5c7258@gmail.com> <20200414103524.wjhyfobzpjk236o7@yavin.dot.cyphar.com>
In-Reply-To: <20200414103524.wjhyfobzpjk236o7@yavin.dot.cyphar.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 15 Apr 2020 22:24:00 +0200
Message-ID: <CAKgNAkhCE0BHjHzc7My1shieDvohCRb-n3AL_E9P49EEsz5upA@mail.gmail.com>
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2) syscall
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
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

Hello Aleksa,

On Tue, 14 Apr 2020 at 12:35, Aleksa Sarai <asarai@suse.de> wrote:

[...]

> > >> I must admit that I'm still confused. There's only the briefest of
> > >> mentions of magic links in symlink(7). Perhaps that needs to be fixe=
d?
> > >
> > > It wouldn't hurt to add a longer description of magic-links in
> > > symlink(7). I'll send you a small patch to beef up the description (I
> > > had planned to include a longer rewrite with the O_EMPTYPATH patches =
but
> > > those require quite a bit more work to land).
> >
> > That would be great. Thank you!
>
> I'll cook something up later this week.

Thank you!

[...]

> > I've reworked the text on RESOLVE_NO_MAGICLINKS substantially:
> >
> >        RESOLVE_NO_MAGICLINKS
> >               Disallow all magic-link resolution during path reso=E2=80=
=90
> >               lution.
> >
> >               Magic links are symbolic link-like objects that  are
> >               most  notably  found  in  proc(5);  examples include
> >               /proc/[pid]/exe  and  /proc/[pid]/fd/*.   (See  sym=E2=80=
=90
> >               link(7) for more details.)
> >
> >               Unknowingly  opening  magic  links  can be risky for
> >               some applications.  Examples of such  risks  include
> >               the following:
> >
> >               =C2=B7 If the process opening a pathname is a controlling
> >                 process that currently has no controlling terminal
> >                 (see  credentials(7)),  then  opening a magic link
> >                 inside /proc/[pid]/fd that happens to refer  to  a
> >                 terminal would cause the process to acquire a con=E2=80=
=90
> >                 trolling terminal.
> >
> >               =C2=B7 In  a  containerized  environment,  a  magic  link
> >                 inside  /proc  may  refer to an object outside the
> >                 container, and thus may provide a means to  escape
> >                 from the container.
> >
> > [The above example derives from https://lwn.net/Articles/796868/]
> >
> >               Because  of such risks, an application may prefer to
> >               disable   magic   link    resolution    using    the
> >               RESOLVE_NO_MAGICLINKS flag.
> >
> >               If  the trailing component (i.e., basename) of path=E2=80=
=90
> >               name is a magic link, and  how.flags  contains  both
> >               O_PATH  and O_NOFOLLOW, then an O_PATH file descrip=E2=80=
=90
> >               tor referencing the magic link will be returned.
> >
> > How does the above look?
>
> The changes look correct, though you could end up going through procfs
> even if you weren't resolving a path inside proc directly (since you can
> bind-mount symlinks or have a symlink to procfs). But I'm not sure if
> it's necessary to outline all the ways a program could be tricked into
> doing something unintended.

Yes, indeed. These paragraphs are merely intended to give the reader
some ideas about what the issues are.

> > Also, regarding the last paragraph, I  have a question.  The
> > text doesn't seem quite to relate to the rest of the discussion.
> > Should it be saying something like:
> >
> > If the trailing component (i.e., basename) of pathname is a magic link,
> > **how.resolve contains RESOLVE_NO_MAGICLINKS,**
> > and how.flags contains both O_PATH and O_NOFOLLOW, then an O_PATH
> > file descriptor referencing the magic link will be returned.
> >
> > ?
>
> Yes, that is what I meant to write --

Good. Fixed.

> and I believe that the
> RESOLVE_NO_SYMLINKS section is missing similar text in the second
> paragraph (except it should refer to RESOLVE_NO_SYMLINKS, obviously).

Also fixed.

Thanks,

Michael

--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/[...]
