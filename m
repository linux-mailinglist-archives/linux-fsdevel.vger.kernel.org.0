Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0BA6B82D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 21:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCMUfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 16:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCMUfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:35:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AD73C2D
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 13:35:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x17so1194716lfu.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 13:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678739721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o418PKKXqs7841bWPsy5T2+jbs2w+FExlTbXsy0SBOs=;
        b=aZOJCTLyzqhUCX1YJj66up+N6LzQ+QA4pFjj96sgoVWx24t3zwWjNp+wcCxO/xESFr
         RUaigQeZjfQSHIaJpqIr98BYgtvZF7ZWdkzST1jH43dw3r20Vq2po8CoEnKt8K77ZOBF
         IGyrU3znW9xLQt1MTXpNacLS06gSp72MP91aYOYBBdI0WIPLxZ60cyHhgvq43DRYGj/O
         Ob7YU4rdfNUytb0cnkqv2DLt/9OqQ2KPvWjuz6mFipIvfS3EkJMLRFEUgGKiyh0LNA+n
         mhOoXGHAYa3M6rZYRwmFfTTdy1SXr6gj1wfhHx4iiP5VcyNjSfFJtxj8B/mUqM2dAmEF
         UECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678739721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o418PKKXqs7841bWPsy5T2+jbs2w+FExlTbXsy0SBOs=;
        b=u1p5kz9GfCPqr5wGANCYlYHbrtTcNqSN8GZMFRbYNMiGkNhz2PpIst/JrzzezWlHSR
         AO5Z/CzETzVpii5K76Zw9xl9R6CqXktqjmnI3DGHAi8Yq0sckeGo3+xkOYfFjiXxJzuY
         yOt4dbAqwlmJwT5+zHcunRuSGtF+KWRBqd1OHya9tkzSzxsGSkG4vrO9XFtLh7gIanhm
         BCyZTXD4RN2IxAPwiSRAn0NVfxKmjSS0QNusUJclKvFg+yxQLBnlCbJF3136G+EFUPBQ
         U+0HwM1ryaUXaiuTdjEkK6GNmgwXLgnGAi6Z3A/BaRcOx9vtVvTSC9IGepJl+r30l27d
         PGDA==
X-Gm-Message-State: AO0yUKVnEXuKkHrfXz3QabvWohp9Hiw3OOlJrDjukUU20mPOoC9YeKvC
        sp8ReuIfRqQQezJTrblouRABfrs+hd6rIPwFMDw=
X-Google-Smtp-Source: AK7set9gS+q8FTQ7LQnbe/yYRsUMgxPmNSZWu3vb0AhHqzwwwgoXbMZCR8XY0/yhuNn1A8eynSHdvZfIGd5EI9T3Kmo=
X-Received: by 2002:a05:6512:102c:b0:4e1:dbbb:4937 with SMTP id
 r12-20020a056512102c00b004e1dbbb4937mr10723512lfr.11.1678739721099; Mon, 13
 Mar 2023 13:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200723185921.1847880-1-tytso@mit.edu> <CA+icZUU7Dqoc3-HeM5W4EMXzmZSetD+=WkavDgeGqAi4St6t3g@mail.gmail.com>
 <CA+icZUW1nybY==tV0sGDjZTOinR17Tpj3Eh3cjCtZXDOXXJAdw@mail.gmail.com> <CA+icZUW5d+JCM=i-OF_hLyN+As14KFZ_4WN0np5AG080WeJuaA@mail.gmail.com>
In-Reply-To: <CA+icZUW5d+JCM=i-OF_hLyN+As14KFZ_4WN0np5AG080WeJuaA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 Mar 2023 21:34:44 +0100
Message-ID: <CA+icZUVn5ObxJ+ReuuJyr0vwX0mgD_L8UfgXbFvBFfFubx8d_w@mail.gmail.com>
Subject: Re: [PATCH] fs: prevent out-of-bounds array speculation when closing
 a file descriptor
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     viro@zeniv.linux.org.uk,
        Linux Filesystem Development List 
        <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 8, 2021 at 2:15=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com> =
wrote:
>
> On Fri, Jan 8, 2021 at 1:59 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Jul 24, 2020 at 3:18 AM Sedat Dilek <sedat.dilek@gmail.com> wro=
te:
> > >
> > > On Thu, Jul 23, 2020 at 9:02 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > > >
> > > > Google-Bug-Id: 114199369
> > > > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > >
> > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # Linux v5.8-rc6+
> > >
> >
> > Ping.
> >
> > What is the status of this patch?
> >
>
> Friendly ping again.
>

Finally upstreamed :-).

-Sedat-

[1] https://git.kernel.org/linus/609d54441493c99f21c1823dfd66fa7f4c512ff4

> >
> > >
> > > > ---
> > > >  fs/file.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/fs/file.c b/fs/file.c
> > > > index abb8b7081d7a..73189eaad1df 100644
> > > > --- a/fs/file.c
> > > > +++ b/fs/file.cfs: prevent out-of-bounds array speculation when clo=
sing a file descriptor
> > > > @@ -632,6 +632,7 @@ int __close_fd(struct files_struct *files, unsi=
gned fd)
> > > >         fdt =3D files_fdtable(files);
> > > >         if (fd >=3D fdt->max_fds)
> > > >                 goto out_unlock;fs: prevent out-of-bounds array spe=
culation when closing a file descriptor fs: prevent out-of-bounds array spe=
culation when closing a file descriptor fs: prevent out-of-bounds array spe=
culation when closing a file descriptor
> > > > +       fd =3D array_index_nospec(fd, fdt->max_fds);
> > > >         file =3D fdt->fd[fd];
> > > >         if (!file)
> > > >                 goto out_unlock;
> > > > --
> > > > 2.24.1
> > > >
